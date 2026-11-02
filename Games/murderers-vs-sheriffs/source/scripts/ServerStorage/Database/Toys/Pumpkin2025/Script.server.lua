local isCarved = false
local tool = script.Parent

local char
local Debris = game:GetService("Debris")
local lifeTime = 30

tool.Equipped:Connect(function()
	char = tool.Parent
end)

tool.Unequipped:Connect(function()
	char = nil
end)

tool.Activated:Connect(function()
	if not tool.Enabled then return end

	if isCarved then
		if not char or not char:FindFirstChild("HumanoidRootPart") then return end
		if tool.Enabled then
			local root = char.HumanoidRootPart :: Part
			local forwardPosition = root.Position + root.CFrame.LookVector * 3

			local direction = Vector3.new(0, -10, 0)

			local raycastParams = RaycastParams.new()
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
			raycastParams.FilterDescendantsInstances = {char, tool}

			local rayResult = workspace:Raycast(forwardPosition, direction, raycastParams)

			if rayResult then
				tool.Enabled = false

				local carved = tool.Carved:Clone()
				carved.Orientation = Vector3.new(0,carved.Orientation.Y,0)

				carved.Parent = workspace
				carved.Position = rayResult.Position + Vector3.new(0,0.8,0)
				carved.Anchored = true
				carved.CanCollide = false

				tool.Handle.Transparency = 1
				tool.Carved.Transparency = 1

				Debris:AddItem(carved, lifeTime)

				task.wait(lifeTime)
				tool.Carved.Transparency = 1
				tool.Handle.Transparency = 0
				tool.Enabled = true
				isCarved = false
			end
		end
		return
	end


	tool.Handle.Snip:Play()
	tool.Handle.CarveEffect.Enabled = true
	task.wait(0.5)
	tool.Handle.CarveEffect.Enabled = false
	tool.Handle.Transparency = 1
	isCarved = true
end)