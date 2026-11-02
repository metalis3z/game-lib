--------------------------------------------------------------------------------
-- GrabZoomClient
-- Smooth camera FOV zoom while holding a grab prompt (island brainrots, world
-- lucky blocks, rarity loot -- any ProximityPrompt tagged with the GrabZoom
-- attribute). Zooms in over the prompt's HoldDuration, then eases back to the
-- original FOV when the item is obtained, the hold is released early, or the
-- prompt disappears mid-hold. The base FOV is captured once per effect and the
-- restore snaps to it exactly on completion, so the camera can never drift or
-- stay stuck zoomed in.
--------------------------------------------------------------------------------

local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local ZOOM_DELTA = 16      -- degrees zoomed in from the base FOV
local MIN_FOV = 30         -- never zoom tighter than this
local RESTORE_SECONDS = 0.3

local camera = Workspace.CurrentCamera
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	camera = Workspace.CurrentCamera or camera
end)

local activePrompt = nil -- prompt currently being held
local promptConns = {}   -- per-hold connections (Destroying watchdog)
local watchdogConn = nil -- Heartbeat validity check while holding
local baseFOV = nil      -- FOV to restore to; nil = no effect in flight
local activeTween = nil

local function cancelTween()
	if activeTween then
		activeTween:Cancel()
		activeTween = nil
	end
end

local function clearHoldWatchers()
	for _, conn in ipairs(promptConns) do
		conn:Disconnect()
	end
	table.clear(promptConns)
	if watchdogConn then
		watchdogConn:Disconnect()
		watchdogConn = nil
	end
end

local endHold -- forward declaration

local function beginHold(prompt)
	if not prompt:GetAttribute("GrabZoom") then
		return
	end
	if activePrompt then
		return -- already zooming on another hold; that hold's end restores
	end

	activePrompt = prompt
	-- Reuse the stored base FOV if a restore tween is still in flight, so a
	-- quick re-grab can't capture a half-restored FOV as the new baseline.
	if baseFOV == nil then
		baseFOV = camera.FieldOfView
	end

	cancelTween()
	local target = math.max(MIN_FOV, baseFOV - ZOOM_DELTA)
	local duration = math.max(prompt.HoldDuration, 0.15)
	-- LINEAR over the full HoldDuration: the prompt's circular progress ring
	-- fills linearly (tweenInfoInFullDuration in ProximityPromptScript) from
	-- the same PromptButtonHoldBegan moment, so a linear ramp keeps the zoom
	-- in exact lockstep with the ring (Quad/Out used to rush ahead early).
	activeTween = TweenService:Create(
		camera,
		TweenInfo.new(duration, Enum.EasingStyle.Linear),
		{ FieldOfView = target }
	)
	activeTween:Play()

	-- PromptButtonHoldEnded does NOT fire if the prompt is destroyed or
	-- disabled mid-hold (block collected by someone else, item despawned),
	-- so watch for that explicitly while the hold is active.
	table.insert(promptConns, prompt.Destroying:Connect(function()
		endHold(prompt)
	end))
	watchdogConn = RunService.Heartbeat:Connect(function()
		if activePrompt == prompt and (not prompt.Parent or not prompt.Enabled) then
			endHold(prompt)
		end
	end)
end

endHold = function(prompt)
	if activePrompt ~= prompt then
		return
	end
	activePrompt = nil
	clearHoldWatchers()

	cancelTween()
	local restoreTo = baseFOV
	if restoreTo == nil then
		return
	end
	local tween = TweenService:Create(
		camera,
		TweenInfo.new(RESTORE_SECONDS, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ FieldOfView = restoreTo }
	)
	activeTween = tween
	tween.Completed:Connect(function(playbackState)
		if activeTween ~= tween then
			return -- superseded by a newer hold or restore
		end
		activeTween = nil
		if playbackState == Enum.PlaybackState.Completed and activePrompt == nil then
			camera.FieldOfView = restoreTo -- exact value, no float drift
			baseFOV = nil
		end
	end)
	tween:Play()
end

ProximityPromptService.PromptButtonHoldBegan:Connect(beginHold)
ProximityPromptService.PromptButtonHoldEnded:Connect(endHold) -- released early
ProximityPromptService.PromptTriggered:Connect(endHold)       -- item obtained
ProximityPromptService.PromptHidden:Connect(endHold)          -- walked away mid-hold
