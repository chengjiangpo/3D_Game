--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/13
-- Time: 17:18
-- To change this template use File | Settings | File Templates.
--

local HomeView = class("HomeView",App.View.BaseView)

function HomeView:ctor(initData)
    HomeView.super.ctor(self,"HomeScene","Scene",initData)
    self:initUI()
end

function HomeView:initUI()

end

return HomeView