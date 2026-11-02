-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Rebirths = require(ReplicatedStorage.Directory.Rebirths)
local t = {}

function t.RebirthToMultiplier(p1) --[[ RebirthToMultiplier | Line: 14 | Upvalues: Asserts (copy), Rebirths (copy), t (copy) ]]
	Asserts.number(p1)

	if p1 <= 0 then
		return 1
	end

	local v1 = Rebirths[p1] or Rebirths[t.GetMaxRebirth()]

	assert(v1 ~= nil, "Expected rebirth multiplier entry")

	return v1.Multiplier
end
function t.GetMaxRebirth() --[[ GetMaxRebirth | Line: 29 | Upvalues: Rebirths (copy) ]]
	return #Rebirths
end
function t.RebirthToRequiredSpeedPower(p1) --[[ RebirthToRequiredSpeedPower | Line: 33 | Upvalues: Asserts (copy), Rebirths (copy) ]]
	Asserts.number(p1)

	local v1 = Rebirths[p1]

	if not v1 then
		return (1 / 0)
	end

	local RequiredSpeedPower = v1.Requirements.RequiredSpeedPower

	if typeof(RequiredSpeedPower) == "number" then
		return RequiredSpeedPower
	end

	return (1 / 0)
end

return t