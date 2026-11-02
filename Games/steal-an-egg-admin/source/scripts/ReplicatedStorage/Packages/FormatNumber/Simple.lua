-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    "K",
    "M",
    "B",
    "T",
    "Qa",
    "Qi",
    "Sx",
    "Sp",
    "Oc",
    "No",
    "Dc",
    "Ud",
    "Dd",
    "Td",
    "Qad",
    "Qid",
    "Sxd",
    "Spd",
    "Ocd",
    "Nod",
    "Vg",
    "Uvg",
    "Dvg",
    "Tvg",
    "Qavg",
    "Qivg",
    "Sxvg",
    "Spvg",
    "Ocvg",
    "Novg",
    "Tg"
}
local Main = require(script.Parent.Main)
local v2 = {}
local v3 = {}
local v4 = {}

function v2.Format(v5, v6) -- line 43 | captures: Main, v4
    local v7 = type(v5) == "number"
    assert(v7, "Value provided must be a number")
    local v8 = if v6 == nil then "" else v6
    local v9 = type(v8) == "string"
    assert(v9, "Skeleton provided must be a string")
    local v10 = v4[v8]
    if not v10 then
        local v11
        v11, v10 = Main.NumberFormatter.forSkeleton(v8)
        assert(v11, v10)
        v4[v8] = v10
    end
    return v10:Format(v5)
end

function v2.FormatCompact(v12, v13) -- line 64 | captures: v1, Main, v3
    local v14 = type(v12) == "number"
    assert(v14, "Value provided must be a number")
    local v15 = if v13 == nil then "" else v13
    local v16 = type(v15) == "string"
    assert(v16, "Skeleton provided must be a string")
    local v17 = v3[v15]
    if not v17 then
        local v18, v19 = Main.NumberFormatter.forSkeleton(v15)
        assert(v18, v19)
        v17 = v19:Notation(Main.Notation.compactWithSuffixThousands(v1))
        v3[v15] = v17
    end
    local v20 = #v1 ~= 0
    assert(v20, "Please provide the suffix abbreviations for FormatCompact at the top of the Simple ModuleScript")
    return v17:Format(v12)
end

return table.freeze(v2)
