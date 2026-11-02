function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

if game:GetService("Players").LocalPlayer ~= nil then
	local TokenRank = 1
	local l__new__5 = 0
	local l__ranks__7 = {}
	local GifterFrame = script.Parent.Leaderboards.Tokens.Friends.Container
	local function ApplyGiftsFriends(LBPlayer, DataStore)
		local LeaderboardFrames = (script.Parent.Leaderboard:FindFirstChild("Place" .. TokenRank) or script.Parent.Leaderboard.Place):Clone()
		if TokenRank < 4 then
			spawn(function()
				LeaderboardFrames.Container.PlayerImage.Image = game.ReplicatedStorage.GetPlayerImage:Invoke(DataStore.key)
			end)
		end
		if DataStore.value ~= nil and DataStore.value > 0 then
			LeaderboardFrames.Container.Username.Text = "#" .. TokenRank .. " - " .. DataStore.key
			LeaderboardFrames.Container.TokenCount.Text = comma_value(DataStore.value) .. " Summer tokens"
			LeaderboardFrames.Parent = GifterFrame
			LeaderboardFrames.Position = UDim2.new(0, 0, 0, l__new__5)
			LeaderboardFrames.Name = DataStore.key
			table.insert(l__ranks__7, LeaderboardFrames)
			l__new__5 = l__new__5 + LeaderboardFrames.AbsoluteSize.Y
			TokenRank = TokenRank + 1
		end
	end
	local l__Friends_Tokens__9 =  game.ReplicatedStorage.Summer2023Events.GetLeaderboard:InvokeServer()
	for _, PlayerData in pairs(l__Friends_Tokens__9) do
		if PlayerData.key ~= game:GetService("Players").LocalPlayer.Name and game:GetService("Players"):GetUserIdFromNameAsync(PlayerData.key) ~= 0 and game:GetService("Players").LocalPlayer:IsFriendsWith(game:GetService("Players"):GetUserIdFromNameAsync(PlayerData.key)) then
			ApplyGiftsFriends(PlayerData.key, PlayerData)
		end
	end
end

if game:GetService("Players").LocalPlayer ~= nil then
	local TokenRank = 1
	local l__new__5 = 0
	local l__ranks__7 = {}
	local GifterFrame = script.Parent.Leaderboards.Gifts.Friends.Container
	local function ApplyGiftsFriends(LBPlayer, DataStore)
		local LeaderboardFrames = (script.Parent.Leaderboard2:FindFirstChild("Place" .. TokenRank) or script.Parent.Leaderboard2.Place):Clone()
		if TokenRank < 4 then
			spawn(function()
				LeaderboardFrames.Container.PlayerImage.Image = game.ReplicatedStorage.GetPlayerImage:Invoke(DataStore.key)
			end)
		end
		if DataStore.value ~= nil and DataStore.value > 0 then
			LeaderboardFrames.Container.Username.Text = "#" .. TokenRank .. " - " .. DataStore.key
			LeaderboardFrames.Container.TokenCount.Text = comma_value(DataStore.value) .. " gifts"
			LeaderboardFrames.Parent = GifterFrame
			LeaderboardFrames.Position = UDim2.new(0, 0, 0, l__new__5)
			LeaderboardFrames.Name = DataStore.key
			table.insert(l__ranks__7, LeaderboardFrames)
			l__new__5 = l__new__5 + LeaderboardFrames.AbsoluteSize.Y
			TokenRank = TokenRank + 1
		end
	end
	local l__Friends_Tokens__9 =  game.ReplicatedStorage.Summer2023Events.GetGiftsLeaderboard:InvokeServer()
	for _, PlayerData in pairs(l__Friends_Tokens__9) do
		if PlayerData.key ~= game:GetService("Players").LocalPlayer.Name and game:GetService("Players"):GetUserIdFromNameAsync(PlayerData.key) ~= 0 and game:GetService("Players").LocalPlayer:IsFriendsWith(game:GetService("Players"):GetUserIdFromNameAsync(PlayerData.key)) then
			ApplyGiftsFriends(PlayerData.key, PlayerData)
		end
	end
end