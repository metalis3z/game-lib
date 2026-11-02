-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	PromptPurchase = require(script:WaitForChild("PromptPurchase")),
	ApplyRarityColor = require(script:WaitForChild("ApplyRarityColor")),
	GetProductByID = require(script:WaitForChild("GetProductByID")),
	GetGamepassByID = require(script:WaitForChild("GetGamepassByID"))
}

require(game.ReplicatedStorage:WaitForChild("ModuleLoader"))(script, t, {
	warn = function(...) --[[ warn | Line: 8 ]]
		warn(...)
	end
})

return t