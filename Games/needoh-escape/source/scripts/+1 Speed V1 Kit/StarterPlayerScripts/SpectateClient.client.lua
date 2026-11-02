--!strict
-- LOCATION: StarterPlayerScripts/SpectateClient
-- Handles the live camera swap when the local player clicks "Spectate" on a
-- TimeLeaderboard entry for a player currently mid-speedrun.
-- Freezes the local player's own movement, points the camera at the target's
-- head (first-person-ish chase POV), and restores everything automatically
-- when the server says the session ended (target finished / died / left).

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local Workspace          = game:GetService("Workspace")
local UserInputService  = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local events = ReplicatedStorage:WaitForChild("Events")
local RequestSpectate     = events:WaitForChild("RequestSpectate") :: RemoteEvent
local RequestStopSpectate = events:WaitForChild("RequestStopSpectate") :: RemoteEvent
local StartSpectate       = events:WaitForChild("StartSpectate") :: RemoteEvent
local StopSpectate        = events:WaitForChild("StopSpectate") :: RemoteEvent
local SpectateFailed      = events:WaitForChild("SpectateFailed") :: RemoteEvent

-- [ CONSTANTS ] ----------------------------------------------------------------

local CAM_OFFSET = CFrame.new(0, 5, 14) * CFrame.Angles(math.rad(-8), 0, 0)
local CAM_LERP_ALPHA = 0.25
local FREEZE_ACTION_NAME = "SpectateMovementFreeze"

-- [ STATE ] ----------------------------------------------------------------------

local isSpectating = false
local targetUserId: number? = nil
local targetPlayer: Player? = nil

local renderConn: RBXScriptConnection? = nil
local targetCharacterConn: RBXScriptConnection? = nil
local targetRemovingConn: RBXScriptConnection? = nil

local originalCamType: Enum.CameraType = Enum.CameraType.Custom
local originalCamSubject: Humanoid? = nil
local originalWalkSpeed: number? = nil
local originalJumpPower: number? = nil
local originalAutoRotate: boolean? = nil

-- Optional: hook these up to a UI banner ("Spectating <name> — Esc to stop")
-- if your HUD has a frame for it. Safe no-ops if not found.
local function findSpectateBanner(): (Frame?, TextLabel?)
	local ok, gui = pcall(function()
		return player:WaitForChild("PlayerGui", 1):WaitForChild("GUI", 1)
	end)
	if not ok or not gui then return nil, nil end
	local hud = gui:FindFirstChild("HUD")
	if not hud then return nil, nil end
	local banner = hud:FindFirstChild("SpectateBanner") :: Frame?
	if not banner then return nil, nil end
	local label = banner:FindFirstChildWhichIsA("TextLabel") :: TextLabel?
	return banner, label
end

-- [ FREEZE / UNFREEZE LOCAL MOVEMENT ] -------------------------------------------

local function freezeMovement()
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	if not humanoid then return end

	originalWalkSpeed = humanoid.WalkSpeed
	originalJumpPower = humanoid.UseJumpPower and humanoid.JumpPower or humanoid.JumpHeight
	originalAutoRotate = humanoid.AutoRotate

	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.JumpHeight = 0
	humanoid.AutoRotate = false

	-- Block jump/movement inputs outright as a second layer of safety
	ContextActionService:BindAction(FREEZE_ACTION_NAME, function()
		return Enum.ContextActionResult.Sink
	end, false,
	Enum.PlayerActions.CharacterForward,
	Enum.PlayerActions.CharacterBackward,
	Enum.PlayerActions.CharacterLeft,
	Enum.PlayerActions.CharacterRight,
	Enum.PlayerActions.CharacterJump
	)
end

local function unfreezeMovement()
	ContextActionService:UnbindAction(FREEZE_ACTION_NAME)

	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	if not humanoid then return end

	if originalWalkSpeed then humanoid.WalkSpeed = originalWalkSpeed end
	if originalJumpPower then
		humanoid.JumpPower = originalJumpPower
		humanoid.JumpHeight = originalJumpPower
	end
	if originalAutoRotate ~= nil then humanoid.AutoRotate = originalAutoRotate end

	originalWalkSpeed = nil
	originalJumpPower = nil
	originalAutoRotate = nil
end

-- [ CLEANUP ] ----------------------------------------------------------------------

