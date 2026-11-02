local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Debounce table to prevent rapid re-triggering
local debounce = {}

local function getSpawnPosition()
	local spawn = Workspace:FindFirstChild("SpawnLocation")
	if spawn then
		return spawn.Position + Vector3.new(0, 5, 0)
	end
	return Vector3.new(0, 15, 0)
end

local function onTouch(otherPart, killPart)
	local character = otherPart.Parent
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if humanoid.Health <= 0 then return end

	-- Check if the touched part is named KillPart (case-insensitive)
	if string.lower(killPart.Name) ~= "killpart" then return end

	-- Debounce per character
	if debounce[character] then return end
	debounce[character] = true

	-- Teleporter le joueur au SpawnLocation instantanement
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if rootPart then
		rootPart.CFrame = CFrame.new(getSpawnPosition())
	end

	task.wait(1)
	debounce[character] = nil
end

local function setupKillPart(part)
	if not part:IsA("BasePart") then return end
	if string.lower(part.Name) ~= "killpart" then return end

	part.Touched:Connect(function(otherPart)
		onTouch(otherPart, part)
	end)
end

-- Handle existing KillParts in Workspace (spread across frames to avoid startup freeze)
task.spawn(function()
	local descendants = game.Workspace:GetDescendants()
	for i = 1, #descendants, 500 do
		local endIndex = math.min(i + 499, #descendants)
		for j = i, endIndex do
			setupKillPart(descendants[j])
		end
		task.wait() -- Yield to prevent freeze
	end
end)

-- Handle KillParts added later during gameplay
game.Workspace.DescendantAdded:Connect(function(descendant)
	setupKillPart(descendant)
end)