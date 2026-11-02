-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Save = require(ReplicatedStorage.Shared.Save)

local function count(v1) -- line 5
    if type(v1) == "table" then
        local v2 = 0
        for v3 in pairs(v1) do
            v2 += 1
        end
        return v2
    end
    return -1
end

Save.WatchFields("EggInventory", function() -- line 19 | captures: Save
    local v4 = Save.Get()
    local print_2 = print
    local v5 = "[EGGCHK] delta recibido -> EggInventory ="
    local v6 = v4 and v4.EggInventory
    local v7
    if type(v6) == "table" then
        v7 = 0
        for v8 in pairs(v6) do
            v7 += 1
        end
    else
        v7 = -1
    end
    print_2(v5, v7)
end)
