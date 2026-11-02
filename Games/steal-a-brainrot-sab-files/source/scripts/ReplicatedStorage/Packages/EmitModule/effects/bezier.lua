
local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = require("../mod/tween")
local v_u_4 = require("../mod/shape")
local v_u_5 = require("../mod/utility")
local v_u_6 = require("../obj/Bezier")
local v_u_7 = require("../pkg/Promise")
require("../obj/ObjectCache")
local v_u_38 = {
    ["Box"] = {
        ["Volume"] = v_u_4.getPointWithinBox,
        ["Surface"] = v_u_4.getPointOnBox
    },
    ["Cylinder"] = {
        ["Volume"] = function(p8, p9, p10, p11, p12)
            return v_u_4.getPointWithinCylinder(p8, 0, p12, p9, p10, p11)
        end,
        ["Surface"] = function(p13, p14, p15, p16, p17)
            return v_u_4.getPointWithinCylinder(p13, 1, p17, p14, p15, p16)
        end
    },
    ["Sphere"] = {
        ["Volume"] = function(p18, p19, p20, p21, p22)
            return v_u_4.getPointWithinSphere(p18, 0, p22, p19, p20, p21)
        end,
        ["Surface"] = function(p23, p24, p25, p26, p27)
            return v_u_4.getPointWithinSphere(p23, 1, p27, p24, p25, p26)
        end
    },
    ["Disc"] = {
        ["Volume"] = function(p28, p29, p30, p31, p32)
            return v_u_4.getPointWithinDisc(p28, 0, p32, p29, p30, p31)
        end,
        ["Surface"] = function(p33, p34, p35, p36, p37)
            return v_u_4.getPointWithinDisc(p33, 1, p37, p34, p35, p36)
        end
    }
}
local v39 = {}
local v_u_40 = nil
function v39.init(p41)
    v_u_40 = p41
end
function v39.deinit()
    v_u_40 = nil
end
function v39.emit()
end
return v39