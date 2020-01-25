--
-- Created by IntelliJ IDEA.
-- User: chengjp.
-- Date: 2020/1/14
-- Time: 10:17
-- To change this template use File | Settings | File Templates.
--

local view = {}

view.Layers         = import(".Layers")
view.BaseUI         = import(".BaseUI")
view.BaseView       = import(".BaseView")
view.Views          = import(".Views")
view.Manager        = import(".ViewManager").new()

return view

