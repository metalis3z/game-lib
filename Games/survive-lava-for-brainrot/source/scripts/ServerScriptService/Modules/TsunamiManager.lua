--!strict
-- LOCATION: ServerScriptService/Modules/TsunamiManager

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local TsunamiManager = {}

-- [ MODULES ]
local TsunamiConfigurations = require(ReplicatedStorage.Modules.TsunamiConfigurations)

-- [ ASSETS ]
local TsunamiStorage = ReplicatedStorage:WaitForChild("Tsunamis")
local WorldFolder = Workspace:WaitForChild("Tsunamis")
local StartPart = WorldFolder:WaitForChild("Start") :: BasePart
local EndPart = WorldFolder:WaitForChild("End") :: BasePart
local GlobalSounds = Workspace:WaitForChild("Sounds")
local Events = ReplicatedStorage:WaitForChild("Events") -- Needed for Notifications

-- [ STATE ]
local queuedSpawn: {Name: string, Invoker: Player}? = nil

-- [ HELPERS ]

local function killPlayer(character: Model)
	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	if humanoid then
		humanoid.Health = 0
	end
end

local function setupKillTouch(model: Model)
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Touched:Connect(function(hit)
				local char = hit.Parent
				if char and char:FindFirstChild("Humanoid") then
					killPlayer(char)
				end
			end)
		end
	end
end

-- Refactored to accept specific config and an optional invoker (player who bought it)
local function spawnTsunami(forcedConfig: any?, invoker: Player?)
	local config = forcedConfig

	-- 1. Pick Random Tsunami if no force config is provided
	if not config then
		local list = TsunamiConfigurations.MODELS
		local possible = {}

		-- Filter out "Mega" from random rotation
		for _, data in ipairs(list) do
			if data.Name ~= "Mega" then
				table.insert(possible, data)
			end
		end

		if #possible > 0 then
			config = possible[math.random(1, #possible)]
		end
	end

	if not config then warn("No Tsunami Config found"); return end

	local template = TsunamiStorage:FindFirstChild(config.Name)
	if not template then warn("Tsunami model not found: " .. config.Name); return end

	-- 2. Notification (If Forced)
	if invoker then
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then
			-- Notify everyone
			for _, p in ipairs(Players:GetPlayers()) do
				notif:FireClient(p, invoker.Name .. " summoned a MEGA TSUNAMI!", "Warning")
			end
		end
	end

	-- 3. Clone and Position
	local tsunami = template:Clone() :: Model
	if not tsunami.PrimaryPart then
		warn("Tsunami " .. config.Name .. " has no PrimaryPart!")
		tsunami:Destroy()
		return
	end

	-- Position at Start, facing End
	local startPos = StartPart.Position
	local endPos = EndPart.Position

	-- LookAt CFrame so it faces the direction of travel
	local startCFrame = CFrame.new(startPos, Vector3.new(endPos.X, startPos.Y, endPos.Z))

	-- Rotate 90 degrees relative to travel direction
	startCFrame = startCFrame * CFrame.Angles(0, math.rad(-90), 0)

	tsunami:PivotTo(startCFrame)
	tsunami.Parent = WorldFolder

	-- 4. Enable Kill Logic
	setupKillTouch(tsunami)

	-- 5. Enable Audio Logic
	local waveSoundTemplate = GlobalSounds:FindFirstChild("Wave")

	if waveSoundTemplate and waveSoundTemplate:IsA("Sound") then
		local newSound = waveSoundTemplate:Clone()
		newSound.Parent = tsunami.PrimaryPart
		newSound.Looped = true
		newSound.Volume = 2 
		newSound.RollOffMinDistance = 50 
		newSound.RollOffMaxDistance = 1000 
		newSound.RollOffMode = Enum.RollOffMode.Inverse
		newSound:Play()
	end

	-- 6. Calculate Tween
	local distance = (endPos - startPos).Magnitude
	local speed = config.Speed
	local timeToTravel = distance / speed

	local tweenInfo = TweenInfo.new(timeToTravel, Enum.EasingStyle.Linear, Enum.EasingDirection.In)

	-- Target CFrame
	local travelVector = (endPos - startPos)
	local targetCFrame = startCFrame + Vector3.new(travelVector.X, 0, travelVector.Z)

	local cfValue = Instance.new("CFrameValue")
	cfValue.Value = startCFrame

	cfValue.Changed:Connect(function(val)
		if tsunami.Parent then
			tsunami:PivotTo(val)
		end
	end)

	local tween = TweenService:Create(cfValue, tweenInfo, {Value = targetCFrame})
	tween:Play()

	-- 7. Cleanup
	tween.Completed:Connect(function()
		tsunami:Destroy()
		cfValue:Destroy()
	end)
end

-- [ PUBLIC API ]

-- Called by MonetizationController
function TsunamiManager.ForceSpawn(tsunamiName: string, player: Player)
	print("[TsunamiManager] Queueing Force Spawn: " .. tsunamiName)
	queuedSpawn = {Name = tsunamiName, Invoker = player}
end

function TsunamiManager:Init()
	print("[TsunamiManager] Initialized")
end

function TsunamiManager:Start()
	print("[TsunamiManager] Starting Loop")

	task.spawn(function()
		-- Initial spawn
		spawnTsunami(nil, nil)

		while true do
			task.wait(TsunamiConfigurations.SPAWN_INTERVAL)

			-- Check for queued (paid) tsunami
			if queuedSpawn then
				-- Find config
				local selectedConfig = nil
				for _, data in ipairs(TsunamiConfigurations.MODELS) do
					if data.Name == queuedSpawn.Name then
						selectedConfig = data
						break
					end
				end

				if selectedConfig then
					spawnTsunami(selectedConfig, queuedSpawn.Invoker)
				else
					warn("Queued Tsunami Config not found: " .. tostring(queuedSpawn.Name))
					spawnTsunami(nil, nil) -- Fallback to random
				end

				queuedSpawn = nil -- Clear queue
			else
				-- Normal Random Spawn
				spawnTsunami(nil, nil)
			end
		end
	end)
end

return TsunamiManager