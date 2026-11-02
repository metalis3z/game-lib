-- BillboardVisibility
-- Distance-culls every BillboardGui in workspace and animates entry/exit with a
-- subtle bouncy scale. Owns rendering visibility (Enabled toggles) so individual
-- controllers that set MaxDistance = 0 ("always show") still respect distance here.
--
-- Per-billboard overrides:
--   Attribute "ViewDistance" (number, studs)   -> custom show range
--   Attribute "NoDistanceCull" (bool, true)    -> opt out, always shown

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Distances (user spec 2026-07-17): LOBBY billboards (ore pads, booths,
-- pedestals, placed blocks) show from far across the hub -- the old 55-stud
-- default made them vanish a few steps away. Only the SPAWNED zone-loot
-- overheads keep a short range (~150 concurrent drops; see LOOT below).
local DEFAULT_VIEW_DISTANCE = 160
local MAX_AUTHORED_DISTANCE = 220
local LOOT_VIEW_DISTANCE = 100 -- billboards attributed RarityLootBillboard
local POLL_INTERVAL = 0.08
local HYSTERESIS = 4
-- Engine-cull margin past the scripted hide threshold: the native
-- MaxDistance cut is instant (no pop-out anim), so it sits far enough past
-- the UIScale cull that the hard cut can never be seen happening.
local ENGINE_CULL_MARGIN = 15

local SCALE_IN  = TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local SCALE_OUT = TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.In)

local tracked = {}

local function getAnchorPosition(billboard)
	local adornee = billboard.Adornee
	if adornee then
		if adornee:IsA("BasePart") then return adornee.Position end
		if adornee:IsA("Attachment") then return adornee.WorldPosition end
		if adornee:IsA("Model") then return adornee:GetPivot().Position end
	end
	local parent = billboard.Parent
	if parent then
		if parent:IsA("BasePart") then return parent.Position end
		if parent:IsA("Attachment") then return parent.WorldPosition end
		if parent:IsA("Model") then return parent:GetPivot().Position end
	end
	return nil
end

-- The authored MaxDistance is resolved ONCE per billboard (entry.baseViewDist)
-- because track() then OVERWRITES MaxDistance with the capped engine-cull
-- range -- re-reading it every poll would feed our own write back in and
-- creep the range upward.
local function getViewDistance(billboard, entry)
	local attr = billboard:GetAttribute("ViewDistance")
	if typeof(attr) == "number" and attr > 0 then
		return attr
	end
	return (entry and entry.baseViewDist) or DEFAULT_VIEW_DISTANCE
end

-- Force every GuiObject inside a billboard to AnchorPoint (0.5, 0.5),
-- compensating Position so the visual placement is unchanged. Per-instance
-- BillboardCenteringApplied attribute guards against re-running on clones we've
-- already touched (or controllers that re-parent the same billboard repeatedly).
local function normalizeAnchors(billboard)
	if billboard:GetAttribute("BillboardCenteringApplied") then return end
	billboard:SetAttribute("BillboardCenteringApplied", true)
	for _, desc in ipairs(billboard:GetDescendants()) do
		if desc:IsA("GuiObject") then
			local a = desc.AnchorPoint
			if a.X ~= 0.5 or a.Y ~= 0.5 then
				local sz = desc.Size
				local pos = desc.Position
				local dx = 0.5 - a.X
				local dy = 0.5 - a.Y
				desc.Position = UDim2.new(
					pos.X.Scale + sz.X.Scale * dx,
					pos.X.Offset + sz.X.Offset * dx,
					pos.Y.Scale + sz.Y.Scale * dy,
					pos.Y.Offset + sz.Y.Offset * dy
				)
				desc.AnchorPoint = Vector2.new(0.5, 0.5)
			end
		end
	end
end

-- Wrap all of a billboard's direct GUI children in a single centered Frame so
-- that the visibility UIScale (parented inside this wrapper) scales the entire
-- billboard content around its own center instead of the BillboardGui's
-- top-left origin. Without this wrapper, UIScale.Scale=0 collapses every child
-- toward (0,0) of the billboard region -- which is at one corner relative to
-- the adornee -- so the pop-in animation appears to grow out of the corner.
-- One-shot per BillboardGui via the BillboardCenterWrapped guard attribute.
local function wrapInCenteringHost(billboard)
	if billboard:GetAttribute("BillboardCenterWrapped") then
		return billboard:FindFirstChild("_CenterHost")
	end
	billboard:SetAttribute("BillboardCenterWrapped", true)

	local host = Instance.new("Frame")
	host.Name = "_CenterHost"
	host.AnchorPoint = Vector2.new(0.5, 0.5)
	host.Position = UDim2.new(0.5, 0, 0.5, 0)
	host.Size = UDim2.new(1, 0, 1, 0)
	host.BackgroundTransparency = 1
	host.BorderSizePixel = 0
	host.ZIndex = 0

	-- Re-parent everything except the new host (and any prior VisibilityScale)
	-- into the host. Layout helpers (UIListLayout, UIAspectRatioConstraint,
	-- UIPadding, ...) move with the children so the existing arrangement is
	-- preserved -- the host has Size (1,0,1,0) so the constraint envelope is
	-- identical to the BillboardGui's.
	for _, child in ipairs(billboard:GetChildren()) do
		if child ~= host and child.Name ~= "VisibilityScale" then
			child.Parent = host
		end
	end

	host.Parent = billboard
	return host
