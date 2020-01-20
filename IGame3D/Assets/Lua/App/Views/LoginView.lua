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
        if not self.model then
            self.model = Core.Model.create("liubei",false)
            self.model:addListenerByTime(1,Core.Model.EVENTS.LOADED,function(event,data)
                print("模型加载成功："..data.modelName)
            end)

        else
            local params = {"idle","run","dead" }
            self.index = self.index or 0
            self.index = (self.index)%(#params) + 1

            for i = 1,#params do
                self.model:setBool(params[i],i == self.index)
            end
        end

--        Core.Timer.addTimer(0.1,0,function()
--            self.model:test()
--        end)
     end))
end

return LoginView
