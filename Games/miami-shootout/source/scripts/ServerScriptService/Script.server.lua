local plrs = game:GetService("Players")

plrs.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(TextTyped, Targ)
		local words = TextTyped:split(" ")
		local TextService = game:GetService("TextService")
		local first = words[1]
		local filteredtext = TextService:FilterStringAsync(table.concat(words, " ", 2), player.UserId):GetNonChatStringForBroadcastAsync()
		if first == "/tweet" and player.Character:WaitForChild("Tweet"):WaitForChild("Cooldown").Value == 0 then
			local mode = "Success"
			local otherwords = table.concat(words, " ", 2)
			game.ReplicatedStorage.Tweet:FireAllClients(player, filteredtext, mode)
			player.Character:WaitForChild("Tweet"):WaitForChild("Cooldown").Value = 60
		else
			if first == "/tweet" and player.Character:WaitForChild("Tweet"):WaitForChild("Cooldown").Value > 0 then
				local mode = "Failed"
				local otherwords = "You have a tweet cooldown for ".. player.Character.Tweet.Cooldown.Value.. " seconds!"
				game.ReplicatedStorage.Tweet:FireAllClients(player, otherwords, mode)
			elseif first == "/emojis" then
				print("EmojisServer")
				local mode = "Emojis"
				game.ReplicatedStorage.Emojis:FireClient(player)
			end
		end
	end)
end)