local db = false
script.Parent.Equipped:Connect(function(Mouse)
	Mouse.Button1Down:Connect(function()
		if not db then db = true
		local animation = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Animation)
		animation:Play()
		wait(0.5)
		db = false
		end
	end)
end)