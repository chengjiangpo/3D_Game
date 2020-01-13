--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 17:23
-- To change this template use File | Settings | File Templates.
--
local BaseUI = import(".BaseUI")

local BaseView = class("BaseView",BaseUI)

function BaseView:ctor(pkgName,resName,initData)
    BaseView.super.ctor(self,pkgName,resName)

    self.__viewType = nil
    self.__focus    = false

    self._initData  = initData or {}    -- key-value的形式，格式在App.Views中定义
end


--[[
--      初始化的数据
 ]]
function BaseView:getInitValue(key)
    return self._initData[key]
end

function BaseView:setInitValue(key,value)
    self._initData[key] = value
end

function BaseView:updateInitData(data)
    if not data then return end

    for k,v in pairs(data) do
        self._initData[k] = v
    end
end


--[[
--      界面类型参数的维护
 ]]
function BaseView:setViewType(viewType)
    self.__viewType = viewType
end

function BaseView:getViewType()
    return self.__viewType
end

function BaseView:isSameViewType(viewType)
    return self.__viewType == viewType
end


--[[
--      界面前后台状态的维护
 ]]
function BaseView:setFocus(focus)
    self.__focus = focus
end

function BaseView:isFocus()
    return self.__focus
end

--[[
--      添加到前台
 ]]
function BaseView:onFocus(data)
    self.__focus = true

    self:updateInitData(data)
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

