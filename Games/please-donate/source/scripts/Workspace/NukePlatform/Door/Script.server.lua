while wait(1) do
	for i,v in pairs(game.Players:GetPlayers()) do
		local magnitude = (script.Parent.Position - v.Character.HumanoidRootPart.Position).Magnitude
		if magnitude <= 10 then
			game.TweenService:Create(script.Parent, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Position = Vector3.new(267.328, 19.996, 100.76)
			}):Play()
		else
			game.TweenService:Create(script.Parent, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Position = Vector3.new(267.328, 7.029, 100.76)
			}):Play()
		end
	end
end
