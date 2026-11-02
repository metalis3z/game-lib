-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GetScaledRevealTime, time of decompilation: Sun May  3 10:11:47 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)

return function(n1: number) -- line: 5
	-- upvalues: RollSlice (copy)
	return n1 * math.sqrt((math.clamp(RollSlice.rollSpeed() / 3, 0, 1)))
end
