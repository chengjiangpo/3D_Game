--[[
        游戏的启动文件
]]
-- 引入FairyGUI
require("FairyGUI.FairyGUI")

-- 引入App名称空间
require("Game.App")

local Game = class("Game")
function Game:ctor()
end

function Game:start()
    print("Game.start")
    local ui = Core.Loader.FguiLoader:createUI("LoginScene","Scene")
    fgui.GRoot.inst:AddChild(ui)
end

return Game