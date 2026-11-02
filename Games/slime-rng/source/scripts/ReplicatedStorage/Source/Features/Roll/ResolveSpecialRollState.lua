-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ResolveSpecialRollState, time of decompilation: Sun May  3 10:11:43 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpecialRollUtils = require(ReplicatedStorage.Source.Features.Roll.SpecialRollUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return function(p1, t1: {[any]: any}?) -- line: 9
	-- upvalues: SpecialRollUtils (copy)
	local v5 = t1 or {}
	local v6 = SpecialRollUtils.resolveProgression(p1, v5)
	local t2 = {}
	local t3 = {}
	local n1 = 0

	for _, v11 in SpecialRollUtils.getKinds() do
		local v12 = SpecialRollUtils.getRollCadence(v11, v5)
		local v13 = v6[v11]

		t2[v11] = {
			rollsUntilNext = v13.rollsUntilNext,
			paused = v13.paused
		}

		if v12 == nil then
			t2[v11].rollsUntilNext = SpecialRollUtils.getBaseRollCadence(v11)
		elseif v13.paused then
			t2[v11].rollsUntilNext = math.clamp(v13.rollsUntilNext, 0, v12)
		elseif v13.rollsUntilNext <= 0 then
			t3[v11] = true
			t2[v11].rollsUntilNext = v12
			n1 += SpecialRollUtils.getLuckMultiplier(v11, v5) - 1
		else
			t2[v11].rollsUntilNext = v13.rollsUntilNext - 1
		end
	end

	return t3, t2, n1
end
