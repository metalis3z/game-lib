-- FxDistanceCuller: client-side distance gate for always-on DECOR FX.
-- The 30 underground "DestroyPart ZoneN" folders carry 15 Lights + 12
-- ParticleEmitters EACH (torches, glow pads), and Spawn carries ~390 more
-- emitters (training-pad crystals / ore fume) -- ~450 lights and ~750
-- emitters simulating and lighting at ANY distance, all session, no matter
-- where the player stands. Beyond its cull distance this disables them on
-- the local client only; they re-enable well before they could be seen
-- (zones are enclosed rooms -- nothing 200+ studs away is visible).
-- Scope is strictly these decorative subtrees: gameplay-toggled FX
-- (drills, loot drops, player trails, characters) live elsewhere and are
-- never touched. Instances that are Enabled=false at scan time stay owned
-- by whatever authored/toggles them.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local POLL = 0.15
local EMITTER_CULL = 220
local LIGHT_CULL = 260
local HYSTERESIS = 30

-- Zone-geometry culling: Roblox has NO occlusion culling, so every sealed
-- zone room (Assets.Map.ZoneN: ~89 parts + ~670 decals EACH) and every
-- drillable stack folder (workspace["DestroyPart ZoneN"]: 54 parts + 288
-- decals) is submitted to the GPU every frame from anywhere on the map --
-- ~20K decal faces of caves nobody can see. Beyond GEO_CULL the local
-- client hides the whole group via LocalTransparencyModifier (client-only:
-- physics, raycasts, server state and other players untouched). Rooms 300
-- studs away are enclosed caves that cannot be on screen.

local managed = {} -- [inst] = {pos, dist, culled}

local function anchorPosOf(inst)
	local p = inst.Parent
	if p then
		if p:IsA("Attachment") then return p.WorldPosition end
		if p:IsA("BasePart") then return p.Position end
		if p:IsA("Model") then return p:GetPivot().Position end
	end
	local part = inst:FindFirstAncestorWhichIsA("BasePart")
	return part and part.Position or nil
end

local function manage(inst)
	if managed[inst] then return end
	if not (inst:IsA("ParticleEmitter") or inst:IsA("Light") or inst:IsA("Fire") or inst:IsA("Beam")) then return end
	if not inst.Enabled then return end
	local pos
	if inst:IsA("Beam") then
		-- a Beam draws between its attachments regardless of Parent
		local a0 = inst.Attachment0
		pos = (a0 and a0.WorldPosition) or anchorPosOf(inst)
	else
		pos = anchorPosOf(inst)
	end
	if not pos then return end
	managed[inst] = {
		-- zone/spawn decor is anchored & static; position cached once
		pos = pos,
		dist = inst:IsA("Light") and LIGHT_CULL or EMITTER_CULL,
		culled = false,
	}
end

local GEO_CULL = 300
local GEO_HYSTERESIS = 40

local geoGroups = {} -- [root] = {center, parts, fades, sgs, hidden, dirty}

local function applyGeoGroup(g, hidden)
	for _, p in ipairs(g.parts) do
		if p.Parent then
			p.LocalTransparencyModifier = hidden and 1 or 0
		end
	end
	for _, f in ipairs(g.fades) do
		if f.Parent then
			f.LocalTransparencyModifier = hidden and 1 or 0
		end
	end
	for _, e in ipairs(g.sgs) do
		if e.gui.Parent then
			if hidden then
				e.gui.Enabled = false
			else
				e.gui.Enabled = e.enabled
			end
		end
	end
end

