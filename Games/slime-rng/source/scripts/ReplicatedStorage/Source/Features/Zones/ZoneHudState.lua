-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ZoneHudState, time of decompilation: Sun May  3 10:11:52 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local v3 = Vide.source(0)
local v4 = Vide.source("")
local v5 = Vide.source(0)

return {
	enteredZoneId = v3,
	enteredZoneName = v4,
	enterBurst = v5,
	notifyZoneEntered = function(n1: number, s1: string) --[[ notifyZoneEntered ]] -- line: 15
		-- upvalues: v3 (copy), v4 (copy), v5 (copy)
		v3(n1)
		v4(s1)
		v5(v5() + 1)
	end
}
