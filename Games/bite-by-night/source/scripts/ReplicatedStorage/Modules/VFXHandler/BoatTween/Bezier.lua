-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local function v_u_2(p1)
    return p1
end
return function(p_u_3, p_u_4, p_u_5, p_u_6)
    if not (p_u_3 and (p_u_4 and (p_u_5 and p_u_6))) then
        error("Need 4 numbers to construct a Bezier curve", 0)
    end
    if p_u_3 < 0 or (p_u_3 > 1 or (p_u_5 < 0 or p_u_5 > 1)) then
        error("The x values must be within range [0, 1]", 0)
    end
    if p_u_3 == p_u_4 and p_u_5 == p_u_6 then
        return v_u_2
    end
    local v_u_7 = {}
    for v8 = 0, 10 do
        local v9 = v8 / 10
        v_u_7[v8] = (((1 - 3 * p_u_5 + 3 * p_u_5) * v9 + (3 * p_u_5 - 6 * p_u_3)) * v9 + 3 * p_u_3) * v9
    end
    return function(p10)
        if p_u_3 == p_u_4 and p_u_5 == p_u_6 then
            return v_u_2
        end
        if p10 == 0 or p10 == 1 then
            return p10
        end
        local v11 = 1
        local v12 = 0
        while v11 ~= 10 and v_u_7[v11] <= p10 do
            v12 = v12 + 0.1
            v11 = v11 + 1
        end
        local v13 = v11 - 1
        local v14 = v12 + (p10 - v_u_7[v13]) / (v_u_7[v13 + 1] - v_u_7[v13]) / 10
        local v15 = 3 * (1 - 3 * p_u_5 + 3 * p_u_3) * v14 * v14 + 2 * (3 * p_u_5 - 6 * p_u_3) * v14 + 3 * p_u_3
        if v15 >= 0.001 then
            for _ = 0, 3 do
                local v16 = 3 * (1 - 3 * p_u_5 + 3 * p_u_3) * v14 * v14 + 2 * (3 * p_u_5 - 6 * p_u_3) * v14 + 3 * p_u_3
                v14 = v14 - ((((1 - 3 * p_u_5 + 3 * p_u_3) * v14 + (3 * p_u_5 - 6 * p_u_3)) * v14 + 3 * p_u_3) * v14 - p10) / v16
            end
        elseif v15 ~= 0 then
            local v17 = v12 + 0.1
            local v18 = 0
            local v19 = nil
            v14 = nil
            while math.abs(v18) > 1e-7 and v19 < 10 do
                v14 = v12 + (v17 - v12) / 2
                v18 = (((1 - 3 * p_u_5 + 3 * p_u_3) * v14 + (3 * p_u_5 - 6 * p_u_3)) * v14 + 3 * p_u_3) * v14 - p10
                if v18 > 0 then
                    v17 = v14
                else
                    v12 = v14
                end
                v19 = v19 + 1
            end
        end
        return (((1 - 3 * p_u_6 + 3 * p_u_4) * v14 + (3 * p_u_6 - 6 * p_u_4)) * v14 + 3 * p_u_4) * v14
    end
end
