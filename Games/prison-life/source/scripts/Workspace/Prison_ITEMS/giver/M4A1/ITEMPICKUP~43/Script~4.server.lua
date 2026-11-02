local mkps = game:GetService("MarketplaceService")
local idGamePass = 102417947 
Toolname = "M4A1"


function boop(Player)
	if mkps:UserOwnsGamePassAsync(Player.userId, idGamePass) then
		if not Player.Backpack:FindFirstChild(Toolname) then
			local Tool = game.ServerStorage[Toolname]:clone()
			Tool.Parent = Player.Backpack
		end
	else
		mkps:PromptGamePassPurchase(Player, idGamePass)
	end
end
script.Parent.ClickDetector.MouseClick:Connect(boop)
