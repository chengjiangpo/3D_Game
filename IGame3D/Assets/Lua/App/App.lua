--[[
    author:chengjp
    time:2020-01-08 16:04:22
]]

--[[
        逻辑层名称空间，提供逻辑层的部分接口
]]
App = {}

-- 创建App下的通用事件派发器
local events   = import(".Manager.Event.Events")
App.Event      = Core.Event.Dispatcher.new(events)

-- 初始化App下的proxy
App.Proxy      = import(".Manager.Proxy.Init")

-- 初始化App下的Datas
App.Data       = import(".Manager.Datas.Init")

-- 初始化View
App.View       = import(".Manager.View.Init")



