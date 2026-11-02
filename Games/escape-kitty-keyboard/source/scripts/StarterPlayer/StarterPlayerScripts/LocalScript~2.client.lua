local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local GamepassID = 1918401488
local Part = workspace:WaitForChild("VIPPart") -- mets le nom de ta Part ici

local success, ownsPass = pcall(function()
	return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GamepassID)
end)

if success and ownsPass then
	Part.Transparency = 1
	Part.CanCollide = false
end