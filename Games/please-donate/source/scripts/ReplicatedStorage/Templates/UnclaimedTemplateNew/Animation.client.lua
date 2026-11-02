local function u6(p3, p4, p5)
	game:GetService("TweenService"):Create(p3, TweenInfo.new(p4, Enum.EasingStyle.Quint), p5):Play();
end;
script.Parent.MouseEnter:Connect(function()
	local GiftTemplate = script.Parent
	GiftTemplate.Hover.UIPadding.PaddingRight = UDim.new(0.04, 0)
	GiftTemplate.Hover.Claim.TextTransparency = 1
	GiftTemplate.Hover.Tap.TextTransparency = 1
	GiftTemplate.Hover.BackgroundTransparency = 1
	u6(GiftTemplate.Hover, 0.4, {
		BackgroundTransparency = 0.3
	});
	u6(GiftTemplate.Hover.Claim, 0.4, {
		TextTransparency = 0
	});
	u6(GiftTemplate.Hover.Tap, 0.4, {
		TextTransparency = 0
	});
	u6(GiftTemplate.Hover.UIPadding, 0.4, {
		PaddingRight = UDim.new(.1,0)
	});
end)

script.Parent.MouseLeave:Connect(function()
	local GiftTemplate = script.Parent
	u6(GiftTemplate.Hover, 0.4, {
		BackgroundTransparency = 1
	});
	u6(GiftTemplate.Hover.Claim, 0.4, {
		TextTransparency = 1
	});
	u6(GiftTemplate.Hover.Tap, 0.4, {
		TextTransparency = 1
	});
end)
function subtractGiftCount()
	game.Players.LocalPlayer.PlayerGui.ScreenGui.Buttons.Gift.Count.Text = (tonumber(game.Players.LocalPlayer.PlayerGui.ScreenGui.Buttons.Gift.Count.Text) and 1) - 1;
	game.Players.LocalPlayer.PlayerGui.ScreenGui.Gift.Buttons.Inbox.Count.Text = (tonumber(game.Players.LocalPlayer.PlayerGui.ScreenGui.Buttons.Gift.Count.Text) and 1) - 1;
end;
--script.Parent.Activated:Connect(function()
--	game.ReplicatedStorage.SendGiftType:FireServer("claim", script.Username.Value, script.Parent.Name)
--	subtractGiftCount()
--	game.SoundService.Success:Play()
--	script.Parent:Destroy()
--end)