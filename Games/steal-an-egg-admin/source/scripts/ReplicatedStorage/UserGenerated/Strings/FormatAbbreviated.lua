-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundFigures = require(ReplicatedStorage.UserGenerated.Math.RoundFigures)
local StableExp10 = require(ReplicatedStorage.UserGenerated.Math.StableExp10)
local TrimmedNumberString = require(ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString)
local v1 = {
    "",
    "k",
    "m",
    "b",
    "t",
    "q",
    "Qt",
    "Sx",
    "Sp",
    "o",
    "n",
    "d",
    "u",
    "Du",
    "Tr"
}
return function(v2) -- line 27 | captures: RoundFigures, StableExp10, TrimmedNumberString, v1
    local function v3(v4, ...)
        table.insert(v4, ...)
    end

    local function v5(v6, ...)
        table.insert(v6, ...)
    end

    local v7 = type(v2) == "number"
    assert(v7)
    if v2 == v2 then
        if v2 == (1/0) then
            return "Infinity"
        end
        if v2 == (-1/0) then
            return "-Infinity"
        end
        local v8 = {}
        local v9
        if v2 >= 0 then
            v9 = v2
        else
            table.insert(v8, "-")
            v9 = -v2
        end
        local v10 = math.floor(v9)
        if v10 < 1000 then
            v3(v8, TrimmedNumberString(v10))
        else
            local v11 = math.log10(v10) / 3
            local v12 = math.floor(v11) + 1
            local v13 = #v1
            local v14 = math.clamp(v12, 1, v13)
            local v15 = StableExp10(v10, (v14 - 1) * -3)
            v5(v8, TrimmedNumberString((RoundFigures(v15, 3, nil, math.floor))))
            local v16 = v1[v14]
            table.insert(v8, v16)
        end
        return table.concat(v8)
    end
    return "NaN"
end
