--[[
    author:chengjp
    time:2020-01-08 12:06:01
]]

local Listener = class("Listener")

function Listener:ctor(event,callBack,listener)
    self.event      = event 
    self.callBack   = callBack
    self.listener   = listener 
end

function Listener:dispatch(event,...)
    if self.callBack then 
        self.callBack(event,...)
    end
end



return Listener