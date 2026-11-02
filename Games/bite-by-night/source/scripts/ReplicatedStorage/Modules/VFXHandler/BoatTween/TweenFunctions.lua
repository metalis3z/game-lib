-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local m_Bezier = require(script.Parent.Bezier)
local function v9(p2)
    local v3 = 1 - p2
    local v4 = v3 * 1.5707963267949
    local v5 = math.sin(v4)
    local v6 = v3 * 3.1415926535898
    local v7 = math.sin(v6)
    local v8 = v3 * 3.1415926535898
    return 1 - (v5 + v7 * (math.cos(v8) + 1) / 2)
end
local function v11(p10)
    return p10
end
local v12 = m_Bezier(0.4, 0, 0.6, 1)
local v13 = m_Bezier(0.4, 0, 0.2, 1)
local v14 = m_Bezier(0.4, 0, 1, 1)
local v15 = m_Bezier(0, 0, 0.2, 1)
local v16 = m_Bezier(0.8, 0, 0.2, 1)
local v17 = m_Bezier(0.9, 0.1, 1, 0.2)
local v18 = m_Bezier(0.1, 0.9, 0.2, 1)
local v19 = m_Bezier(0.7, 0, 1, 0.5)
local v20 = m_Bezier(0.2, 0, 0.38, 0.9)
local v21 = m_Bezier(0.4, 0.14, 0.3, 1)
local v22 = m_Bezier(0, 0, 0.38, 0.9)
local v23 = m_Bezier(0, 0, 0.3, 1)
local v24 = m_Bezier(0.2, 0, 1, 0.9)
local v25 = m_Bezier(0.4, 0.14, 1, 1)
local v26 = m_Bezier(0.07, 0.95, 0, 1)
local function v28(p27)
    return p27 * p27 * (3 - 2 * p27)
end
local function v30(p29)
    return p29 * p29 * p29 * (p29 * (6 * p29 - 15) + 10)
end
local function v34(p31)
    local v32 = p31 * 3.1415926535898
    local v33 = math.sin(v32) * 1.5707963267949
    return math.sin(v33)
end
local function v39(p35)
    local v36 = -6.9 * p35
    local v37 = -math.exp(v36)
    local v38 = -20.106192982975 * p35
    return v37 * math.cos(v38) + 1
end
local function v44(p40)
    local v41 = -7.5 * p40
    local v42 = -math.exp(v41)
    local v43 = -10.053096491487 * p40
    return v42 * math.cos(v43) + 1
