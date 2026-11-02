local RS = game:GetService("ReplicatedStorage")
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Upgrades = require(RS.Shared.List.Upgrades)
local Potions = require(RS.Shared.List.Items.Potions)
local ActiveEvents = require(RS.Shared.List.Items.ActiveEvents)

return function(player, data)
	local bonus = 0
	bonus += UpgradeUtils.getAllUpgradeMultipliers(data, "toxicPetsLuck")
	local lvl = data.upgrades and data.upgrades.toxicPetsLuck or 0
	if type(lvl) == "number" and lvl > 0 then
		local entry = Upgrades.toxicPetsLuck and Upgrades.toxicPetsLuck.upgrades[lvl]
		if entry then bonus += entry.value end
	end
	if data.activeBoosts and data.activeBoosts.toxic then bonus += Potions.toxic.multiplier end
	if data.activeBoosts and data.activeBoosts.toxicStar then bonus += ActiveEvents.toxicStar.multiplier end
	if data.passes and data.passes.magicEggs then bonus += 1 end
	return bonus
end