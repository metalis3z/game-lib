local msg = game.ReplicatedStorage:WaitForChild("Msg")

msg.OnClientEvent:Connect(function(message,duration)
	
	if game.Players.LocalPlayer.PlayerGui:FindFirstChild("testMsg") then
		game.Players.LocalPlayer.PlayerGui:FindFirstChild("testMsg"):Destroy()
	end
	
	local FrameText = game.ReplicatedStorage.testMsg:Clone()
	FrameText.Parent = game.Players.LocalPlayer.PlayerGui
	FrameText.Frame.TextLabel.Text = message
	
	FrameText.Frame.TextLabel.Transparency = 1
	
	local TweenService = game:GetService('TweenService')
	local Text = FrameText.Frame.TextLabel

	TweenService:Create(
		Text,
		TweenInfo.new(0.5),
		{Transparency = 0}
	):Play()
	
	if duration then wait(duration) end
	
	local endTween = TweenService:Create(
		Text,
		TweenInfo.new(1),
		{Transparency = 1}
	)
	
	endTween:Play()
	endTween.Completed:Connect(function()
		FrameText:Destroy()
	end)
	
end)