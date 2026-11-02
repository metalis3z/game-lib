local RS = game:GetService("ReplicatedStorage")
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Potions = require(RS.Shared.List.Items.Potions)
local Upgrades = require(RS.Shared.List.Upgrades)

return function(player, data)
	local bonus = 0

	-- Passive bonuses (achievements, prestige, clans, index)
	bonus += UpgradeUtils.getAllUpgradeMultipliers(data, "auraLuck")

	-- Machine upgrade (aurasLuck from gem shop)
	local lvl = data.upgrades and data.upgrades.aurasLuck or 0
	if type(lvl) == "number" and lvl > 0 then
		local entry = Upgrades.aurasLuck and Upgrades.aurasLuck.upgrades[lvl]
		if entry then bonus += entry.value end
	end

	if data.activeBoosts and data.activeBoosts.rngLuck then bonus += Potions.rngLuck.multiplier end
	bonus += math.clamp((data.day or 0) * 0.02, 0, 0.6)
	return bonus
end