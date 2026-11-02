-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RebirthSlice, time of decompilation: Sun May  3 10:11:40 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local v3 = Vide.source(0)
local v4 = Vide.source({
	baseLuck = 1,
	multiplier = 1.5,
	resultLuck = 1.5
})
local t2 = {
	triggerBurst = function(t1: {[any]: any}) --[[ triggerBurst ]] -- line: 19
		-- upvalues: v4 (copy), v3 (copy)
		v4(t1)
		v3(v3() + 1)
	end
}

return {
	burstId = v3,
	latestBurst = v4,
	actions = t2
}
