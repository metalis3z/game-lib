-- Game: rcu-roller
-- Original: ReplicatedStorage/Shared/Values/Luck.lua
-- What it does: One function that adds every luck source together: server flag, global event, upgrades, gamepasses, potions, fruits, events and the equipped aura. Same code runs on client (for display) and server (for the roll).

local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Knit = require(RS.Packages.Knit)
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Upgrades = require(RS.Shared.List.Upgrades)
local Potions = require(RS.Shared.List.Items.Potions)
local Fruits = require(RS.Shared.List.Items.Fruits)
local ActiveEvents = require(RS.Shared.List.Items.ActiveEvents)
local ItemUtils = require(RS.Shared.Util.ItemUtils)

return function(player, data, extraLuck)
	local bonus = 1

	if RunService:IsClient() then
		bonus *= Knit.GetController("FFlagController"):getFFlag("luckMultiplier") or 1
		bonus += Knit.GetController("EggController"):getGlobalLuckEventAmount()
	else
		bonus *= Knit.GetService("FFlagService"):getFFlag("luckMultiplier") or 1
		bonus += Knit.GetService("EggService"):getGlobalLuckEventAmount()
	end

	bonus += UpgradeUtils.getAllUpgradeMultipliers(data, "luckMultiplier")

	local upgradeLevel = data.upgrades and data.upgrades.luckMultiplier or 0
	if type(upgradeLevel) == "number" and upgradeLevel > 0 then
		local entry = Upgrades.luckMultiplier and Upgrades.luckMultiplier.upgrades[upgradeLevel]
		if entry then bonus += entry.value end
	end

	if data.passes then
		if data.passes.megaLuck then bonus += 0.5 end
		if data.passes.ultraLuck then bonus += 1.0 end
		if data.passes.vip then bonus += 0.25 end
	end

	if data.activeBoosts then
		if data.activeBoosts.luck then bonus += Potions.luck.multiplier end
		if data.activeBoosts.megaLuck then bonus += Potions.megaLuck.multiplier end
		if data.activeBoosts.carrot then bonus += Fruits.carrot.multiplier end
		if data.activeBoosts.goldenCarrot then bonus += Fruits.goldenCarrot.multiplier end
		if data.activeBoosts.luckyStar then bonus += ActiveEvents.luckyStar.multiplier end
		if data.activeBoosts.megaLuckyStar then bonus += ActiveEvents.megaLuckyStar.multiplier end
	end

	local aura = ItemUtils.getItemFromId(data, data.equippedAura)
	if aura then
		local mults = aura:getMultipliers()
		if mults and mults.luck then bonus += mults.luck end
	end

	bonus += (extraLuck or 0)
	return bonus
end
