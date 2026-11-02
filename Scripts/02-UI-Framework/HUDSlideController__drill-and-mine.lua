-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ReplicatedStorage/Source/Controllers/HUDSlideController.lua
-- What it does: Slides HUD groups off the screen edges when the player leaves the home area and back when they return; uses a manual Heartbeat lerp so it wins against other tween systems. Heavily commented.

-- HUDSlideController: when the player leaves the MainIsland (out collecting on
-- rarity islands / building a bridge), slide the screen-edge HUD groups off
-- screen so the bridge build view isn't cluttered. Slides back in when the
-- player is back home on MainIsland.
--   * TopButtons       -> off the TOP
--   * LeftSide         -> off the LEFT
--   * InventoryBottom  -> off the BOTTOM
-- Right side / wood HUD stay visible -- they're useful info during the run.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local HUDSlideController = {}

local SLIDE_DURATION = 0.35
local SLIDE_EASE = Enum.EasingStyle.Quart
local SLIDE_DIR_OUT = Enum.EasingDirection.In
local SLIDE_DIR_IN = Enum.EasingDirection.Out
local POLL_INTERVAL = 0.15

-- One entry per HUD group we manage. axis = which direction it slides off.
local SLIDE_TARGETS = {
	{ path = { "HUD", "TopButtons" },         axis = "Y", sign = -1 },
	{ path = { "HUD", "LeftSide" },           axis = "X", sign = -1 },
	{ path = { "Folder", "InventoryBottom" }, axis = "Y", sign = 1  },
}

local function resolveTarget(gui, pathParts)
	local node = gui
	for _, name in ipairs(pathParts) do
		node = node and node:FindFirstChild(name)
		if not node then return nil end
	end
	return node
end

local function offscreenPosition(originalPos, axis, sign)
	-- IMPORTANT: keep OFFSETS at 0 in the off position too. FrameAnimator's
	-- tweenHud sets offsets (negative pixel values) to slide HUD out; if we
	-- baked the original offset into our off-pos and tweened to it, we'd
	-- ping-pong against FrameAnimator and the wood HUD / cash HUD positions
	-- could drift.
	if axis == "Y" then
		local outScale = sign < 0 and -0.8 or 1.8
		return UDim2.new(originalPos.X.Scale, 0, outScale, 0)
	else
		local outScale = sign < 0 and -0.8 or 1.8
		return UDim2.new(outScale, 0, originalPos.Y.Scale, 0)
	end
end

-- Read the authored Position from StarterGui (the live PlayerGui copy may
-- already have been moved by FrameAnimator before this controller initializes,
-- which would make us "restore" to a moved position).
local function readStarterGuiPosition(pathParts)
	local starter = game:GetService("StarterGui")
	local gui = starter:FindFirstChild("GUI")
	if not gui then return nil end
	local node = gui
	for _, name in ipairs(pathParts) do
		node = node and node:FindFirstChild(name)
		if not node then return nil end
	end
	if node and node:IsA("GuiObject") then
		return node.Position
	end
	return nil
end

