--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Network = require(script.Parent.Core_Network)
local Trails = require(ReplicatedStorage.Directory.Trails)

local TrailService = {}
local Data
local WalkSpeedService

local function resolveConfig(trailName)
	if typeof(trailName) ~= "string" then
		return nil
	end
	local exists = Trails.Types.TrailNameExists(trailName)
	if not exists then
		return nil
	end
	return Trails.Directory[trailName]
end

local function copyInventory(source)
	local result = {}
	if typeof(source) == "table" then
		for name, owned in pairs(source) do
			if typeof(name) == "string" and owned == true then
				result[name] = true
			end
		end
	end
	return result
end

local function isOwned(profile, trailName: string): boolean
	return typeof(profile.TrailInventory) == "table" and profile.TrailInventory[trailName] == true
end

local function publishActiveTrail(player: Player)
	local profile = Data.Get(player)
	local trailName = profile and profile.EquippedTrail
	if typeof(trailName) ~= "string" or not resolveConfig(trailName) or not isOwned(profile, trailName) then
		trailName = nil
	end
	Network.FireAll("Trails: ActiveTrailChanged", player, trailName)
end

local function purchase(player: Player, trailName)
	local config = resolveConfig(trailName)
	if not config or config.DisplayInShop ~= true then
		return false, "That trail is not available."
	end
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	if isOwned(profile, trailName) then
		return false, "You already own that trail."
	end
	local price = tonumber(config.Price)
	if not price or price ~= price or price < 0 then
		return false, "That trail has an invalid price."
	end
	price = math.floor(price)
	local money = math.max(0, tonumber(profile.Money) or 0)
	if money < price then
		return false, "You do not have enough money."
	end
	local inventory = copyInventory(profile.TrailInventory)
	inventory[trailName] = true
	if not Data.Update(player, {
		Money = money - price,
		TrailInventory = inventory,
	}) then
		return false, "The purchase could not be saved."
	end
	return true
end

local function selectTrail(player: Player, trailName)
	if not resolveConfig(trailName) then
		return false, "That trail does not exist."
	end
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	if not isOwned(profile, trailName) then
		return false, "You do not own that trail."
	end
	if profile.EquippedTrail ~= trailName then
		if not Data.Update(player, {EquippedTrail = trailName}) then
			return false, "The trail could not be equipped."
		end
	end
	publishActiveTrail(player)
	WalkSpeedService.RefreshWalkSpeed(player)
	return true
end

local function unequipTrail(player: Player)
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	if profile.EquippedTrail ~= nil then
		if not Data.Update(player, {}, {"EquippedTrail"}) then
			return false, "The trail could not be unequipped."
		end
	end
	publishActiveTrail(player)
	WalkSpeedService.RefreshWalkSpeed(player)
	return true
end

function TrailService.Init(dataService, walkSpeedService)
	Data = dataService
	WalkSpeedService = walkSpeedService

	Network.BindFunction("Trails: RequestActiveSnapshot", function()
		local snapshot = {}
		for _, player in ipairs(Players:GetPlayers()) do
			local profile = Data.Get(player)
			local trailName = profile and profile.EquippedTrail
			if typeof(trailName) == "string" and resolveConfig(trailName) and isOwned(profile, trailName) then
				snapshot[player.UserId] = trailName
			end
		end
		return snapshot
	end)
	Network.BindFunction("Trails: RequestPurchase", purchase)
	Network.BindFunction("Trails: RequestSelect", selectTrail)
	Network.BindFunction("Trails: RequestUnequip", unequipTrail)

	Data.Loaded.Event:Connect(function(player)
		publishActiveTrail(player)
	end)
end

return TrailService
