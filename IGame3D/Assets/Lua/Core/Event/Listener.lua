--[[
    author:chengjp
    time:2020-01-08 12:06:01
]]

local Listener = class("Listener")

function Listener:ctor(event,callBack,listener,time)
    self.event      = event 
    self.callBack   = callBack
    self.listener   = listener
    self.time       = time or -1    -- -1表示无限次数
end

function Listener:dispatch(event,...)
    if self.callBack then
        if self.time  == 0 then
            return
        elseif self.time > 0 then
            self.time = self.time - 1
        end

        self.callBack(event,...)
    end
end



return Listener