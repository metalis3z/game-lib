local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local button = script.Parent

-- Put your gamepass ID here
local gamePassId = 1039509747

button.MouseButton1Click:Connect(function()
    MarketplaceService:PromptGamePassPurchase(player, gamePassId)
end)

