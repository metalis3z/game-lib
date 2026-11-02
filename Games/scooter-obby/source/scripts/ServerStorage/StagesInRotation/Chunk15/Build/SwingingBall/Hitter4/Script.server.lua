local debounce = false

script.Parent.Touched:Connect(function(part)
	print(part)
	local stringFPC = string.sub(part.Name, 0, 7)
	local player = game.Players:FindFirstChild(part.Name)
	if not player then
		if game.Players:FindFirstChild(stringFPC) then
			player = game.Players:FindFirstChild(stringFPC)
			part = workspace.Ignore:FindFirstChild(player.Name)
		end
	end
	print(player)
	if part.Parent == workspace.Ignore and not debounce then
		if part:FindFirstChild("BallForce") then
			part.BallForce.Force = Vector3.new(0,-5000,0)
			debounce = true
			wait(0.05)
			part.BallForce.Force = Vector3.new(0,0,0)
			wait(.95)
			debounce = false
		end
	end
end)