local function rebuildGeoGroup(root, g)
	g.dirty = false
	-- Preserve each SurfaceGui's AUTHORED Enabled across rebuilds. While the
	-- group is hidden the live .Enabled is our forced-off value, not the
	-- authored state, so re-reading it here (e.g. the Lbs boards reclone their
	-- entry frames every 30s, flagging the group dirty) would stamp the board
	-- permanently off once the player resurfaces. Re-use the value we captured
	-- the first time we saw this gui; only read .Enabled for gui's we've never
	-- seen before.
	local prevEnabled = {}
	for _, e in ipairs(g.sgs) do
		prevEnabled[e.gui] = e.enabled
	end
	table.clear(g.parts)
	table.clear(g.fades)
	table.clear(g.sgs)
	local sum, n = Vector3.zero, 0
	if root:IsA("BasePart") then
		table.insert(g.parts, root)
		sum += root.Position
		n += 1
	end
	for _, d in ipairs(root:GetDescendants()) do
		if d:IsA("BasePart") then
			table.insert(g.parts, d)
			sum += d.Position
			n += 1
		elseif d:IsA("Decal") or d:IsA("Texture") then
			table.insert(g.fades, d)
		elseif d:IsA("SurfaceGui") then
			local authored = prevEnabled[d]
			if authored == nil then
				authored = d.Enabled
			end
			table.insert(g.sgs, { gui = d, enabled = authored })
		end
	end
	if n > 0 then
		g.center = sum / n
	end
	-- fresh membership (zone reset reclones, drilled layers) must reflect
	-- the current culled state immediately
	applyGeoGroup(g, g.hidden)
end

local function hookGeoRoot(root)
	if geoGroups[root] then return end
	local g = { center = nil, parts = {}, fades = {}, sgs = {}, hidden = false, dirty = true }
	geoGroups[root] = g
	root.DescendantAdded:Connect(function()
		g.dirty = true
	end)
	root.DescendantRemoving:Connect(function(d)
		g.dirty = true
		-- a descendant leaving WHILE hidden (reparented loot/tool) must not
		-- keep the local hide stamped on it forever
		if g.hidden then
			if d:IsA("BasePart") or d:IsA("Decal") or d:IsA("Texture") then
				d.LocalTransparencyModifier = 0
			elseif d:IsA("SurfaceGui") then
				for _, e in ipairs(g.sgs) do
					if e.gui == d then
						d.Enabled = e.enabled
						break
					end
				end
			end
		end
	end)
	root.AncestryChanged:Connect(function(_, parent)
		if not parent then
			geoGroups[root] = nil
		end
	end)
end

local function isManagedRoot(child)
	return child.Name == "Spawn" or child.Name == "THUMB" or child.Name:match("^DestroyPart Zone%d+$") ~= nil
end

-- Zones are RESET by the server (recloned from boot snapshots), so roots and
-- their contents can be replaced mid-session -- hook both levels.
local function hookRoot(root)
	for _, d in ipairs(root:GetDescendants()) do
		manage(d)
	end
	root.DescendantAdded:Connect(function(d)
		-- defer so the authored Enabled state is final before we read it
		task.defer(manage, d)
	end)
	root.DescendantRemoving:Connect(function(d)
		managed[d] = nil
	end)
end

for _, child in ipairs(workspace:GetChildren()) do
	if isManagedRoot(child) then
		hookRoot(child)
		-- THUMB: sealed thumbnail set (822 decals + FX) far from gameplay
		if child.Name == "THUMB" or child.Name:match("^DestroyPart Zone%d+$") then
			hookGeoRoot(child)
		end
	end
end
workspace.ChildAdded:Connect(function(child)
	if isManagedRoot(child) then
		task.defer(function()
			hookRoot(child)
			if child.Name == "THUMB" or child.Name:match("^DestroyPart Zone%d+$") then
				hookGeoRoot(child)
			end
		end)
	end
end)

-- the sealed zone rooms of the map itself
local assetsFolder = workspace:FindFirstChild("Assets")
local mapFolder = assetsFolder and assetsFolder:FindFirstChild("Map")
if mapFolder then
	for _, c in ipairs(mapFolder:GetChildren()) do
		if c.Name:match("^Zone%d+$") then
			hookGeoRoot(c)
		end
	end
	mapFolder.ChildAdded:Connect(function(c)
		if c.Name:match("^Zone%d+$") then
			task.defer(hookGeoRoot, c)
		end
	end)
end

-- ===== surface depth gate =====
-- The surface build (Spawn model, Lbs leaderboards, SpawnBoard, loose
-- Grass/Tree/Flower decor, small ground unions) is OPEN-AIR: plain distance
-- culling could visibly pop it across long surface sightlines. Depth is the
-- safe signal instead -- 100+ studs below ground the player is inside sealed
-- zone rooms and cannot see the surface at all, so the local client hides it
-- (render only: physics, prompts, server state and other players untouched).
-- Startup-only scan -- runtime-added workspace children (loot drops, FX)
-- are never hooked. Roots reaching below ground level are skipped so any
-- structure that could share a sightline with the caves stays rendered.
local SURFACE_HIDE_Y = -80
local SURFACE_SHOW_Y = -50
local SURFACE_ROOT_NAMES = { Spawn = true, Lbs = true, SpawnBoard = true, Grass = true, Tree = true, Flower = true, Model = true }

