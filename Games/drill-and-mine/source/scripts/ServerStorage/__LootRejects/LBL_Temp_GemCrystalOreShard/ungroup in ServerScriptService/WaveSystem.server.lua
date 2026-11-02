local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local MIN_SPAWN = 3.5
local MAX_SPAWN = 10
local HITBOX_END_RADIUS = 2

local WAVES = {
	{ Name = "SuperSlow", Time = 20, Weight = 50 },
	{ Name = "Medium",    Time = 15, Weight = 30 },
	{ Name = "Fast",      Time = 12, Weight = 15 },
	{ Name = "Lighting",  Time = 9, Weight = 4.998 },
	{ Name = "RAINBOW",   Time = 3,  Weight = 0.001 },
	{ Name = "GOLD",      Time = 2,  Weight = 0.001 },
	{ Name = "WackyWave", Time = 1,  Weight = 6.998 },
}

local WavesFolder = ReplicatedStorage:WaitForChild("Waves")
local BrainrotData = ReplicatedStorage:WaitForChild("Data"):WaitForChild("BrainrotData")

local function XZ(v)
	return Vector3.new(v.X, 0, v.Z)
end

local function getMapPoints()
	local map = workspace:FindFirstChild("Map")
	if not map then return end
	local startPart = map:FindFirstChild("Start", true)
	local endPart = map:FindFirstChild("End", true)
	if not startPart or not endPart then return end
	return startPart, endPart
end

local function chooseWave()
	local total = 0
	for _, w in ipairs(WAVES) do total += w.Weight end
	local r = math.random(1, total)
	local sum = 0
	for _, w in ipairs(WAVES) do
		sum += w.Weight
		if r <= sum then return w end
	end
	return WAVES[1]
end

local function getWaveFromName(name)
	for _, w in ipairs(WAVES) do
		if w.Name == name then return w end
	end
	return WAVES[1]
end

local function killIfPlayer(hit)
	local char = hit:FindFirstAncestorOfClass("Model")
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.Health = 0 end
	end
end

local function notify(str)
	local notif = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("SendNotification")
	if notif then notif:FireAllClients(str, "Normal", 5) end
end

local customWaveBehaviourEnd = {
	["RAINBOW"] = function()
		notify(`<font color="#ff0000"><b>BRAINROT GOD LUCKY BLOCKS</b></font> have spawned <font color="#55ff00"><b>GLOBALLY</b></font>`)
		for i = 1, 5 do
			ReplicatedStorage.Remotes.SpawnBrainrot:Fire("Brainrot God Lucky Block", "Secret", workspace.Misc.FirstFloor)
			ReplicatedStorage.Remotes.SpawnBrainrot:Fire("Brainrot God Lucky Block", "Secret", workspace.Floors.Common)
		end
	end,
	["GOLD"] = function()
		notify(`<font color="#ff0000"><b>COSMIC BRAINROTS</b></font> have spawned <font color="#55ff00"><b>GLOBALLY</b></font>`)
		local function getRandomCosmic()
			local selectedIndex = math.random(1, 3)
			local count = 0
			for brainrotName, _ in BrainrotData.DropWeights.Cosmic do
				count += 1
				if count == selectedIndex then return brainrotName end
			end
			return "Unclito_Samito"
		end
		for i = 1, 5 do
			ReplicatedStorage.Remotes.SpawnBrainrot:Fire(getRandomCosmic(), "Secret", workspace.Misc.FirstFloor)
			ReplicatedStorage.Remotes.SpawnBrainrot:Fire(getRandomCosmic(), "Secret", workspace.Floors.Common)
		end
	end
}

local function spawnWave(specificWave)
	local startPart, endPart = getMapPoints()
	if not startPart or not endPart then return end

	local waveData = specificWave and getWaveFromName(specificWave) or chooseWave()
	local template = WavesFolder:FindFirstChild(waveData.Name)
	if not template or not template:IsA("Model") then return end

	local templatePivot = template:GetPivot()
	local originalY = templatePivot.Position.Y
	local rotation = CFrame.fromMatrix(Vector3.zero, templatePivot.RightVector, templatePivot.UpVector)

	local wave = template:Clone()
	wave.Parent = workspace

	local hitbox = wave:FindFirstChild("Hitbox", true)
	if hitbox and hitbox:IsA("BasePart") then
		hitbox.Touched:Connect(killIfPlayer)
	end

	local startPos = startPart.Position
	local endPos = endPart.Position

	local posValue = Instance.new("Vector3Value")
	posValue.Value = Vector3.new(startPos.X, 0, startPos.Z)

	wave:PivotTo(CFrame.new(startPos.X, originalY, startPos.Z) * rotation)

	local updateConn
	updateConn = posValue:GetPropertyChangedSignal("Value"):Connect(function()
		if wave and wave.Parent then
			local p = posValue.Value
			wave:PivotTo(CFrame.new(p.X, originalY, p.Z) * rotation)
		else
			if updateConn then updateConn:Disconnect() end
		end
	end)

	local tween = TweenService:Create(
		posValue,
		TweenInfo.new(waveData.Time, Enum.EasingStyle.Linear),
		{ Value = Vector3.new(endPos.X, 0, endPos.Z) }
	)

	tween:Play()

	local hbConn
	hbConn = RunService.Heartbeat:Connect(function()
		if not wave or not wave.Parent then
			if hbConn then hbConn:Disconnect() end
			return
		end
		if hitbox and hitbox.Parent then
			if (XZ(hitbox.Position) - XZ(endPos)).Magnitude <= HITBOX_END_RADIUS then
				if hbConn then hbConn:Disconnect() end
				tween:Cancel()
				posValue:Destroy()
				wave:Destroy()
			end
		end
	end)

	tween.Completed:Once(function()
		if customWaveBehaviourEnd[specificWave] then
			customWaveBehaviourEnd[specificWave]()
		end
		if wave and wave.Parent then
			if hbConn then hbConn:Disconnect() end
			posValue:Destroy()
			wave:Destroy()
		end
	end)
end

task.spawn(function()
	while true do
		local ok, err = pcall(spawnWave)
		if not ok then warn("spawnWave error:", err) end
		task.wait(math.random(MIN_SPAWN, MAX_SPAWN))
	end
end)
