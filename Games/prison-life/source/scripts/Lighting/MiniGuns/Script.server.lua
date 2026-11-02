local mkps = game:GetService("MarketplaceService")
local idGamePass = 76717080 
Toolname = "MiniGun"


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
