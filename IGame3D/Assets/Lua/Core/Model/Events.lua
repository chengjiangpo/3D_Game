--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/19
-- Time: 17:41
-- To change this template use File | Settings | File Templates.
--

--[[
        最终需要的事件的格式为：
        "EVENT_NAME" = {name = "EVENT_NAME", handler = function()...end}
]]

local Events = {
    LOADED = {handler = function (modelName)
        return {modelName = modelName}
    end}
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