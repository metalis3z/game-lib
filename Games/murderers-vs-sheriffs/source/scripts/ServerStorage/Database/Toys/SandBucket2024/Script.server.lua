-- all rights deserved to Peppa Pig ™
local Tool = script.Parent

local Step = 0
local CurrentSand = nil
local LastPosition = nil

local MAX_BUILD_DISTANCE = 7
local SAND_TIMEOUT = 4

local CanCreateSand = true
local Debounce = false

local AnimationSand = Instance.new("Animation")
AnimationSand.AnimationId = "rbxassetid://112652880183088"

local AnimationCastle = Instance.new("Animation")
AnimationCastle.AnimationId = "rbxassetid://113542036748825"

local function placeModel(model, position)
	local clone = model:Clone()
	clone.Anchored = true

	if clone:IsA("Model") then
		local sizeY = clone:GetExtentsSize().Y
		clone:PivotTo(CFrame.new(position + Vector3.new(0, sizeY / 2, 0)))
	else
		clone.CFrame = CFrame.new(position + Vector3.new(0, clone.Size.Y / 2, 0))
	end

	clone.Parent = workspace
	return clone
end

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

	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {character}
	params.FilterType = Enum.RaycastFilterType.Blacklist

	local result = workspace:Raycast(
		rootPart.Position + rootPart.CFrame.LookVector * 5 + Vector3.new(0, 10, 0),
		Vector3.new(0, -20, 0),
		params
	)

	if not result then
		Debounce = false
		return
	end

	local position = result.Position

	if Step == 0 and CanCreateSand then
		local sand = Tool:FindFirstChild("SandPile")
		if not sand then
			Debounce = false
			return
		end

		humanoid:LoadAnimation(AnimationSand):Play()

		CurrentSand = placeModel(sand, position)
		LastPosition = position
		Step = 1
		CanCreateSand = false

		task.delay(SAND_TIMEOUT, function()
			CanCreateSand = true
		end)

	elseif Step == 1 and CurrentSand and LastPosition then
		local distance = (rootPart.Position - LastPosition).Magnitude
		if distance > MAX_BUILD_DISTANCE then
			Debounce = false
			return
		end

		local castle = Tool:FindFirstChild("Castle")
		if not castle then
			Debounce = false
			return
		end

		humanoid:LoadAnimation(AnimationCastle):Play()

		if CurrentSand and CurrentSand.Parent then
			CurrentSand:Destroy()
		end

		local castleClone = placeModel(castle, LastPosition)

		task.delay(15, function()
			if castleClone and castleClone.Parent then
				castleClone:Destroy()
			end
		end)

		CurrentSand = nil
		LastPosition = nil
		Step = 0
	end

	task.delay(0.3, function()
		Debounce = false
	end)
end)
