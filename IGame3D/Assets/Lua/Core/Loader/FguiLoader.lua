--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/9
-- Time: 16:56
-- To change this template use File | Settings | File Templates.
--

--[[
--      FairyGUI的加载器
 ]]
local FguiLoader = class("FguiLoader")


function FguiLoader:load(abPath)
    local index = string.find(abPath,"fgui/") or 0
    if index ~= 1 then
        abPath = "fgui/" .. abPath;
    end

    local ab = Core.Loader.ABLoader:load(abPath)
    if not ab then
        warn("fgui is not exist: "..abPath)
        return
    end

    return fgui.UIPackage.AddPackage(ab)
end

--[[
--      创建UI， 默认情况下，包的名称和AB包的路径相同，只需要前面加上"fgui/"即可
--
 ]]
function FguiLoader:createUI(pkgName,resName)
    -- 加载AB包并添加到UIPackage中管理。
    self:load(pkgName)

    -- 创建UI对象
    local ui = fgui.UIPackage.CreateObject(pkgName,resName)
    return ui
end



return FguiLoader

