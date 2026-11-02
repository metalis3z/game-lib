local tool = script.Parent
local sound = tool:WaitForChild("GravestoneSound")
local debounce = false

tool.Activated:Connect(function()
	if debounce then return end
	debounce = true

	local character = tool.Parent
	local handle = tool:FindFirstChild("Handle")
	if not handle then return end

	handle.Transparency = 1

	local handleOnGround = handle:Clone()
	handleOnGround.Name = "DroppedHandle"
	handleOnGround.Anchored = true
	handleOnGround.CanCollide = false
	handleOnGround.Transparency = 0
	handleOnGround.Parent = workspace

	local root = character:FindFirstChild("HumanoidRootPart")
	if root then
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {character}
		params.FilterType = Enum.RaycastFilterType.Blacklist

		local result = workspace:Raycast(
			root.Position + Vector3.new(0,2,0),
			Vector3.new(0,-10,0),
			params
		)

		if result then
			handleOnGround.CFrame =
				CFrame.new(result.Position + Vector3.new(0, handleOnGround.Size.Y/2, 0))
		end
	end

	if sound then sound:Play() end

	task.delay(50, function()
		if handleOnGround and handleOnGround.Parent then
			handleOnGround.Transparency = 1
			handleOnGround.CanCollide = false
		end
	end)

	task.delay(51, function()
		if handleOnGround and handleOnGround.Parent then
			handleOnGround:Destroy()
		end

		if handle and handle.Parent then
			handle.Transparency = 0
		end

		debounce = false
	end)
end)
