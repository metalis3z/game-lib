-- TrainingPadClient: "Requires N Rebirths" toast when stepping on a locked
-- ore pad (same notification system as "Loot storage full!"), plus rainbow
-- accent cycling for the x100 Robux pad (outline, crystals and glow are
-- tagged "PadRainbow" in Studio).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

-- ===== rainbow accent cycling (x100 pad) =====
local RAINBOW_TAG = "PadRainbow"
local RAINBOW_SPEED = 0.22 -- hue cycles per second

local tagged = {}
for _, inst in CollectionService:GetTagged(RAINBOW_TAG) do
	tagged[inst] = true
end
CollectionService:GetInstanceAddedSignal(RAINBOW_TAG):Connect(function(inst)
	tagged[inst] = true
end)
CollectionService:GetInstanceRemovedSignal(RAINBOW_TAG):Connect(function(inst)
	tagged[inst] = nil
end)

RunService.Heartbeat:Connect(function()
	local h = (os.clock() * RAINBOW_SPEED) % 1
	local main = Color3.fromHSV(h, 0.72, 1)
	local soft = Color3.fromHSV(h, 0.4, 1)
	for inst in tagged do
		if inst:IsA("BasePart") then
			inst.Color = main
		elseif inst:IsA("ParticleEmitter") then
			inst.Color = ColorSequence.new(soft, main)
		elseif inst:IsA("PointLight") then
			inst.Color = main
		elseif inst:IsA("TextLabel") then
			local grad = inst:FindFirstChildOfClass("UIGradient")
			if grad then
				grad.Color = ColorSequence.new(soft, main)
			end
		end
	end
end)

-- ===== rainbow flow on the x100 (1000 Robux) pad price text =====
-- Same smooth 20-keypoint rainbow as the HUD Robux prices (PriceRainbowFlow),
-- but cycled faster. The label is tagged "PadPriceRainbow" in Studio -- the
-- tag follows the instance through moves/renames (the training area was
-- restructured once already) and BillboardVisibility's _CenterHost reparent,
-- so no path lookup can go stale.
local PRICE_RAINBOW_TAG = "PadPriceRainbow"
local PRICE_RAINBOW_SPEED = 0.6 -- cycles/sec (the HUD price flow uses 0.25)
local PRICE_N = 19 -- 20 keypoints (engine max) = smoothest sequence, no banding
local function rainbowSeq(phase, span)
	span = span or 1 -- fraction of the hue wheel spread across the gradient
	local kps = table.create(PRICE_N + 1)
	for i = 0, PRICE_N do
		local t = i / PRICE_N
		kps[i + 1] = ColorSequenceKeypoint.new(t, Color3.fromHSV((t * span - phase) % 1, 1, 1))
	end
	return ColorSequence.new(kps)
end

local priceGrads = {} -- [TextLabel] = UIGradient
local function bindPriceLabel(inst)
	if not inst:IsA("TextLabel") then return end
	inst.TextColor3 = Color3.new(1, 1, 1) -- white base -> clean rainbow
	local grad = inst:FindFirstChildOfClass("UIGradient")
	if not grad then
		grad = Instance.new("UIGradient")
		grad.Parent = inst
	end
	grad.Rotation = 0
	grad.Offset = Vector2.new(0, 0)
	priceGrads[inst] = grad
end
for _, inst in CollectionService:GetTagged(PRICE_RAINBOW_TAG) do
	bindPriceLabel(inst)
end
CollectionService:GetInstanceAddedSignal(PRICE_RAINBOW_TAG):Connect(bindPriceLabel)
CollectionService:GetInstanceRemovedSignal(PRICE_RAINBOW_TAG):Connect(function(inst)
	priceGrads[inst] = nil
end)

-- ===== rainbow flow across the x100 pad floor (ZonePart SurfaceGui) =====
-- The pad's ZonePart carries a Top-face SurfaceGui (RainbowGradient.Fill,
-- tagged "PadZoneRainbow") whose UIGradient flows diagonally (Rotation 45,
-- set in Studio). Unlike the price text it spreads only ZONE_RAINBOW_SPAN of
-- the hue wheel across the pad (big wide color bands) and cycles slower.
local ZONE_RAINBOW_TAG = "PadZoneRainbow"
local ZONE_RAINBOW_SPEED = 0.2 -- cycles/sec (text uses 0.6 -- too fast on the floor)
local ZONE_RAINBOW_SPAN = 0.35 -- fraction of the hue wheel across the pad
local zoneGrads = {} -- [GuiObject] = UIGradient
local function bindZoneFill(inst)
	if not inst:IsA("GuiObject") then return end
	local grad = inst:FindFirstChildOfClass("UIGradient")
	if not grad then
		grad = Instance.new("UIGradient")
		grad.Parent = inst
	end
	zoneGrads[inst] = grad
