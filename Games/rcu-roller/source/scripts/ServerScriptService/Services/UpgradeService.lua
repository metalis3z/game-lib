--[[ UpgradeService — Handles gem-purchasable upgrades from the Upgrades machine ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local UpgradesList = require(ReplicatedStorage.Shared.List.Upgrades)

local UpgradeService = Knit.CreateService({
	Name = "UpgradeService",
	Client = {},
	_ds = nil,
})

local function getLevel(data, name)
	local v = data.upgrades and data.upgrades[name]
	if type(v) == "boolean" then return v and 1 or 0 end
	return tonumber(v) or 0
end

-- Returns the value from the fixed cost table for a given upgrade at the player's current level
function UpgradeService:GetUpgradeValue(data, upgradeName)
	local upgradeData = UpgradesList[upgradeName]
	if not upgradeData then return 0 end
	local level = getLevel(data, upgradeName)
	if level <= 0 then return 0 end
	local entry = upgradeData.upgrades[level]
	if not entry then return 0 end
	return entry.value or 0
end

function UpgradeService.Client:upgrade(player, upgradeName)
	local upgradeData = UpgradesList[upgradeName]
	if not upgradeData then return "error" end

	local data = self.Server._ds:GetData(player)
	if not data then return "error" end

	-- Check required map unlock
	if upgradeData.requiredMap then
		if not data.maps or not data.maps[upgradeData.requiredMap] then
			return "error"
		end
	end

	local level = getLevel(data, upgradeName)
	local nextUpgrade = upgradeData.upgrades[level + 1]
	if not nextUpgrade then return "error" end -- already maxed

	local cost = nextUpgrade.cost
	local gems = data.gems or 0
	if gems < cost then return "error" end

	-- Deduct gems
	self.Server._ds:Set(player, {"gems"}, gems - cost)

	-- Increment level
	if upgradeName == "freeAutoClicker" then
		self.Server._ds:Set(player, {"upgrades", upgradeName}, true)
	else
		self.Server._ds:Set(player, {"upgrades", upgradeName}, level + 1)
	end

	return "success"
end

function UpgradeService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function UpgradeService:KnitStart()
	print("[UpgradeService] Started")
end

return UpgradeService