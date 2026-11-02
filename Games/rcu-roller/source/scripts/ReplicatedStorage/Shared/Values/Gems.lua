local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Knit = require(RS.Packages.Knit)
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Potions = require(RS.Shared.List.Items.Potions)
local Fruits = require(RS.Shared.List.Items.Fruits)
local ActiveEvents = require(RS.Shared.List.Items.ActiveEvents)

return function(player, data)
	local bonus = 1

	if RunService:IsClient() then
		bonus *= Knit.GetController("FFlagController"):getFFlag("gemsMultiplier") or 1
	else
		bonus *= Knit.GetService("FFlagService"):getFFlag("gemsMultiplier") or 1
	end

	local upgradeLevel = data.upgrades and data.upgrades.gemsMultiplier or 0
	if type(upgradeLevel) == "number" and upgradeLevel > 0 then
		bonus += upgradeLevel * 0.25
	end

	bonus += UpgradeUtils.getAllUpgradeMultipliers(data, "gemsMultiplier")

	if data.passes and data.passes.vip then bonus += 0.25 end

	if data.activeBoosts then
		if data.activeBoosts.gems then bonus += Potions.gems.multiplier end
		if data.activeBoosts.megaGems then bonus += Potions.megaGems.multiplier end
		if data.activeBoosts.grape then bonus += Fruits.grape.multiplier end
		if data.activeBoosts.goldenGrape then bonus += Fruits.goldenGrape.multiplier end
		if data.activeBoosts.gemStar then bonus += ActiveEvents.gemStar.multiplier end
	end

	return bonus
end