
DB = true


local animation

script.Parent.Equipped:Connect(function()
	
	animation = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Animation)
	
	animation:Play()
	
	
end)

script.Parent.Unequipped:Connect(function()
	
	
	animation:Stop()
	
	
end)

script.Parent.Activated:connect(function()
	if DB == true then
		DB = false
		
		local player = game.Players:FindFirstChild(script.Parent.Parent.Name)
		local val = script.Parent.val.Value
		local ani =  player.Character.Humanoid:LoadAnimation(script.Parent.Pocket)
		
		ani:Play()
		animation:Stop()
		
	end
end)


