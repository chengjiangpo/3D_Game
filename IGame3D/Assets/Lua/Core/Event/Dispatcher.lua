--[[
    author:chengjp
    time:2020-01-08 14:26:14
]]

--[[
        事件监听和派发的接口
        事件定义的例子(handler可以不存在，如果不存在则根据传入的数据直接派发事件)：
         "EVENT_NAME" = {name = "EVENT_NAME",handler = function(a,b,c) 
            return{a = a , bb = b, ccc = c} 
        end}
]]

local Container = import(".Container")
local Dispatcher = class("Dispatcher")

function Dispatcher:ctor(eventMap)
     self.eventMap  = eventMap or {} -- 所有的事件map
     self.container = Container.new(self)
end

function Dispatcher:isEventValid(event,log)
    local eventName = type(event) == "string" and event or event.name
    eventName       = eventName or "none"

    if not self.eventMap[eventName] then 
        if log then 
            warn(string.format( "event[ %s ] is not exist! (key = %s)",eventName,log))
        end
        return false 
    end

    return true 
end

--[[
        添加监听
]]
function Dispatcher:addListener(event,callback,listener)
    if not self:isEventValid(event,"addListener") then 
        return 
    end 
    self.container:addListener(event,callback,listener)
end

--[[
        移除监听
]]
function Dispatcher:removeListener(event)
    self.container:removeByEvent(event)
end

function Dispatcher:removeByListener(listener)
    self.container:removeByListener(listener)
end

--[[
        事件派发
]]
function Dispatcher:dispatch(event,...)
    if not self:isEventValid(event,"dispatch") then 
        return 
    end 

    self.container:dispatch(event,...)
end



return Dispatcher