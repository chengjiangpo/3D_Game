--[[
    author:chengjp
    time:2020-01-08 10:33:56
]]

local Logger = {}
_print = print
function  Logger.log(log)
    _print("[lua] "..log)
end

function  Logger.warn(warn)
    warn = warn or ""
    UnityEngine.Debug.LogWarning("[lua]"..warn);
end

function  Logger.error(error)
    error = error or ""
    UnityEngine.Debug.LogError("[lua]"..error);
end



-- 定义全局日志
log   = Logger.log
print = Logger.log
warn  = Logger.warn
error = Logger.error

return Logger