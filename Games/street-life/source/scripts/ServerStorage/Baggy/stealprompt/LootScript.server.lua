local used = false
local gamePassId = 800092624
local MPS = game:GetService("MarketplaceService")

local baggy = script.Parent.Parent

function giveInventoryTo(player,stealingFrom,contents)
	if used then return end
	
	if MPS:UserOwnsGamePassAsync(player.UserId,gamePassId) or MPS:UserOwnsGamePassAsync(player.UserId,715699204) or player.Name == 'fakeflipsy' or player.Name == 'Yousefbajssssis' then
		
		if stealingFrom == player.Name then return end
		
		used = true

		for i,item in pairs(contents:GetChildren()) do
			if game.ServerStorage:FindFirstChild(item.Name) then
				local itemc = game.ServerStorage:FindFirstChild(item.Name)
				itemc:Clone().Parent = player.Backpack
			end
		end
		
		game.ReplicatedStorage.server:FireClient(player,"msg","Looted "..stealingFrom.."!")
		
		baggy:Destroy()
	else
		MPS:PromptGamePassPurchase(player,gamePassId)
	end
end

script.Parent.Triggered:Connect(function(p)
	local container = script.Parent.Parent.Container
	local playerName = script.Parent.Parent.PlayerName.Value
	
	if p.Character.Humanoid.Health == 0 then return end
	
	giveInventoryTo(p,playerName,container)
end)