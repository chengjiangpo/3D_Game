--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 16:55
-- To change this template use File | Settings | File Templates.
--

local LoginView = class("LoginView",App.BaseView)

function LoginView:ctor()
    LoginView.super.ctor(self,"LoginScene","Scene")

    self:initUI()
end

function LoginView:initUI()
    local btnLogin = self:getChild("btn_login")
    btnLogin.onClick:Set(delegate(function()
        App.ViewManager:openView(App.Views.HOME_VIEW)

     end))
end

return LoginView
