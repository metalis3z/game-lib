local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local tool = script.Parent

local remote = ReplicatedStorage
	:WaitForChild("Signals")
	:WaitForChild("RemoteEvents")
	:WaitForChild("JetpackControl")

local action = "JetpackBoost"
local interval = 0.08

local equipped = false
local boosting = false
local lastSent = 0

local function getLookVector()
	local camera = workspace.CurrentCamera

	if camera then
		return camera.CFrame.LookVector
	end

	return Vector3.new(0, 0, -1)
end

local function getWearable()
	local character = player.Character

	if not character then
		return nil
	end

	return character:FindFirstChild("EquippedJetpackVisual")
end

local function setWearableEffects(enabled)
	local wearable = getWearable()

	if not wearable then
		return
	end

	for _, inst in ipairs(wearable:GetDescendants()) do
		if inst:IsA("ParticleEmitter") then
			inst.Enabled = enabled

		elseif inst:IsA("Beam")
			or inst:IsA("Trail")
			or inst:IsA("Fire")
			or inst:IsA("Smoke")
			or inst:IsA("Sparkles") then

			inst.Enabled = enabled

		elseif inst:IsA("PointLight")
			or inst:IsA("SpotLight")
			or inst:IsA("SurfaceLight") then

			inst.Enabled = enabled

		elseif inst:IsA("Sound") and inst.Name == "Loop" then
			inst.Looped = true

			if enabled then
				if not inst.IsPlaying then
					inst:Play()
				end
			else
				inst:Stop()
			end
		end
	end
end

local function fireBoost(state, force)
	if state and not equipped then
		state = false
	end

	if not force and boosting == state then
		return
	end

	boosting = state
	lastSent = os.clock()

	remote:FireServer(
		boosting,
		getLookVector()
	)

	if not boosting then
		setWearableEffects(false)
	end
end

local function onBoostAction(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		fireBoost(true, true)

	elseif inputState == Enum.UserInputState.End
		or inputState == Enum.UserInputState.Cancel then

		fireBoost(false, true)
	end

	return Enum.ContextActionResult.Sink
end

tool.Equipped:Connect(function()
	equipped = true

	ContextActionService:BindAction(
		action,
		onBoostAction,
		true,
		Enum.KeyCode.Space,
		Enum.KeyCode.ButtonA
	)

	ContextActionService:SetTitle(
		action,
		"BOOST"
	)

	ContextActionService:SetPosition(
		action,
		UDim2.fromScale(0.82, 0.62)
	)
end)

tool.Unequipped:Connect(function()
	equipped = false

	fireBoost(false, true)
	setWearableEffects(false)

	ContextActionService:UnbindAction(
		action
	)
end)

tool.Activated:Connect(function()
	fireBoost(true, true)
end)

tool.Deactivated:Connect(function()
	fireBoost(false, true)
end)

RunService.RenderStepped:Connect(function()
	if not equipped then
		return
	end

	if not boosting then
		setWearableEffects(false)
		return
	end

	setWearableEffects(true)

	if os.clock() - lastSent >= interval then
		lastSent = os.clock()

		remote:FireServer(
			true,
			getLookVector()
		)
	end
end)