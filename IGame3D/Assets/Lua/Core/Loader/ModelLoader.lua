--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/19
-- Time: 15:09
-- To change this template use File | Settings | File Templates.
--

--[[
--      3D模型加载
 ]]
local ModelLoader = class("ModelLoader")

function ModelLoader:ctor()

end

function ModelLoader:create(abPath)
    local ab = self:load(abPath)
    if not ab then
        return nil
    end

    return self:createModelByAB(ab,abPath)
end

function ModelLoader:createAsync(abPath,callBack)
    local invokeCallBack = function(gameObject)
        if not callBack then
            return
        end

        callBack(gameObject)
    end
    self:loadAsync(abPath,function(ab)
        if not ab then
            return invokeCallBack(nil)
        end

        local go = self:createModelByAB(ab,abPath)
        return invokeCallBack(go)
    end)
end

function ModelLoader:createModelByAB(ab,abPath)
    if not ab then
        return nil
    end

    local prefab = self:loadPrefab(ab,abPath)
    if not prefab then
        return nil
    end
    return UnityEngine.GameObject.Instantiate(prefab)
end

--[[
--      同步加载模型
 ]]
function ModelLoader:load(abPath)
    abPath      = self:inspectAbPath(abPath)
    local ab    = Core.Loader.ABLoader:load(abPath)
    if not ab then
        return
    end

--    local prefab = self:onABLoaded(ab,abPath)
--    return prefab

    return ab
end

function ModelLoader:loadAsync(abPath,callback)
    local invokeCallBack = function(ab)
        if callback then
            callback(ab)
        end
    end
    abPath = self:inspectAbPath(abPath)
    Core.Loader.ABLoader:loadAsync(abPath,function(ab)
        if not ab then
            return invokeCallBack(nil)
        end
        invokeCallBack(ab)
    end)
end

function ModelLoader:loadPrefab(ab,abPath)
    if not ab then
        return
    end

    local paths = string.split(abPath,"/")
    local name = paths[#paths]
    local prefabName = name.."_prefab"

    -- 调用接口，加载资源
    local prefab =  Core.Loader.ABLoader:loadAsset(ab,prefabName)
    return prefab
end


function ModelLoader:inspectAbPath(abPath)
    abPath = string.lower(abPath)
    abPath = string.gsub(abPath,"model/","",1)
    abPath = string.gsub(abPath,"role/","",1)
    abPath = "model/role/"..abPath

    return abPath
end


return ModelLoader