end
for _, inst in CollectionService:GetTagged(ZONE_RAINBOW_TAG) do
	bindZoneFill(inst)
end
CollectionService:GetInstanceAddedSignal(ZONE_RAINBOW_TAG):Connect(bindZoneFill)
CollectionService:GetInstanceRemovedSignal(ZONE_RAINBOW_TAG):Connect(function(inst)
	zoneGrads[inst] = nil
end)

-- 30 Hz: indistinguishable for these slow hue flows, but per-frame Color
-- sets re-rastered the pad price texts + floor SurfaceGuis at the full
-- client framerate. Phases are clock-based; skipping frames never desyncs.
local RAINBOW_UPDATE_INTERVAL = 1 / 30
local rainbowAccum = 0
RunService.RenderStepped:Connect(function(dt)
	rainbowAccum += dt
	if rainbowAccum < RAINBOW_UPDATE_INTERVAL then return end
	rainbowAccum = 0
	if next(priceGrads) then
		local seq = rainbowSeq((os.clock() * PRICE_RAINBOW_SPEED) % 1)
		for _, grad in priceGrads do
			grad.Color = seq
		end
	end
	if next(zoneGrads) then
		local seq = rainbowSeq((os.clock() * ZONE_RAINBOW_SPEED) % 1, ZONE_RAINBOW_SPAN)
		for _, grad in zoneGrads do
			grad.Color = seq
		end
	end
end)

-- ===== locked-pad denial toast =====
-- NotificationsController is the game's live toast system (GUI.Folder.Notification
-- with NotificationGreen/NotificationRed templates) -- same path RarityLootClient
-- uses for "Loot storage full!".
local NotificationsController
pcall(function()
	NotificationsController = require(ReplicatedStorage.Source.Controllers.NotificationsController)
end)

local padRemote = ReplicatedStorage:WaitForChild("TrainingPadRemote")
padRemote.OnClientEvent:Connect(function(action, payload)
	if action == "denied" and type(payload) == "string" then
		if NotificationsController then
			NotificationsController.Send("Red", payload)
		end
	end
end)

-- ===== distance-compensated billboard strokes =====
-- The pad billboards use FixedSize strokes: sharp 3 screen-px lines up
-- close, but a fixed pixel width visually swallows the text once the
-- billboard shrinks with distance (and ScaledSize explodes into blobs on
-- BillboardGuis). So scale each stroke's PIXEL thickness down with camera
-- distance manually. Tag-based ("PadBillboardStroke") -- path lookups here
-- go stale (area restructures + BillboardVisibility's _CenterHost reparent).
local STROKE_TAG = "PadBillboardStroke"
local STROKE_REF_DIST = 30 -- full thickness at/inside this distance
local STROKE_MIN = 0.5

local strokeAnchors = {} -- [UIStroke] = anchor BasePart
local function bindStroke(s)
	local bb = s:FindFirstAncestorOfClass("BillboardGui")
	local anchor = bb and bb.Parent
	if anchor and anchor:IsA("BasePart") then
		strokeAnchors[s] = anchor
	end
end
for _, s in CollectionService:GetTagged(STROKE_TAG) do
	bindStroke(s)
end
CollectionService:GetInstanceAddedSignal(STROKE_TAG):Connect(bindStroke)
CollectionService:GetInstanceRemovedSignal(STROKE_TAG):Connect(function(s)
	strokeAnchors[s] = nil
end)

local strokeAccum = 0
RunService.Heartbeat:Connect(function(dt)
	strokeAccum += dt
	if strokeAccum < 0.1 then return end
	strokeAccum = 0
	local cam = workspace.CurrentCamera
	if not cam then return end
	local camPos = cam.CFrame.Position
	for s, anchor in pairs(strokeAnchors) do
		if s.Parent and anchor.Parent then
			local base = s:GetAttribute("BaseThickness") or 3
			local dist = (anchor.Position - camPos).Magnitude
			s.Thickness = math.clamp(base * STROKE_REF_DIST / math.max(dist, 1), STROKE_MIN, base)
		end
	end
end)