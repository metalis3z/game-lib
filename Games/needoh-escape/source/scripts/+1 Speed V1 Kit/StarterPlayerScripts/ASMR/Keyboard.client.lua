-- KeysClick LocalScript
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local Debris            = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local LocalPlayer       = Players.LocalPlayer

local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local event     = ReplicatedStorage:WaitForChild("PlayKeySound")

local SOUND_IDS = {
	KeySound1 = "rbxassetid://140336132302166",
	KeySound2 = "rbxassetid://140336132302166",
}

local function keyboardSoundOff(): boolean
	local settings = _G.PlayerSettings
	return settings ~= nil and settings.KeyboardSoundOff == true
end

local function getPlayerRange(): number
	local h = LocalPlayer:FindFirstChild("HiddenStats")
	if h then
		local r = h:FindFirstChild("Range")
		if r then return math.max(1, r.Value) end
	end
	return 1
end

local function getRandomSoundName()
	local names = {"KeySound1", "KeySound2", "Silent"}
	return names[math.random(1, #names)]
end

local function playKeySound(sensor, soundName)
	if soundName == "Silent" then return end
	if keyboardSoundOff() then return end
	local id = SOUND_IDS[soundName]
	if not id then return end
	local sound = Instance.new("Sound")
	sound.SoundId            = id
	sound.Volume             = 0.5
	sound.RollOffMaxDistance = 40
	sound.RollOffMinDistance = 5
	sound.Parent             = sensor
	sound:Play()
	Debris:AddItem(sound, 2)
end

local keyStates = {}

local function setupKey(model)
	if not model:IsA("Model") or model.Name ~= "ModelKey" then return end
	if keyStates[model] then return end

	local sensor = model:FindFirstChild("Sensor")
	local key    = model:FindFirstChild("KeyMesh")
	if not (sensor and key and sensor:IsA("BasePart") and key:IsA("BasePart")) then return end

	keyStates[model] = {
		sensor         = sensor,
		key            = key,
		originalCFrame = key.CFrame,
		pressCFrame    = key.CFrame + Vector3.new(0, -0.8, 0),
		pressed        = false,
		onFrames       = 0,
		offFrames      = 0,
	}
end

task.spawn(function()
	local descs = workspace:GetDescendants()
	for i = 1, #descs, 50 do
		for j = i, math.min(i + 49, #descs) do
			local d = descs[j]
			if d:IsA("Model") then setupKey(d) end
		end
		task.wait()
	end
	workspace.DescendantAdded:Connect(function(d)
		task.defer(function()
			if d:IsA("Model") then setupKey(d) end
			local p = d.Parent
			if p and p:IsA("Model") and p.Name == "ModelKey" then setupKey(p) end
		end)
	end)
end)

local function tweenKey(ks, targetCFrame)
	TweenService:Create(ks.key, tweenInfo, { CFrame = targetCFrame }):Play()
end

RunService.RenderStepped:Connect(function()
	local character = LocalPlayer.Character
	local rootPart  = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid  = character and character:FindFirstChildOfClass("Humanoid")
	if not rootPart then return end
	if humanoid and humanoid.FloorMaterial == Enum.Material.Air then return end

	local range   = getPlayerRange()
	local rootPos = rootPart.Position

	for model, ks in pairs(keyStates) do
		if not model.Parent or not ks.sensor.Parent then
			keyStates[model] = nil
			continue
		end

		local sPos  = ks.sensor.Position
		local sSize = ks.sensor.Size

		local dx = rootPos.X - sPos.X
		local dy = rootPos.Y - sPos.Y
		local dz = rootPos.Z - sPos.Z

		local baseRadius = (sSize.X / 2 + sSize.Z / 2)
		local radius     = baseRadius * range
		local distXZ     = math.sqrt(dx * dx + dz * dz)
		local halfY      = sSize.Y / 2
		local inRange    = distXZ <= radius
			and dy >= -halfY - 1
			and dy <= halfY + 6

		if inRange then
			ks.onFrames  = math.min(ks.onFrames + 1, 2)
			ks.offFrames = 0
		else
			ks.onFrames  = 0
			ks.offFrames = math.min(ks.offFrames + 1, 3)
		end

		local isOn  = ks.onFrames  >= 1
		local isOff = ks.offFrames >= 3

		if isOn and not ks.pressed then
			ks.pressed = true
			tweenKey(ks, ks.pressCFrame)
			local soundName = getRandomSoundName()
			playKeySound(ks.sensor, soundName)
			event:FireServer(ks.sensor, soundName)
		elseif isOff and ks.pressed then
			ks.pressed = false
			tweenKey(ks, ks.originalCFrame)
		end
	end
end)

LocalPlayer.CharacterAdded:Connect(function()
	for _, ks in pairs(keyStates) do
		if ks.pressed then
			ks.pressed   = false
			ks.onFrames  = 0
			ks.offFrames = 0
			tweenKey(ks, ks.originalCFrame)
		end
	end
end)