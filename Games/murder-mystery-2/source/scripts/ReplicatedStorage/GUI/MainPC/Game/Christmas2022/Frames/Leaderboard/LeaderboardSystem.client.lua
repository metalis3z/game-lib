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
local Player, TotalCandies = game.ReplicatedStorage.Christmas2022Events.GetLeaderboard:InvokeServer()
if Player ~= nil then
	local TokensFrame = script.Parent.Contents.Tokens.Container
	TokensFrame:ClearAllChildren()
	local Rank = 1
	local RankFrame = 0
	local Ranks = {}
	local function AddLeaderboard(LBPlayer, DataStore)
		local LeaderboardFrames = (script.LeaderboardFrames:FindFirstChild("Place" .. Rank) or script.LeaderboardFrames.Place):Clone()
		if Rank < 4 then
			spawn(function()
				LeaderboardFrames.Container.PlayerImage.Image = game.ReplicatedStorage.GetPlayerImage:Invoke(DataStore.key)
			end)
		end
		if DataStore.value ~= nil and DataStore.value > 0 then
			LeaderboardFrames.Container.Username.Text = "#" .. Rank .. " - " .. DataStore.key
			LeaderboardFrames.Container.TokenCount.Text = comma_value(DataStore.value) .. " Snow Tokens"
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
		script.Parent.Description.Text =  "You have earned " .. game.ReplicatedStorage.Christmas2022Events.GetTokens:InvokeServer() .. " Snow Tokens In total."
	end
end)
