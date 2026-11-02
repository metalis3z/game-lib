--!strict
-- LOCATION: StarterPlayerScripts/SpeedRunReplayClient

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local Workspace         = game:GetService("Workspace")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local events        = ReplicatedStorage:WaitForChild("Events")
local RequestReplay = events:WaitForChild("RequestReplay") :: RemoteEvent
local DeliverReplay = events:WaitForChild("DeliverReplay") :: RemoteEvent

-- [ CONSTANTS ] --------------------------------------------------------------

local RECORD_FPS     = 20
local FRAME_DURATION = 1 / RECORD_FPS

-- Camera sits behind/above the ghost. Increase Z to zoom out further.
local CAM_BACK   = 22   -- studs behind (bigger = more zoomed out)
local CAM_UP     = 10   -- studs above
local CAM_PITCH  = -12  -- degrees tilted downward
local CAM_OFFSET = CFrame.new(0, CAM_UP, CAM_BACK)
	* CFrame.Angles(math.rad(CAM_PITCH), 0, 0)
local CAM_LERP   = 0.2  -- smoothing (lower = smoother lag)

local HIGHLIGHT_FILL    = Color3.fromRGB(80, 200, 255)
local HIGHLIGHT_OUTLINE = Color3.fromRGB(255, 255, 255)
local REVIVE_FILL       = Color3.fromRGB(255, 160, 40)

-- [ TYPES ] ------------------------------------------------------------------

type ReplayBlob = {
	userId  : number,
	username: string,
	time    : number,
	recorded: number,
	frames  : {{number}},
	revives : {number},
}

-- [ STATE ] ------------------------------------------------------------------

local isReplaying    = false
local replayConn     : RBXScriptConnection? = nil
local ghostModel     : Model?               = nil
local ghostHighlight : Highlight?           = nil
local characterConn  : RBXScriptConnection? = nil
local originalCamType: Enum.CameraType      = Enum.CameraType.Custom

local wiredButtons: {[any]: boolean} = {}

-- [ GHOST BUILDER ] ----------------------------------------------------------
-- Strategy: load the REAL player model via CreateHumanoidModelFromUserId.
-- We keep ALL Motor6D joints intact so the limbs stay connected and visible.
-- Only the HumanoidRootPart is anchored — joints propagate the position to
-- all limbs automatically.  We disable CanCollide on every part so the ghost
-- doesn't push the spectator around, and we remove the Humanoid so the
-- character doesn't try to walk/fall/animate on its own.

local function buildGhostFromUserId(userId: number): Model?
	local ok, result = pcall(function()
		return Players:CreateHumanoidModelFromUserId(userId)
	end)
	if not ok or not result then
		warn("[ReplayClient] CreateHumanoidModelFromUserId failed:", result)
		return nil
	end

	local model = result :: Model

	-- Remove Humanoid so the rig doesn't self-animate or fall
	local humanoid = model:FindFirstChildWhichIsA("Humanoid")
	if humanoid then humanoid:Destroy() end

	-- Remove Animate script to stop any default idle animations
	local animScript = model:FindFirstChild("Animate")
	if animScript then animScript:Destroy() end

	-- Disable collision on every part; keep Motor6D joints intact
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("BasePart") then
			local bp      = desc :: BasePart
			bp.CanCollide = false
			bp.CastShadow = false
			-- Do NOT anchor child parts — only HumanoidRootPart gets anchored.
			-- The Motor6D joints will keep all limbs attached to the root.
		end
		if desc:IsA("Script") or desc:IsA("LocalScript") then
			desc:Destroy()
		end
	end

	-- Anchor only the root so we can drive it each frame
	local hrp = model:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not hrp then
		-- R15 fallback
		hrp = model:FindFirstChild("LowerTorso") :: BasePart?
	end
	if not hrp then
		warn("[ReplayClient] No HumanoidRootPart found in loaded model.")
		model:Destroy()
		return nil
	end

	hrp.Anchored = true

	model.Name   = "SpeedRunGhost"
	model.Parent = Workspace

	return model
end

