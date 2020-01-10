--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 17:23
-- To change this template use File | Settings | File Templates.
--
local BaseUI = import(".BaseUI")

local BaseView = class("BaseView",BaseUI)

function BaseView:ctor(pkgName,resName)
    BaseView.super.ctor(self,pkgName,resName)
end

--[[
--      添加到前台
 ]]
function BaseView:onFocus()

end

--[[
--      添加到后台
 ]]
function BaseView:onLoseFocus()

end



return BaseView

