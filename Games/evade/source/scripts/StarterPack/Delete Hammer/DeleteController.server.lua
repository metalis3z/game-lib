local Tool = script.Parent
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

local DEBOUNCE = 0.1
local SWING_WINDOW = 0.1
local TOUCH_TIMEOUT = 0.1

local lastTouchedPart = nil
local lastTouchedTime = 0
local debounce = false

-- Record the touched part
local function recordTouch(part)
	if part and part:IsA("BasePart") then
		lastTouchedPart = part
		lastTouchedTime = tick()
	end
end

-- Check touch freshness
local function isTouchRecent()
	return lastTouchedPart and (tick() - lastTouchedTime) <= TOUCH_TIMEOUT
end

-- Explosion FX
local function spawnEffects(position)
	local explosion = Instance.new("Explosion")
	explosion.BlastRadius = 5
	explosion.BlastPressure = 0
	explosion.Position = position
	explosion.Parent = Workspace

	local smokePart = Instance.new("Part")
	smokePart.Anchored = true
	smokePart.CanCollide = false
	smokePart.Transparency = 1
	smokePart.Size = Vector3.new(1,1,1)
	smokePart.CFrame = CFrame.new(position)
	smokePart.Parent = Workspace

	local smoke = Instance.new("Smoke")
	smoke.Opacity = 0.7
	smoke.RiseVelocity = 10
	smoke.Size = 5
	smoke.Color = Color3.new(0.7,0.7,0.7)
	smoke.Parent = smokePart

	Debris:AddItem(smokePart, 2)
end

-- Setup touch listener
local handle = Tool:WaitForChild("Handle", 5)
if handle then
	handle.Touched:Connect(recordTouch)
else
	warn("DeleteHammer: No Handle found!")
end

-- Tool activation
Tool.Activated:Connect(function()
	if debounce then return end
	debounce = true

	-- Play swing sounds
	if handle then
		for _, sound in ipairs(handle:GetChildren()) do
			if sound:IsA("Sound") and sound.Name == "Swing" then
				sound:Play()
			end
		end
	end

	task.wait(SWING_WINDOW)

	-- If recently hit → delete & explode
	if isTouchRecent() and lastTouchedPart then

		local plotsFolder = Workspace:FindFirstChild("Plots")

		local isInsideAnimalPodiums = false

		if plotsFolder then
			-- Check each Plot
			for _, plot in ipairs(plotsFolder:GetChildren()) do
				local podiums = plot:FindFirstChild("AnimalPodiums")
				if podiums and lastTouchedPart:IsDescendantOf(podiums) then
					isInsideAnimalPodiums = true
					break
				end
			end
		end

		-- Delete ONLY if part is inside any Plot's AnimalPodiums folder
		if isInsideAnimalPodiums then
			local pos = lastTouchedPart.Position

			lastTouchedPart:Destroy()
			spawnEffects(pos)
		end
	end


	lastTouchedPart = nil
	lastTouchedTime = 0

	-- Reset debounce
	task.delay(DEBOUNCE, function()
		debounce = false
	end)
end)
