-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminAbuseEgg = require(ReplicatedStorage.Data.AdminAbuseEgg)
local DragonEgg = require(ReplicatedStorage.Data.DragonEgg)
local v1 = {}
local v2 = { AdminAbuseEgg, DragonEgg }

function v1.IsEventEgg(v3) -- line 11 | captures: v2
    local v4 = false
    for v5, v6 in v2 do
        if not v4 then
            if v3 == nil then
                v4 = false
            else
                v4 = v6.IsEventCategory(v3)
            end
        end
    end
    return v4
end

return table.freeze(v1)
