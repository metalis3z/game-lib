local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Knit = require(RS.Packages.Knit)
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Upgrades = require(RS.Shared.List.Upgrades)
local Potions = require(RS.Shared.List.Items.Potions)
local Fruits = require(RS.Shared.List.Items.Fruits)
local ActiveEvents = require(RS.Shared.List.Items.ActiveEvents)
local ItemUtils = require(RS.Shared.Util.ItemUtils)
local Functions = require(RS.Shared.Functions)

return function(player, data, options)
	local bonus = 1

	-- Rebirth multiplier: each rebirth adds rebirthClicksMultiplier to bonus
	local Variables = require(RS.Shared.Variables)
	bonus += (data.rebirths or 0) * Variables.rebirthClicksMultiplier

	if RunService:IsClient() then
		bonus *= Knit.GetController("FFlagController"):getFFlag("clicksMultiplier") or 1
	else
		bonus *= Knit.GetService("FFlagService"):getFFlag("clicksMultiplier") or 1
	end

	if data.passes and data.passes.vip then
		bonus += 0.25
	end

	local upgradeLevel = data.upgrades and data.upgrades.clicksMultiplier or 0
	if type(upgradeLevel) == "number" and upgradeLevel > 0 then
		local entry = Upgrades.clicksMultiplier and Upgrades.clicksMultiplier.upgrades[upgradeLevel]
		if entry then bonus += entry.value end
	end

	bonus += UpgradeUtils.getAllUpgradeMultipliers(data, "clicksMultiplier")

	if data.activeBoosts then
		if data.activeBoosts.clicks then bonus += Potions.clicks.multiplier end
		if data.activeBoosts.megaClicks then bonus += Potions.megaClicks.multiplier end
		if data.activeBoosts.apple then bonus += Fruits.apple.multiplier end
		if data.activeBoosts.goldenApple then bonus += Fruits.goldenApple.multiplier end
		if data.activeBoosts.clickStar then bonus += ActiveEvents.clickStar.multiplier end
	end

	bonus += (data.friendsInServer or 0) * 0.05

	local aura = ItemUtils.getItemFromId(data, data.equippedAura)
	if aura then
		local mults = aura:getMultipliers()
		if mults and mults.clicks then
			bonus += mults.clicks
		end
	end

	local clanBoosts = data.clanWeeklyBoosts
	if clanBoosts then
		local week = Functions.getWeekNumber()
		local tiers = {
			{key = "1-1-rebirths", val = 0.25}, {key = "1-1-hatching", val = 0.25},
			{key = "2-3-rebirths", val = 0.20}, {key = "2-3-hatching", val = 0.20},
			{key = "4-10-rebirths", val = 0.10}, {key = "4-10-hatching", val = 0.10},
			{key = "11-25-rebirths", val = 0.05}, {key = "11-25-hatching", val = 0.05},
		}
		for _, t in tiers do
			if clanBoosts[week .. "-" .. t.key] then
				bonus += t.val
			end
		end
	end

	return bonus
end