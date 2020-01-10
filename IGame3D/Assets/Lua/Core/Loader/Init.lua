--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/9
-- Time: 17:04
-- To change this template use File | Settings | File Templates.
--

--[[
--      加载器的初始化界面
 ]]

local Loader = {}
Loader.ABLoader     = import(".ABLoader").new()
Loader.FguiLoader   = import(".FguiLoader").new()

return Loader
