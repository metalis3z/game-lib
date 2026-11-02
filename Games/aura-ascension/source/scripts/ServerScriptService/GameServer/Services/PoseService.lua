local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local RateLimiter = require(script.Parent.Parent.Core.RateLimiter)
local TableUtil = require(script.Parent.Parent.Core.TableUtil)
local PoseConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PoseConfig"))
local PacksConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PacksConfig"))

local PoseService = {}
PoseService.__index = PoseService

function PoseService.new()
	return setmetatable({
		RateLimiter = RateLimiter.new(),
	}, PoseService)
end

function PoseService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.RemoteBinder:BindFunction("PoseService", "GetPoseData", function(player)
		return self:GetPoseData(player)
	end)
	self.RemoteBinder:BindFunction("PoseService", "PurchasePoseWithRebirths", function(player, poseId)
		return self:PurchasePoseWithRebirths(player, poseId)
	end)
	self.RemoteBinder:BindFunction("PoseService", "PromptPosePurchase", function(player, poseId)
		return self:PromptPosePurchase(player, poseId)
	end)
	self.RemoteBinder:BindFunction("PoseService", "EquipPose", function(player, poseId)
		return self:EquipPose(player, poseId)
	end)
	self.RemoteBinder:BindFunction("PoseService", "UnequipPose", function(player)
		return self:UnequipPose(player)
	end)
end

function PoseService:Start()
	self.DataService.ProfileLoaded.Event:Connect(function(player)
		self:PushPoseData(player)
	end)
	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		if self.DataService:GetProfile(player) then
			self:PushPoseData(player)
		end
	end
end

function PoseService:_getProfile(player)
	return self.DataService:GetProfile(player) or self.DataService:WaitForProfile(player, 10)
end

function PoseService:_buildOwnedPoses(profile)
	local ownedPoses = TableUtil.ShallowCopy(profile.Inventory.OwnedPoses)
	for packId in pairs(profile.Inventory.OwnedPacks) do
		local poseId = PacksConfig.GetPoseId and PacksConfig.GetPoseId(packId)
		if type(poseId) == "string" and poseId ~= "" then
			ownedPoses[poseId] = true
		end
	end
	return ownedPoses
end

function PoseService:GetPoseData(player)
	local profile = self:_getProfile(player)
	if not profile then
		return nil
	end
	return {
		OwnedPoses = self:_buildOwnedPoses(profile),
		EquippedPose = profile.Inventory.EquippedPose or "",
	}
end

function PoseService:PushPoseData(player)
	self.RemoteBinder:FireClient("PoseService", "PoseDataUpdated", player, self:GetPoseData(player))
end

function PoseService:GrantPoseById(player, poseId)
	if not PoseConfig.GetPose(poseId) then
		return false, "INVALID_POSE"
	end
	self.DataService:Mutate(player, function(data)
		data.Inventory.OwnedPoses[poseId] = true
	end)
	self:PushPoseData(player)
	return true
end

function PoseService:PromptPosePurchase(player, poseId)
	local allowed = self.RateLimiter:Allow(player, "PromptPosePurchase", GameConfig.RateLimits.PosePurchase)
	if not allowed then
		return { ok = false, reason = "RATE_LIMITED" }
	end
	local productId = PoseConfig.GetProductId and PoseConfig.GetProductId(poseId)
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

function PoseService:PurchasePoseWithRebirths(player, poseId)
	local allowed = self.RateLimiter:Allow(player, "PurchasePoseWithRebirths", GameConfig.RateLimits.PosePurchase)
	if not allowed then
		return { ok = false, reason = "RATE_LIMITED" }
	end
	local pose = PoseConfig.GetPose(poseId)
	local price = PoseConfig.GetRebirthPrice and PoseConfig.GetRebirthPrice(poseId)
	local profile = self:_getProfile(player)
	if not pose or not profile then
		return { ok = false, reason = "INVALID_POSE" }
	end
	if profile.Inventory.OwnedPoses[poseId] == true then
		return { ok = false, reason = "ALREADY_OWNED" }
	end
	if typeof(price) ~= "number" or price <= 0 then
		return { ok = false, reason = "NO_REBIRTH_PRICE" }
	end
	if (profile.Stats.Rebirths or 0) < price then
		return { ok = false, reason = "NOT_ENOUGH_REBIRTHS", price = price }
	end
	self.DataService:Mutate(player, function(data)
		data.Stats.Rebirths -= price
		data.Inventory.OwnedPoses[poseId] = true
		data.Inventory.EquippedPose = poseId
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:PushPoseData(player)
	return { ok = true, poseId = poseId, price = price }
end

function PoseService:EquipPose(player, poseId)
	local profile = self:_getProfile(player)
	if not profile then
		return { ok = false, reason = "PROFILE_NOT_READY" }
	end
	local ownedPoses = self:_buildOwnedPoses(profile)
	if ownedPoses[poseId] ~= true then
		return { ok = false, reason = "NOT_OWNED" }
	end
	self.DataService:Mutate(player, function(data)
		data.Inventory.EquippedPose = poseId
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:PushPoseData(player)
	return { ok = true, poseId = poseId }
end

function PoseService:UnequipPose(player)
	self.DataService:Mutate(player, function(data)
		data.Inventory.EquippedPose = ""
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:PushPoseData(player)
	return { ok = true }
end

return PoseService
