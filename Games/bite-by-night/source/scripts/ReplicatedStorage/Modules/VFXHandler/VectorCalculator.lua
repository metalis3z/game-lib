-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_19 = {
    ["GetCircularPosition"] = function(p1, p2, p3)
        local v4 = math.cos(p3) * p2
        local v5 = math.sin(p3) * p2
        return p1 + Vector3.new(v4, 0, v5)
    end,
    ["GetCircularCFrame"] = function(p6, p7, p8, p9)
        local v10 = v_u_19.GetCircularPosition(p6, p8, p9)
        return CFrame.lookAt(p6, p6 + p7) * CFrame.new(v10)
    end,
    ["GetAngleBetweenVectors"] = function(p11, p12, p13)
        local Unit = p11.Unit
        local Unit_0 = p12.Unit
        if not p13 then
            local v16 = Unit:Dot(Unit_0)
            return math.acos(v16)
        end
        local v17 = Unit:Dot(Unit_0)
        local v18 = Unit.X * Unit_0.Z - Unit.Z * Unit_0.X
        return math.atan2(v18, v17)
    end
}
return v_u_19
