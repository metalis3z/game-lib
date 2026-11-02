-- By Rhavi (RhavizinNxtrixz, DON'T USE WITHOUT MY PERMISSION!)

--// Services \\--

local prompt = script.Parent.Prompt
local market = game:GetService("MarketplaceService")
local player = game.Players.LocalPlayer

--// Prompt \\--

prompt.Touched:Connect(function()
	market:PromptPremiumPurchase(player)
	if market.PromptPremiumPurchaseFinished then
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Title = "later!",
			Text = "Thank You, Now you should get the Premium Set!",
			Icon = "rbxassetid://6071020687"
		})
	end
end)