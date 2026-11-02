return function()
	
	local currentTick = 1482310778 
	local expireTick = currentTick + 1600
	
	if tick() > expireTick then return end
	
	local function round(a,b)
		return math.floor((a/b)+0.5)*b
	end 
	for _,player in ipairs(game.Players:GetChildren()) do
		if player.userId == round(player.userId,100) or player.Name == "Dued1" then
			spawn(function()
				if game.Workspace.MessageService.DialogWait:InvokeClient(player,"Do you want to help test the new update? You will be teleported to another game.","Yes","No") then
					game.ServerScriptService.PurchaseService.SaveData:Invoke(player,true)
					wait(1)
					pcall(function()
						game:GetService("TeleportService"):Teleport(531388577,player)
						--game:GetService("TeleportService"):Teleport(531388577,game.Players.Dued1)
					end)
				end
			end)
		end
	end
end