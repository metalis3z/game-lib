local DataStoreService = game:GetService("DataStoreService")
local PlayerTimeStore = DataStoreService:GetDataStore("PlayerTimeStore") -- You can rename the string in quotation marks to whatever you want

function savedata(player) -- Call this function whenever you need to save data
	local success, err = pcall(function()
		PlayerTimeStore:SetAsync(player.UserId, player.leaderstats.Time.Value)
	end)
	if success then
		print("Saved player's data successfully!")
	else
		print(err) -- Prints the error that had happened
	end
end

game.Players.PlayerRemoving:Connect(function(player) -- When player leaves
	savedata(player)
end)

game:BindToClose(function() -- When the server shuts down
	for _, player in pairs(game.Players:GetPlayers()) do
		savedata(player)
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local Time = Instance.new("IntValue") -- Time can be renamed to whatever you want
	Time.Name = "Time"
	Time.Parent = leaderstats
	Time.Value = PlayerTimeStore:GetAsync(player.UserId) or 0
end)

while true do 
	for i, player in pairs(game.Players:GetPlayers()) do
		player.leaderstats.Time.Value +=1
	end
	task.wait(1)
end