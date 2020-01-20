--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/19
-- Time: 15:07
-- To change this template use File | Settings | File Templates.
--

local BaseModel = class("BaseModel")

function BaseModel:ctor(modelName)
    self:__regiseterEvents()
    self.modelName  = modelName
    self.model      = nil
    self.params     = {}
    self:__initSwitch()
end

function BaseModel:setModel(model)
    self.model = model
    self:onLoaded()
    return self
end

function BaseModel:getModel()
    return self.model
end

function BaseModel:isLoaded()
    return self.model ~= nil
end

function BaseModel:onLoaded()
    self:__initWithParams()

    self:dispatch(Core.Model.EVENTS.LOADED,self.modelName)
end

-----------------------------------------------------------------------------------------------
--------------------------------      属性设置和获取        ------------------------------------
-- 父节点
function BaseModel:setParent(parent)
    self:__setParams("parent",parent)
end

function BaseModel:getParent()
    return self:__getParams("parent")
end

-- 位置
function BaseModel:setPosition(x,y,z)
    local pos = self:__newVector3("position",x,y,z)
    self:__setParams("position",pos)
end

function BaseModel:getPosition()
    return self:__getParams("position")
end

-- 旋转
function BaseModel:setRotation(x,y,z)
    local rotation = self:__newVector3("rotation",x,y,z)
    self:__setParams("rotation",rotation)
end

function BaseModel:getRotation()
    return self:__getParams("rotation")
end

-- 缩放
function BaseModel:setScale(x,y,z)
    local scale = self:__newVector3("scale",x,y,z)
    self:__setParams("scale",scale)
end

function BaseModel:getScale()
    self:__getParams("scale")
end


function BaseModel:__newVector3(type,x,y,z)
    local old  = self:__getParams(type) or Vector3.New(0,0,0)
    x = x or old.x
    y = y or old.y
    z = z or old.z

    return Vector3.New(x,y,z)
end

function BaseModel:__initSwitch()
    self.switchs = {
        parent   =
        {
            set = function(value)
                self.model.transform.parent = value
            end,
            get = function()
                return self.model.transform.parent
            end
        },
        position = {
            set = function(value)
                self.model.transform.localPosition = value
            end,
            get = function()
                return self.model.transform.localPosition
            end,
        },
        rotation = {
            set = function(value)
                self.model.transform.localRotation = value
            end,
            get = function()
                return self.model.transform.localRotation
            end
        },
        scale = {
            set = function(value)
                self.model.transform.localScale = value
            end,
            get = function()
                return self.model.transform.localScale
            end
        },
    }
end

function BaseModel:__setParams(key,value)
    self.params[key] = value

    if not self.model then
        return
    end

    local switch = self.switchs[key]
    if switch and switch.set then
        switch.set(value)
    end
end

function BaseModel:__getParams(key)
    if not self.model then
        return self.params[key]
    end

    local switch = self.switchs[key]
    if switch and switch.get then
        switch.get(key)
    end
end

function BaseModel:__initWithParams()
    for k,v in pairs(self.params) do
        self:__setParams(k,v)
    end
end

--------------------------------------------------------------------------------------------
--------------------------      控制变量        ---------------------------------------------
function BaseModel:getAnimator()
    if not self.model then
        error("model is not inited!")
        return
    end

    local animator = self.model:GetComponent("Animator")
    if not animator then
        error("Animator 组件不存在！"..self.modelName)
        return
    end

    return animator
end

function BaseModel:setBool(key,value)
    self:setValue(Core.Model.KEY_TYPE.BOOL,key,value)
end

function BaseModel:setInt(key,value)
    self:setValue(Core.Model.KEY_TYPE.INT,key,value)
end

function BaseModel:setFloat(key,value)
    self:setValue(Core.Model.KEY_TYPE.FLOAT,key,value)
end

function BaseModel:trigger(key)
    self:setValue(Core.Model.KEY_TYPE.TRIGGER,key,nil)
end

function BaseModel:setValue(type,key,value)
    if not self.model then
        return
    end

    local animator = self:getAnimator()
    if not animator then
        return
    end

    if type == Core.Model.KEY_TYPE.BOOL then
        animator:SetBool(key,value and true or false )
    elseif type == Core.Model.KEY_TYPE.FLOAT then
        animator:SetFloat(key,value)
    elseif type == Core.Model.KEY_TYPE.INT then
        animator:SetInt(key,value)
    elseif type == Core.Model.KEY_TYPE.TRIGGER then
        animator:Trigger(key)
    end
end

function BaseModel:getBool(key)
    return self:getValue(Core.Model.KEY_TYPE.BOOL,key)
end

function BaseModel:getInt(key)
    return self:getValue(Core.Model.KEY_TYPE.INT,key)
end

function BaseModel:getFloat(key)
    return self:getValue(Core.Model.KEY_TYPE.FLOAT,key)
end

function BaseModel:getValue(type,key)
    if not self.model then
        return nil
    end

    local animator = self.model:GetComponent("Animator")
    if not animator then
        error("Animator 组件不存在！")
        return nil
    end

    if type == Core.Model.KEY_TYPE.BOOL then
        return animator:GetBool(key)
    elseif type == Core.Model.KEY_TYPE.FLOAT then
        return animator:GetFloat(key)
    elseif type == Core.Model.KEY_TYPE.INT then
        return animator:GetInt(key)
    end

    return nil
end


function BaseModel:test()
    local animator = self.model:GetComponent("Animator")
    if not animator then
        return
    end

    local list = {"idle","run","dead"}
    local state = animator:GetCurrentAnimatorStateInfo(0)
    for i = 1,#list do
        if state:IsName(""..list[i]) then
            print(string.format("当前动作：%s, time = %f,length = %f",list[i],state.normalizedTime,state.length))
            if state.normalizedTime >= 1 then
                animator.speed = 0
            end
        end
    end
end

-----------------------------------------------------------------------------------------------
----------------------------------      事件监听        ----------------------------------------
--[[
--      注册事件监听组件
 ]]
function BaseModel:__regiseterEvents()
    local onLoadEvent = function()
        if self:isLoaded() then
            self:dispatch(Core.Model.EVENTS.LOADED,self.modelName)
            return
        end
    end

    Core.Event.Dispatcher.new(Core.Model.EVENTS):apply(self)   -- 注册事件监听的接口
    local addListener = self.addListener
    self.addListener =function(self,event,...)
        -- 在监听loaded事件的时候需要判断当前是否已经加载完成，如果是，则立即派发loaded事件
        if event == Core.Model.EVENTS.LOADED then
            self:addListenerByTime(1,event,...)
            onLoadEvent()
            return
        end

        addListener(self,event,...)
    end

    local addListenerByTime = self.addListenerByTime
    self.addListenerByTime =function(self,time,event,...)
        addListenerByTime(self,time,event,...)
        -- 在监听loaded事件的时候需要判断当前是否已经加载完成，如果是，则立即派发loaded事件
        if event == Core.Model.EVENTS.LOADED then
            if event == Core.Model.EVENTS.LOADED then
                onLoadEvent()
            end
        end
    end
end


return BaseModel

