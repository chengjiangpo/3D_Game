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
    -- 判断缓存列表中是否有该界面，如果有，直接显示
    if self:__showView() then
        return
    end

    -- 创建界面并添加到列表中
    local view = require("App.Views."..viewType.name).new(...)
    view:setViewType(viewType)
    self:__onOpenView(view)
end


--[[
--      界面回退
 ]]
function ViewManager:popView()
    local viewCount = #self.views
    if viewCount > 1 then
        self:__onViewLoseFocus(self.views[viewCount])
        self:__onViewFocus(self.views[viewCount - 1])
    end
end


--[[
--      当前展示的界面
 ]]
function ViewManager:getCurView()
    if #self.views == 0 then
        return nil
    end

    return self.views[#self.views]
end

function ViewManager:getOpenedView(viewType)
    for i = 1,#self.views do
        local view = self.views[i]
        if view:isSameViewType(viewType) then
            return view
        end
    end
end


------------------------------------------------------------------------------------------------------------------------
--[[
--      添加新的界面到队列中
 ]]
function ViewManager:__onOpenView(view)
    if not view then
        return
    end

    -- 检查当前界面的类型，判断前面的界面的处理方式
    local viewType = view:getViewType()
    if viewType.type == App.Views.TYPE.ROOT
            or viewType.type == App.Views.TYPE.CLEAN
    then
        -- 清空所有队列
        for i = #self.views,1,-1 do
            local _view = self.views[i]
            self:__onViewDestory(_view)
            table.remove(self.views,i)
        end
    else
        -- loseFocus前面的界面
        for i = #self.views,1,-1 do
            local _view = self.views[i]
            self:__onViewLoseFocus(_view)
        end
    end

    -- 添加到队列中
    view:setParent(App.Layers.UILayer)
    table.insert(self.views,view)
end

--[[
--      查找队列中是否有对应的view，如果有则显示(并移除该界面后面的所有的界面)
 ]]
function ViewManager:__showView(viewType)
    local view = nil
    local index = 0
    -- 检查当前界面是否在队列中，如果是，显示该界面
    for i = 1,#self.views do
        local _view = self.views[i]
        if not view then
            if _view:isSameViewType(viewType) then
                view = _view
                index = i
                break
            end
        end
    end

    if view then
        for i = #self.views,index + 1,-1 do
            local _view = self.views[i]
            self:__onViewDestory(_view)
            table.remove(self.views,i)
        end

        self:__onViewFocus(view)
    end
    return view
end

function ViewManager:__onViewFocus(view)
    if not view then
        return
    end

    if view:isFocus() then
        warn("view is now focused!:"..view:getViewType().name)
        return
    end

    view:setVisible(true)
    view:onFocus()
end

function ViewManager:__onViewLoseFocus(view)
    if not view then
        return
    end

    if not view:isFocus() then
        warn("view is now unfocus!:"..view:getViewType().name)
        return
    end

    view:setVisible(false)
    view:onLoseFocus()
end

function ViewManager:__onViewDestory(view)
    if not view then
        return
    end

    view:removeFromParent()
end

return ViewManager

