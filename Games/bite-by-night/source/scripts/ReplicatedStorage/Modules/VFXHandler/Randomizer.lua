-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_1 = Random.new(tick())
local v_u_25 = {
    ["GetRandomVector"] = function(p2, p3, p4)
        if p4 then
            local v5 = v_u_1:NextNumber(p2[1], p3[1])
            local v6 = v_u_1:NextNumber(p2[2], p3[2])
            local v7 = v_u_1
            local v8 = p2[3]
            local v9 = p3[3]
            return Vector3.new(v5, v6, v7:NextNumber(v8, v9))
        else
            local v10 = v_u_1:NextInteger(p2[1], p3[1])
            local v11 = v_u_1:NextInteger(p2[2], p3[2])
            local v12 = v_u_1
            local v13 = p2[3]
            local v14 = p3[3]
            return Vector3.new(v10, v11, v12:NextInteger(v13, v14))
        end
    end,
    ["GetRandomCFrame"] = function(p15, p16, p17)
        if p17 then
            return CFrame.new(v_u_1:NextNumber(p15[1], p16[1]), v_u_1:NextNumber(p15[2], p16[2]), v_u_1:NextNumber(p15[3], p16[3]))
        else
            return CFrame.new(v_u_1:NextInteger(p15[1], p16[1]), v_u_1:NextInteger(p15[2], p16[2]), v_u_1:NextInteger(p15[3], p16[3]))
        end
    end,
    ["GetRandomAngles"] = function(p18, p19, p20)
        if p20 then
            return CFrame.Angles(v_u_1:NextNumber(p18[1], p19[1]), v_u_1:NextNumber(p18[2], p19[2]), v_u_1:NextNumber(p18[3], p19[3]))
        else
            return CFrame.Angles(v_u_1:NextInteger(p18[1], p19[1]), v_u_1:NextInteger(p18[2], p19[2]), v_u_1:NextInteger(p18[3], p19[3]))
        end
    end,
    ["GetRandomNumber"] = function(p21, p22, p23)
        if p23 then
            return v_u_1:NextNumber(p21, p22)
        else
            return v_u_1:NextInteger(p21, p22)
        end
    end,
    ["GetRandomSign"] = function()
        local v24 = v_u_25.GetRandomNumber(-1, 1)
        return v24 == 0 and 1 or v24
    end
}
return v_u_25
