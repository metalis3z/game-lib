-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Functions = game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Functions")
local ArrayToSet = require(Functions.ArrayToSet)
local t = { "_fu", "_cu", "_ct", "_oc", "_ol", "_tr" }
local t2 = { "_am", "_lk", "_to", "_uq" }
local t3 = { "_am", "_lk" }

return {
	PointlessUniquesList = t,
	PointlessUniques = ArrayToSet(t),
	StackKeyIgnoredFieldsList = t2,
	StackKeyIgnoredFields = ArrayToSet(t2),
	ExactStackKeyIgnoredFieldsList = t3,
	ExactStackKeyIgnoredFields = ArrayToSet(t3)
}