game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("Generic"):WaitForChild("GetGiftsLeft"):InvokeServer()
game.Players.LocalPlayer.PlayerGui:WaitForChild("Gifter").Enabled = false
local v1 = game.Players.LocalPlayer.PlayerGui:WaitForChild("MainGUI"):FindFirstChild("Chat")
if v1 then
	GiftTip = v1:FindFirstChild("Gift")
	if GiftTip then
		GiftTip.Visible = false
	end
end
