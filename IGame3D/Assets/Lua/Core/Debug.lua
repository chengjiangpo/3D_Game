--[[
    author:chengjp
    time:2020-01-08 10:33:56
]]

local Debug = {}
_print = print
function  Debug.log(log)
    _print("[lua] "..log)
end

function  Debug.warn(warn)
    warn = warn or ""
    UnityEngine.Debug.LogWarning("[lua]"..warn);
end

function  Debug.error(error)
    error = error or ""
    UnityEngine.Debug.LogError("[lua]"..error);
end

return Debug