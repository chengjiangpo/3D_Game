--[[
        游戏的启动文件
]]
-- 引入FairyGUI
require("FairyGUI.FairyGUI")

-- 引入App名称空间
require("App.App")

local Game = class("Game")
function Game:ctor()

end

function Game:start()
    print("Game.start")
    App.View.Manager:openView(App.View.Views.LOGIN_VIEW)
end

return Game