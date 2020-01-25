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
     self.events  = eventMap or {} -- 所有的事件map
     self.container = Container.new(self)
end

function Dispatcher:isEventValid(event,log)
    local eventName = type(event) == "string" and event or event.name
    eventName       = eventName or "none"

    if not self.events[eventName] then 
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
--      @time:监听的次数
 ]]
function Dispatcher:addListenerByTime(time,event,callback,listener)
    if not self:isEventValid(event,"addListener") then
        return
    end

    self.container:addListener(event,callback,listener,time)
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


--[[
--      作为组件添加到对象上去
 ]]
function Dispatcher:apply(object)
    local funcList = {
        "addListener",
        "addListenerByTime",
        "removeListener",
        "removeByListener",
        "dispatch"
    }

    if not object then
        return self
    end

    object.__event = self
    for i = 1,#funcList do
        local func = funcList[i]
        object[func] = function(object,...)
            self[func](self, ...)
        end
    end

    return self
end


return Dispatcher