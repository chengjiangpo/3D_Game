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
App.event      = Core.Event.Dispatcher.new(events)

-- 初始化App下的proxy
App.proxy      = import(".Manager.Proxy.Init")

-- 初始化App下的Datas
App.datas      = import(".Manager.Datas.Init")


App.Layers     = import(".Manager.View.Layers")
App.BaseUI     = import(".Manager.View.BaseUI")
App.BaseView   = import(".Manager.View.BaseView")
App.Views      = import(".Manager.View.Views")
App.ViewManager = import(".Manager.View.ViewManager").new()

