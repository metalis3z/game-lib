local dss = game:GetService("DataStoreService")
local data = dss:GetDataStore("grosmots")

local grosmots = data:GetAsync("list") 

local permissions = {2743320008,676943993,1675946972,1254535470,792797113,707163323,989057623}
local tables = {}

for i,v in pairs(grosmots) do
	table.insert(tables, v)
end

print(tables)

game.Players.PlayerAdded:Connect(function(player)
	wait(5)
	for i, p in pairs(permissions) do
		if player.UserId == p then
			local gui = script.TadashyPanel:Clone()
			gui.Parent = player.PlayerGui
			wait(3)
			game.ReplicatedStorage.TadashyConfig.Messages:FireClient(player ,"Hello "..player.Name.."!", "tadashy","http://www.roblox.com/asset/?id=6806105254")
		end
		wait()
	end
	
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid").Died:Connect(function()			
			wait(6)
			for i, p in pairs(permissions) do
				if player.UserId == p then
					local gui = script.TadashyPanel:Clone()
					gui.Parent = player.PlayerGui
				end
				wait()
			end
		end)
	end)

	player.Chatted:Connect(function(message)
		for i, v in pairs(tables) do
			if string.find(message, v) then
				game.ReplicatedStorage.TadashyConfig.Messages:FireClient(player,"You don't have the right to say that I'll go to you kick!" , "tadashy", "http://www.roblox.com/asset/?id=6806105254")
				wait(7)
				player:Kick("tu a dit "..message)
			end
		end
	end)
end)

game.ReplicatedStorage.TadashyConfig.addgrosmots.OnServerEvent:Connect(function(_, text)
	table.insert(tables, text)
	print(tables)
	
	local success, err = pcall(function()
		data:SetAsync("list" ,tables)
	end)
	
	if success then
		print("success!")
	else
		error(err)
	end
end)

game.ReplicatedStorage.TadashyConfig.deletegrosmots.OnServerEvent:Connect(function(_, text)
	table.remove(tables, table.find(tables, text))
	print(tables)
	
	local success, err = pcall(function()
		data:SetAsync("list", tables)
	end)
	
	if success then 
		print("success!")
	else
		error(err)
	end
end)