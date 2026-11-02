-- Outil d'édition (pas utilisé en jeu) : refait l'enclos des jardins de Workspace["all base"].
--   clôture à trois lisses, poteaux bruns coiffés de pierre lilas (en bas et en haut)
--   devant : une seule travée de chaque côté, l'entrée prend toute la largeur entre les deux
--   le jardin est surélevé (RAISE) : on y monte par trois rangs de planches empilées (Steps)
-- Les originaux sont dans ServerStorage.AllBase_BeforeGardenStyle. return function() -> rapport. Une base déjà refaite est sautée.
local ServerStorage = game:GetService("ServerStorage")

local RAISE = 1.2                 -- hauteur du jardin au-dessus du sol
local POST_HEIGHT = 6.0
local RAILS = {2.0, 3.4, 4.8}     -- hauteur des trois lisses au-dessus du sol
local STEP_DEPTH = 1.6            -- profondeur d'une marche
local rgb = Color3.fromRGB
local POST, RAIL, STONE = rgb(122, 78, 48), rgb(150, 96, 58), rgb(176, 160, 226)
local PLANKS = {rgb(170, 112, 62), rgb(146, 92, 50), rgb(188, 132, 80)}
local DIRT, GRASS = rgb(124, 82, 50), rgb(104, 196, 62)

local function studs(p)
	p.Material = Enum.Material.Plastic
	pcall(function() p.MaterialVariant = "Studs" end)
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
end
local function block(parent, name, size, cf, color)
	local p = Instance.new("Part")
	p.Name = name
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Anchored = true
	studs(p)
	p.Parent = parent
	return p
end

local function stylePost(post, ground)
	post.Size = Vector3.new(1.1, POST_HEIGHT, 1.1)
	post.CFrame = CFrame.new(post.Position.X, ground + POST_HEIGHT / 2 - 0.1, post.Position.Z) * post.CFrame.Rotation
	post.Color = POST
	studs(post)
	local flat = CFrame.new(post.Position.X, 0, post.Position.Z) * post.CFrame.Rotation
	block(post.Parent, "PostCap", Vector3.new(1.7, 1.0, 1.7), flat + Vector3.new(0, ground + 0.5, 0), STONE)
	block(post.Parent, "PostCap", Vector3.new(1.5, 0.7, 1.5), flat + Vector3.new(0, ground + POST_HEIGHT + 0.2, 0), STONE)
end

