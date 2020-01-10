--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 17:22
-- To change this template use File | Settings | File Templates.
--

--[[
--      @name:对应的代码的文件名称
--      @type:该界面的类型：
            1：普通类型，该界面会被保存
            2：该界面不会保存，在显示下个界面的时候会被销毁
            3：该界面将清空当前的缓存界面
            4：清空当前缓存界面并且该界面不会缓存
 ]]
local ViewDefine = {}

ViewDefine.TYPE =
{
    ROOT        = 1,        -- 根界面
    SAVE        = 2,        -- 界面会被保存
}



ViewDefine.LOGIN_VIEW = {name = "LoginView",type = 2}




return ViewDefine

