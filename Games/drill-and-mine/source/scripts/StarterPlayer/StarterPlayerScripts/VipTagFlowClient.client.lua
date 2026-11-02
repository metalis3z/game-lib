-- Animates the overhead VIP tag gradients (tagged "VipTagGradient" by
-- OverheadStatServer) with a scrolling rainbow -- exact same technique as
-- the HUD PriceRainbowFlow on the strength buy buttons.
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local SPEED = 0.25 -- cycles per second, matches PriceRainbowFlow

-- 20 keypoints (engine max) = smoothest possible ColorSequence, no banding.
local N = 19
local function seqAt(phase)
	local kps = table.create(N + 1)
	for i = 0, N do
		local t = i / N
		kps[i + 1] = ColorSequenceKeypoint.new(t, Color3.fromHSV((t - phase) % 1, 1, 1))
	end
	return ColorSequence.new(kps)
end

-- Owner tag (tagged "OwnerTagGradient" by OverheadStatServer): flowing
-- blue/white cosine wave instead of the rainbow. Integer wave count keeps
-- the two ends of the sequence identical, so the loop never seams.
local OWNER_SPEED = 0.45
local OWNER_WAVES = 2
local OWNER_WHITE = Color3.fromRGB(255, 255, 255)
local OWNER_BLUE = Color3.fromRGB(60, 140, 255)
local function ownerSeqAt(phase)
	local kps = table.create(N + 1)
	for i = 0, N do
		local t = i / N
		local a = 0.5 - 0.5 * math.cos(2 * math.pi * (t * OWNER_WAVES - phase))
		kps[i + 1] = ColorSequenceKeypoint.new(t, OWNER_WHITE:Lerp(OWNER_BLUE, a))
	end
	return ColorSequence.new(kps)
end

-- 30 Hz: indistinguishable for these slow flows, but per-frame Color sets
-- re-rasterized every tagged billboard label at the full client framerate.
-- Phases are clock-based, so skipping frames never desyncs the flow.
local UPDATE_INTERVAL = 1 / 30
local accum = 0
RunService.RenderStepped:Connect(function(dt)
	accum += dt
	if accum < UPDATE_INTERVAL then return end
	accum = 0
	local grads = CollectionService:GetTagged("VipTagGradient")
	if #grads > 0 then
		local seq = seqAt((os.clock() * SPEED) % 1)
		for _, g in ipairs(grads) do
			g.Color = seq
		end
	end

	local ownerGrads = CollectionService:GetTagged("OwnerTagGradient")
	if #ownerGrads > 0 then
		local seq = ownerSeqAt((os.clock() * OWNER_SPEED) % 1)
		for _, g in ipairs(ownerGrads) do
			g.Color = seq
		end
	end
end)
