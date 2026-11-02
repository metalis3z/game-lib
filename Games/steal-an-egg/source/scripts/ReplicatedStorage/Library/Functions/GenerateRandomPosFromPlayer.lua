-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v2 = require(ReplicatedStorage.Library.Modules.BetterRandom).new()

return function(p1, p2) --[[ Line: 11 | Upvalues: Asserts (copy), v1 (copy), v2 (copy) ]]
	Asserts.Player(p1)

	local HumanoidRootPart = (p1.Character or p1.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 60)

	if not HumanoidRootPart then
		return v1:AtWarning():Log((("Failed to gen rng pos from player \"%*\", primary part timeout"):format(p1.Name)))
	end

	local v22 = p2 and v2:positiveYVector3() or v2:Vector3()

	return HumanoidRootPart.Position + v22 * v2:number(20, 50)
end