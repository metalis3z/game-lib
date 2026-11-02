function findNearestHumanoidRootPart(pos)
	local list = workspace:children()
	local HumanoidRootPart = nil
	local dist = 350
	local temp = nil
	local human = nil
	local temp2 = nil
	for x = 1, #list do
		temp2 = list[x]
		if temp2:IsA("Model") and temp2 ~= script.Parent then
			temp = temp2:FindFirstChild("HumanoidRootPart")
			human = temp2:FindFirstChild("Humanoid")
			if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
				if (temp.Position - pos).Magnitude < dist then
					HumanoidRootPart = temp
					dist = (temp.Position - pos).Magnitude

				end
			end
		end
	end
	return HumanoidRootPart
end

while wait() do
	wait(0.1)
	local target = findNearestHumanoidRootPart(script.Parent:WaitForChild("Primar").Position)
	if target ~= nil then
		if (target.Position - script.Parent:WaitForChild("Primar").Position).Magnitude < 120 then
			game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(2, 18, 0, 0.7)
		end
	end
end