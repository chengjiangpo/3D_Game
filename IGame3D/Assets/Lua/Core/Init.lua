--[[
    author:chengjp
    time:2020-01-08 10:33:45
]]


require("Core.Global")

local Core = {}

Core.Debug = import(".Debug")
Core.Event = import(".Event.Init")



-- 定义全局日志
log   = Core.Debug.log
print = Core.Debug.log
warn  = Core.Debug.Warn 
error = Core.Debug.error

return Core 