local RS = game:GetService("ReplicatedStorage")
local UpgradeUtils = require(RS.Shared.Util.UpgradeUtils)
local Upgrades = require(RS.Shared.List.Upgrades)

return function(player, data)
	local slots = 3

	-- Passive bonuses (achievements, prestige, clans, index)
	slots += UpgradeUtils.getAllUpgradeMultipliers(data, "petsEquipped")

	-- Machine upgrade (petEquip from gem shop — value is direct slot count)
	local petEquipLvl = data.upgrades and data.upgrades.petEquip or 0
	if type(petEquipLvl) == "number" and petEquipLvl > 0 then
		local entry = Upgrades.petEquip and Upgrades.petEquip.upgrades[petEquipLvl]
		if entry then slots += entry.value end
	end

	-- Gamepasses
	if data.passes then
		if data.passes.petEquip2 then slots += 2 end
		if data.passes.petEquip3 then slots += 3 end
	end

	return slots
end