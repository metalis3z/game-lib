script.Parent.MouseButton1Click:Connect(function()
	local MarketplaceService = game:GetService("MarketplaceService")
	local id = 271377202 -- Change to your Gamepass ID
	local hasPass
	local player = game.Players.LocalPlayer
	local success, message = pcall(function()
		hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, id)
	end)

	if hasPass then
		local char = player.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
	else
		MarketplaceService:PromptGamePassPurchase(player, id)
	end
end) 
