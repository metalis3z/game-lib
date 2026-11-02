local RS = game:GetService("ReplicatedStorage")
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Upgrades = require(RS.Shared.List.Upgrades)
local Potions = require(RS.Shared.List.Items.Potions)
local ActiveEvents = require(RS.Shared.List.Items.ActiveEvents)

return function(player, data)
	local bonus = 0
	bonus += UpgradeUtils.getAllUpgradeMultipliers(data, "goldenPetsLuck")
	local lvl = data.upgrades and data.upgrades.goldenPetsLuck or 0
	if type(lvl) == "number" and lvl > 0 then
		local entry = Upgrades.goldenPetsLuck and Upgrades.goldenPetsLuck.upgrades[lvl]
		if entry then bonus += entry.value end
	end
	if data.activeBoosts and data.activeBoosts.golden then bonus += Potions.golden.multiplier end
	if data.activeBoosts and data.activeBoosts.goldenStar then bonus += ActiveEvents.goldenStar.multiplier end
	if data.passes and data.passes.magicEggs then bonus += 10 end
	return bonus
end