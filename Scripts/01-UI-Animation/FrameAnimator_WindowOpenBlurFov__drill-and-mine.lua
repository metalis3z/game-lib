-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ReplicatedStorage/Source/Modules/FrameAnimator.lua  (luau, 801 lines)
-- Categories: ui-framework 17.1, ui-animation 16.1, tycoon-plots 12.2
-- What it does: Window manager: Back-eased open / Quad-in close, blur + camera FOV tween, HUD groups slide off-screen while a window is open, cached fade tweens, open-by-button or by standing on a part.

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayerDataService")

local FrameManager = {}

local Data = nil

local permanentOriginals = {}

local anim_time = 0.22
local anim_easing_style = Enum.EasingStyle.Back
local anim_direction = Enum.EasingDirection.Out
local blur_size = 24

local default_fov = 70
local open_fov = 50

local tweenBlur = TweenInfo.new(anim_time, Enum.EasingStyle.Sine)
local tweenOpenSize = TweenInfo.new(anim_time, anim_easing_style, anim_direction)

local tweenCloseSize = TweenInfo.new(anim_time * 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local tweenFade = TweenInfo.new(anim_time * 0.7, Enum.EasingStyle.Quad)

local tweenFadeClose = TweenInfo.new(anim_time * 0.7, Enum.EasingStyle.Quad)
local tweenFov = TweenInfo.new(anim_time, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local tweenFovClose = TweenInfo.new(anim_time * 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
local tweenHudOut = TweenInfo.new(anim_time * 0.85, Enum.EasingStyle.Back, Enum.EasingDirection.In)
local tweenHudIn = TweenInfo.new(anim_time * 0.85, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local hud_offscreen_padding = 36

local blurEffect = Lighting:FindFirstChild("BlurUi")
-- Enabled ONLY while a frame is open: an enabled BlurEffect can still cost
-- a fullscreen pass every frame even at Size 0.
blurEffect.Enabled = false

local currentlyOpenFrame = nil
local frameData = {}
local isAnimating = false
local uiRoot = nil
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local frameCache = {}
local fadeTweenCache = {} -- [instance] = {open = Tween, close = Tween}
local snapCache = {} -- [frame] = set of scroll cards offscreen at last close
local frameCacheDirty = true
local hudFrame = nil
local hudOriginalPositions = {}
local hudTweens = {}

local bottomUiTargets = {}
local bottomUiOriginalPositions = {}
local bottomUiTweens = {}

local function invalidateFrameCache()
	frameCacheDirty = true
end

local function rebuildFrameCache()
	if not uiRoot then return end
	table.clear(frameCache)
	for _, desc in uiRoot:GetDescendants() do
		if desc:IsA("Frame") or desc:IsA("CanvasGroup") or desc:IsA("ScrollingFrame") or desc:IsA("ImageLabel") then
			frameCache[desc.Name] = frameCache[desc.Name] or desc
		end
	end
	frameCacheDirty = false
end

local function toggleBlur(state)
	local targetSize = state and blur_size or 0
	if state then
		blurEffect.Enabled = true
	end
	local t = TweenService:Create(blurEffect, tweenBlur, { Size = targetSize })
	t:Play()
	t.Completed:Once(function()
		if state then
			blurEffect.Size = targetSize
		elseif blurEffect.Size <= 0.01 then
			-- reached zero for real (not a cancelled close): stop paying the
			-- fullscreen pass entirely
			blurEffect.Size = 0
			blurEffect.Enabled = false
		end
	end)
end

local function tweenFovTo(targetFov, opening)
	local info = opening and tweenFov or tweenFovClose
	TweenService:Create(camera, info, { FieldOfView = targetFov }):Play()
end

local function getHudObjects()
	if not hudFrame then return {} end

	local objects = {}
	for _, child in hudFrame:GetChildren() do
		if child:IsA("GuiObject") then
			table.insert(objects, child)
		end
	end
	return objects
end

local function getHudExitPosition(obj)
	local originalPosition = hudOriginalPositions[obj]
	if not originalPosition then
		originalPosition = obj.Position
		hudOriginalPositions[obj] = originalPosition
	end

	-- SCALE-based off-screen targets with ZERO pixel offsets. Pixel deltas
	-- baked at open time go stale when the viewport is still settling at
	-- join (Studio window resize / device rotation), which left HUD groups
	-- half on screen when the daily-reward popup auto-opened. Scale
	-- positions keep tracking the real screen size, and zero offsets match
	-- HUDSlideController's convention (see its offscreenPosition comment).
	-- Top-of-screen groups all exit straight UP (never sideways), so the whole
	-- top strip lifts off together when a frame opens.
	local topGroups = { TopButtons = true, LevelReadout = true }
	if topGroups[obj.Name] then
		return UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, -0.9, 0)
	end

	-- decide which side to exit from the AUTHORED horizontal placement
	local sizeXScale = obj.Size.X.Scale
	local leftEdgeScale = originalPosition.X.Scale - obj.AnchorPoint.X * sizeXScale
	local centerScale = leftEdgeScale + sizeXScale * 0.5
	if centerScale < 0.5 then
		return UDim2.new(-0.9, 0, originalPosition.Y.Scale, originalPosition.Y.Offset)
	else
		return UDim2.new(1.9, 0, originalPosition.Y.Scale, originalPosition.Y.Offset)
	end
end

local function parseHudKeep(frame)
	local keep = {}
	if not frame then return keep end
	local raw = frame:GetAttribute("HudKeep")
	if type(raw) ~= "string" or raw == "" then return keep end
	for name in string.gmatch(raw, "[^,%s]+") do
		keep[name] = true
	end
	return keep
end

-- The top strip is owned by SurfaceModeController: underground shows the
-- Surface button (TopButtons), on the surface the level bar owns the slot.
-- Restoring blindly to the first-captured position put the WRONG element
-- back (the Surface button stayed hidden after closing a shop frame down in
-- the zones). On open only lift what is actually on screen; on close restore
-- only the element the CURRENT mode calls for, at the shown position
-- SurfaceModeController publishes via the SurfaceShownPos attribute.
local TOP_STRIP = { TopButtons = "underground", LevelReadout = "surface" }

local function tweenHud(opening, keepSet)
	keepSet = keepSet or {}
	for _, obj in getHudObjects() do
		if keepSet[obj.Name] then
			continue
		end

		local strip = TOP_STRIP[obj.Name]
		if strip then
			local shown = obj:GetAttribute("SurfaceShownPos")
			if opening then
				if not obj.Visible then
					continue
				end
				if shown then
					hudOriginalPositions[obj] = shown
				end
			else
				local underground = player:GetAttribute("Underground") == true
				local wanted = (strip == "underground") == underground
				if not wanted then
					continue
				end
				if shown then
					hudOriginalPositions[obj] = shown
				end
				obj.Visible = true
			end
		end

		if not hudOriginalPositions[obj] then
			hudOriginalPositions[obj] = obj.Position
		end

		if hudTweens[obj] then
			hudTweens[obj]:Cancel()
		end

		local targetPosition = opening and getHudExitPosition(obj) or hudOriginalPositions[obj]
		local tweenInfo = opening and tweenHudOut or tweenHudIn
		local tween = TweenService:Create(obj, tweenInfo, { Position = targetPosition })
		hudTweens[obj] = tween
		tween.Completed:Once(function()
			if hudTweens[obj] == tween then
				hudTweens[obj] = nil
			end
		end)
		tween:Play()
	end
end

local function findBottomUiTargets()
	bottomUiTargets = {}
	if not uiRoot then return end
	local folder = uiRoot:FindFirstChild("Folder")
	if not folder then return end
	for _, name in ipairs({ "InventoryBottom", "InventoryFrame" }) do
		local obj = folder:FindFirstChild(name)
		if obj and obj:IsA("GuiObject") then
			table.insert(bottomUiTargets, obj)
		end
	end
end

local function getBottomExitPosition(obj)
	local originalPos = bottomUiOriginalPositions[obj]
	if not originalPos then
		originalPos = obj.Position
		bottomUiOriginalPositions[obj] = originalPos
	end

	-- scale-based exit below the screen, zero pixel offsets (same reasoning
	-- as getHudExitPosition: pixel deltas go stale while the viewport settles)
	return UDim2.new(
		originalPos.X.Scale,
		originalPos.X.Offset,
		1.9,
		0
	)
end

local function tweenBottomUi(opening)
	for _, obj in ipairs(bottomUiTargets) do
		if obj:GetAttribute("FrameAnimSkip") then
			continue
		end

		if not bottomUiOriginalPositions[obj] then
			bottomUiOriginalPositions[obj] = obj.Position
		end

		if bottomUiTweens[obj] then
			bottomUiTweens[obj]:Cancel()
		end

		local targetPos = opening and getBottomExitPosition(obj) or bottomUiOriginalPositions[obj]
		local tweenInfo = opening and tweenHudOut or tweenHudIn
		local tween = TweenService:Create(obj, tweenInfo, { Position = targetPos })
		bottomUiTweens[obj] = tween
		tween.Completed:Once(function()
			if bottomUiTweens[obj] == tween then
				bottomUiTweens[obj] = nil
			end
		end)
		tween:Play()
	end
end

local function registerOriginalValues(obj)
	if not obj:IsA("GuiObject") and not obj:IsA("UIStroke") then return end
	if permanentOriginals[obj] then return end

	permanentOriginals[obj] = {
		BackgroundTransparency = obj:IsA("GuiObject") and obj.BackgroundTransparency or nil,
		TextTransparency = (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) and obj.TextTransparency or nil,
		ImageTransparency = (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) and obj.ImageTransparency or nil,
		Transparency = obj:IsA("UIStroke") and obj.Transparency or nil,
	}
end

local function scanAndRegister(root)
	registerOriginalValues(root)
	for _, desc in root:GetDescendants() do
		registerOriginalValues(desc)
	end
end

-- AnimatedText per-char overlays ("_AnimText") mirror their source label's
-- TextTransparency / stroke transparency through their own listeners, and
-- every character is 4-6 GuiObjects -- tweening those internals here
-- multiplied the open/close tween count several times over on label-heavy
-- frames (a large part of the Drill shop / Rebirth open hitch).
local function isInAnimTextOverlay(child, root)
	local node = child.Parent
	while node and node ~= root do
		if node.Name == "_AnimText" then
			return true
		end
		node = node.Parent
	end
	return false
end

-- Cards scrolled outside their ScrollingFrame window are CLIPPED -- fading
-- their contents is invisible work (the drill shop keeps ~20 of 28 cards
-- offscreen, each with a dozen tweening texts/strokes per open AND close).
-- Those instances snap straight to the end state instead: pixel-identical,
-- most of the fade storm gone. The offscreen set is computed at CLOSE time
-- (geometry settled; at open the frame is size-0 so absolutes are useless)
-- and reused by the next open -- the scroll can't move while closed. The
-- first-ever open has no set yet and fades everything, same as before.
local SNAP_MARGIN = 0.1

local function computeOffscreenCards(frame)
	local set = nil
	local scrolls = nil
	if frame:IsA("ScrollingFrame") then
		scrolls = { frame }
	end
	for _, d in frame:GetDescendants() do
		if d:IsA("ScrollingFrame") then
			scrolls = scrolls or {}
			table.insert(scrolls, d)
		end
	end
	if not scrolls then
		return nil
	end
	for _, sf in ipairs(scrolls) do
		local win = sf.AbsoluteWindowSize
		if win.X > 0 and win.Y > 0 then
			local pos = sf.AbsolutePosition
			local minX = pos.X - win.X * SNAP_MARGIN
			local maxX = pos.X + win.X * (1 + SNAP_MARGIN)
			local minY = pos.Y - win.Y * SNAP_MARGIN
			local maxY = pos.Y + win.Y * (1 + SNAP_MARGIN)
			for _, card in ipairs(sf:GetChildren()) do
				if card:IsA("GuiObject") and card.Visible then
					local cp = card.AbsolutePosition
					local cs = card.AbsoluteSize
					local inWindow = cp.X + cs.X >= minX and cp.X <= maxX
						and cp.Y + cs.Y >= minY and cp.Y <= maxY
					if not inWindow then
						set = set or {}
						set[card] = true
					end
				end
			end
		end
	end
	return set
end

local function isInSnappedCard(child, root, snapSet)
	if not snapSet then
		return false
	end
	local node = child.Parent
	while node and node ~= root do
		if snapSet[node] then
			return true
		end
		node = node.Parent
	end
	return false
end

local function setTransparency(frame, targetAlpha)
	local isOpening = (targetAlpha == 0)
	local fadeInfo = isOpening and tweenFade or tweenFadeClose

	local snapSet
	if isOpening then
		snapSet = snapCache[frame]
	else
		snapSet = computeOffscreenCards(frame)
		snapCache[frame] = snapSet
	end

	for _, child in frame:GetDescendants() do
		if not (child:IsA("GuiObject") or child:IsA("UIStroke")) then continue end
		if isInAnimTextOverlay(child, frame) then continue end

		local originals = permanentOriginals[child]
		if not originals then 
			registerOriginalValues(child)
			originals = permanentOriginals[child]
		end

		-- only tween properties that are NOT already at their target: most
		-- GuiObjects are fully-transparent containers, so this cuts the
		-- tweens created per open/close from thousands to a few hundred
		local goal = {}
		if child:IsA("GuiObject") then
			local target = isOpening and originals.BackgroundTransparency or 1
			if child.BackgroundTransparency ~= target then
				goal.BackgroundTransparency = target
			end
		end
		if originals.TextTransparency then
			local target = isOpening and originals.TextTransparency or 1
			if child.TextTransparency ~= target then
				goal.TextTransparency = target
			end
		end
		if originals.ImageTransparency then
			local target = isOpening and originals.ImageTransparency or 1
			if child.ImageTransparency ~= target then
				goal.ImageTransparency = target
			end
		end
		if originals.Transparency then
			local target = isOpening and originals.Transparency or 1
			if child.Transparency ~= target then
				goal.Transparency = target
			end
		end

		if next(goal) then
			if isInSnappedCard(child, frame, snapSet) then
				-- clipped outside the scroll window: end state applied
				-- directly, nothing visible ever happens
				for prop, value in pairs(goal) do
					child[prop] = value
				end
				continue
			end
			-- cached per (instance, direction): creating hundreds of fresh
			-- Tween objects on every open/close of a big frame was its own
			-- one-frame burst. The cached tween carries the FULL goal for its
			-- direction (props already at target tween harmlessly in place);
			-- the reduced `goal` above still decides whether to play at all.
			local cache = fadeTweenCache[child]
			if not cache then
				cache = {}
				fadeTweenCache[child] = cache
			end
			local key = isOpening and "open" or "close"
			local tween = cache[key]
			if not tween then
				local fullGoal = {}
				if child:IsA("GuiObject") then
					fullGoal.BackgroundTransparency = isOpening and originals.BackgroundTransparency or 1
				end
				if originals.TextTransparency then
					fullGoal.TextTransparency = isOpening and originals.TextTransparency or 1
				end
				if originals.ImageTransparency then
					fullGoal.ImageTransparency = isOpening and originals.ImageTransparency or 1
				end
				if originals.Transparency then
					fullGoal.Transparency = isOpening and originals.Transparency or 1
				end
				tween = TweenService:Create(child, fadeInfo, fullGoal)
				cache[key] = tween
			end
			tween:Play()
		end
	end
end

local function findFrame(name)
	if not uiRoot or name == "" then return nil end
	if frameCacheDirty then rebuildFrameCache() end
	return frameCache[name]
end

-- ===== quantized size animation =====
-- Every write to frame.Size relayouts the whole frame: TextScaled metrics
-- recompute and strokes/gradients re-raster for everything inside, clipped
-- or not. TweenService wrote Size once per RENDERED frame, so a 240Hz rig
-- paid that storm 4x more often than a 60Hz one for the same 0.22s pop.
-- Size is now stepped at SIZE_ANIM_HZ on the identical curve/duration --
-- exactly what a 60 FPS player always saw, nothing visibly changes.
local SIZE_ANIM_HZ = 60

local sizeAnims = {} -- [frame] = {conn = RBXScriptConnection}

local function cancelSizeAnim(frame)
	local anim = sizeAnims[frame]
	if anim then
		if anim.conn then anim.conn:Disconnect() end
		sizeAnims[frame] = nil
	end
end

local function animateSize(frame, targetSize, info, onDone)
	cancelSizeAnim(frame)
	local startSize = frame.Size
	local duration = info.Time
	local style, direction = info.EasingStyle, info.EasingDirection
	local elapsed = 0
	local sinceWrite = math.huge -- first step lands on the very next frame
	local anim = {}
	anim.conn = RunService.Heartbeat:Connect(function(dt)
		elapsed += dt
		sinceWrite += dt
		if not frame.Parent then
			-- frame left the tree mid-anim: still run the completion so
			-- isAnimating can never wedge shut
			cancelSizeAnim(frame)
			if onDone then task.spawn(onDone) end
			return
		end
		if elapsed >= duration then
			cancelSizeAnim(frame)
			frame.Size = targetSize
			if onDone then task.spawn(onDone) end
			return
		end
		if sinceWrite < 1 / SIZE_ANIM_HZ then
			return
		end
		sinceWrite = 0
		local alpha = TweenService:GetValue(elapsed / duration, style, direction)
		frame.Size = startSize:Lerp(targetSize, alpha)
	end)
	sizeAnims[frame] = anim
end

function FrameManager:Open(frame)
	if isAnimating or not frame or currentlyOpenFrame == frame then return end
	if Data and Data.IsTutorialFinished == false
		and (frame.Name == "Spinwheel"
			or frame.Name == "FreeGiftFrame"
			or frame.Name == "StarterPack")
	then
		return
	end	

	isAnimating = true

	if not currentlyOpenFrame then
		default_fov = camera.FieldOfView
	end

	toggleBlur(true)
	tweenFovTo(open_fov, true)
	tweenHud(true, parseHudKeep(frame))
	tweenBottomUi(true)

	if currentlyOpenFrame then 
		self:Close(currentlyOpenFrame, true) 
	end

	if not frameData[frame] then 
		frameData[frame] = {
			OriginalSize = frame.Size,
			RootBackgroundTransparency = frame.BackgroundTransparency,
			RootImageTransparency = (frame:IsA("ImageLabel") or frame:IsA("ImageButton")) and frame.ImageTransparency or 0,
		} 
	end

	local state = frameData[frame]

	frame.Size = UDim2.new(0, 0, 0, 0)
	frame.Visible = true

	setTransparency(frame, 0)

	animateSize(frame, state.OriginalSize, tweenOpenSize, function()
		currentlyOpenFrame = frame
		isAnimating = false
	end)
end

function FrameManager:Close(frame, isSwitching)
	if not frame or not frame.Visible then return end
	if not isSwitching then isAnimating = true end

	if not isSwitching then
		toggleBlur(false)
		tweenFovTo(default_fov, false	)
		tweenHud(false, parseHudKeep(frame))
		tweenBottomUi(false)
	end

	local state = frameData[frame] or { OriginalSize = frame.Size }

	setTransparency(frame, 1)

	animateSize(frame, UDim2.new(0, 0, 0, 0), tweenCloseSize, function()
		frame.Visible = false
		frame.Size = state.OriginalSize

		if not isSwitching then
			currentlyOpenFrame = nil
			isAnimating = false
		end
	end)
end

-- Pre-create a frame's cached fade tweens (both directions) and its
-- offscreen-card snap set at startup, spread over many frames. The first
-- open otherwise pays the whole Tween-creation burst AND fades cards
-- clipped outside the scroll window (snapCache only fills at first close).
-- Creation only: nothing plays, nothing visible changes.
function FrameManager.Prewarm(frameOrName)
	task.spawn(function()
		local frame = frameOrName
		if typeof(frameOrName) ~= "Instance" then
			frame = findFrame(frameOrName)
		end
		if not frame then return end

		local createdThisSlice = 0
		for _, child in frame:GetDescendants() do
			if not (child:IsA("GuiObject") or child:IsA("UIStroke")) then continue end
			if isInAnimTextOverlay(child, frame) then continue end

			local originals = permanentOriginals[child]
			if not originals then
				registerOriginalValues(child)
				originals = permanentOriginals[child]
			end
			if not originals then continue end

			local cache = fadeTweenCache[child]
			if not cache then
				cache = {}
				fadeTweenCache[child] = cache
			end
			for _, key in ipairs({ "open", "close" }) do
				if not cache[key] then
					local isOpening = key == "open"
					local fullGoal = {}
					if child:IsA("GuiObject") then
						fullGoal.BackgroundTransparency = isOpening and originals.BackgroundTransparency or 1
					end
					if originals.TextTransparency then
						fullGoal.TextTransparency = isOpening and originals.TextTransparency or 1
					end
					if originals.ImageTransparency then
						fullGoal.ImageTransparency = isOpening and originals.ImageTransparency or 1
					end
					if originals.Transparency then
						fullGoal.Transparency = isOpening and originals.Transparency or 1
					end
					if next(fullGoal) then
						cache[key] = TweenService:Create(child, isOpening and tweenFade or tweenFadeClose, fullGoal)
						createdThisSlice += 1
					end
				end
			end
			if createdThisSlice >= 40 then
				createdThisSlice = 0
				task.wait()
			end
		end

		-- absolutes are valid even while the frame is invisible; if the
		-- window reads 0 (layout not settled yet) retry briefly, then give
		-- up silently -- first open then just fades everything, as before
		if not snapCache[frame] then
			for _ = 1, 10 do
				local set = computeOffscreenCards(frame)
				if set then
					if not snapCache[frame] then
						snapCache[frame] = set
					end
					break
				end
				task.wait(0.5)
			end
		end
	end)
end

function FrameManager:SetupButton(button)
	button.MouseButton1Click:Connect(function()
		local openName = button:GetAttribute("Open")
		local closeName = button:GetAttribute("Close")
		local toggleName = button:GetAttribute("Toggle")

		if toggleName then
			local frame = findFrame(toggleName)
			if currentlyOpenFrame == frame then self:Close(frame) else self:Open(frame) end
		elseif openName then
			self:Open(findFrame(openName))
		elseif closeName then
			self:Close(findFrame(closeName))
		end
	end)
end

function FrameManager:SetupPart(part)
	local wasInside = false

	local function isHrpInsidePart(hrp)
		local local_pos = part.CFrame:PointToObjectSpace(hrp.Position)
		local half = part.Size / 2
		return math.abs(local_pos.X) <= half.X
			and math.abs(local_pos.Y) <= half.Y
			and math.abs(local_pos.Z) <= half.Z
	end

	RunService.Heartbeat:Connect(function()
		local character = player.Character
		if not character then return end

		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		local inside = isHrpInsidePart(hrp)

		if inside and not wasInside then
			wasInside = true
			local openName = part:GetAttribute("Open")
			local closeName = part:GetAttribute("Close")
			local toggleName = part:GetAttribute("Toggle")
			if toggleName then
				local frame = findFrame(toggleName)
				if currentlyOpenFrame == frame then self:Close(frame) else self:Open(frame) end
			elseif openName then
				self:Open(findFrame(openName))
			elseif closeName then
				self:Close(findFrame(closeName))
			end
		elseif not inside and wasInside then
			wasInside = false
			local openName = part:GetAttribute("Open")
			if openName then
				local frame = findFrame(openName)
				if currentlyOpenFrame == frame and not isAnimating then
					self:Close(frame)
				end
			end
		end
	end)
end

function FrameManager.Init(root)
	uiRoot = root
	hudFrame = root.Name == "HUD" and root or root:FindFirstChild("HUD", true)

	default_fov = camera.FieldOfView

	scanAndRegister(root)
	rebuildFrameCache()
	findBottomUiTargets()

	if blurEffect then
		blurEffect.Size = 0
		blurEffect.Enabled = false
	end

	root.DescendantAdded:Connect(function(desc)
		task.defer(function()
			registerOriginalValues(desc)
			invalidateFrameCache()
		end)
	end)

	root.DescendantRemoving:Connect(function(desc)
		permanentOriginals[desc] = nil
		fadeTweenCache[desc] = nil
		snapCache[desc] = nil
		cancelSizeAnim(desc)
		hudOriginalPositions[desc] = nil
		if hudTweens[desc] then
			hudTweens[desc]:Cancel()
			hudTweens[desc] = nil
		end
		bottomUiOriginalPositions[desc] = nil
		if bottomUiTweens[desc] then
			bottomUiTweens[desc]:Cancel()
			bottomUiTweens[desc] = nil
		end
		invalidateFrameCache()
	end)

	remotes:WaitForChild("DataUpdate").OnClientEvent:Connect(function(fullData)
		Data = fullData
	end)

	for _, obj in root:GetDescendants() do
		if obj:IsA("TextButton") or obj:IsA("ImageButton") then
			if obj:GetAttribute("Open") or obj:GetAttribute("Close") or obj:GetAttribute("Toggle") then
				FrameManager:SetupButton(obj)
			end
		end
	end
end

function FrameManager.InitParts(folder)
	local function trySetup(obj)
		if obj:IsA("BasePart") then
			if obj:GetAttribute("Open") or obj:GetAttribute("Close") or obj:GetAttribute("Toggle") then
				FrameManager:SetupPart(obj)
			end
		end
	end

	for _, obj in folder:GetDescendants() do
		trySetup(obj)
	end

	folder.DescendantAdded:Connect(trySetup)
end

return FrameManager