-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedStorage.Library.Client.Network)
local CameraShaker = require(ReplicatedStorage.Library.Modules.Packages.CameraShaker)
local ShakeRequestData = require(ReplicatedStorage.Library.Types.ShakeRequestData)
local v1 = CameraShaker.new()

v1:Start()
Network.Fired(Network.NET_MAP.ReplicatedEffects.SHAKE_ONCE):Connect(function(p1) --[[ Line: 12 | Upvalues: ShakeRequestData (copy), v1 (copy) ]]
	assert(ShakeRequestData.SchemaValidation(p1))
	v1:ShakeOnce(p1.Magnitude or 1, p1.Roughness or 1, p1.FadeInTime or 0, p1.FadeOutTime or 0, p1.PosInfluence, p1.RotInfluence)
end)