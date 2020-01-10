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
end

return LoginView
