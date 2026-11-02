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

local Player, TotalCandies = game.ReplicatedStorage.Summer2023Events.GetGiftsLeaderboard:InvokeServer()
if Player ~= nil then
	local TokensFrame = script.Parent.Leaderboards.Gifts.Global.Container
	TokensFrame:ClearAllChildren()
	local Rank = 1
	local RankFrame = 0
	local Ranks = {}
	local function AddLeaderboard(LBPlayer, DataStore)
		local LeaderboardFrames = (script:FindFirstChild("Place" .. Rank) or script.Place):Clone()
		if Rank < 4 then
			spawn(function()
				LeaderboardFrames.Container.PlayerImage.Image = game.ReplicatedStorage.GetPlayerImage:Invoke(DataStore.key)
			end)
		end
		if DataStore.value ~= nil and DataStore.value > 0 then
			LeaderboardFrames.Container.Username.Text = "#" .. Rank .. " - " .. DataStore.key
			LeaderboardFrames.Container.TokenCount.Text = comma_value(DataStore.value) .. " gifts"
			LeaderboardFrames.Parent = TokensFrame
			LeaderboardFrames.Position = UDim2.new(0, 0, 0, RankFrame)
			LeaderboardFrames.Name = DataStore.key
			table.insert(Ranks, LeaderboardFrames)
			RankFrame = RankFrame + LeaderboardFrames.AbsoluteSize.Y
			Rank = Rank + 1
		end
	end
	for Players, Tokens in pairs(Player) do
		AddLeaderboard(Players, Tokens)
	end
end
if game.Players.LocalPlayer ~= nil then
	local TokenRank = 1
	local l__new__5 = 0
	local l__ranks__7 = {}
	local GifterFrame = script.Parent.Leaderboards.Gifts.Friends.Container
	local function ApplyGiftsFriends(LBPlayer, DataStore)
		local LeaderboardFrames = (script:FindFirstChild("Place" .. TokenRank) or script.Place):Clone()
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
		if PlayerData.key ~= game.Players.LocalPlayer.Name and game.Players:GetUserIdFromNameAsync(PlayerData.key) ~= 0 and game.Players.LocalPlayer:IsFriendsWith(game.Players:GetUserIdFromNameAsync(PlayerData.key)) then
			ApplyGiftsFriends(PlayerData.key, PlayerData)
		end
	end
end