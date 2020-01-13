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

    self.__viewType = nil
    self.__focus    = false
end

function BaseView:setViewType(viewType)
    self.__viewType = viewType
end

function BaseView:getViewType()
    return self.__viewType
end

function BaseView:isSameViewType(viewType)
    return self.__viewType == viewType
end

function BaseView:setFocus(focus)
    self.__focus = focus
end

function BaseView:isFocus()
    return self.__focus
end

--[[
--      添加到前台
 ]]
function BaseView:onFocus()
    self.__focus = true
end

--[[
--      添加到后台
 ]]
function BaseView:onLoseFocus()
    self.__focus = false
end

--[[
--      被销毁
 ]]
function BaseView:onDestory()
    self.__focus = false
end


return BaseView

