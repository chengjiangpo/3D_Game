--[[
    author:chengjp
    time:2020-01-08 10:33:45
]]


require("Core.Global")

local Core = {}

Core.Debug      = import(".Debug.Init")
Core.Event      = import(".Event.Init")
Core.Loader     = import(".Loader.Init")
Core.Model      = import(".Model.Init")
return Core 