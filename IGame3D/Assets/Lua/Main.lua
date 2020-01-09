

-- 引入Core库
Core = require("Core.Init")


--场景切换通知
function OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function OnApplicationQuit()
end


--主入口函数。从这里开始lua逻辑
function Main()		
    print("Lua logic start")	
    require("Game").new():start()
end

function __G__TRACKBACK__(errorMessage)
    if errorMessage ~= "attempt to call a nil value" then
        local msg = "----- Lua error begin -----\n"
        msg = msg .. tostring(errorMessage)
        msg = msg .. debug.traceback("", 2)
        msg = msg .. "\n----- Lua error end -----"
        error(msg)
    end
end

local status, msg = xpcall(Main, __G__TRACKBACK__)

collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)