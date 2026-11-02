-- LowGravityZone LocalScript
-- Place this inside: StarterPlayer > StarterCharacterScripts
-- Then place a Part in the Workspace and name it "LowGravityZone"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- ============================================================
--  CONFIGURATION
-- ============================================================
local ZONE_NAME      = "LowGravityZone"  -- Name of the Part in Workspace
local LOW_GRAVITY    = 20                -- Gravity inside the zone (default Roblox = 196.2)
local NORMAL_GRAVITY = 196.2             -- Gravity outside the zone
local HIGH_JUMP      = 100               -- JumpPower inside the zone (default Roblox = 50)
local NORMAL_JUMP    = 50                -- JumpPower outside the zone
-- ============================================================

local player = Players.LocalPlayer
local zone   = Workspace:WaitForChild("Map"):WaitForChild("ObbyStuff"):WaitForChild("Stage5"):WaitForChild(ZONE_NAME)

local rootPart      = nil
local humanoid      = nil
local heartbeatConn = nil
local insideZone    = false

local function stopChecking()
	if heartbeatConn then
		heartbeatConn:Disconnect()
		heartbeatConn = nil
	end
end

local function startChecking()
	stopChecking()
	insideZone = false

	heartbeatConn = RunService.Heartbeat:Connect(function()
		if not rootPart or not rootPart.Parent then
			stopChecking()
			return
		end

		local zoneCFrame = zone.CFrame
		local zoneSize   = zone.Size
		local localPos   = zoneCFrame:PointToObjectSpace(rootPart.Position)

		local halfX = zoneSize.X / 2
		local halfY = zoneSize.Y / 2
		local halfZ = zoneSize.Z / 2

		local isInside = (
			localPos.X > -halfX and localPos.X < halfX and
				localPos.Y > -halfY and localPos.Y < halfY and
				localPos.Z > -halfZ and localPos.Z < halfZ
		)

		if isInside and not insideZone then
			insideZone = true
			Workspace.Gravity = LOW_GRAVITY
			if humanoid then
				humanoid.JumpPower = HIGH_JUMP  -- also try humanoid.JumpHeight if your game uses that
			end

		elseif not isInside and insideZone then
			insideZone = false
			Workspace.Gravity = NORMAL_GRAVITY
			if humanoid then
				humanoid.JumpPower = NORMAL_JUMP
			end
		end
	end)
end

local function onCharacterAdded(newCharacter)
	rootPart = newCharacter:WaitForChild("HumanoidRootPart")
	humanoid = newCharacter:WaitForChild("Humanoid")
	startChecking()
end

local function onCharacterRemoving()
	stopChecking()
	insideZone = false
	Workspace.Gravity = NORMAL_GRAVITY
end

player.CharacterAdded:Connect(onCharacterAdded)
player.CharacterRemoving:Connect(onCharacterRemoving)

if player.Character then
	onCharacterAdded(player.Character)
end