
local v_u_1 = require("./utility")
local v_u_118 = {
    ["getSurfaceCFrame"] = function(p2, p3, p4)
        local v5 = p3:Dot(Vector3.new(0, 1, 0))
        local v6 = math.abs(v5) > 0.99 and Vector3.new(0, 0, 1) or Vector3.new(0, 1, 0)
        local v7 = CFrame.lookAt(Vector3.new(0, 0, 0), p3, v6)
        return p2 * CFrame.new(p4) * v7
    end,
    ["getPointWithinBox"] = function(p8, p9, p10, p11)
        debug.profilebegin("getPointWithinBox")
        local v12 = Random.new(p8)
        local v13 = p10 / 2
        local v14 = v12:NextNumber(-1, 1)
        local v15 = v12:NextNumber(-1, 1)
        local v16 = Vector3.new(v14, v15, v12:NextNumber(-1, 1)) * v13
        local v17 = v_u_118.getSurfaceCFrame(p9, Vector3.FromNormalId(p11), v16)
        debug.profileend()
        return v17
    end,
    ["getPointOnBox"] = function(p18, p19, p20, p21)
        debug.profilebegin("getPointOnBox")
        local v22 = Random.new(p18)
        local v23 = Vector3.FromNormalId(p21)
        local v24 = p20 / 2
        local v25 = Vector3.new(1, 1, 1) - v23:Abs()
        local v26 = v22:NextNumber(-1, 1)
        local v27 = v22:NextNumber(-1, 1)
        local v28 = Vector3.new(v26, v27, v22:NextNumber(-1, 1)) * v24 * v25
        local v29 = v_u_118.getSurfaceCFrame(p19, v23, v28 + v23 * v24)
        debug.profileend()
        return v29
    end,
    ["getPointWithinCylinder"] = function(p30, p31, p32, p33, p34, p35)
        debug.profilebegin("getPointWithinCylinder")
        local v36 = Random.new(p30)
        local v37 = v36:NextNumber(p31, 1)
        local v38 = math.sqrt(v37)
        local v39 = v36:NextNumber(0, 6.283185307179586)
        if p35 == Enum.NormalId.Left or p35 == Enum.NormalId.Right then
            p33 = p33 * CFrame.fromOrientation(0, 1.5707963267948966 * (p35 == Enum.NormalId.Right and -1 or 1), 0)
            local v40 = p34.Z
            local v41 = p34.Y
            local v42 = p34.X
            p34 = Vector3.new(v40, v41, v42)
        elseif p35 == Enum.NormalId.Front or p35 == Enum.NormalId.Back then
            p33 = p33 * CFrame.fromOrientation(0, 3.141592653589793, 0)
        end
        local v43 = 1 - v36:NextNumber() ^ v_u_1.lerp(0.5, 1, (math.sqrt(p32)))
        local v44 = v_u_1.lerp(1, p32, v43)
        local v45 = v43 * 2 - 1
        local v46 = v38 * math.sin(v39) * v44
        local v47 = v38 * math.cos(v39) * v44
        local v48 = Vector3.new(v45, v46, v47) * p34 / 2
        local v49 = math.sin(v39) * v44
        local v50 = math.cos(v39) * v44
        local v51 = Vector3.new(0, v49, v50) * p34 / 2
        local v52 = math.cos(v39) * v44
        local v53 = -math.sin(v39) * v44
        local v54 = Vector3.new(0, v52, v53) * p34 / 2
        local v55 = v54.Magnitude > 0.001 and v54.Unit or p33.UpVector
        local v56 = p33 * CFrame.new(v48) * CFrame.lookAt(Vector3.new(0, 0, 0), v51, v55)
        debug.profileend()
        return v56
    end,
    ["getPointWithinSphere"] = function(p57, p58, p59, p60, p61, p62)
        debug.profilebegin("getPointWithinSphere")
        local v63 = Random.new(p57)
        local v64 = v63:NextNumber()
        local v65 = v63:NextNumber()
        local v66 = v64 * 2 * 3.141592653589793
        local v67 = 2 * v65 - 1
        local v68 = math.acos(v67) * p59
        local v69 = v63:NextNumber(p58, 1) ^ 0.3333333333333333
        local v70 = math.sin(v66)
        local v71 = math.cos(v66)
        local v72 = math.sin(v68)
        local v73 = math.cos(v68)
        local v74 = Vector3.FromNormalId(p62)
        if p62 == Enum.NormalId.Left or p62 == Enum.NormalId.Right then
            local v75 = p61.Z
            local v76 = p61.Y
            local v77 = p61.X
            p61 = Vector3.new(v75, v76, v77)
        elseif p62 == Enum.NormalId.Top or p62 == Enum.NormalId.Bottom then
            local v78 = p61.X
            local v79 = p61.Z
            local v80 = p61.Y
            p61 = Vector3.new(v78, v79, v80)
        end
        local v81 = p61 / 2
        local v82 = v_u_118.getSurfaceCFrame(p60, v74, Vector3.new(0, 0, 0))
        local v83 = v69 * v72 * v71
        local v84 = v69 * v72 * v70
        local v85 = v69 * v73
        local v86 = Vector3.new(v83, v84, v85) * v81
        local v87 = -v72 * v70
        local v88 = v72 * v71
        local v89 = Vector3.new(v87, v88, 0) * v81
        local v90 = v89.Magnitude <= 0.001 and Vector3.new(1, 0, 0) or v89.Unit
        local v91 = v82 * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(v86) * CFrame.lookAt(Vector3.new(0, 0, 0), v86, v90)
        debug.profileend()
        return v91
    end,
    ["getPointWithinDisc"] = function(p92, p93, p94, p95, p96, p97)
        debug.profilebegin("getPointWithinDisc")
        local v98 = Random.new(p92)
        local v99 = Vector3.FromNormalId(p97)
        local v100 = Vector3.new(1, 1, 1) - v99:Abs() * p93
        local v101 = p96 / 2
        local v102 = v98:NextNumber(p93, 1)
        local v103 = v_u_1.lerp(1, 0.5, p94 ^ 4)
        local v104 = v98:NextNumber(1 - p94, 1) ^ v103
        local v105 = v98:NextNumber(0, 6.283185307179586)
        local v106 = v102 * 2 - 1
        local v107 = v104 * math.sin(v105)
        local v108 = v104 * math.cos(v105)
        local v109 = Vector3.new(v106, v107, v108)
        if p97 == Enum.NormalId.Bottom or p97 == Enum.NormalId.Top then
            local v110 = v109.Z
            local v111 = v109.X
            local v112 = v109.Y
            v109 = Vector3.new(v110, v111, v112)
        elseif p97 == Enum.NormalId.Front or p97 == Enum.NormalId.Back then
            local v113 = v109.Y
            local v114 = v109.Z
            local v115 = v109.X
            v109 = Vector3.new(v113, v114, v115)
        end
        local v116 = v109 * (v101 * v100)
        local v117 = v_u_118.getSurfaceCFrame(p95, v99, v116 + v99 * p93 * v101)
        debug.profileend()
        return v117
    end
}
return v_u_118