-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Confetti = require(script:WaitForChild("Confetti")),
	Crater = require(script:WaitForChild("Crater")),
	Damage = require(script:WaitForChild("Damage")),
	RewardBillboard = require(script:WaitForChild("RewardBillboard")),
	RewardItem = require(script:WaitForChild("RewardItem")),
	Selection = require(script:WaitForChild("Selection")),
	PlayerTeleport = require(script:WaitForChild("PlayerTeleport")),
	Poof = require(script:WaitForChild("Poof")),
	SmallPuff = require(script:WaitForChild("SmallPuff")),
	Pads = require(script:WaitForChild("Pads")),
	Sparkles = require(script:WaitForChild("Sparkles")),
	ArrowPointer3D = require(script:WaitForChild("ArrowPointer3D")),
	OfflineGeneratedMoney = require(script.OfflineGeneratedMoney),
	OfflineMoneyClaimVisual = require(script.OfflineMoneyClaimVisual)
}

require(game.ReplicatedStorage:WaitForChild("ModuleLoader"))(script, t, {
	warn = function(...) --[[ Line: 21 ]]
		warn(...)
	end
})

return t