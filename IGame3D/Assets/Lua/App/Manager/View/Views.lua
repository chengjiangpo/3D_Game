--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/10
-- Time: 17:22
-- To change this template use File | Settings | File Templates.
--

local ViewDefine = {}

ViewDefine.TYPE =
{
    ROOT       = 1,        -- 根界面，没有界面显示的时候就会自动显示根界面
    SAVE       = 2,        -- 界面会被保存
    CLEAN      = 3,        -- 清理前面所有的界面
}


--[[
--      @name:界面的名称
--      @type:界面的类型（界面的缓存方式）
--      @subViews: 系统子界面或切页
--      @initHandler: 创建界面时的数据接口
--      @focusHandler: focus时的数据接口
 ]]
ViewDefine.LOGIN_VIEW = {name = "LoginView",    type = 3,
    initHandler = function()
        return
    end,
    focusHandler = function()
        return
    end
}
ViewDefine.HOME_VIEW  = {name = "HomeView",     type = 1}
ViewDefine.FIGHT_VIEW = {name = "FightView",    type = 3}


return ViewDefine

