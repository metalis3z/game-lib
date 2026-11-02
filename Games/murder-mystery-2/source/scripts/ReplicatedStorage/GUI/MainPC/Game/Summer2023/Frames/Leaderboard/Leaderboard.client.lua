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

local l__Buttons__3 = script.Parent.Buttons
local l__Leaderboard__2 = script.Parent
l__Buttons__3.Gifts.Activated:Connect(function()
	l__Leaderboard__2.Leaderboards.Gifts.Visible = true;
	l__Leaderboard__2.Leaderboards.Tokens.Visible = false;
	l__Buttons__3.Gifts.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	l__Buttons__3.Tokens.Style = Enum.ButtonStyle.RobloxRoundButton;
end);
l__Buttons__3.Tokens.Activated:Connect(function()
	l__Leaderboard__2.Leaderboards.Gifts.Visible = false;
	l__Leaderboard__2.Leaderboards.Tokens.Visible = true;
	l__Buttons__3.Gifts.Style = Enum.ButtonStyle.RobloxRoundButton;
	l__Buttons__3.Tokens.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
end);
l__Buttons__3.Friends.Activated:Connect(function()
	l__Leaderboard__2.Leaderboards.Gifts.Global.Visible = false;
	l__Leaderboard__2.Leaderboards.Gifts.Friends.Visible = true;
	l__Leaderboard__2.Leaderboards.Tokens.Global.Visible = false;
	l__Leaderboard__2.Leaderboards.Tokens.Friends.Visible = true;
	l__Buttons__3.Friends.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	l__Buttons__3.Global.Style = Enum.ButtonStyle.RobloxRoundButton;
end);
l__Buttons__3.Global.Activated:Connect(function()
	l__Leaderboard__2.Leaderboards.Gifts.Global.Visible = true;
	l__Leaderboard__2.Leaderboards.Gifts.Friends.Visible = false;
	l__Leaderboard__2.Leaderboards.Tokens.Global.Visible = true;
	l__Leaderboard__2.Leaderboards.Tokens.Friends.Visible = false;
	l__Buttons__3.Global.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	l__Buttons__3.Friends.Style = Enum.ButtonStyle.RobloxRoundButton;
end);

local Player, TotalCandies = game.ReplicatedStorage.Summer2023Events.GetLeaderboard:InvokeServer()
if Player ~= nil then
	local TokensFrame = script.Parent.Leaderboards.Tokens.Global.Container
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
			LeaderboardFrames.Container.TokenCount.Text = comma_value(DataStore.value) .. " Summer tokens"
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
spawn(function()
	while true do
		game:GetService("RunService").RenderStepped:Wait()
		script.Parent.Timer.Pause.Text =  "You have collected " .. comma_value(game.ReplicatedStorage.Summer2023Events.GetTokens:InvokeServer()) .. " summer tokens in total."
	end
end)
