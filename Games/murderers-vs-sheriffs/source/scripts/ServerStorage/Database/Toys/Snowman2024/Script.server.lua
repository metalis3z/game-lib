-- idk why i made this i regret it so muchh..!
local Tool = script.Parent
local Debounce = false
local Step = 0
local CurrentPart = nil
local LastPosition = nil
local SnowmanMeshes = game.ServerStorage.SnowmanMeshes

local AnimationCastle = Instance.new("Animation")
AnimationCastle.AnimationId = "rbxassetid://113542036748825"

Tool.Activated:Connect(function()
	if Debounce then return end
	Debounce = true

	local character = Tool.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not rootPart then
		Debounce = false
		return
	end

	local animTrack = humanoid:LoadAnimation(AnimationCastle)
	animTrack:Play()

	local frontPosition = rootPart.Position + rootPart.CFrame.LookVector * 5 + Vector3.new(0, 10, 0)
	local direction = Vector3.new(0, -20, 0)

	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {character}
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist

	local result = workspace:Raycast(frontPosition, direction, rayParams)

	if result then
		local basePosition = result.Position

		if Step == 0 then
			local base = SnowmanMeshes:WaitForChild("Base")
			if base then
				local clone = base:Clone()
				clone.Anchored = true
				clone.CanCollide = false

				local height = clone:IsA("Model") and clone:GetExtentsSize().Y or clone.Size.Y
				clone:PivotTo(CFrame.new(basePosition + Vector3.new(0, height / 2, 0)))

				clone.Parent = workspace

				CurrentPart = clone
				LastPosition = basePosition
				Step = 1
			end

			task.delay(1, function()
				Debounce = false
			end)

		elseif Step == 1 then
			if CurrentPart and CurrentPart.Parent then
				CurrentPart:Destroy()
			end

			local snowman = SnowmanMeshes:WaitForChild("Snowman")
			if snowman then
				local clone = snowman:Clone()
				clone.Anchored = true

				local height = clone:IsA("Model") and clone:GetExtentsSize().Y or clone.Size.Y
				clone:PivotTo(CFrame.new(LastPosition + Vector3.new(0, height / 2, 0)))

				clone.Parent = workspace

				CurrentPart = clone
				Step = 0

				task.delay(12, function()
					if clone and clone.Parent then
						clone:Destroy()
					end
				end)
			end

			task.delay(13, function()
				Debounce = false
			end)
		end
	else
		task.delay(1, function()
			Debounce = false
		end)
	end
end)
