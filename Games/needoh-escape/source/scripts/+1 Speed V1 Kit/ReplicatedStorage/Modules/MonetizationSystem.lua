--!strict
-- LOCATION: ReplicatedStorage/Modules/MonetizationSystem

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local MonetizationSystem = {}

local player = Players.LocalPlayer

function MonetizationSystem.PromptProduct(productId: number)
	if not productId then
		warn("[MonetizationSystem] Invalid Product ID")
		return
	end

	local success, err = pcall(function()
		MarketplaceService:PromptProductPurchase(player, productId)
	end)

	if not success then
		warn("[MonetizationSystem] Failed to prompt purchase: " .. tostring(err))
	end
end

function MonetizationSystem.PromptGamePass(gamePassId: number)
	if not gamePassId then return end

	local success, err = pcall(function()
		MarketplaceService:PromptGamePassPurchase(player, gamePassId)
	end)
end

return MonetizationSystem