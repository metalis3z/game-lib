-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OddsGradients, time of decompilation: Sun May  3 10:12:41 2026 ]]
local RarityTiers = require(script.Parent.RarityTiers)

return {
	getGradient = function(n1: number) --[[ getGradient ]] -- line: 5
		-- upvalues: RarityTiers (copy)
		return RarityTiers.getTier(n1).gradient
	end
}
