local mkps = game:GetService("MarketplaceService")
local idGamePass = 102417947 
Toolname = "Riot Shield"
local allowedTeam = BrickColor.new("Bright blue");

function boop(Player)    
	if Player.TeamColor == allowedTeam then
	if mkps:UserOwnsGamePassAsync(Player.userId, idGamePass) then
		if not Player.Backpack:FindFirstChild(Toolname) then
			local Tool = game.ServerStorage[Toolname]:clone()
			Tool.Parent = Player.Backpack
		end
	else
		mkps:PromptGamePassPurchase(Player, idGamePass)
	end
	end
	end
script.Parent.ClickDetector.MouseClick:Connect(boop)
