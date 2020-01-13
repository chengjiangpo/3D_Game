--[[
        author:chengjp
        time:2020-01-08 16:05:56
]]

--[[
        最终需要的事件的格式为：
        "EVENT_NAME" = {name = "EVENT_NAME", handler = function()...end}
]]

local Events = {
    TEST = {handler = function (a,b,c)
        return {x = a,y = b, z= c}
    end},
}


--[[
        整理消息的格式，使之与消息监听系统相匹配
]]
local formatEvents = function (eventList)
    local list = clone(eventList)
    for k,v in pairs(list) do 
        if v and v.name == nil then 
            v.name = k
        end
    end

    return list
end


return formatEvents(Events)








