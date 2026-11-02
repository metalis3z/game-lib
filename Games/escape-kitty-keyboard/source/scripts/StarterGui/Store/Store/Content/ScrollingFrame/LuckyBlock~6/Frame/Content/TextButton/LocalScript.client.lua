local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local gamePassId = 1919277271 -- Remplace par ton ID de Game Pass

script.Parent.MouseButton1Click:Connect(function()
	MarketplaceService:PromptGamePassPurchase(player, gamePassId)
end)