-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = { Changed = require(ReplicatedStorage.Packages.Signal).new() }

function v1.CanShowPanel() -- line 5
    return true
end

function v1.SetAdminStatus() -- line 9 | captures: v1
    v1.Changed:Fire(true)
end

return v1