local surfaceGroups = {} -- [root] = same group shape as geoGroups, toggled by depth
local surfaceHidden = false

local function hookSurfaceRoot(root)
	if surfaceGroups[root] or geoGroups[root] then return end
	local g = { center = nil, parts = {}, fades = {}, sgs = {}, hidden = false, dirty = true }
	surfaceGroups[root] = g
	root.DescendantAdded:Connect(function()
		g.dirty = true
	end)
	root.DescendantRemoving:Connect(function(d)
		g.dirty = true
		if g.hidden then
			if d:IsA("BasePart") or d:IsA("Decal") or d:IsA("Texture") then
				d.LocalTransparencyModifier = 0
			elseif d:IsA("SurfaceGui") then
				for _, e in ipairs(g.sgs) do
					if e.gui == d then
						d.Enabled = e.enabled
						break
					end
				end
			end
		end
	end)
	root.AncestryChanged:Connect(function(_, parent)
		if not parent then
			surfaceGroups[root] = nil
		end
	end)
end

local function rootMinY(c)
	if c:IsA("BasePart") then
		return c.Position.Y - c.Size.Y * 0.5
	end
	local minY
	for _, d in ipairs(c:GetDescendants()) do
		if d:IsA("BasePart") then
			local y = d.Position.Y - d.Size.Y * 0.5
			if not minY or y < minY then
				minY = y
			end
		end
	end
	return minY
end

for _, c in ipairs(workspace:GetChildren()) do
	local eligible = (SURFACE_ROOT_NAMES[c.Name] and (c:IsA("Model") or c:IsA("Folder")))
		or c:IsA("UnionOperation")
	if eligible then
		local minY = rootMinY(c)
		if minY and minY > -40 then
			hookSurfaceRoot(c)
		end
	end
end

local accum = 0
local lastPos = nil
RunService.Heartbeat:Connect(function(dt)
	accum += dt
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	local camera = workspace.CurrentCamera
	local pos = (hrp and hrp.Position) or (camera and camera.CFrame.Position)
	-- per-frame teleport watch: a skip-pad jump between zones must refresh
	-- this very tick -- never show the inside of a still-hidden room
	if pos and lastPos and (pos - lastPos).Magnitude > 80 then
		accum = POLL
	end
	lastPos = pos
	if accum < POLL then return end
	accum = 0
	if not pos then return end
	for inst, entry in pairs(managed) do
		if not inst.Parent then
			managed[inst] = nil
		else
			local d = (entry.pos - pos).Magnitude
			if entry.culled then
				if d <= entry.dist then
					entry.culled = false
					inst.Enabled = true
				end
			else
				if d > entry.dist + HYSTERESIS then
					entry.culled = true
					inst.Enabled = false
				end
			end
		end
	end
	for root, g in pairs(geoGroups) do
		if not root.Parent then
			geoGroups[root] = nil
		else
			if g.dirty then
				rebuildGeoGroup(root, g)
			end
			if g.center then
				local d = (g.center - pos).Magnitude
				if g.hidden then
					if d <= GEO_CULL then
						g.hidden = false
						applyGeoGroup(g, false)
					end
				elseif d > GEO_CULL + GEO_HYSTERESIS then
					g.hidden = true
					applyGeoGroup(g, true)
				end
			end
		end
	end
	-- depth-gated surface hide (see surface depth gate block above)
	if surfaceHidden then
		surfaceHidden = pos.Y < SURFACE_SHOW_Y
	else
		surfaceHidden = pos.Y < SURFACE_HIDE_Y
	end
	for root, g in pairs(surfaceGroups) do
		if not root.Parent then
			surfaceGroups[root] = nil
		else
			if g.dirty then
				rebuildGeoGroup(root, g)
			end
			if g.hidden ~= surfaceHidden then
				g.hidden = surfaceHidden
				applyGeoGroup(g, surfaceHidden)
			end
		end
	end
end)
