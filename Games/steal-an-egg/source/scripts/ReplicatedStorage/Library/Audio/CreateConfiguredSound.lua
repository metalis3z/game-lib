-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(script.Parent)

return function(p1, p2, p3) --[[ CreateConfiguredSound | Line: 14 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.Instance(p1)

	local Sound = Instance.new("Sound")

	Sound.Name = p3 or "ConfiguredSound"
	v1.PrepareSoundFromSoundFile(Sound, p2)
	Sound.Parent = p1

	return Sound
end