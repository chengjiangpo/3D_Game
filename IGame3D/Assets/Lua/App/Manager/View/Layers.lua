--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 17:06
-- To change this template use File | Settings | File Templates.
--

--[[
--      Layer的层级管理
 ]]

local BaseUI = import(".BaseUI")
local Layers = {}

Layers.UILayer      = BaseUI.new():setUI(fgui.GComponent.New())
Layers.DialogLayer  = BaseUI.new():setUI(fgui.GComponent.New())

Layers.UILayer:setParent(fgui.GRoot.inst)
Layers.DialogLayer:setParent(fgui.GRoot.inst)

return Layers
