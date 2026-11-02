-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = { EggDisplayName = "Demonic Egg" }
local v2 = {}
local v3 = { "Hellhound", 28 }
local v4 = { "Gargoyle", 15 }
local v5 = { "Balrog", 4.9 }
local v6 = { "Archdemon Dragon", 0.1 }

v2[1] = { "Demon Imp", 42 }
v2[2] = v3
v2[3] = v4
v2[4] = { "Minotaur", 10 }
v2[5] = v5
v2[6] = v6
v1.DropTable = v2

function v1.IsEventCategory(v7) -- line 20 | captures: v1
    if v7 ~= nil then
        for v8, v9 in v1.DropTable do
            if v9[1] == v7 then
                return true
            end
        end
    end
    return false
end

function v1.GetTotalWeight() -- line 34 | captures: v1
    local v10 = 0
    for v11, v12 in v1.DropTable do
        v10 += v12[2]
    end
    return v10
end

function v1.Roll(v13) -- line 44 | captures: v1
    local v14 = v13 or Random.new()
    local v15 = v1.GetTotalWeight()
    if v15 <= 0 then
        return v1.DropTable[1][1]
    end
    local v16 = 0
    for v17, v18 in v1.DropTable do
        v16 += v18[2]
        if v14:NextNumber() * v15 <= v16 then
            return v18[1]
        end
    end
    return v1.DropTable[#v1.DropTable][1]
end

return v1