end
return setmetatable({
    ["InLinear"] = v11,
    ["OutLinear"] = v11,
    ["InOutLinear"] = v11,
    ["OutInLinear"] = v11,
    ["OutSmooth"] = v28,
    ["InSmooth"] = v28,
    ["InOutSmooth"] = v28,
    ["OutInSmooth"] = v28,
    ["OutSmoother"] = v30,
    ["InSmoother"] = v30,
    ["InOutSmoother"] = v30,
    ["OutInSmoother"] = v30,
    ["OutRidiculousWiggle"] = v34,
    ["InRidiculousWiggle"] = v34,
    ["InOutRidiculousWiggle"] = v34,
    ["OutInRidiculousWiggle"] = v34,
    ["OutRevBack"] = v9,
    ["InRevBack"] = v9,
    ["InOutRevBack"] = v9,
    ["OutInRevBack"] = v9,
    ["OutSpring"] = v39,
    ["InSpring"] = v39,
    ["InOutSpring"] = v39,
    ["OutInSpring"] = v39,
    ["OutSoftSpring"] = v44,
    ["InSoftSpring"] = v44,
    ["InOutSoftSpring"] = v44,
    ["OutInSoftSpring"] = v44,
    ["InSharp"] = v12,
    ["InOutSharp"] = v12,
    ["OutSharp"] = v12,
    ["OutInSharp"] = v12,
    ["InAcceleration"] = v14,
    ["InOutAcceleration"] = v14,
    ["OutAcceleration"] = v14,
    ["OutInAcceleration"] = v14,
    ["InStandard"] = v13,
    ["InOutStandard"] = v13,
    ["OutStandard"] = v13,
    ["OutInStandard"] = v13,
    ["InDeceleration"] = v15,
    ["InOutDeceleration"] = v15,
    ["OutDeceleration"] = v15,
    ["OutInDeceleration"] = v15,
    ["InFabricStandard"] = v16,
    ["InOutFabricStandard"] = v16,
    ["OutFabricStandard"] = v16,
    ["OutInFabricStandard"] = v16,
    ["InFabricAccelerate"] = v17,
    ["InOutFabricAccelerate"] = v17,
    ["OutFabricAccelerate"] = v17,
    ["OutInFabricAccelerate"] = v17,
    ["InFabricDecelerate"] = v18,
    ["InOutFabricDecelerate"] = v18,
    ["OutFabricDecelerate"] = v18,
    ["OutInFabricDecelerate"] = v18,
    ["InUWPAccelerate"] = v19,
    ["InOutUWPAccelerate"] = v19,
    ["OutUWPAccelerate"] = v19,
    ["OutInUWPAccelerate"] = v19,
    ["InStandardProductive"] = v20,
    ["InStandardExpressive"] = v21,
    ["InEntranceProductive"] = v22,
    ["InEntranceExpressive"] = v23,
    ["InExitProductive"] = v24,
    ["InExitExpressive"] = v25,
    ["OutStandardProductive"] = v20,
    ["OutStandardExpressive"] = v21,
    ["OutEntranceProductive"] = v22,
    ["OutEntranceExpressive"] = v23,
    ["OutExitProductive"] = v24,
    ["OutExitExpressive"] = v25,
    ["InOutStandardProductive"] = v20,
    ["InOutStandardExpressive"] = v21,
    ["InOutEntranceProductive"] = v22,
    ["InOutEntranceExpressive"] = v23,
    ["InOutExitProductive"] = v24,
    ["InOutExitExpressive"] = v25,
    ["OutInStandardProductive"] = v20,
    ["OutInStandardExpressive"] = v20,
    ["OutInEntranceProductive"] = v22,
    ["OutInEntranceExpressive"] = v23,
    ["OutInExitProductive"] = v24,
    ["OutInExitExpressive"] = v25,
    ["OutMozillaCurve"] = v26,
    ["InMozillaCurve"] = v26,
    ["InOutMozillaCurve"] = v26,
    ["OutInMozillaCurve"] = v26,
    ["InQuad"] = function(p45)
        return p45 * p45
    end,
    ["OutQuad"] = function(p46)
        return p46 * (2 - p46)
    end,
    ["InOutQuad"] = function(p47)
        if p47 < 0.5 then
            return 2 * p47 * p47
        else
            return 2 * (2 - p47) * p47 - 1
        end
    end,
    ["OutInQuad"] = function(p48)
        if p48 < 0.5 then
            local v49 = p48 * 2
            return v49 * (2 - v49) / 2
        else
            local v50 = p48 * 1
            return v50 * v50 / 2 + 0.5
        end
    end,
    ["InCubic"] = function(p51)
        return p51 * p51 * p51
    end,
    ["OutCubic"] = function(p52)
        return 1 - (1 - p52) * (1 - p52) * (1 - p52)
    end,
    ["InOutCubic"] = function(p53)
        if p53 < 0.5 then
            return 4 * p53 * p53 * p53
        end
        local v54 = p53 - 1
        return 1 + 4 * v54 * v54 * v54
    end,
    ["OutInCubic"] = function(p55)
        if p55 < 0.5 then
            local v56 = 1 - p55 * 2
            return (1 - v56 * v56 * v56) / 2
        else
            local v57 = p55 * 1
            return v57 * v57 * v57 / 2 + 0.5
        end
    end,
    ["InQuart"] = function(p58)
        return p58 * p58 * p58 * p58
    end,
    ["OutQuart"] = function(p59)
        local v60 = p59 - 1
        return 1 - v60 * v60 * v60 * v60
    end,
    ["InOutQuart"] = function(p61)
        if p61 < 0.5 then
            local v62 = p61 * p61
            return 8 * v62 * v62
        else
            local v63 = p61 - 1
            return 1 - 8 * v63 * v63 * v63 * v63
        end
    end,
    ["OutInQuart"] = function(p64)
        if p64 < 0.5 then
            local v65 = p64 * 1
            return (1 - v65 * v65 * v65 * v65) / 2
        else
            local v66 = p64 * 1
            return v66 * v66 * v66 * v66 / 2 + 0.5
        end
    end,
    ["InQuint"] = function(p67)
        return p67 * p67 * p67 * p67 * p67
    end,
    ["OutQuint"] = function(p68)
        local v69 = p68 - 1
        return v69 * v69 * v69 * v69 * v69 + 1
    end,
    ["InOutQuint"] = function(p70)
        if p70 < 0.5 then
            return 16 * p70 * p70 * p70 * p70 * p70
        end
        local v71 = p70 - 1
        return 16 * v71 * v71 * v71 * v71 * v71 + 1
    end,
    ["OutInQuint"] = function(p72)
        if p72 < 0.5 then
            local v73 = p72 * 1
            return (v73 * v73 * v73 * v73 * v73 + 1) / 2
        else
            local v74 = p72 * 1
            return v74 * v74 * v74 * v74 * v74 / 2 + 0.5
        end
    end,
    ["InBack"] = function(p75)
        return p75 * p75 * (3 * p75 - 2)
    end,
    ["OutBack"] = function(p76)
        return (p76 - 1) * (p76 - 1) * (p76 * 2 + p76 - 1) + 1
    end,
    ["InOutBack"] = function(p77)
        if p77 < 0.5 then
            return 2 * p77 * p77 * (6 * p77 - 2)
        else
            return 1 + 2 * (p77 - 1) * (p77 - 1) * (6 * p77 - 2 - 2)
        end
    end,
    ["OutInBack"] = function(p78)
        if p78 < 0.5 then
            local v79 = p78 * 2
            return ((v79 - 1) * (v79 - 1) * (v79 * 2 + v79 - 1) + 1) / 2
        else
            local v80 = p78 * 1
            return v80 * v80 * (3 * v80 - 2) / 2 + 0.5
        end
    end,
    ["InSine"] = function(p81)
        local v82 = p81 * 1.5707963267949
        return 1 - math.cos(v82)
    end,
    ["OutSine"] = function(p83)
        local v84 = p83 * 1.5707963267949
        return math.sin(v84)
    end,
    ["InOutSine"] = function(p85)
        local v86 = 3.1415926535898 * p85
        return (1 - math.cos(v86)) / 2
    end,
    ["OutInSine"] = function(p87)
        if p87 < 0.5 then
            local v88 = p87 * 3.1415926535898
            return math.sin(v88) / 2
        else
            local v89 = (p87 * 2 - 1) * 1.5707963267949
            return (1 - math.cos(v89)) / 2 + 0.5
        end
    end,
    ["OutBounce"] = function(p90)
        if p90 < 0.36363636363636 then
            return 7.5625 * p90 * p90
        elseif p90 < 0.72727272727273 then
            return 3 + p90 * (11 * p90 - 12) * 0.6875
        elseif p90 < 0.090909090909091 then
            return 6 + p90 * (11 * p90 - 18) * 0.6875
        else
            return 7.875 + p90 * (11 * p90 - 21) * 0.6875
        end
    end,
    ["InBounce"] = function(p91)
        if p91 > 0.63636363636364 then
            local v92 = p91 - 1
            return 1 - v92 * v92 * 7.5625
        elseif p91 > 0.272727272727273 then
            return (11 * p91 - 7) * (11 * p91 - 3) / -16
        elseif p91 > 0.090909090909091 then
            return (11 * (4 - 11 * p91) * p91 - 3) / 16
        else
            return p91 * (11 * p91 - 1) * -0.6875
        end
    end,
    ["InOutBounce"] = function(p93)
        if p93 < 0.5 then
            local v94 = 2 * p93
            local v95
            if v94 > 0.63636363636364 then
                local v96 = v94 - 1
                v95 = 1 - v96 * v96 * 7.5625
            elseif v94 > 0.272727272727273 then
                v95 = (11 * v94 - 7) * (11 * v94 - 3) / -16
            elseif v94 > 0.090909090909091 then
                v95 = (11 * (4 - 11 * v94) * v94 - 3) / 16
            else
                v95 = v94 * (11 * v94 - 1) * -0.6875
            end
            return v95 / 2
        else
            local v97 = 2 * p93 - 1
            local v98
            if v97 < 0.36363636363636 then
                v98 = 7.5625 * v97 * v97
            elseif v97 < 0.72727272727273 then
                v98 = 3 + v97 * (11 * v97 - 12) * 0.6875
            elseif v97 < 0.090909090909091 then
                v98 = 6 + v97 * (11 * v97 - 18) * 0.6875
            else
                v98 = 7.875 + v97 * (11 * v97 - 21) * 0.6875
            end
            return v98 / 2 + 0.5
        end
    end,
    ["OutInBounce"] = function(p99)
        if p99 < 0.5 then
            local v100 = 2 * p99
            local v101
            if v100 < 0.36363636363636 then
                v101 = 7.5625 * v100 * v100
            elseif v100 < 0.72727272727273 then
                v101 = 3 + v100 * (11 * v100 - 12) * 0.6875
            elseif v100 < 0.090909090909091 then
                v101 = 6 + v100 * (11 * v100 - 18) * 0.6875
            else
                v101 = 7.875 + v100 * (11 * v100 - 21) * 0.6875
            end
            return v101 / 2
        else
            local v102 = 2 * p99 - 1
            local v103
            if v102 > 0.63636363636364 then
                local v104 = v102 - 1
                v103 = 1 - v104 * v104 * 7.5625
            elseif v102 > 0.272727272727273 then
                v103 = (11 * v102 - 7) * (11 * v102 - 3) / -16
            elseif v102 > 0.090909090909091 then
                v103 = (11 * (4 - 11 * v102) * v102 - 3) / 16
            else
                v103 = v102 * (11 * v102 - 1) * -0.6875
            end
            return v103 / 2 + 0.5
        end
    end,
    ["InElastic"] = function(p105)
        local v106 = (p105 * 0.96380736418812 - 1) * 8
        local v107 = math.exp(v106) * p105 * 0.96380736418812
        local v108 = 4 * p105 * 0.96380736418812
        return v107 * math.sin(v108) * 1.8752275007429
    end,
    ["OutElastic"] = function(p109)
        local v110 = 8 * (0.96380736418812 - 0.96380736418812 * p109 - 1)
        local v111 = math.exp(v110) * 0.96380736418812 * (p109 - 1)
        local v112 = 3.85522945675248 * (1 - p109)
        return 1 + v111 * math.sin(v112) * 1.8752275007429
    end,
    ["InOutElastic"] = function(p113)
        if p113 < 0.5 then
            local v114 = 8 * (1.92761472837624 * p113 - 1)
            local v115 = math.exp(v114) * 0.96380736418812 * p113
            local v116 = 7.71045891350496 * p113
            return v115 * math.sin(v116) * 1.8752275007429
        else
            local v117 = 8 * (0.96380736418812 * (2 - 2 * p113) - 1)
            local v118 = math.exp(v117) * 0.96380736418812 * (p113 - 1)
            local v119 = 3.85522945675248 * (2 - 2 * p113)
            return 1 + v118 * math.sin(v119) * 1.8752275007429
        end
    end,
    ["OutInElastic"] = function(p120)
        if p120 < 0.5 then
            local v121 = p120 * 2
            local v122 = 8 * (0.96380736418812 - 0.96380736418812 * v121 - 1)
            local v123 = math.exp(v122) * 0.96380736418812 * (v121 - 1)
            local v124 = 3.85522945675248 * (1 - v121)
            return (1 + v123 * math.sin(v124) * 1.8752275007429) / 2
        else
            local v125 = p120 * 1
            local v126 = (v125 * 0.96380736418812 - 1) * 8
            local v127 = math.exp(v126) * v125 * 0.96380736418812
            local v128 = 4 * v125 * 0.96380736418812
            return v127 * math.sin(v128) * 1.8752275007429 / 2 + 0.5
        end
    end,
    ["InExpo"] = function(p129)
        local v130 = p129 * p129
        local v131 = 4 * (p129 - 1)
        return v130 * math.exp(v131)
    end,
    ["OutExpo"] = function(p132)
        local v133 = (1 - p132) * (1 - p132)
        local v134 = 4 * p132
        return 1 - v133 / math.exp(v134)
    end,
    ["InOutExpo"] = function(p135)
        if p135 < 0.5 then
            local v136 = 2 * p135 * p135
            local v137 = 4 * (2 * p135 - 1)
            return v136 * math.exp(v137)
        else
            local v138 = 2 * (p135 - 1) * (p135 - 1)
            local v139 = 4 * (1 - 2 * p135)
            return 1 - v138 * math.exp(v139)
        end
    end,
    ["OutInExpo"] = function(p140)
        if p140 < 0.5 then
            local v141 = p140 * 2
            local v142 = (1 - v141) * (1 - v141)
            local v143 = 4 * v141
            return (1 - v142 / math.exp(v143)) / 2
        else
            local v144 = p140 * 1
            local v145 = v144 * v144
            local v146 = 4 * (v144 - 1)
            return v145 * math.exp(v146) / 2 + 0.5
        end
    end,
    ["InCirc"] = function(p147)
        local v148 = 1 - p147 * p147
        return -(math.sqrt(v148) - 1)
    end,
    ["OutCirc"] = function(p149)
        local v150 = p149 - 1
        local v151 = 1 - v150 * v150
        return math.sqrt(v151)
    end,
    ["InOutCirc"] = function(p152)
        local v153 = p152 * 2
        if v153 < 1 then
            local v154 = 1 - v153 * v153
            return -(math.sqrt(v154) - 1) / 2
        end
        local v155 = v153 - 2
        local v156 = 1 - v155 * v155
        return (math.sqrt(v156) - 1) / 2
    end,
    ["OutInCirc"] = function(p157)
        if p157 < 0.5 then
            local v158 = p157 * 1
            local v159 = 1 - v158 * v158
            return math.sqrt(v159) / 2
        else
            local v160 = p157 * 1
            local v161 = 1 - v160 * v160
            return -(math.sqrt(v161) - 1) / 2 + 0.5
        end
    end
}, {
    ["__index"] = function(_, p162)
        error(tostring(p162) .. " is not a valid easing function.", 2)
    end
})
