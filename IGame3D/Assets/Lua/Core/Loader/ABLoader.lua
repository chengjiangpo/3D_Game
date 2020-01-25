--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/9
-- Time: 17:04
-- To change this template use File | Settings | File Templates.
--

--[[
--      AB包的加载器，注意生成的AB包的名称为小写字母，所以在加载的时候需要将大写字母全部替换成小写字母
 ]]

-- 定义AB包的加载状态
local LOAD_STATE = {
    NONE        = 0,    -- 未加载
    LOADING     = 1,    -- 加载中
    LOADED      = 2,    -- 已加载
    UNLOAD      = 3,    -- 将要销毁
}


local ABStore   = class("ABStore")
local ABLoader  = class("ABLoader")
------------------------------------------------------------------------------------------------
---------------------------------       AB包加载器        ---------------------------------------
function ABLoader:ctor()
    self.loadedMap = {}    --  已经加载完成的AB包的记录
end

--[[
--      查看本地是否已经缓存
 ]]
function ABLoader:findStore(abPath)
    abPath = string.lower(abPath)
    return self.loadedMap[abPath]
end

function ABLoader:newABStore(abPath)
    local abStore = ABStore.new(abPath)
    self.loadedMap[abPath] = abStore
    return abStore
end

function ABLoader:load(abPath)
    abPath = string.lower(abPath)
    local abStore = self:findStore(abPath) or self:newABStore(abPath)
    abStore:load()
    local ab = abStore:getABRes()
    if not ab then
        warn("ab is not exist: "..abPath)
    end
    return ab
end

function ABLoader:loadAsync(abPath,callback)
    local abStore = self:findStore(abPath) or self:newABStore(abPath)
    self.loadedMap[abPath] = abStore
    abStore:loadAsync(callback)
end

function ABLoader:unload(abPath)
    local abStore = self:findStore(abPath)
    if abStore then
        abStore.state = LOAD_STATE.UNLOAD

        if abStore.state == LOAD_STATE.LOADED then

        end
    end
end

function ABLoader:loadAsset(ab,assetName)
    if not ab then
       warn("ab is nil!")
        return
    end

    return IGame3D.ABLoader.loadAsset(ab,assetName)
end

------------------------------------------------------------------------------------------------
---------------------------------       AB包存储结构        -------------------------------------
function ABStore:ctor(abPath,abRes,state)
    self.abPath = abPath
    self.abRes  = abRes
    self.state  = state or LOAD_STATE.NONE
    self.callbacks = {}
end

function ABStore:getABPath()
    return self.abPath
end

function ABStore:setABRes(abRes)
    self.abRes = abRes
end

function ABStore:getABRes()
    return self.abRes
end

function ABStore:setState(state)
    self.state = state
end

function ABStore:getState()
    return self.state
end

function ABStore:load(callback)
    table.insert(self.callbacks,callback)
    if self.state == LOAD_STATE.LOADED then
        return self:onLoaded(self.abRes)
    else
        local abRes = IGame3D.ABLoader.Instance:load(self.abPath)
        return self:onLoaded(abRes)
    end
end

function ABStore:loadAsync(callback)
    table.insert(self.callbacks,callback)
    if self.state == LOAD_STATE.LOADED then
        return self:onLoaded(self.abRes)
    elseif self.state == LOAD_STATE.NONE then
        -- 调用异步加载的接口
        IGame3D.ABLoader.Instance:loadAsync(self.abPath,function(abRes)
            return self:onLoaded(abRes)
        end)
    end
end

function ABStore:onLoaded(abRes)
    self.abRes = abRes
    self.state = LOAD_STATE.LOADED

    for i = 1,#self.callbacks do
        local callback = self.callbacks[i]
        if callback then
            callback(self.abRes)
        end
    end

    -- 清空callback列表
    self.callbacks = {}

    if not self.abRes then
        warn("ab is not exist: "..self.abPath)
    end
end

return ABLoader

