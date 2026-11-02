-- BillboardStrokeScaler: distance-matched UIStroke thickness for world-space
-- billboard cards. Everything carrying the "DistanceScaledStrokes" tag is
-- handled -- the tag is authored on StarterGui.PodiumBillboard (so every
-- runtime clone of it inherits the tag), the static pedestal price/timer
-- signs (DevProductN), and the OverheadStatServer head tags (tagged
-- server-side at build). Ported from "+1 Kick Door Per Click" 2026-07-21.
--
-- Why: these BillboardGuis are sized in STUDS, so the card and its
-- TextScaled text shrink on screen as the camera moves away -- but
-- UIStroke.Thickness is SCREEN PIXELS and never changes. Zoomed out, the
-- authored ~3px outlines swallow the shrinking glyphs and neighbouring
-- digits' outlines merge into a single blob.
--
-- Fix: scale each stroke by the billboard's CURRENT on-screen size. The
-- factor caps at 1, so at close/normal range the cards render exactly as
-- authored; past the reference density the strokes thin out in proportion
-- with the text.
--
-- Plays nice with UiStrokeScaler (resolution scaling of PlayerGui strokes):
-- world billboards live under Workspace parts/attachments, never PlayerGui.

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local TAG = "DistanceScaledStrokes"

-- on-screen pixels per billboard stud at the reference range (~20 studs on
-- a 1080p screen); at or above this density the authored thickness holds
local REF_PX_PER_STUD = 36

local registered = {} -- [BillboardGui] = { strokes = {[UIStroke]=baseThickness}, lastQ = number?, conn = RBXScriptConnection? }

-- AnimatedText's per-char overlay strokes are CLONES of the label's own
-- stroke and mirror its thickness live (AnimatedText owns them); they live
-- under the AT_Ignore-flagged overlay frame, so anything below one is
-- skipped here -- scaling a clone whose base is already scaled would thin
-- it twice.
local function underAnimatedTextOverlay(inst, billboard)
	local node = inst.Parent
	while node and node ~= billboard do
		if node:GetAttribute("AT_Ignore") then return true end
		node = node.Parent
	end
	return false
end

local function register(billboard)
	if registered[billboard] then return end
	-- defer so registration happens after the owning controller has finished
	-- configuring the freshly-parented clone
	task.defer(function()
		if registered[billboard] or not billboard.Parent then return end
		local info = { strokes = {} }
		registered[billboard] = info
		local function addStroke(d)
			if d:IsA("UIStroke") and info.strokes[d] == nil and not underAnimatedTextOverlay(d, billboard) then
				info.strokes[d] = d.Thickness
				info.lastQ = nil -- force a rewrite so the new stroke scales now
			end
		end
		for _, d in ipairs(billboard:GetDescendants()) do
			addStroke(d)
		end
		-- server-built overheads replicate their descendants AFTER the tag
		-- signal fires on the client, so strokes are collected live, not once
		info.conn = billboard.DescendantAdded:Connect(addStroke)
	end)
end

CollectionService:GetInstanceAddedSignal(TAG):Connect(function(inst)
	if inst:IsA("BillboardGui") then register(inst) end
end)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(inst)
	local info = registered[inst]
	if info and info.conn then info.conn:Disconnect() end
	registered[inst] = nil
end)
for _, inst in ipairs(CollectionService:GetTagged(TAG)) do
	if inst:IsA("BillboardGui") then register(inst) end
end

RunService.Heartbeat:Connect(function()
	for billboard, info in pairs(registered) do
		if not billboard.Parent then
			if info.conn then info.conn:Disconnect() end
			registered[billboard] = nil
		-- the un-adorned StarterGui/PlayerGui TEMPLATE is tagged too; never
		-- write to it, or clones taken from it would inherit shrunken strokes
		elseif billboard.Adornee or billboard:IsDescendantOf(workspace) then
			local absY = billboard.AbsoluteSize.Y
			local studsY = billboard.Size.Y.Scale
			if absY > 0 and studsY > 0 then
				local factor = math.min(1, absY / (studsY * REF_PX_PER_STUD))
				-- quantized so far-away cards (which barely change frame to
				-- frame) don't rewrite ~8 stroke properties every Heartbeat
				local q = math.floor(factor * 32 + 0.5) / 32
				if q ~= info.lastQ then
					info.lastQ = q
					for stroke, base in pairs(info.strokes) do
						if stroke.Parent then
							stroke.Thickness = base * q
						end
					end
				end
			end
		end
	end
end)
