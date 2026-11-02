-- Colle les zones d'oeufs les unes aux autres contre la safe zone, les élargit (x1,5 le long du couloir)
-- et resserre le couloir (largeur / 1,2, des deux côtés). return function(dry) : dry = true ne change rien, rend le rapport.
local ZONES = {"common egg zone", "UNcommon forest egg zone", "RARE aquatic egg zone", "EPIC Ice egg zone", "legendary egg zone",
	"Mythic lava egg zone", "SECRET demon egg zone", "Halloween demon egg zone"}
local SX, SZ = 1.5, 1 / 1.2
local V = Vector3.new

return function(dry)
	local ServerStorage = game:GetService("ServerStorage")
	local CollectionService = game:GetService("CollectionService")
	local report = {}
	local function log(s) table.insert(report, s) end

	local function aabb(inst)
		local lo, hi, n = V(1, 1, 1) * math.huge, V(1, 1, 1) * -math.huge, 0
		local function add(p)
			local cf, s = p.CFrame, p.Size / 2
			local e = V(math.abs(cf.RightVector.X) * s.X + math.abs(cf.UpVector.X) * s.Y + math.abs(cf.LookVector.X) * s.Z,
				math.abs(cf.RightVector.Y) * s.X + math.abs(cf.UpVector.Y) * s.Y + math.abs(cf.LookVector.Y) * s.Z,
				math.abs(cf.RightVector.Z) * s.X + math.abs(cf.UpVector.Z) * s.Y + math.abs(cf.LookVector.Z) * s.Z)
			lo, hi, n = lo:Min(cf.Position - e), hi:Max(cf.Position + e), n + 1
		end
		if inst:IsA("BasePart") then add(inst) end
		for _, d in inst:GetDescendants() do if d:IsA("BasePart") then add(d) end end
		return lo, hi, n
	end
	local function shift(inst, delta)
		if inst:IsA("Model") then
			inst:PivotTo(inst:GetPivot() + delta)
		else
			if inst:IsA("BasePart") then inst.CFrame += delta end
			for _, d in inst:GetDescendants() do if d:IsA("BasePart") then d.CFrame += delta end end
		end
	end
	-- change l'étendue d'une pièce le long d'un axe du monde ("X" ou "Z"), si un de ses axes locaux lui est aligné
	local function setRange(part, axis, a, b)
		local cf = part.CFrame
		local world = axis == "X" and V(1, 0, 0) or V(0, 0, 1)
		for _, k in {"X", "Y", "Z"} do
			local dir = k == "X" and cf.RightVector or k == "Y" and cf.UpVector or cf.LookVector
			if math.abs(dir:Dot(world)) > 0.999 then
				local s = part.Size
				part.Size = V(k == "X" and b - a or s.X, k == "Y" and b - a or s.Y, k == "Z" and b - a or s.Z)
				local p = cf.Position
				part.CFrame = cf.Rotation + V(axis == "X" and (a + b) / 2 or p.X, p.Y, axis == "Z" and (a + b) / 2 or p.Z)
				return true
			end
		end
		return false
	end

	---------------------------------------------------------------- repères
	local zones = {}
	for i, name in ZONES do
		local part = workspace:FindFirstChild(name)
		assert(part and part:IsA("BasePart"), "zone not found: " .. name)
		zones[i] = {part = part, cx = part.Position.X, half = part.Size.X / 2}
	end
	local safe = workspace:FindFirstChild("safe zone")
	local CZ = zones[1].part.Position.Z
	local X0 = safe.Position.X + safe.Size.X / 2                 -- bord de la safe zone : la première zone commence là
	local W = zones[1].part.Size.X * SX
	local D = zones[1].part.Size.Z * SZ
	for i, z in zones do z.nx = X0 + W * (i - 0.5) end
	local XEND = X0 + W * #zones
	local ZN, ZS = CZ + D / 2, CZ - D / 2                         -- faces intérieures des murs du couloir
	log(string.format("zones %.2f x %.2f, from X %.1f to %.1f, corridor Z %.1f .. %.1f", W, D, X0, XEND, ZS, ZN))
	local function nearest(x)
		local best
		for _, z in zones do if not best or math.abs(x - z.cx) < math.abs(x - best.cx) then best = z end end
		return best
	end
	local function map(z, p)
		return V(z.nx + math.clamp(p.X - z.cx, -z.half, z.half) * SX, p.Y, CZ + (p.Z - CZ) * SZ)
	end

	---------------------------------------------------------------- ce qui bouge
	local SKIP = {["AnimalModels"] = true, ["safe zone"] = true, ["all base"] = true, ["MapDecor"] = true, ["SafeZoneDecor"] = true, ["HalloweenTheme"] = true,
		["lava realiste"] = true, ["Wall"] = true, ["Part"] = true, ["walls"] = true, ["Dragons"] = true, ["Corridor"] = true}
	local zoneSet = {}
	for _, z in zones do zoneSet[z.part] = true end
	local corridor, lavas, decor, twins = {}, {}, {}, {}
	local themed -- le pan de mur couleur sable de la zone rare
	for _, c in workspace:GetChildren() do
		if zoneSet[c] or c:IsA("Terrain") or c:IsA("Camera") then continue end
		local lo, hi, n = aabb(c)
		if n == 0 then continue end
		local size, mid = hi - lo, (lo + hi) / 2
		if c.Name == "lava realiste" then
			table.insert(lavas, c)
		elseif c.Name == "Model" and c:IsA("Model") and size.X > 3000 then
			table.insert(corridor, c)
		elseif c.Name == "Wall" and c:IsA("BasePart") and mid.X > 400 then
			themed = c
		elseif (c.Name == "hi" or c.Name == "¨hi") and c:IsA("BasePart") then
			table.insert(twins, c) -- copies de la zone légendaire empilées dessous
		elseif not SKIP[c.Name] and mid.X > 62 and hi.Y > -60 and lo.Y < 200 and mid.Z > -400 and mid.Z < 60 then
			table.insert(decor, c)
		end
	end
	local lamps = workspace.HalloweenTheme:FindFirstChild("ZoneLamps")
	for _, c in lamps and lamps:GetChildren() or {} do table.insert(decor, c) end
	-- près de la porte de la safe zone : ce qui est dans la bande du couloir suit seulement le resserrement
	local door = {}
	for _, root in {workspace.MapDecor, workspace.HalloweenTheme, workspace.SafeZoneDecor} do
		for _, c in root:GetDescendants() do
			local nested, up = false, c.Parent -- seulement les objets entiers, pas leurs morceaux
			while up and up ~= root do
				if up:IsA("Model") or up:IsA("BasePart") or up == lamps then nested = true end
				up = up.Parent
			end
			if (c:IsA("Model") or c:IsA("BasePart")) and not nested then
				local lo, hi, n = aabb(c)
				local mid = (lo + hi) / 2
				if n > 0 and mid.X > X0 - 4 and mid.X < 62 and mid.Z > CZ - 128 and mid.Z < CZ + 128 then table.insert(door, c) end
			end
		end
	end
	log(#decor .. " decor objects, " .. #corridor .. " corridor models, " .. #lavas .. " lava models, " .. #twins .. " zone twins, " .. #door .. " door objects, themed wall=" .. tostring(themed ~= nil))
	local perZone = {}
	for _, c in decor do
		local lo, hi = aabb(c)
		local z = nearest((lo.X + hi.X) / 2)
		local key = z.part.Name
		perZone[key] = perZone[key] or {}
		table.insert(perZone[key], c.Name .. (math.abs((lo.X + hi.X) / 2 - z.cx) > z.half + 5 and "(far " .. math.round((lo.X + hi.X) / 2 - z.cx) .. ")" or ""))
	end
	for _, name in ZONES do
		local list = perZone[name] or {}
		local counts, order = {}, {}
		for _, n in list do if not counts[n] then counts[n] = 0 table.insert(order, n) end counts[n] += 1 end
		local s = {}
		for _, n in order do table.insert(s, n .. (counts[n] > 1 and " x" .. counts[n] or "")) end
		log("  " .. name .. ": " .. table.concat(s, ", "))
	end
	local ds = {}
	for _, c in door do local lo, hi = aabb(c) table.insert(ds, string.format("%s(%.0f,%.0f)", c.Name, (lo.X + hi.X) / 2, (lo.Z + hi.Z) / 2)) end
	log("  door: " .. table.concat(ds, " "))
	if dry then return table.concat(report, "\n") end

	---------------------------------------------------------------- sauvegarde
	local backup = Instance.new("Folder")
	backup.Name = "MapBackup_BeforeCompact"
	local function keep(inst, label)
		local copy = inst:Clone()
		copy:SetAttribute("BackupOf", label or inst:GetFullName())
		copy.Parent = backup
	end
	for _, z in zones do keep(z.part) end
	for _, c in decor do keep(c) end
	task.wait()
	for _, c in twins do keep(c) end
	for _, c in door do keep(c) end
	for _, c in workspace:GetChildren() do if c.Name == "Wall" and c:IsA("BasePart") then keep(c) end end
	backup.Parent = ServerStorage
	local removed = Instance.new("Folder") -- l'ancien couloir et la lave en trop : retirés de la carte, gardés ici
	removed.Name = "Removed"
	removed.Parent = backup
	task.wait()

	---------------------------------------------------------------- décor : chaque objet suit sa zone
	local moved, resized = 0, 0
	local function place(inst, z)
		local lo, hi, n = aabb(inst)
		if n == 0 then return end
		local size, mid = hi - lo, (lo + hi) / 2
		local big = size.X > 40 or size.Z > 70
		local kids = {}
		for _, k in inst:GetChildren() do if (k:IsA("BasePart") or k:IsA("Model") or k:IsA("Folder")) and select(3, aabb(k)) > 0 then table.insert(kids, k) end end
		if big and #kids >= 2 and not inst:IsA("BasePart") then
			for _, k in kids do place(k, z) end -- un grand ensemble : chaque morceau est replacé séparément
			return
		end
		if big and inst:IsA("BasePart") and #kids == 0 then -- une grande dalle : elle s'étire et se resserre comme la zone
			local target = map(z, mid)
			local okX = size.X > 40 and setRange(inst, "X", target.X - size.X * SX / 2, target.X + size.X * SX / 2)
			local okZ = size.Z > 70 and setRange(inst, "Z", target.Z - size.Z * SZ / 2, target.Z + size.Z * SZ / 2)
			local p = inst.Position
			inst.CFrame = inst.CFrame.Rotation + V(target.X, p.Y, target.Z)
			if okX or okZ then resized += 1 end
			moved += 1
			return
		end
		shift(inst, map(z, mid) - mid)
		moved += 1
	end
	for i, c in decor do
		local lo, hi = aabb(c)
		place(c, nearest((lo.X + hi.X) / 2))
		if i % 15 == 0 then task.wait() end
	end
	-- zones : nouvelle place, nouvelle taille ; les pièces rangées dedans suivent
	local legendary = zones[5]
	for _, z in zones do
		local part = z.part
		for _, k in part:GetChildren() do if k:IsA("BasePart") or k:IsA("Model") then place(k, z) end end
		part.Size = V(W, part.Size.Y, D)
		part.CFrame = part.CFrame.Rotation + V(z.nx, part.Position.Y, CZ)
	end
	for _, t in twins do
		for _, k in t:GetChildren() do if k:IsA("BasePart") or k:IsA("Model") then place(k, legendary) end end
		t.Size = V(W, t.Size.Y, D)
		t.CFrame = t.CFrame.Rotation + V(legendary.nx, t.Position.Y, CZ)
	end
	for _, c in door do
		local lo, hi = aabb(c)
		local mid = (lo + hi) / 2
		shift(c, V(0, 0, (CZ + (mid.Z - CZ) * SZ) - mid.Z))
	end
	log("moved " .. moved .. " objects, resized " .. resized .. " slabs")
	task.wait()

	---------------------------------------------------------------- couloir : murs neufs à la bonne longueur
	local function sample(test)
		for _, m in corridor do for _, p in m:GetChildren() do if p:IsA("BasePart") and test(p) then return p end end end
	end
	local wallSample = sample(function(p) return p.Transparency == 0 and p.Size.Y > 60 and p.Position.Y > 0 end)
	local trimSample = sample(function(p) return p.Transparency == 0 and p.Size.Y < 10 end)
	local ghostSample = sample(function(p) return p.Transparency == 1 end)
	assert(wallSample and ghostSample, "corridor samples not found")
	local T = wallSample.Size.X -- épaisseur des murs
	local X1 = X0 + T          -- après l'épaisseur du mur de la safe zone
	local shell = Instance.new("Model")
	shell.Name = "Corridor"
	local function wall(src, name, lo, hi)
		local p = src:Clone()
		p.Name = name
		p.Size = hi - lo
		p.CFrame = CFrame.new((lo + hi) / 2)
		p.Parent = shell
		return p
	end
	local top = wallSample.Position.Y + wallSample.Size.Y / 2
	local bottom = top - wallSample.Size.Y
	for _, side in {{"North", ZN, ZN + T}, {"South", ZS - T, ZS}} do
		wall(wallSample, side[1] .. "Wall", V(X1, bottom, side[2]), V(XEND + T, top, side[3]))
		wall(wallSample, side[1] .. "WallLow", V(X1, bottom - 60, side[2]), V(XEND + T, bottom, side[3]))
		if trimSample then wall(trimSample, side[1] .. "Trim", V(X1, top + 0.5, side[2]), V(XEND + T, top + 3.5, side[3])) end
		wall(ghostSample, side[1] .. "Barrier", V(X0, top - 29, side[2]), V(XEND + T, top + 79, side[3]))
	end
	wall(wallSample, "EndWall", V(XEND, bottom, ZS), V(XEND + T, top, ZN))
	wall(wallSample, "EndWallLow", V(XEND, bottom - 60, ZS), V(XEND + T, bottom, ZN))
	if trimSample then wall(trimSample, "EndTrim", V(XEND, top + 0.5, ZS), V(XEND + T, top + 3.5, ZN)) end
	wall(ghostSample, "EndBarrier", V(XEND, top - 29, ZS), V(XEND + T, top + 79, ZN))
	wall(ghostSample, "Ceiling", V(X0, top + 5, ZS - T), V(XEND + T, top + 113, ZN + T))
	shell.Parent = workspace
	for _, m in corridor do m.Parent = removed end
	-- le pan de mur couleur sable suit la zone rare (un peu plus épais que le mur neuf, pour le couvrir)
	if themed then
		local z = zones[3]
		local north = themed.Position.Z > CZ
		themed.Size = V(W, themed.Size.Y + 0.4, T + 0.4)
		themed.CFrame = CFrame.new(z.nx, themed.Position.Y, north and ZN + T / 2 or ZS - T / 2)
	end
	-- la porte de la safe zone se resserre comme le couloir
	local doorFixed = 0
	for _, c in workspace:GetChildren() do
		if c.Name == "Wall" and c:IsA("BasePart") and c ~= themed then
			local lo, hi = aabb(c)
			if math.abs((lo.X + hi.X) / 2 - (X0 + T / 2)) < 6 and hi.X - lo.X < T + 4 then
				if lo.Z < ZS and hi.Z < CZ then
					if setRange(c, "Z", lo.Z, ZS) then doorFixed += 1 end
				elseif hi.Z > ZN and lo.Z > CZ then
					if setRange(c, "Z", ZN, hi.Z) then doorFixed += 1 end
				end
			end
		end
	end
	log("door walls adjusted: " .. doorFixed)
	-- lave : seulement sous le couloir qui reste
	local trimmed, gone = 0, 0
	for _, model in lavas do
		for _, p in model:GetDescendants() do
			if p:IsA("BasePart") then
				local lo, hi = aabb(p)
				if lo.X >= XEND + T then
					p.Parent = removed
					gone += 1
				elseif hi.X > XEND + T then
					setRange(p, "X", lo.X, XEND + T)
					trimmed += 1
				end
			end
		end
		if #model:GetDescendants() == 0 then model.Parent = removed end
	end
	log("lava: " .. gone .. " parts removed, " .. trimmed .. " trimmed")
	return table.concat(report, "\n")
end
