--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/19
-- Time: 15:07
-- To change this template use File | Settings | File Templates.
--

local BaseModel = class("BaseModel")

function BaseModel:ctor(modelName)
    self:regiseterEvents()
    self.modelName  = modelName
    self.model      = nil
end

--[[
--      注册事件监听组件，在监听loaded事件的时候需要判断当前是否已经加载完成，如果是，则立即派发loaded事件
 ]]
function BaseModel:regiseterEvents()
    Core.Event.Dispatcher.new(Core.Model.EVENTS):apply(self)   -- 注册事件监听的接口
    local addListener = self.addListener
    self.addListener =function(self,event,...)
        addListener(self,event,...)

        if event == Core.Model.EVENTS.LOADED then
            if self:isLoaded() then
                self:dispatch(Core.Model.EVENTS.LOADED,self.modelName)
                return
            end
        end


    end
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
    self:dispatch(Core.Model.EVENTS.LOADED,self.modelName)
end





--------------------------------------------------------------------------------------------
--------------------------      控制变量        ---------------------------------------------
function BaseModel:setBool(key,value)
    self:setValue(Core.Model.KEY_TYPE.BOOL,key,value)
end

function BaseModel:setInt(key,value)
    self:setValue(Core.Model.KEY_TYPE.INT,key,value)
end

function BaseModel:setFloat(key,value)
    self:setValue(Core.Model.KEY_TYPE.FLOAT,key,value)
end

function BaseModel:setBool(key,value)
    self:setValue(Core.Model.KEY_TYPE.TRIGGER,key,value)
end

function BaseModel:setValue(type,key,value)
    if not self.model then
        return
    end

    local animator = self.model:GetComponent("Animator")
    if not animator then
        error("Animator 组件不存在！")
        return
    end

    if type == Core.Model.KEY_TYPE.BOOL then
        self:SetBool(key,value and true or false )
    elseif type == Core.Model.KEY_TYPE.FLOAT then
        self:SetFloat(key,value)
    elseif type == Core.Model.KEY_TYPE.INT then
        self:SetInt(key,value)
    elseif type == Core.Model.KEY_TYPE.TRIGGER then
        self:Trigger(key)
    end
end




return BaseModel

