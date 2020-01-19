--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 16:55
-- To change this template use File | Settings | File Templates.
--

local LoginView = class("LoginView",App.View.BaseView)

function LoginView:ctor(initData)
    LoginView.super.ctor(self,"LoginScene","Scene",initData)

    self:initUI()
end

function LoginView:initUI()
    local btnLogin = self:getChild("btn_login")
    btnLogin.onClick:Set(delegate(function()
--        App.View.Manager:openView(App.View.Views.HOME_VIEW)
        Core.Model.create("liubei",true)
     end))
end

return LoginView
