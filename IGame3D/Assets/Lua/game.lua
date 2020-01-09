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
end

return Game