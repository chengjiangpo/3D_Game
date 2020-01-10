--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 17:19
-- To change this template use File | Settings | File Templates.
--

--[[
--      UI管理
 ]]
local ViewManager = class("ViewManager")

function ViewManager:ctor()
    self.views = {}
end

function ViewManager:openView(viewType,...)
    -- 创建界面并添加到列表中
    local view = require("Game.Views."..viewType.name).new(...)
    view:setParent(App.Layers.UILayer)
    table.insert(self.views,view)
end

function ViewManager:popView()

end

function ViewManager:getCurView()
    if #self.views == 0 then
        return nil
    end

    return self.views[#self.views]
end



return ViewManager

