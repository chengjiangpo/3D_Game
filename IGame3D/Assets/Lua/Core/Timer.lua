local Timer = {
    listenerList = {};
}

----------------------------------------------------------------------------------------
--[[
--      基于FairyGUI的定时器，回调的最小间隔为帧刷新的间隔
--      @interval：间隔
--      @loop：循环的次数，0表示无限循环
--      @func：回调函数
--      @obj：对象句柄
--      @param：额外参数
]]
function Timer.addTimer(interval, loop, func, obj, param)
    interval    = interval or 0.01
    loop        = loop or 0
    local callbackParam
    if param~=nil then
        if obj==nil then
            callbackParam=param
        else
            callbackParam=obj
            func = function(p)
                func(p, param)
            end
        end
    end

    local delegate = delegate(func, obj,  FairyGUI.TimerCallback)
    FairyGUI.Timers.inst:Add(interval, loop, delegate, callbackParam)

    table.insert(Timer.listenerList,delegate)

    return delegate
end


function Timer.removeTimer( delegate)
    -- body
    if delegate then
        FairyGUI.Timers.inst:Remove(delegate)
        for k,v in ipairs(Timer.listenerList) do
            if v == delegate then
                table.remove(Timer.listenerList,k)
            end
        end

    end
end

function Timer.destory(  )
    -- body
    for k,delegate in ipairs(Timer.listenerList) do
        FairyGUI.Timers.inst:Remove(delegate)
    end

    Timer.listenerList = {};

end

return Timer;