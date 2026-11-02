local Tool = script.Parent
local PlaceEvent = Tool:WaitForChild("PlaceToyEvent")
local Cooldowns = {}

PlaceEvent.OnServerEvent:Connect(function(Player)
	local Now = tick()
	if Cooldowns[Player] and Now - Cooldowns[Player] < 25 then
		return
	end
	Cooldowns[Player] = Now

	local ToyTemplate = Tool:FindFirstChild("Flamingo2025")
	if not ToyTemplate or not ToyTemplate:IsA("Model") then
		warn("No valid ToyModel inside the tool.")
		return
	end

	local Character = Player.Character
	if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end

	local LookVector = Character.HumanoidRootPart.CFrame.LookVector
	local ForwardOffset = LookVector * 2.5
	local RayOrigin = Character.HumanoidRootPart.Position + ForwardOffset
	local RayDirection = Vector3.new(0, -100, 0)

	local RayParams = RaycastParams.new()
	RayParams.FilterType = Enum.RaycastFilterType.Exclude
	RayParams.FilterDescendantsInstances = {Character}

	local Result = workspace:Raycast(RayOrigin, RayDirection, RayParams)
	if not Result then return end

	local Toy = ToyTemplate:Clone()
	Toy.Parent = workspace

	if not Toy.PrimaryPart then
		warn("ToyModel inside tool has no PrimaryPart set.")
		return
	end

	local Position = Result.Position + Vector3.new(0, Toy.PrimaryPart.Size.Y / 2, 0)
	Toy:SetPrimaryPartCFrame(CFrame.new(Position))

	local Handle = Tool:FindFirstChild("Handle")
	if Handle and Handle:IsA("BasePart") then
		Handle.Transparency = 0.8
	end

	for _, Part in ipairs(Toy:GetDescendants()) do
		if Part:IsA("BasePart") then
			Part.Anchored = true
		end
	end

	local Sound = Toy:FindFirstChild("PlaceSound", true)
	if Sound and Sound:IsA("Sound") then
		Sound:Play()
	end

	task.delay(25, function()
		if Toy and Toy.Parent then
			Toy:Destroy()
		end

		local Handle = Tool:FindFirstChild("Handle")
		if Handle and Handle:IsA("BasePart") then
			Handle.Transparency = 0
		end

		Cooldowns[Player] = nil
	end)
end)