-- Fallback block rig if CreateHumanoidModelFromUserId fails entirely
local FALLBACK_OFFSETS: {[string]: {size: Vector3, offset: CFrame}} = {
	Torso         = {size = Vector3.new(2, 2, 1),  offset = CFrame.new(0,     0,  0)},
	Head          = {size = Vector3.new(2, 1, 1),  offset = CFrame.new(0,   1.5,  0)},
	["Left Arm"]  = {size = Vector3.new(1, 2, 1),  offset = CFrame.new(-1.5,  0,  0)},
	["Right Arm"] = {size = Vector3.new(1, 2, 1),  offset = CFrame.new( 1.5,  0,  0)},
	["Left Leg"]  = {size = Vector3.new(1, 2, 1),  offset = CFrame.new(-0.5, -2,  0)},
	["Right Leg"] = {size = Vector3.new(1, 2, 1),  offset = CFrame.new( 0.5, -2,  0)},
}

type FallbackLimb = {part: BasePart, offset: CFrame}
type FallbackData = {model: Model, root: BasePart, limbs: {FallbackLimb}}

local fallbackData: FallbackData? = nil  -- only set when using block rig

local function buildFallbackGhost(): Model
	local model = Instance.new("Model")
	model.Name  = "SpeedRunGhost"

	local function addPart(name: string, size: Vector3, alpha: number): BasePart
		local p = Instance.new("Part")
		p.Name         = name
		p.Size         = size
		p.Anchored     = true
		p.CanCollide   = false
		p.CastShadow   = false
		p.Transparency = alpha
		p.Color        = HIGHLIGHT_FILL
		p.Material     = Enum.Material.SmoothPlastic
		p.Parent       = model
		return p
	end

	local rootPart    = addPart("HumanoidRootPart", Vector3.new(2, 2, 1), 1)
	model.PrimaryPart = rootPart

	local limbs: {FallbackLimb} = {}
	for name, def in pairs(FALLBACK_OFFSETS) do
		local p = addPart(name, def.size, 0.35)
		table.insert(limbs, {part = p, offset = def.offset})
	end

	-- Store for per-frame driving
	fallbackData = {model = model, root = rootPart, limbs = limbs}
	model.Parent = Workspace
	return model
end

-- [ CLEANUP ] ----------------------------------------------------------------

local function stopReplay()
	if not isReplaying then return end
	isReplaying = false

	if replayConn    then replayConn:Disconnect();     replayConn    = nil end
	if characterConn then characterConn:Disconnect();  characterConn = nil end
	if ghostModel    then ghostModel:Destroy();        ghostModel    = nil end
	ghostHighlight = nil
	fallbackData   = nil

	camera.CameraType = originalCamType
	local char = player.Character
	if char then
		local hum = char:FindFirstChildWhichIsA("Humanoid")
		if hum then camera.CameraSubject = hum end
	end
	print("[ReplayClient] Replay stopped.")
end

-- [ PLAYBACK ] ---------------------------------------------------------------

local function buildReviveSet(revives: {number}): {[number]: boolean}
	local s: {[number]: boolean} = {}
	for _, i in ipairs(revives) do s[i] = true end
	return s
end

