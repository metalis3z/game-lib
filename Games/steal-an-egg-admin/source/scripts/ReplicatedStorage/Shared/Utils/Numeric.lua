-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = Random.new()
local v2 = Random.new()
local v3 = {}

local function isDrawable(v4) -- line 9
    if type(v4) == "number" and v4 > 0 and v4 == v4 then
        return v4 ~= (1/0)
    end
    return false
end

local function factorial(v5) -- line 13
    local v6 = 1
    for v7 = 2, v5 do
        v6 *= v7
    end
    return v6
end

local function isFinite(v8) -- line 22
    if v8 == v8 then
        if v8 == (1/0) then
            return false
        end
        return v8 ~= (-1/0)
    end
    return false
end

function v3.IsFiniteCFrame(v9) -- line 26
    for v10, v11 in { v9:GetComponents() } do
        if not (v11 == v11 and v11 ~= (1/0) and v11 ~= (-1/0)) then
            return false
        end
    end
    return true
end

function v3.Binomial(v12, v13) -- line 39
    local v14 = 1
    for v15 = 2, v12 do
        v14 *= v15
    end
    local v16 = 1
    for v17 = 2, v13 do
        v16 *= v17
    end
    local v18 = v12 - v13
    local v19 = 1
    for v20 = 2, v18 do
        v19 *= v20
    end
    return v14 / (v16 * v19)
end

function v3.PickWeightedWith(v21, ...) -- line 60 | captures: v1
    local v22 = { ... }
    local v23 = if #v22 == 1 then v22[1] else nil
    if type(v23) == "table" then
        local v24 = v23[2]
        if type(v24) ~= "number" then
            v22 = v23
        end
    end
    local v25 = {}
    local v26 = 0
    for v27, v28 in ipairs(v22) do
        local v29 = v28[2]
        local v30 = type(v29) == "number"
        assert(v30, "a lottery entry carries a non-numeric weight")
        if type(v29) == "number" and v29 > 0 and v29 == v29 and v29 ~= (1/0) then
            v26 += v29
            local v31 = {
                index = v27,
                value = v28[1],
                weight = v29
            }
            table.insert(v25, v31)
        end
    end
    if #v25 == 0 then
        return nil, 0, 0, 0, 0
    end
    local v32 = (v21 or v1):NextNumber(0, v26)
    local v33 = v32
    for v34, v35 in v25 do
        v33 -= v35.weight
        if v33 > 0 then
            if v34 == #v25 then
                return v35.value, v32 / v26, v35.weight / v26, v35.index, v35.weight
            end
        else
            return v35.value, v32 / v26, v35.weight / v26, v35.index, v35.weight
        end
    end
    error("the weighted draw fell through every candidate, which cannot happen")
end

function v3.Shuffle(v36, v37) -- line 105 | captures: v2
    local v38 = v37 or v2
    local v39 = #v36
    for v40 = v39, 2, -1 do
        local v41 = v38:NextInteger(1, v40)
        local v42 = v36[v40]
        v36[v40] = v36[v41]
        v36[v41] = v42
    end
    return v36
end

return table.freeze(v3)
