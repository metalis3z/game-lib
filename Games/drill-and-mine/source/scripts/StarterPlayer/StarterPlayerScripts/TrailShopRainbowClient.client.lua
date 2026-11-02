--[[
	TrailShopRainbowClient
	STATIC rainbow on the Trail Shop title text + tagged accent parts
	(user request 2026-07-17: the scrolling flow kept the booth re-rendering
	forever -- now the rainbow is painted ONCE, left -> right across the
	booth, and only re-applied if the tagged set itself changes).
	Everything is tagged "TrailShopRainbow" (CollectionService) at edit time,
	so this survives the BillboardVisibility _CenterHost reparent and clones.
	Parts keep their original brightness (two-tone shading); only hue is set.
]]

local CollectionService = game:GetService("CollectionService")

local TAG = "TrailShopRainbow"
-- FULL hue wheel left -> right (user request: every color represented, each
-- shingle its own color). 0.92, not 1.0, so the two ends aren't both red.
local HORIZONTAL_HUE_SPAN = 0.92
local TEXT_KEYPOINTS = 12      -- gradient smoothness on the title text

local accentParts = {} -- [BasePart] = {sat, val, coord}
local textGradients = {} -- [TextLabel] = UIGradient

-- forward-declared; parts stream in as a burst at join, so applies coalesce
local applyStaticRainbow
local applyScheduled = false
local function scheduleApply()
	if applyScheduled then return end
	applyScheduled = true
	task.defer(function()
		applyScheduled = false
		if applyStaticRainbow then
			applyStaticRainbow()
		end
	end)
end

-- Each part gets a 0..1 coord along the booth's widest horizontal axis
-- (world X or Z, picked by spread, so the flow reads left-to-right whichever
-- way the shop is rotated). Recomputed whenever the tagged set changes.
local function rebuildCoords()
	local minX, maxX = math.huge, -math.huge
	local minZ, maxZ = math.huge, -math.huge
	for part in pairs(accentParts) do
		local p = part.Position
		minX = math.min(minX, p.X); maxX = math.max(maxX, p.X)
		minZ = math.min(minZ, p.Z); maxZ = math.max(maxZ, p.Z)
	end
	local useX = (maxX - minX) >= (maxZ - minZ)
	local minC = useX and minX or minZ
	local span = math.max(useX and (maxX - minX) or (maxZ - minZ), 0.001)
	for part, info in pairs(accentParts) do
		local c = useX and part.Position.X or part.Position.Z
		info.coord = (c - minC) / span
	end
end

local function addInstance(inst)
	if inst:IsA("BasePart") then
		local _, sat, val = inst.Color:ToHSV()
		accentParts[inst] = { sat = sat, val = val, coord = 0 }
		rebuildCoords()
		scheduleApply()
	elseif inst:IsA("TextLabel") then
		local gradient = inst:FindFirstChildOfClass("UIGradient")
		if gradient then
			textGradients[inst] = gradient
			scheduleApply()
		end
	end
end

for _, inst in ipairs(CollectionService:GetTagged(TAG)) do
	addInstance(inst)
end
CollectionService:GetInstanceAddedSignal(TAG):Connect(addInstance)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(inst)
	if accentParts[inst] then
		accentParts[inst] = nil
		rebuildCoords()
		scheduleApply()
	end
	textGradients[inst] = nil
end)

-- Paint the rainbow ONCE: hue spread left -> right across the booth on the
-- accent parts (original two-tone shading preserved via saved sat/val), and
-- one fixed full-wheel gradient on the title text. No per-frame work at all.
applyStaticRainbow = function()
	for part, info in pairs(accentParts) do
		if part.Parent then
			part.Color = Color3.fromHSV((info.coord * HORIZONTAL_HUE_SPAN) % 1, info.sat, info.val)
		end
	end
	if next(textGradients) then
		local keypoints = table.create(TEXT_KEYPOINTS)
		for i = 1, TEXT_KEYPOINTS do
			local alpha = (i - 1) / (TEXT_KEYPOINTS - 1)
			keypoints[i] = ColorSequenceKeypoint.new(alpha, Color3.fromHSV(alpha % 1, 1, 1))
		end
		local sequence = ColorSequence.new(keypoints)
		for _, gradient in pairs(textGradients) do
			gradient.Color = sequence
		end
	end
end

scheduleApply()