local function stopSpectating()
	if not isSpectating then return end
	isSpectating = false

	if renderConn then renderConn:Disconnect(); renderConn = nil end
	if targetCharacterConn then targetCharacterConn:Disconnect(); targetCharacterConn = nil end
	if targetRemovingConn then targetRemovingConn:Disconnect(); targetRemovingConn = nil end

	unfreezeMovement()

	camera.CameraType = originalCamType
	if originalCamSubject then
		camera.CameraSubject = originalCamSubject
	else
		local char = player.Character
		if char then
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if hum then camera.CameraSubject = hum end
		end
	end

	local banner = findSpectateBanner()
	if banner then banner.Visible = false end

	targetUserId = nil
	targetPlayer = nil

	print("[SpectateClient] Spectate ended, camera restored.")
end

-- [ START ] --------------------------------------------------------------------------

local function followTargetHRP(hrp: BasePart)
	if renderConn then renderConn:Disconnect() end
	renderConn = RunService.RenderStepped:Connect(function()
		if not isSpectating then return end
		if not hrp or not hrp.Parent then
			-- Target's HRP vanished unexpectedly (e.g. ragdoll/respawn edge case)
			return
		end
		local targetCF = hrp.CFrame * CAM_OFFSET
		camera.CFrame = camera.CFrame:Lerp(targetCF, CAM_LERP_ALPHA)
	end)
end

local function beginSpectate(uid: number, targetName: string)
	-- Find the Player object for the target
	local tp = Players:GetPlayerByUserId(uid)
	if not tp then
		warn("[SpectateClient] Target player not found locally:", targetName)
		return
	end

	-- If already spectating, fully tear down first so state never doubles up
	if isSpectating then
		stopSpectating()
	end

	local character = tp.Character
	if not character then
		warn("[SpectateClient] Target has no character:", targetName)
		return
	end
	local hrp = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not hrp then
		warn("[SpectateClient] Target has no HumanoidRootPart:", targetName)
		return
	end

	isSpectating = true
	targetUserId = uid
	targetPlayer = tp

	originalCamType = camera.CameraType
	originalCamSubject = camera.CameraSubject :: Humanoid?

	freezeMovement()

	camera.CameraType = Enum.CameraType.Scriptable
	followTargetHRP(hrp)

	-- If the target's character gets replaced mid-spectate (e.g. server revive
	-- teleport via LoadCharacter), re-hook onto the new HumanoidRootPart.
	targetCharacterConn = tp.CharacterAdded:Connect(function(newCharacter)
		if not isSpectating or targetPlayer ~= tp then return end
		local newHrp = newCharacter:WaitForChild("HumanoidRootPart", 5) :: BasePart?
		if newHrp and isSpectating then
			followTargetHRP(newHrp)
		end
	end)

	-- Safety net: if the target leaves without the server event reaching us
	-- in time for any reason, stop locally too.
	targetRemovingConn = Players.PlayerRemoving:Connect(function(leavingPlayer)
		if leavingPlayer == tp then
			stopSpectating()
		end
	end)

	local banner, label = findSpectateBanner()
	if banner then
		banner.Visible = true
		if label then
			label.Text = "Spectating " .. targetName .. "  (click again to stop)"
		end
	end

	print("[SpectateClient] Now spectating", targetName)
end

-- [ REMOTE EVENTS ] -----------------------------------------------------------------

StartSpectate.OnClientEvent:Connect(function(uid: number, targetName: string)
	beginSpectate(uid, targetName)
end)

StopSpectate.OnClientEvent:Connect(function(reason: string)
	stopSpectating()
end)

SpectateFailed.OnClientEvent:Connect(function(reason: string)
	warn("[SpectateClient] Spectate request failed:", reason)
end)

-- If the local player's own character resets/dies while spectating, the
-- camera swap survives that fine (Scriptable camera isn't tied to the local
-- character), but we still want to keep movement frozen correctly once they
-- respawn — so re-apply freeze state on respawn if still spectating.
player.CharacterAdded:Connect(function()
	if isSpectating then
		task.defer(freezeMovement)
	end
end)

-- [ PUBLIC API for button wiring ] ---------------------------------------------------

local SpectateClient = {}

function SpectateClient.RequestSpectate(uid: number)
	if isSpectating and targetUserId == uid then
		-- Clicking Spectate again on the same target stops it
		RequestStopSpectate:FireServer()
		return
	end
	RequestSpectate:FireServer(uid)
end

function SpectateClient.Stop()
	RequestStopSpectate:FireServer()
end

function SpectateClient.IsSpectating(): boolean
	return isSpectating
end

return SpectateClient