local function playReplay(blob: ReplayBlob)
	if isReplaying then stopReplay() end
	if #blob.frames == 0 then warn("[ReplayClient] 0 frames."); return end

	isReplaying     = true
	originalCamType = camera.CameraType
	fallbackData    = nil

	-- Load the real model async (CreateHumanoidModelFromUserId yields)
	task.spawn(function()
		local model = buildGhostFromUserId(blob.userId)

		if not isReplaying then
			-- Was cancelled while we were loading
			if model then model:Destroy() end
			return
		end

		-- If real model failed, use block rig
		if not model then
			warn("[ReplayClient] Falling back to block rig.")
			model = buildFallbackGhost()
		end

		ghostModel = model

		-- Get the root part we'll drive each frame
		local hrp = model:FindFirstChild("HumanoidRootPart") :: BasePart?
		if not hrp then
			hrp = model:FindFirstChild("LowerTorso") :: BasePart?
		end
		if not hrp then
			warn("[ReplayClient] Ghost has no driveable root part.")
			stopReplay()
			return
		end

		-- Highlight — AlwaysOnTop so ghost shows through walls
		local hl = Instance.new("Highlight")
		hl.Adornee             = model
		hl.FillColor           = HIGHLIGHT_FILL
		hl.OutlineColor        = HIGHLIGHT_OUTLINE
		hl.FillTransparency    = 0.35
		hl.OutlineTransparency = 0
		hl.DepthMode           = Enum.HighlightDepthMode.AlwaysOnTop
		hl.Parent              = model
		ghostHighlight         = hl

		-- Apply frame 1 immediately
		local f0     = blob.frames[1]
		local initCF = CFrame.new(f0[1], f0[2], f0[3])
			* CFrame.fromEulerAnglesYXZ(f0[4], f0[5], f0[6])
		hrp.CFrame = initCF

		-- If using fallback block rig, also move the limbs
		if fallbackData then
			for _, entry in ipairs(fallbackData.limbs) do
				entry.part.CFrame = initCF * entry.offset
			end
		end

		-- Snap camera into position
		camera.CameraType = Enum.CameraType.Scriptable
		local _, yaw0, _ = initCF:ToEulerAnglesYXZ()
		local yawCF0     = CFrame.new(initCF.Position)
			* CFrame.fromEulerAnglesYXZ(0, yaw0, 0)
		camera.CFrame    = yawCF0 * CAM_OFFSET

		-- Stop if local player respawns
		characterConn = player.CharacterAdded:Connect(function()
			stopReplay()
		end)

		local reviveSet  = buildReviveSet(blob.revives)
		local frameIndex = 2
		local lastTick   = os.clock()

		replayConn = RunService.Heartbeat:Connect(function()
			if not isReplaying then return end

			local now = os.clock()
			if now - lastTick < FRAME_DURATION then return end
			lastTick = now

			if frameIndex > #blob.frames then
				print("[ReplayClient] Replay finished.")
				stopReplay()
				return
			end

			local f      = blob.frames[frameIndex]
			local rootCF = CFrame.new(f[1], f[2], f[3])
				* CFrame.fromEulerAnglesYXZ(f[4], f[5], f[6])

			-- Move the ghost root; Motor6D joints drag all limbs along
			hrp.CFrame = rootCF

			-- Fallback block rig: drive each limb manually
			if fallbackData then
				for _, entry in ipairs(fallbackData.limbs) do
					entry.part.CFrame = rootCF * entry.offset
				end
			end

			-- Camera: yaw-only follow (no pitch/roll) — same as default Roblox cam
			local _, yaw, _ = rootCF:ToEulerAnglesYXZ()
			local yawCF     = CFrame.new(rootCF.Position)
				* CFrame.fromEulerAnglesYXZ(0, yaw, 0)
			local targetCF  = yawCF * CAM_OFFSET
			camera.CFrame   = camera.CFrame:Lerp(targetCF, CAM_LERP)

			-- Flash highlight at revive markers
			if reviveSet[frameIndex] and ghostHighlight then
				ghostHighlight.FillColor = REVIVE_FILL
				task.delay(0.6, function()
					if ghostHighlight then ghostHighlight.FillColor = HIGHLIGHT_FILL end
				end)
			end

			frameIndex += 1
		end)
	end)
end

-- [ DELIVER ] ----------------------------------------------------------------

DeliverReplay.OnClientEvent:Connect(function(blob: any)
	if not blob then
		warn("[ReplayClient] Server returned nil — player has no saved replay yet.")
		return
	end
	playReplay(blob :: ReplayBlob)
end)

-- [ VIEW BUTTON WIRING ] -----------------------------------------------------

local function getUserIdFromEntry(entry: Instance): number?
	local cached = entry:GetAttribute("UserId")
	if type(cached) == "number" and cached > 0 then return cached end

	local imageLabel = entry:FindFirstChildWhichIsA("ImageLabel", true) :: ImageLabel?
	if imageLabel then
		local idStr = imageLabel.Image:match("[?&]id=(%d+)")
			or imageLabel.Image:match("id=(%d+)")
		if idStr then
			local uid = tonumber(idStr)
			if uid then entry:SetAttribute("UserId", uid); return uid end
		end
	end

	local nameLabel  = entry:FindFirstChildWhichIsA("TextLabel", true) :: TextLabel?
	local playerName = nameLabel and nameLabel.Text
	if not playerName or playerName == "" then return nil end

	local ok, userId = pcall(function()
		return Players:GetUserIdFromNameAsync(playerName)
	end)
	if not ok or type(userId) ~= "number" then return nil end
	entry:SetAttribute("UserId", userId)
	return userId
