local DataStore = game:GetService("DataStoreService"):GetDataStore("MusicStorage")
game.Players.PlayerAdded:connect(function(player)
	wait(4)
	script.MusicTipGui:Clone().Parent=player.PlayerGui
	if player then
		local music = script.LocalScript:clone()
		local value = DataStore:GetAsync(player.Name)
		local taffy = Instance.new("IntValue",player)
		taffy.Name = "MusicId"
		if value then
			if value > 0 then
				print("setting SoundId for " .. player.Name .. " to http://roblox.com/asset?id="..value)
				music.Sound.SoundId = "http://roblox.com/asset?id="..value
				taffy.Value = value	
			end
		end
		wait()
		music:Clone().Parent = player.PlayerGui
	end
end)

game.Players.PlayerRemoving:connect(function(player)
	local bubblegum = player:FindFirstChild("MusicId")
	local value = DataStore:GetAsync(player.Name)
	if value and bubblegum then
		if value ~= bubblegum.Value then
			DataStore:SetAsync(player.Name,bubblegum.Value)
		end
	end
end)

game.ReplicatedStorage.MasterKey.OnServerEvent:connect(function(player,mode,source)
	if mode == "Music" then
		local bubblegum = player:FindFirstChild("MusicId")
		bubblegum.Value = source
		print("SERVER CONFIRMATION, SETTING MUSIC TO ID "..source)
	end
end)