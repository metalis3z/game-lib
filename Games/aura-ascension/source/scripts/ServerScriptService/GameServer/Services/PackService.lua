local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local RateLimiter = require(script.Parent.Parent.Core.RateLimiter)
local TableUtil = require(script.Parent.Parent.Core.TableUtil)
local PacksConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PacksConfig"))

local PackService = {}
PackService.__index = PackService

function PackService.new()
	return setmetatable({
		RateLimiter = RateLimiter.new(),
	}, PackService)
end

function PackService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.RemoteBinder:BindFunction("PackService", "GetPackData", function(player)
		return self:GetPackData(player)
	end)
	self.RemoteBinder:BindFunction("PackService", "PromptPackPurchase", function(player, packId)
		return self:PromptPackPurchase(player, packId)
	end)
end

function PackService:Start()
	self.DataService.ProfileLoaded.Event:Connect(function(player)
		self:PushPackData(player)
	end)
	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		if self.DataService:GetProfile(player) then
			self:PushPackData(player)
		end
	end
end

function PackService:_getProfile(player)
	return self.DataService:GetProfile(player) or self.DataService:WaitForProfile(player, 10)
end

function PackService:_buildPackData(profile)
	local packData = {
		OwnedPacks = TableUtil.ShallowCopy(profile.Inventory.OwnedPacks),
		OwnedPackTitles = TableUtil.ShallowCopy(profile.Inventory.OwnedPackTitles),
		EquippedPackTitle = profile.Inventory.EquippedPackTitle or "",
	}
	for _, pack in ipairs(PacksConfig.GetAllPacks()) do
		if packData.OwnedPacks[pack.Id] == true and pack.Title and type(pack.Title.Id) == "string" then
			packData.OwnedPackTitles[pack.Title.Id] = true
		end
	end
	return packData
end

function PackService:GetPackData(player)
	local profile = self:_getProfile(player)
	if not profile then
		return nil
	end
	return self:_buildPackData(profile)
end

function PackService:PushPackData(player)
	self.RemoteBinder:FireClient("PackService", "PackDataUpdated", player, self:GetPackData(player))
end

function PackService:GrantPackById(player, packId)
	local pack = PacksConfig.GetPack(packId)
	if not pack then
		return false, "INVALID_PACK"
	end

	local profile = self:_getProfile(player)
	if not profile then
		return false, "NO_PROFILE"
	end
	if profile.Inventory.OwnedPacks[pack.Id] == true then
		return false, "AlreadyOwned"
	end

	self.DataService:Mutate(player, function(data)
		data.Inventory.OwnedPacks[pack.Id] = true
		if pack.Title and type(pack.Title.Id) == "string" then
			data.Inventory.OwnedPackTitles[pack.Title.Id] = true
		end
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:PushPackData(player)
	self.Registry:Get("RankTitleService"):PushRankTitleData(player)
	self.Registry:Get("PoseService"):PushPoseData(player)
	return true
end

function PackService:PromptPackPurchase(player, packId)
	local allowed = self.RateLimiter:Allow(player, "PromptPackPurchase", GameConfig.RateLimits.PackPurchase)
	if not allowed then
		return { ok = false, reason = "RATE_LIMITED" }
	end

	local profile = self:_getProfile(player)
	local pack = PacksConfig.GetPack(packId)
	if not profile or not pack then
		return { ok = false, reason = "INVALID_PACK" }
	end
	if profile.Inventory.OwnedPacks[pack.Id] == true then
		self:PushPackData(player)
		return { ok = false, reason = "AlreadyOwned" }
	end

	local productId = PacksConfig.GetProductId and PacksConfig.GetProductId(pack.Id)
	if typeof(productId) ~= "number" or productId <= 0 then
		return { ok = false, reason = "INVALID_PRODUCT" }
	end
	MarketplaceService:PromptProductPurchase(player, productId)
	return {
		ok = true,
		prompted = true,
		productId = productId,
	}
end

return PackService