function HUDSlideController.Init()
	local pg = player:WaitForChild("PlayerGui")
	local gui = pg:WaitForChild("GUI")

	-- Boxed flag so both the drive-loop and the poll-loop share state by
	-- reference (closures capture upvalues by value-of-the-binding, and the
	-- drive-loop is created first; without the box it would always see the
	-- initial false).
	local currentlyOutRef = { value = false }
	local entries = {}
	for _, target in ipairs(SLIDE_TARGETS) do
		local obj = resolveTarget(gui, target.path)
		if obj and obj:IsA("GuiObject") then
			local authored = readStarterGuiPosition(target.path) or obj.Position
			table.insert(entries, {
				obj = obj,
				original = authored,
				off = offscreenPosition(authored, target.axis, target.sign),
				activeTween = nil,
			})
		end
	end

	-- Manual lerp via Heartbeat. We discovered that TweenService's Position
	-- writes were being silently overridden by another system (likely
	-- FrameAnimator's tweenHud running concurrently when proximity-part
	-- triggers fire). Driving the Position write ourselves every Heartbeat
	-- guarantees we win the last-write-wins race AND lets us cancel cleanly
	-- by setting `lerp.cancelled = true` instead of fighting tween cleanup.
	local function lerpUDim2(a, b, t)
		return UDim2.new(
			a.X.Scale + (b.X.Scale - a.X.Scale) * t, a.X.Offset + (b.X.Offset - a.X.Offset) * t,
			a.Y.Scale + (b.Y.Scale - a.Y.Scale) * t, a.Y.Offset + (b.Y.Offset - a.Y.Offset) * t
		)
	end

	local function ease(t, dirIn)
		-- Quart easing. EasingDirection "In" => slow start fast end; "Out" => fast start slow end.
		if dirIn then
			return t * t * t * t
		else
			local m = 1 - t
			return 1 - m * m * m * m
		end
	end

	local function slideTo(target, useInDir)
		for _, e in ipairs(entries) do
			local goal = (target == "out") and e.off or e.original
			local start = e.obj.Position
			if e.lerp then e.lerp.cancelled = true end
			local lerp = {
				start = start,
				goal = goal,
				startT = os.clock(),
				duration = SLIDE_DURATION,
				dirIn = useInDir,
				cancelled = false,
			}
			e.lerp = lerp
		end
	end

	-- Drive position every Heartbeat while:
	-- (a) the lerp is in flight (animating toward goal), OR
	-- (b) the player is OFF main area (we must HOLD them off-screen because
	--     FrameAnimator could otherwise tween them back to its own "original"
	--     when a popup closes mid-walk).
	-- When player is HOME and the lerp has finished, we stop writing entirely
	-- so FrameAnimator's open/close tweens can manage the HUD normally.
	RunService.Heartbeat:Connect(function()
		local driveOff = currentlyOutRef.value -- (declared below; captured via table)
		for _, e in ipairs(entries) do
			local lerp = e.lerp
			if lerp and not lerp.cancelled then
				local elapsed = os.clock() - lerp.startT
				local t = math.min(elapsed / lerp.duration, 1)
				local eased = ease(t, lerp.dirIn)
				e.obj.Position = lerpUDim2(lerp.start, lerp.goal, eased)
				if t >= 1 then
					e.lerp = nil
				end
			elseif driveOff then
				-- Hold off-screen. Without this, FrameAnimator restores the HUD
				-- to its "hudOriginalPositions" snapshot on popup close even if
				-- the player is still on an island.
				e.obj.Position = e.off
			end
		end
	end)

	-- The MainAreaPart is a thin gate / boundary plane the player walks through
	-- to leave the home area. We auto-detect which side is "home" by sampling
	-- the MainIsland's local position relative to the gate -- whichever side
	-- the island sits on is the home side -- so the controller works even if
	-- the gate's facing direction is later changed in Studio.
	local mainAreaPart
	local homeSideAxis -- "X" | "Y" | "Z"
	local homeSideSign -- +1 or -1

	local function chooseThinAxis(size)
		-- Wall-style parts are thin on one axis; use that as the crossing axis.
		if size.Z < size.X and size.Z < size.Y then return "Z" end
		if size.X < size.Y and size.X < size.Z then return "X" end
		return "Y"
	end

	local function resolveGateGeometry()
		if mainAreaPart and mainAreaPart.Parent then return true end
		mainAreaPart = Workspace:FindFirstChild("MainAreaPart")
		if not (mainAreaPart and mainAreaPart:IsA("BasePart")) then return false end
		homeSideAxis = chooseThinAxis(mainAreaPart.Size)
		-- Pick a known home-side reference point. MainIsland is canonical.
		local assets = Workspace:FindFirstChild("Assets")
		local map = assets and assets:FindFirstChild("Map")
		local mainIsland = map and map:FindFirstChild("MainIsland")
		local refPos
		if mainIsland and mainIsland:IsA("BasePart") then
			refPos = mainIsland.Position
		else
			refPos = Vector3.zero
		end
		local refLocal = mainAreaPart.CFrame:PointToObjectSpace(refPos)
		local axisValue = refLocal[homeSideAxis]
		homeSideSign = (axisValue >= 0) and 1 or -1
		return true
	end

	local function isOnMainSide(pos)
		if not resolveGateGeometry() then return true end -- fail-open: keep HUD visible
		local lp = mainAreaPart.CFrame:PointToObjectSpace(pos)
		return (lp[homeSideAxis] * homeSideSign) >= 0
	end

	local accum = 0
	RunService.Heartbeat:Connect(function(dt)
		accum = accum + dt
		if accum < POLL_INTERVAL then return end
		accum = 0

		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		local home = isOnMainSide(hrp.Position)
		local wantOut = not home
		if wantOut == currentlyOutRef.value then return end
		currentlyOutRef.value = wantOut
		slideTo(wantOut and "out" or "in", not wantOut)
	end)
end

return HUDSlideController