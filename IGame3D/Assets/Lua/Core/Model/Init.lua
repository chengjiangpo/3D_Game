--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/19
-- Time: 16:02
-- To change this template use File | Settings | File Templates.
--
local BaseModel = import(".BaseModel")
local Model = {}

Model.create = function(modelName,async,...)
    local model = BaseModel.new(modelName,...)
    if async then
        Core.Loader.ModelLoader:createAsync(modelName,function(go)
            model:setModel(go)
        end)
    else
        local obj = Core.Loader.ModelLoader:create(modelName)
        model:setModel(obj)
    end

    return model
end

return Model