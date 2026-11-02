-- SellHammer (LocalScript)
-- When you hit a podium with this hammer, it plays swing sounds,
-- fires the sell remote, and adds smoke + explosion effects

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer
local Tool = script.Parent

-- Net wrapper (same as the game uses)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages:WaitForChild("Net"))
local SellRemote = Net:RemoteEvent("PlotService/Sell")

-- Settings
local TOUCH_TIMEOUT = 1.2
local SWING_WINDOW = 0.25
local COOLDOWN = 0.6

-- State
local lastTouchedPart = nil
local lastTouchedTime = 0
local debounce = false

-- Helper functions
local function timestamp()
	return tick()
end

local function recordTouch(part)
	if not part or not part:IsA("BasePart") then return end
	lastTouchedPart = part
	lastTouchedTime = timestamp()
end

local function findPodiumIndexFromPart(part)
	local current = part
	while current and current.Parent do
		if current.Parent.Name == "AnimalPodiums" then
			local index = tonumber(current.Name)
			if index then return index end
		end
		current = current.Parent
	end

	-- fallback search up the ancestry
	current = part
	for _ = 1, 8 do
		if not current then break end
		local maybeModel
		if current.FindFirstAncestorWhichIsA then
			maybeModel = current:FindFirstAncestorWhichIsA("Model")
		end
		if maybeModel and maybeModel.Parent and maybeModel.Parent.Name == "AnimalPodiums" then
			local idx = tonumber(maybeModel.Name)
			if idx then return idx end
		end
		current = current.Parent
	end
	return nil
end

local function isTouchRecent()
	return lastTouchedPart and (timestamp() - lastTouchedTime) <= TOUCH_TIMEOUT
end

-- Touch detection
local handle = Tool:WaitForChild("Handle", 5)
if handle then
	handle.Touched:Connect(function(hit)
		recordTouch(hit)
	end)
else
	warn("SellHammer: Handle not found in tool.")
end

-- Effect spawner
local function spawnEffects(position)
	-- Explosion (visual only)
	local explosion = Instance.new("Explosion")
	explosion.BlastPressure = 0
	explosion.BlastRadius = 0
	explosion.Position = position
	explosion.Parent = workspace

	-- Smoke
	local smoke = Instance.new("Smoke")
	smoke.Opacity = 0.7
	smoke.RiseVelocity = 10
	smoke.Size = 15
	smoke.Color = Color3.new(0.7, 0.7, 0.7)
	smoke.Parent = workspace.Terrain

	-- Attach smoke to a part in space
	local fakePart = Instance.new("Part")
	fakePart.Anchored = true
	fakePart.CanCollide = false
	fakePart.Transparency = 1
	fakePart.Size = Vector3.new(1, 1, 1)
	fakePart.CFrame = CFrame.new(position)
	fakePart.Parent = workspace
	smoke.Parent = fakePart

	task.delay(1.5, function()
		smoke.Enabled = false
		game:GetService("Debris"):AddItem(fakePart, 1)
	end)
end

-- When activated
Tool.Activated:Connect(function()
	if debounce then return end
	debounce = true

	-- Play animation & sound
	local char = Tool.Parent
	local humanoid = char and char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if animator then
			local swingAnim = script:FindFirstChild("Swing")
			if swingAnim then
				local track = animator:LoadAnimation(swingAnim)
				track:Play()
			end
		end
	end
	if handle and handle:FindFirstChild("Swing") then
		pcall(function() handle.Swing:Play() end)
	end

	task.wait(SWING_WINDOW)

	if isTouchRecent() and lastTouchedPart then
		local podiumIndex = findPodiumIndexFromPart(lastTouchedPart)
		if podiumIndex then
			if handle and handle:FindFirstChild("Ban") then
				pcall(function() handle.Ban:Play() end)
			end

			local hitPos = lastTouchedPart.Position

			-- Fire the sell remote
			local ok, err = pcall(function()
				SellRemote:FireServer(podiumIndex)
			end)
			if ok then
			else
				warn("[SellHammer] Sell failed:", tostring(err))
			end
		end
	end

	lastTouchedPart = nil
	lastTouchedTime = 0

	task.delay(COOLDOWN, function()
		debounce = false
	end)
end)
