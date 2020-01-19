--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/19
-- Time: 15:07
-- To change this template use File | Settings | File Templates.
--

local BaseModel = class("BaseModel")

function BaseModel:ctor(modelName)
    self.modelName  = modelName
    self.model      = nil
end

function BaseModel:setModel(model)
    self.model = model
    return self
end

function BaseModel:getModel()
    return self.model
end






return BaseModel

