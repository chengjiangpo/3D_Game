--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 15:38
-- To change this template use File | Settings | File Templates.
--

--[[
--      Fgui的基类
 ]]
local BaseUI     = class("BaseUI")

function BaseUI:ctor(pkgName,resName)
    self.pkgName = pkgName
    self.resName = resName
    self.ui      = nil

    self:initUI()
end

function BaseUI:getUI()
    return self.ui
end

--[[
--      加载UI
 ]]
function BaseUI:initUI()
    if not self.pkgName or not self.resName then return self end
    self.ui = Core.Loader.FguiLoader:createUI(self.pkgName,self.resName)
    return self
end

function BaseUI:setUI(ui)
    self.ui = ui
    return self
end


--[[
--      获取子节点，可以获取多层子节点
 ]]
function BaseUI:getChild(path)
    if not self.ui then
        error("BaseUI:getChild ui is not init:"..self:formatPath())
        return
    end

    local paths = string.split(path,".")
    local child = self.ui
    local full  = ""
    for i = 1,#paths do
        local name = paths[i]
        full = full .. name .. "."
        child = child:GetChild(name)
        if not child then
            warn("child is not exist: "..full)
            return nil
        end
    end

    return child
end

--[[
--      添加父、子节点
 ]]
function BaseUI:setParent(parent)
    if not self.ui then
        error("BaseUI:setParent ui is not init! "..self:formatPath())
        return
    end

    if not parent then
        error("BaseUI:setParent parent is nil! "..self:formatPath())
        return
    end

    if type(parent) == "userdata" then
        parent:AddChild(self.ui)
    else
        parent:addChild(self.ui)
    end
    return self
end

function BaseUI:addChild(child)
    if not self.ui then
        error("BaseUI:setParent ui is not init! "..self:formatPath())
        return
    end

    if not child then
        error("BaseUI:addChild child is nil!"..self:formatPath())
        return
    end

    if type(child) == "userdata" then
        self.ui:AddChild(child)
    elseif child.ui then
        self.ui:AddChild(child.ui)
    else
        error("BaseUI:addChild child is not avalid!"..self:formatPath())
    end
end

function BaseUI:removeChild(child)
    if not self.ui then
        error("BaseUI:removeChild ui is not init! "..self:formatPath())
        return
    end

    if not child then
        warn("BaseUI:removeChild child is nil:"..self:formatPath())
        return
    end

    if type(child) == "usertable" then
        self.ui:RemoveChild(child)
    else
        self.ui:RemoveChild(child.ui)
    end
end

function BaseUI:removeFromParent()
    if not self.ui then
        error("BaseUI:removeFromParent ui is not init! "..self:formatPath())
        return
    end

    local parent = self.ui.parent
    if parent then
        parent:RemoveChild(self.ui)
    end
end

function BaseUI:getParent()
    if not self.ui then
        error("BaseUI:getParent ui is not init! "..self:formatPath())
        return
    end

    return self.ui.parent
end

function BaseUI:formatPath()
    return self.pkgName.."."..self.resName
end


return BaseUI