local function styleRails(model, ground)
	local rails = {}
	for _, p in model:GetChildren() do if p.Name == "Rail" then table.insert(rails, p) end end
	if #rails == 0 then return end
	table.sort(rails, function(a, b) return a.Position.Y < b.Position.Y end)
	for i = #rails + 1, #RAILS do
		local copy = rails[1]:Clone()
		copy.Parent = model
		rails[i] = copy
	end
	for i, rail in rails do
		local size = rail.Size
		local longest = math.max(size.X, size.Y, size.Z)
		rail.Size = Vector3.new(size.X == longest and longest or 0.7, size.Y == longest and longest or 0.7, size.Z == longest and longest or 0.7)
		rail.CFrame = CFrame.new(rail.Position.X, ground + (RAILS[i] or RAILS[#RAILS]), rail.Position.Z) * rail.CFrame.Rotation
		rail.Color = RAIL
		studs(rail)
	end
end

local function build(base)
	if base:GetAttribute("GardenStyle") == 2 then return "skipped" end
	local front, back, left, right = base:FindFirstChild("Front"), base:FindFirstChild("Back"), base:FindFirstChild("Left"), base:FindFirstChild("Right")
	local floor, zone = base:FindFirstChild("Floor"), base:FindFirstChild("animaux")
	if not (front and back and left and right and floor and zone) then return "missing parts" end
	local dir = ((back:GetPivot().Position - front:GetPivot().Position) * Vector3.new(1, 0, 1)).Unit -- vers le fond du jardin
	local ground = floor.Position.Y + floor.Size.Y / 2

	-- côtés et fond : mêmes poteaux, trois lisses
	for _, model in {left, right, back} do
		for _, p in model:GetChildren() do if p.Name == "Post" then stylePost(p, ground) end end
		styleRails(model, ground)
	end

	-- devant : on garde les deux poteaux de chaque bout, l'entrée prend tout le milieu
	local posts = {}
	for _, p in front:GetChildren() do
		if p.Name == "Post" then table.insert(posts, p) elseif p.Name == "Rail" then p:Destroy() end
	end
	local across = Vector3.new(-dir.Z, 0, dir.X)
	table.sort(posts, function(a, b) return a.Position:Dot(across) < b.Position:Dot(across) end)
	for i = 3, #posts - 2 do posts[i]:Destroy() end
	local kept = {posts[1], posts[2], posts[#posts - 1], posts[#posts]}
	for _, p in kept do stylePost(p, ground) end
	for _, pair in {{kept[1], kept[2]}, {kept[3], kept[4]}} do
		local a, b = pair[1].Position, pair[2].Position
		local mid = (a + b) / 2
		local length = ((b - a) * Vector3.new(1, 0, 1)).Magnitude
		for _, h in RAILS do
			local at = Vector3.new(mid.X, ground + h, mid.Z)
			block(front, "Rail", Vector3.new(length, 0.7, 0.7), CFrame.lookAt(at, at + dir), RAIL) -- la longueur (X) suit la clôture
		end
	end

	-- jardin surélevé : le sol (Floor) devient un massif de terre, l'herbe (animaux) est posée dessus
	local function footprint(part) -- longueur (vers le fond) et largeur d'une pièce posée à plat
		local axis = part.CFrame:VectorToObjectSpace(dir)
		if math.abs(axis.X) > 0.5 then return part.Size.X, part.Size.Z, true end
		return part.Size.Z, part.Size.X, false
	end
	local zoneLong, zoneWide, zoneAlongX = footprint(zone)
	local floorLong, _, floorAlongX = footprint(floor)
	local long = math.min(zoneLong, floorLong)
	local centre = floor.Position
	floor.Size = floorAlongX and Vector3.new(long, RAISE + 0.4, zoneWide) or Vector3.new(zoneWide, RAISE + 0.4, long)
	floor.CFrame = CFrame.new(centre.X, ground + RAISE - floor.Size.Y / 2, centre.Z) * floor.CFrame.Rotation
	floor.Transparency, floor.Color = 0, DIRT
	studs(floor)
	zone.Size = zoneAlongX and Vector3.new(long - 1.2, zone.Size.Y, zoneWide - 1.2) or Vector3.new(zoneWide - 1.2, zone.Size.Y, long - 1.2)
	zone.CFrame = CFrame.new(centre.X, ground + RAISE + zone.Size.Y / 2 + 0.01, centre.Z) * zone.CFrame.Rotation
	zone.Color = GRASS

	-- marches : trois rangs de planches empilées devant l'entrée, du sol jusqu'au jardin
	local old = base:FindFirstChild("Steps")
	if old then old:Destroy() end
	local steps = Instance.new("Model")
	steps.Name = "Steps"
	local entryMid = (kept[2].Position + kept[3].Position) / 2
	local width = ((kept[3].Position - kept[2].Position) * Vector3.new(1, 0, 1)).Magnitude - 2.0
	local edge = centre - dir * (long / 2) -- bord avant du massif
	local origin = Vector3.new(entryMid.X, ground, entryMid.Z) + dir * ((edge - entryMid):Dot(dir))
	local frame = CFrame.lookAt(origin, origin - dir) -- −Z vers l'extérieur, X le long de l'entrée
	local layer = RAISE / 3
	local rng = Random.new(11)
	for k = 1, 3 do
		local boards = (4 - k) * 2 -- deux planches par marche
		local depth = STEP_DEPTH / 2
		for b = 1, boards do
			local split = rng:NextNumber(0.3, 0.7) -- chaque rang de planches est coupé à un endroit différent
			local z = -(b - 0.5) * depth
			local y = (k - 0.5) * layer
			local a, c = width * split, width * (1 - split)
			local color = PLANKS[(b + k) % 3 + 1]
			local p1 = block(steps, "Plank", Vector3.new(a - 0.12, layer, depth - 0.06), frame * CFrame.new(-width / 2 + a / 2, y, z), color)
			local p2 = block(steps, "Plank", Vector3.new(c - 0.12, layer, depth - 0.06), frame * CFrame.new(width / 2 - c / 2, y, z), PLANKS[(b + k + 1) % 3 + 1])
			p1.CanCollide, p2.CanCollide = false, false
		end
	end
	-- on marche sur une rampe invisible : la montée est douce
	local run = STEP_DEPTH * 3
	local ramp = Instance.new("WedgePart")
	ramp.Name = "Ramp"
	ramp.Size = Vector3.new(width, RAISE, run)
	ramp.CFrame = frame * CFrame.new(0, RAISE / 2, -run / 2)
	ramp.Transparency = 1
	ramp.Anchored, ramp.CanQuery, ramp.CastShadow = true, false, false
	ramp.Parent = steps
	steps.Parent = base
	base:SetAttribute("GardenStyle", 2)
	return "ok"
end

return function()
	local bases = workspace:WaitForChild("all base")
	if not ServerStorage:FindFirstChild("AllBase_BeforeGardenStyle") then
		local backup = bases:Clone()
		backup.Name = "AllBase_BeforeGardenStyle"
		backup.Parent = ServerStorage
	end
	local report = {}
	for _, base in bases:GetChildren() do
		if base:IsA("Model") or base:IsA("Folder") then
			table.insert(report, base.Name .. ": " .. build(base))
			task.wait()
		end
	end
	return table.concat(report, "\n")
end
