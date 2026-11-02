-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

local function earlierStop(v2, v3) -- line 7
    return v2.Time < v3.Time
end

v1.Colour = {
    Blend = function(v4, v5, v6) -- Blend | line 12
        return Color3.new(v4.R + (v5.R - v4.R) * v6, v4.G + (v5.G - v4.G) * v6, v4.B + (v5.B - v4.B) * v6)
    end,
    Stop = function(v7, v8) -- Stop | line 15
        return ColorSequenceKeypoint.new(v7, v8)
    end,
    Wrap = function(v9, v10) -- Wrap | line 18
        return (v9 + v10) % 1
    end
}
v1.Alpha = {
    Blend = function(v11, v12, v13) -- Blend | line 23
        return v11 + (v12 - v11) * v13
    end,
    Stop = function(v14, v15) -- Stop | line 26
        return NumberSequenceKeypoint.new(v14, v15)
    end,
    Wrap = function(v16, v17) -- Wrap | line 29
        local v18 = v16 + v17
        if v18 < 0 or v18 > 1 then
            return v18 % 1
        end
        return v18
    end
}

local function Sample(v19, v20, v21) -- line 37
    local v22 = {}
    local v23 = v20 + 1
    for v24 = 0, 2 do
        for v25, v26 in v19 do
            v22[#v22 + 1] = {
                Time = v26.Time + v24,
                Value = v26.Value
            }
        end
    end
    for v27, v28 in v22 do
        local v29 = v22[v27 + 1]
        if v29 then
            if v28.Time <= v23 and v23 < v29.Time then
                return v21.Blend(v28.Value, v29.Value, (v23 - v28.Time) / (v29.Time - v28.Time))
            end
        else
            break
        end
    end
    return nil
end

v1.Sample = Sample

function v1.Drift(v30, v31, v32, v33, v34) -- line 66 | captures: v1, earlierStop
    local function v35(v36, v37, ...)
        table.insert(v36, v37, ...)
    end

    local v38 = {}
    local v39 = v33
    local v40 = v34
    for v41, v42 in v30 do
        local v43 = v31.Wrap(v42.Time, v32)
        local v44 = v31.Stop(v43, v42.Value)
        if v40 < v44.Time then
            v38[#v38 + 1] = v44
        else
            v39 -= 1
            v38[v39] = v44
            v40 = v44.Time
        end
    end
    local v45 = {}
    for v46, v47 in v38 do
        v45[#v45 + 1] = v47
    end
    table.sort(v45, earlierStop)
    if v45[1].Time ~= 0 then
        v35(v45, 1, v31.Stop(0, v1.Sample(v45, 0, v31)))
    end
    if v45[#v45].Time ~= 1 then
        v45[#v45 + 1] = v31.Stop(1, v1.Sample(v45, 1, v31))
    end
    return v45
end

function v1.Restripe(v48, v49, v50, v51) -- line 101 | captures: v1
    local v52 = {}
    local v53 = #v48 == #v49
    for v54, v55 in v48 do
        local v56 = v1.Sample(v49, v55.Time, v51)
        if v53 then
            v56 = v56:Lerp(v55.Value, v50)
        end
        v52[#v52 + 1] = v51.Stop(v55.Time, v56)
    end
    return v52
end

return table.freeze(v1)