end


local function wireEntry(entry: Instance)
	print("[ReplayClient] wireEntry called for:", entry:GetFullName())

	local viewFrame = entry:WaitForChild("View", 10)
	if not viewFrame then
		warn("[ReplayClient] No 'View' child in", entry:GetFullName())
		return
	end

	print("[ReplayClient] Found View:", viewFrame.ClassName)
	pcall(function() (viewFrame :: any).Visible = true end)

	local key = viewFrame :: any
	if wiredButtons[key] then
		print("[ReplayClient] Already wired, skipping.")
		return
	end
	wiredButtons[key] = true
	viewFrame.Destroying:Connect(function() wiredButtons[key] = nil end)

	local btn      = Instance.new("TextButton")
	btn.Name       = "_ReplayClickTarget"
	btn.Size       = UDim2.fromScale(1, 1)
	btn.BackgroundTransparency = 1
	btn.Text       = ""
	btn.ZIndex     = 99
	btn.Parent     = viewFrame

	btn.MouseButton1Click:Connect(function()
		print("[ReplayClient] View clicked on", entry.Name)
		local userId = getUserIdFromEntry(entry)
		if not userId then
			warn("[ReplayClient] Could not resolve userId for", entry.Name)
			return
		end
		print("[ReplayClient] Requesting replay for userId:", userId)
		RequestReplay:FireServer(userId)
	end)

	print("[ReplayClient] Wired", entry.Name)
end


local function isTimeLeaderboardEntry(entry: Instance): boolean
	local current: Instance? = entry.Parent
	while current do
		if current:IsA("Model") then
			local p = current.Parent
			if p and p:IsA("Folder") and p.Name == "Leaderboards" then
				return current.Name == "TimeLeaderboard"
			end
		end
		current = current.Parent
	end
	return false
end

-- Entries are Frame instances named "Entry_N" inside a ScrollingFrame inside
-- a SurfaceGui inside a Model in Workspace/Leaderboards.
-- We must NOT filter by :IsA("GuiObject") here because that check works fine
-- on the instance itself — the real problem was that DescendantAdded on the
-- Leaderboards FOLDER fires for every descendant at every depth, so we just
-- check the Name prefix and let wireEntry handle the rest.

local function handleDescendant(desc: Instance)
	-- Only care about instances whose name starts with "Entry_"
	if desc.Name:sub(1, 6) ~= "Entry_" then return end
	-- Must be some kind of GuiBase2d (Frame, etc.) — skip non-GUI things
	-- like Scripts or Parts that happen to be named Entry_something
	if not desc:IsA("GuiBase2d") then return end

	if isTimeLeaderboardEntry(desc) then
		task.spawn(wireEntry, desc)
	else
		-- Hide the View button on non-time leaderboard entries
		task.defer(function()
			local v = desc:FindFirstChild("View")
			if v then (v :: any).Visible = false end
		end)
	end
end

local function hookLeaderboardModel(model: Instance)
	-- Walk all current descendants and wire any already-existing entries
	for _, desc in ipairs(model:GetDescendants()) do
		handleDescendant(desc)
	end
	-- Watch for entries added later (LeaderboardController spawns them async)
	model.DescendantAdded:Connect(handleDescendant)
end

local function hookLeaderboardsFolder(folder: Instance)
	print("[ReplayClient] Hooking Leaderboards folder.")
	-- Hook each leaderboard model inside the folder
	for _, child in ipairs(folder:GetChildren()) do
		if child:IsA("Model") then
			hookLeaderboardModel(child)
		end
	end
	-- Also catch models added later
	folder.ChildAdded:Connect(function(child)
		if child:IsA("Model") then
			hookLeaderboardModel(child)
		end
	end)
end

-- The Leaderboards folder may already exist or appear later
local lb = Workspace:FindFirstChild("Leaderboards")
if lb then
	hookLeaderboardsFolder(lb)
else
	print("[ReplayClient] Waiting for Leaderboards folder...")
	Workspace.ChildAdded:Connect(function(child)
		if child.Name == "Leaderboards" then
			hookLeaderboardsFolder(child)
		end
	end)
end

print("[ReplayClient] Loaded.")