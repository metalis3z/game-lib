-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
local PlayerDataStore = require(script.PlayerDataStore)
local v1 = require(Parent.Config):Get()
local v2 = { Store = PlayerDataStore }

function v2.Start(v3) -- line 11 | captures: PlayerDataStore, v1
    if v1.DataStoreEnabled then
        PlayerDataStore:Start()
    end
end

return v2
