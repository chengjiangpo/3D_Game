--[[
    author:chengjp
    time:2020-01-08 15:00:09
]]

--[[
            记录所有的事件监听对象
]]

local Listener          = import(".Listener")
local Container         = class("Container")
function Container:ctor(dispatcher)
    self.dispatcher     = dispatcher
    self.listenerMap    = {}  
end

--[[
        添加事件监听
]]
function Container:addListener(event,callback,listener)
    local obj = Listener.new(event,callback,listener)
    
    self.listenerMap[event] = self.listenerMap[event] or {}
    table.insert(self.listenerMap[event],obj)
end

--[[
        移除某一个事件的所有的监听
]]
function Container:removeByEvent(event)
    self.listenerMap[event] = {}
end

--[[
        移除某一个监听对象的所有监听事件
]]
function  Container:removeByListener(listener)
    for name,list in pairs(self.listenerMap) do 
        local index = 1
        while(index <= #list)
        do 
            local obj = self.list[index]
            if obj.listener and obj.listener == listener then 
                table.remove( list,index )
            else
                index = index + 1 
            end
        end
    end
end

--[[
        发送消息并返回接收到消息的监听对象
]]
function Container:dispatch(event,...)
    -- 调用event中的数据结构接口整理数据
    local params = {...}
    if event.handler then 
        params = event.handler(...) 
    end

    local dispatchList = {}
    local list = self.listenerMap[event] or {}
    for i = 1,#list do 
        local obj = list[i]
        if obj and obj:isAble() then 
            obj:dispatch(event,unpack(params))
            table.insert(dispatchList,obj)
        end
    end

    return dispatchList
end

return Container 