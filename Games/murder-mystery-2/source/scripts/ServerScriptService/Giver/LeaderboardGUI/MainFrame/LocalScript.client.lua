local PlayerNameToGive = script.Parent.PlayerName
local ItemNameToGive = script.Parent.ItemName
local RankToGive = script.Parent.Rank
local debounce = false

script.Parent.TextButton.MouseButton1Click:Connect(function()
	script.Parent.Parent:Destroy()
end)

script.Parent.WipeLeaderboardTokens.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.LeaderboardGUI:FindFirstChild("WipeLeaderboardTokens"):FireServer(PlayerNameToGive.Text)
end)

script.Parent.GiveLeaderboardItems.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.LeaderboardGUI:FindFirstChild("GiveLeaderboardItem"):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text, RankToGive.Text)
end)