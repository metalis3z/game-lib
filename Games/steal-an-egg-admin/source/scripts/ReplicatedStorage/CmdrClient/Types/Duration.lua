-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
local v1 = {
    Years = 31556926,
    Months = 2629744,
    Weeks = 604800,
    Days = 86400,
    Hours = 3600,
    Minutes = 60,
    Seconds = 1
}
local v2 = {}
for v3, v4 in pairs(v1) do
    table.insert(v2, v3)
end
local v5 = Util.MakeFuzzyFinder(v2)

local function stringToSecondDuration(v6) -- line 21 | captures: v1, v5
    if v6 == nil then
        return nil
    end
    if v6 == "" then
        return nil
    end
    local v7 = tonumber(v6)
    if v7 then
        if v7 == 0 then
            return 0, 0, true
        end
    else
        local v8 = v6:gsub("-?%d+%a+", ""):match("-?%d+")
        if v8 then
            return nil, tonumber(v8), true
        end
        local v9, v10
        for v11 in v6:gmatch("-?%d+%a+") do
            local v12
            v9, v12 = v11:match("(-?%d+)(%a+)")
            local v13 = v5(v12)
            if #v13 == 0 then
                return nil, (tonumber(v9))
            end
            if v10 == nil then
                v10 = 0
            end
            local v14 = if v12:lower() == "m" then 60 else v1[v13[1]]
            v10 += v14 * tonumber(v9)
        end
        if v10 == nil then
            return nil
        end
        return v10, (tonumber(v9))
    end
end

local function mapUnits(v15, v16, v17, v18) -- line 66
    local v19 = v18 or 1
    local v20 = {}
    for v21, v22 in pairs(v15) do
        if v17 == 1 then
            v20[v21] = v16 .. v22:sub(v19, #v22 - 1)
        else
            v20[v21] = v16 .. v22:sub(v19)
        end
    end
    return v20
end

local v23 = {}

function v23.Transform(v24) -- line 79 | captures: stringToSecondDuration
    return v24, stringToSecondDuration(v24)
end

local function Validate(v25, v26) -- line 82
    return v26 ~= nil
end

v23.Validate = Validate

function v23.Autocomplete(v27, v28, v29, v30, v31) -- line 86 | captures: v5, mapUnits
    local v32 = {}
    if v30 then
        local v33 = v30 == true and v5("") or v31
        if v30 == true then
            return (mapUnits(v33, v27, v29))
        end
        local v34 = v27:match("^.*(%a+)$"):len()
        return (mapUnits(v33, v27, v34 + 1))
    end
    if v31 then
        return
    end
    if v28 ~= nil then
        local v35 = v27:match("^.*-?%d+(%a+)%s?$")
        local v36 = v5(v35)
        v32 = mapUnits(v36, v27, v29, #v35 + 1)
        table.sort(v32)
    end
    return v32
end

local function Parse(v37, v38) -- line 113
    return v38
end

v23.Parse = Parse
return function(v39) -- line 117 | captures: Util, v23
    v39:RegisterType("duration", v23)
    v39:RegisterType("durations", Util.MakeListableType(v23))
end
