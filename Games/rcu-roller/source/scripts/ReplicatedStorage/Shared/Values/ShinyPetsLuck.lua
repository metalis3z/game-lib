local RS = game:GetService("ReplicatedStorage")
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Potions = require(RS.Shared.List.Items.Potions)
local ActiveEvents = require(RS.Shared.List.Items.ActiveEvents)

return function(player, data)
	local bonus = 1
	bonus += UpgradeUtils.getAllUpgradeMultipliers(data, "shinyPetsLuck")
	local lvl = data.upgrades and data.upgrades.shinyPetsLuck or 0
	if type(lvl) == "number" and lvl > 0 then bonus += lvl * 0.05 end
	if data.passes and data.passes.shinyHunter then bonus += 2 end
	if data.activeBoosts and data.activeBoosts.shiny then bonus += Potions.shiny.multiplier end
	if data.activeBoosts and data.activeBoosts.shinyStar then bonus += ActiveEvents.shinyStar.multiplier end
	return bonus
end