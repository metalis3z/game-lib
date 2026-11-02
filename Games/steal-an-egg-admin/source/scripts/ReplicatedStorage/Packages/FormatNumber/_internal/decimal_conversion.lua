-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {}

v2["0"] = "\000"
v2["1"] = "\001"
v2["2"] = "\002"
v2["3"] = "\003"
v2["4"] = "\004"
v2["5"] = "\005"
v2["6"] = "\006"
v2["7"] = "\007"
v2["8"] = "\008"
v2["9"] = "\t"

local v3 = table.freeze(v2)

function v1.from_double(v4) -- line 19 | captures: v3
    local v5 = tostring(v4)
    local v6, v7, v8 = string.match(v5, "^(%d+)%.?(%d*)e?([+-]?%d*)$")
    local v9, v10 = string.match(v6 .. v7, "^0*(%d-)(0*)$")
    local v11 = string.gsub(v9, ".", v3)
    local v12 = { string.byte(v11, 1, -1) }
    local v13 = tonumber(v8) or 0
    return v12, #v12, v13 - #v7 + #v10
end

return table.freeze(v1)
