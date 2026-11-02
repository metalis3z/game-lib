-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ShakeRequestData = require(ReplicatedStorage.Client.Types.ShakeRequestData)
local v1 = CameraShaker.new()
v1:Start()
Remotes.SharedFx.JoltOnce.OnClientEvent:Connect(function(v2) -- line 12 | captures: ShakeRequestData, v1
    local function v3(...)
        assert(...)
    end

    v3(ShakeRequestData.SchemaValidation(v2))
    v1:ShakeOnce(v2.Magnitude or 1, v2.Roughness or 1, v2.FadeInTime or 0, v2.FadeOutTime or 0, v2.PosInfluence, v2.RotInfluence)
end)
