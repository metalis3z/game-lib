local UsernameBox = script.Parent.Username
local ReasonBox = script.Parent.Reason
local ReplicatedStorage = game.ReplicatedStorage
local PlayerService = game.Players

script.Parent.BanButton.MouseButton1Click:Connect(function()
	ReplicatedStorage.Remotes.Bans.BanUser:FireServer(PlayerService:GetUserIdFromNameAsync(UsernameBox.Text), ReasonBox.Text)
end)

script.Parent.UnbanButton.MouseButton1Click:Connect(function()
	ReplicatedStorage.Remotes.Bans.UnbanUser:FireServer(PlayerService:GetUserIdFromNameAsync(UsernameBox.Text))
end)