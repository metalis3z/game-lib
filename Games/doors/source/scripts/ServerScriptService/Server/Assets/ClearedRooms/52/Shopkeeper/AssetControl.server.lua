game.ReplicatedStorage.StartShop.OnServerEvent:Connect(function()
	local IntroAnim = script.Parent.Humanoid:LoadAnimation(script.Parent.Animations.Intro)
	IntroAnim:Play()
end)