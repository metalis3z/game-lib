--!strict
-- LOCATION: StarterPlayerScripts/ProgressController

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- [ UI REFERENCES ]
local gui = playerGui:WaitForChild("GUI")
local hud = gui:WaitForChild("HUD")
local topFrame = hud:WaitForChild("Top")
local bar = topFrame:WaitForChild("Bar")

-- Ensure the bar is ALWAYS visible
bar.Visible = true

-- [ ASSETS ]
local Zones = Workspace:WaitForChild("Zones")
local Templates = ReplicatedStorage:WaitForChild("Templates")
local PlayerMarkerTemplate = Templates:WaitForChild("PlayerMarker") 

-- [ STATE ]
local minZ: number = 0
local maxZ: number = 0
local totalDistZ: number = 0
local startZ: number = 0

print("[ProgressController] Loaded (Cinematic Tracking & Full Track Bounds)")

--================------------------------------------------------
-- ## PLAYER MARKER SETUP ##
--================------------------------------------------------
local playerMarker = bar:FindFirstChild("PlayerMarker") :: ImageLabel
if not playerMarker then
	-- Clone your custom template
	playerMarker = PlayerMarkerTemplate:Clone() :: ImageLabel
	playerMarker.Name = "PlayerMarker"

	-- Force AnchorPoint to center so the math always aligns it perfectly
	playerMarker.AnchorPoint = Vector2.new(0.5, 0.5) 

	-- Set the Image to the player's avatar
	playerMarker.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"
	playerMarker.Parent = bar
end

local fillFrame = bar:FindFirstChild("Fill") :: Frame

--================------------------------------------------------
-- ## ZONE TRACKING SETUP ##
--================------------------------------------------------
local function updateZones()
	minZ = math.huge
	maxZ = -math.huge

	-- 1. Include the KickPart to act as the absolute start of the progress bar
	local kickPart = Workspace:FindFirstChild("KickPart") :: BasePart
	if kickPart then
		local halfZ = kickPart.Size.Z / 2
		minZ = math.min(minZ, kickPart.Position.Z - halfZ)
		maxZ = math.max(maxZ, kickPart.Position.Z + halfZ)
	end

	local zone1Spawn: BasePart? = nil

	-- 2. Iterate through ALL folders to expand the bounds to the end of the track
	for _, zoneFolder in ipairs(Zones:GetChildren()) do
		local collection = zoneFolder:FindFirstChild("Collection")
		if collection and collection:IsA("BasePart") then
			local halfZ = collection.Size.Z / 2
			minZ = math.min(minZ, collection.Position.Z - halfZ)
			maxZ = math.max(maxZ, collection.Position.Z + halfZ)
		end

		if zoneFolder.Name == "1" then
			zone1Spawn = zoneFolder:FindFirstChild("Spawn") :: BasePart
		end
	end

	totalDistZ = maxZ - minZ

	-- 3. Dynamically determine startZ so the bar always goes left-to-right
	if kickPart then
		if math.abs(kickPart.Position.Z - maxZ) < math.abs(kickPart.Position.Z - minZ) then
			startZ = maxZ -- Running towards negative Z
		else
			startZ = minZ -- Running towards positive Z
		end
	elseif zone1Spawn then
		if math.abs(zone1Spawn.Position.Z - maxZ) < math.abs(zone1Spawn.Position.Z - minZ) then
			startZ = maxZ 
		else
			startZ = minZ 
		end
	else
		startZ = maxZ -- Default fallback
	end
end

updateZones()
Zones.ChildAdded:Connect(updateZones)
Zones.ChildRemoved:Connect(updateZones)

--================------------------------------------------------
-- ## PLAYER/BLOCK TRACKING LOOP ##
--================------------------------------------------------
RunService.RenderStepped:Connect(function()
	if not bar.Visible then bar.Visible = true end
	if totalDistZ <= 0 then return end

	local percent = 0
	local targetZ = nil

	-- Track whatever the camera is currently looking at!
	-- (Player running -> Block rolling -> Item hatching -> Morphed Player escaping)
	local subject = camera.CameraSubject
	if subject then
		if subject:IsA("Humanoid") and subject.Parent then
			local root = subject.Parent:FindFirstChild("HumanoidRootPart")
			if root then targetZ = root.Position.Z end
		elseif subject:IsA("BasePart") then
			targetZ = subject.Position.Z
		end
	end

	-- Fallback directly to player if camera subject is adjusting
	if not targetZ then
		local char = player.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if root then targetZ = root.Position.Z end
	end

	-- Calculate unconditionally: clamp handles the start (0%) and end (100%) naturally
	if targetZ then
		if startZ == maxZ then
			percent = math.clamp((maxZ - targetZ) / totalDistZ, 0, 1)
		else
			percent = math.clamp((targetZ - minZ) / totalDistZ, 0, 1)
		end
	end

	-- Apply the final percentage to the UI
	playerMarker.Position = UDim2.new(percent, 0, 0.5, 0)

	if fillFrame then
		fillFrame.Size = UDim2.new(percent, 0, 1, 0)
	end
end)