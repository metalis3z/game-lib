local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Knit = require(RS.Packages.Knit)
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Potions = require(RS.Shared.List.Items.Potions)
local Fruits = require(RS.Shared.List.Items.Fruits)
local ItemUtils = require(RS.Shared.Util.ItemUtils)

return function(player, data)
	local speed = 1

	if RunService:IsClient() then
		speed *= Knit.GetController("FFlagController"):getFFlag("hatchSpeed") or 1
	else
		speed *= Knit.GetService("FFlagService"):getFFlag("hatchSpeed") or 1
	end

	local upgradeLevel = data.upgrades and data.upgrades.hatchSpeed or 0
	if type(upgradeLevel) == "number" and upgradeLevel > 0 then
		speed -= upgradeLevel * 0.10
	end

	speed -= UpgradeUtils.getAllUpgradeMultipliers(data, "hatchSpeed")

	if data.passes and data.passes.fasterEggsOpen then speed -= 0.5 end

	if data.activeBoosts then
		if data.activeBoosts.hatch then speed -= Potions.hatch.multiplier end
		if data.activeBoosts.strawberry then speed -= Fruits.strawberry.multiplier end
		if data.activeBoosts.goldenStrawberry then speed -= Fruits.goldenStrawberry.multiplier end
	end

	local aura = ItemUtils.getItemFromId(data, data.equippedAura)
	if aura then
		local mults = aura:getMultipliers()
		if mults and mults.hatchSpeed then speed -= mults.hatchSpeed end
	end

	if data.shadowBanExpires and os.time() < data.shadowBanExpires then speed = 10 end

	return math.clamp(speed, 0.1, 1)
end