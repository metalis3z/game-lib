--!strict
-- LOCATION: StarterPlayerScripts/SpeedUIController

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [ UI REFERENCES ]
local gui = playerGui:WaitForChild("GUI")
local hud = gui:WaitForChild("HUD")
local labels = hud:WaitForChild("Labels")
local speedFrame = labels:WaitForChild("Speed")

-- Find the actual TextLabel (whether the frame itself is a TextLabel, or contains one named "Text")
local speedText = speedFrame:IsA("TextLabel") and speedFrame or speedFrame:FindFirstChildWhichIsA("TextLabel") or speedFrame:FindFirstChild("Text") :: TextLabel

print("[SpeedUIController] Initialized (Prefix Added)")

local function setupSpeedTracking(character: Model)
	local humanoid = character:WaitForChild("Humanoid", 10) :: Humanoid
	if not humanoid then return end

	local function updateSpeed()
		if speedText then
			-- ## CHANGED: Added "Speed: " prefix ##
			speedText.Text = "Speed: " .. tostring(math.floor(humanoid.WalkSpeed))
		end
	end

	-- Listen for any speed changes (Upgrades, Rebirths, etc.)
	humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(updateSpeed)

	-- Initial setup
	updateSpeed()
end

player.CharacterAdded:Connect(setupSpeedTracking)
if player.Character then
	task.spawn(setupSpeedTracking, player.Character)
end