end

local function track(billboard)
	if tracked[billboard] then return end
	if billboard:GetAttribute("NoDistanceCull") == true then return end

	normalizeAnchors(billboard)
	local host = wrapInCenteringHost(billboard)

	-- Park the UIScale INSIDE the centered host so scaling pivots around the
	-- host's (and thus the billboard's) center instead of the BillboardGui's
	-- top-left origin. Falls back to the billboard itself if the host couldn't
	-- be created for some reason.
	local scaleParent = host or billboard
	local scale = scaleParent:FindFirstChild("VisibilityScale")
	if not scale then
		-- Migrate any pre-existing UIScale that was previously parented to the
		-- BillboardGui (from an earlier session before this fix landed).
		local stale = billboard:FindFirstChild("VisibilityScale")
		if stale and stale ~= scaleParent then
			stale:Destroy()
		end
		scale = Instance.new("UIScale")
		scale.Name = "VisibilityScale"
		scale.Scale = 0
		scale.Parent = scaleParent
	end

	-- We drive visibility ONLY via the UIScale. We deliberately do NOT touch
	-- billboard.Enabled here, so per-billboard owners (e.g. PodiumController
	-- hiding the CashPodium on empty pads) keep full authority over Enabled.

	local entry = {
		scale = scale,
		state = "out",
		tween = nil,
		baseViewDist = nil, -- resolved in the deferred block below
	}
	tracked[billboard] = entry

	-- Native engine cull on TOP of the scripted UIScale cull: a scaled-to-0
	-- billboard is invisible but still Enabled, so the engine kept processing
	-- every tracked billboard at ANY distance (~150 loot drops across the 30
	-- zones, placed blocks, overhead tags...). Capping MaxDistance makes the
	-- engine skip them entirely past the scripted range. Deferred so the
	-- OWNER's authored MaxDistance (often 0 = infinite) is read after its
	-- creation block finishes, THEN overwritten with the capped range.
	task.defer(function()
		if tracked[billboard] ~= entry or not billboard.Parent then return end
		if billboard:GetAttribute("RarityLootBillboard") then
			-- spawned zone loot: deliberately short (user spec)
			entry.baseViewDist = LOOT_VIEW_DISTANCE
		else
			-- honor a sane authored MaxDistance, but cap it so the legacy
			-- ~490-stud shop billboards aren't visible from across the map
			local m = billboard.MaxDistance
			if m and m > 0 and m < 9999 then
				entry.baseViewDist = math.min(m, MAX_AUTHORED_DISTANCE)
			else
				entry.baseViewDist = DEFAULT_VIEW_DISTANCE
			end
		end
		local function applyEngineCull()
			billboard.MaxDistance = getViewDistance(billboard, entry) + HYSTERESIS + ENGINE_CULL_MARGIN
		end
		applyEngineCull()
		billboard:GetAttributeChangedSignal("ViewDistance"):Connect(applyEngineCull)
	end)

	billboard.AncestryChanged:Connect(function(_, parent)
		if not parent then
			if entry.tween then entry.tween:Cancel() end
			tracked[billboard] = nil
		end
	end)
end

local function untrack(billboard)
	local entry = tracked[billboard]
	if not entry then return end
	if entry.tween then entry.tween:Cancel() end
	tracked[billboard] = nil
end

local function tweenScale(entry, target, info)
	if entry.tween then entry.tween:Cancel() end
	local tween = TweenService:Create(entry.scale, info, { Scale = target })
	entry.tween = tween
	tween:Play()
	return tween
end

local function enter(billboard, entry)
	if entry.state == "in" then return end
	entry.state = "in"
	tweenScale(entry, 1, SCALE_IN)
end

local function exit(_billboard, entry)
	if entry.state == "out" then return end
	entry.state = "out"
	tweenScale(entry, 0, SCALE_OUT)
end

-- Scan + watch workspace only. StarterGui/StarterPlayer copies are templates
-- that never render directly; controllers clone them into workspace as needed.
for _, desc in ipairs(workspace:GetDescendants()) do
	if desc:IsA("BillboardGui") then track(desc) end
end
workspace.DescendantAdded:Connect(function(d)
	if d:IsA("BillboardGui") then track(d) end
end)
workspace.DescendantRemoving:Connect(function(d)
	if d:IsA("BillboardGui") then untrack(d) end
end)

local accum = 0
RunService.Heartbeat:Connect(function(dt)
	accum = accum + dt
	if accum < POLL_INTERVAL then return end
	accum = 0

	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local playerPos = hrp.Position

	for billboard, entry in pairs(tracked) do
		if billboard.Parent then
			local anchor = getAnchorPosition(billboard)
			if anchor then
				local viewDist = getViewDistance(billboard, entry)
				local d = (anchor - playerPos).Magnitude
				-- Hysteresis: leaving needs a few extra studs past the entry threshold
				-- so a player loitering on the boundary doesn't flicker.
				if entry.state == "in" then
					if d > viewDist + HYSTERESIS then exit(billboard, entry) end
				else
					if d <= viewDist then enter(billboard, entry) end
				end
			end
		end
	end
end)
