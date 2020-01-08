--[[
    author:chengjp
    time:2020-01-08 16:04:22
]]

--[[
        逻辑层名称空间，提供逻辑层的部分接口
]]
local App = {}

-- 创建App下的通用事件派发器
local events   = import(".Events")
App.event      = Core.Event.Dispatcher.new(events)

return App 