local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PoseConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PoseConfig"))
local PacksConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PacksConfig"))
local TableUtil = require(script.Parent.Parent.Core.TableUtil)

local ReceiptService = {}
ReceiptService.__index = ReceiptService

function ReceiptService.new()
	return setmetatable({}, ReceiptService)
end

function ReceiptService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.PoseProductMap = PoseConfig.GetProductIdToPoseMap and PoseConfig.GetProductIdToPoseMap() or {}
	self.PackProductMap = PacksConfig.GetProductIdToPackMap and PacksConfig.GetProductIdToPackMap() or {}
	self.RemoteBinder:BindFunction("ReceiptService", "GetEntitlements", function(player)
		return self:GetEntitlements(player)
	end)
	MarketplaceService.ProcessReceipt = function(receiptInfo)
		return self:ProcessReceipt(receiptInfo)
	end
end

function ReceiptService:GetEntitlements(player)
	local profile = self.DataService:GetProfile(player)
	if not profile then
		return nil
	end
	return {
		OwnedPoses = TableUtil.ShallowCopy(profile.Inventory.OwnedPoses),
		OwnedPacks = TableUtil.ShallowCopy(profile.Inventory.OwnedPacks),
		OwnedPackTitles = TableUtil.ShallowCopy(profile.Inventory.OwnedPackTitles),
		AuraBoost = profile.Monetization.AuraBoost or 1,
		RebirthPackBuys = TableUtil.ShallowCopy(profile.Monetization.RebirthPackBuys),
	}
end

function ReceiptService:_grantPose(player, poseId)
	local success = self.Registry:Get("PoseService"):GrantPoseById(player, poseId)
	if success then
		self.RemoteBinder:FireClient("ReceiptService", "EntitlementGranted", player, {
			Type = "Pose",
			Id = poseId,
		})
	end
	return success
end

function ReceiptService:_grantPack(player, packId)
	local success = self.Registry:Get("PackService"):GrantPackById(player, packId)
	if success then
		self.RemoteBinder:FireClient("ReceiptService", "EntitlementGranted", player, {
			Type = "Pack",
			Id = packId,
		})
	end
	return success
end

function ReceiptService:ProcessReceipt(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	if not self.DataService:GetProfile(player) then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local monetizationService = self.Registry:Get("MonetizationService")
	if monetizationService:GrantAuraBoostByProductId(player, receiptInfo.ProductId) then
		self.RemoteBinder:FireClient("ReceiptService", "EntitlementGranted", player, {
			Type = "AuraBoost",
			Id = receiptInfo.ProductId,
		})
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
	if monetizationService:GrantRebirthPackByProductId(player, receiptInfo.ProductId) then
		self.RemoteBinder:FireClient("ReceiptService", "EntitlementGranted", player, {
			Type = "RebirthPack",
			Id = receiptInfo.ProductId,
		})
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local poseId = self.PoseProductMap[receiptInfo.ProductId]
	if poseId then
		if self:_grantPose(player, poseId) then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local packId = self.PackProductMap[receiptInfo.ProductId]
	if packId then
		if self:_grantPack(player, packId) then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	warn("[ReceiptService] Unknown developer product:", receiptInfo.ProductId)
	return Enum.ProductPurchaseDecision.NotProcessedYet
end

return ReceiptService
