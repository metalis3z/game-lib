-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Size = function(v2) -- Size | line 8
        local v3 = 0
        for v4 in v2 do
            v3 += 1
        end
        return v3
    end,
    IsVacant = function(v5) -- IsVacant | line 18
        if type(v5) == "table" then
            return next(v5) == nil
        end
        return nil
    end
}
local v6

function v6(v7, v8, v9) -- line 26 | captures: v6
    if v7 ~= v8 and type(v7) == "table" and type(v8) == "table" then
        local v10 = v9 or
        {
            LeftToRight = {},
            RightToLeft = {}
        }
        local v11 = v10.LeftToRight[v7]
        local v12 = v10.RightToLeft[v8]
        if v11 == nil and v12 == nil then
            v10.LeftToRight[v7] = v8
            v10.RightToLeft[v8] = v7
            local v13 = getmetatable(v7)
            local v14 = getmetatable(v8)
            local __eq, __eq_2
            if v13 then
                __eq_2 = v13.__eq
            else
                if not v14 then
                    if #v7 == #v8 then
                        for v15, v16 in v7 do
                            local v17 = v8[v15]
                            if v17 == nil or not v6(v16, v17, v10) then
                                return false
                            end
                        end
                        for v18, v19 in v8 do
                            local v20 = v7[v18]
                            if v20 == nil or not v6(v19, v20, v10) then
                                return false
                            end
                        end
                        return true
                    end
                    return false
                end
                __eq = v14.__eq
            end
            if v13 and not __eq_2 or not v13 and not __eq then
                return
            end
        elseif v11 == v8 then
            return v12 == v7
        end
        return false
    end
    return v7 == v8
end

local v21

function v21(v22, v23) -- line 94 | captures: v21
    if v22 == v23 then
        return true
    end
    if not (type(v22) == "table" and type(v23) == "table") then
        if v22 == v22 then
            return false
        end
        return v23 ~= v23
    end
    if #v22 == #v23 then
        for v24, v25 in v22 do
            local v26 = v23[v24]
            if v26 == nil or not v21(v25, v26) then
                return false
            end
        end
        for v27, v28 in v23 do
            local v29 = v22[v27]
            if v29 == nil or not v21(v28, v29) then
                return false
            end
        end
        return true
    end
    return false
end

v1.Matches = v6
v1.MatchesFast = v21

local v30

function v30(v31, v32) -- line 130 | captures: v30
    if type(v31) ~= "table" or v32[v31] then
        return
    end
    v32[v31] = true
    for v33, v34 in v31 do
        v30(v33, v32)
        v30(v34, v32)
    end
    if not table.isfrozen(v31) then
        table.freeze(v31)
    end
end

function v1.Seal(v35) -- line 146 | captures: v30
    v30(v35, {})
    return v35
end

return table.freeze(v1)
