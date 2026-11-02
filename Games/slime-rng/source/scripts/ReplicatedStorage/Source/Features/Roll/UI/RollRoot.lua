-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RollRoot, time of decompilation: Sun May  3 10:11:46 2026 ]]
local SpecialRollEdgeOverlay = require(script.Parent.Components.SpecialRollEdgeOverlay)
local RareRollCutscene = require(script.Parent.Components.RareRollCutscene)
local NewSlimeScreen = require(script.Parent.NewSlimeScreen)
local JackpotScreen = require(script.Parent.Jackpot.JackpotScreen)
local RollScreen = require(script.Parent.RollScreen)

return function() -- line: 7
	-- upvalues: SpecialRollEdgeOverlay (copy), RollScreen (copy), JackpotScreen (copy), RareRollCutscene (copy), NewSlimeScreen (copy)
	return {
		SpecialRollEdgeOverlay(),
		RollScreen(),
		JackpotScreen(),
		RareRollCutscene(),
		NewSlimeScreen()
	}
end
