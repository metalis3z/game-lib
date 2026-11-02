-- Outil d'édition (pas utilisé en jeu) : change la longueur des zones d'œufs SANS reconstruire la carte.
--   require(game.ServerStorage.ZoneStretcher).run(0.2, true)  -> rapport (true = on applique ; false = on calcule seulement)
-- grow = de combien chaque zone est plus longue que la précédente, en part de la première : 0.2 -> x1, x1,2, x1,4 ... x3,2.
-- (relancer avec 0.1 remet l'ancienne carte : x1, x1,1 ... x2,1)
-- Comment : une "règle" relie chaque ancienne position X à la nouvelle. La zone 1 ne bouge pas ; chaque zone s'étire de son
-- facteur ; les bandes entre deux zones gardent leur largeur ; tout ce qui est après la dernière zone recule d'autant.
--   * les grandes pièces alignées sur X (sols des zones, plateaux, murs du couloir) : leurs deux bouts suivent la règle (étirées)
--   * tout le reste (décors, coulées de lave, golem, séparateurs...) : déplacé avec son centre, sans être déformé
--   * la forêt de l'intro (ReplicatedStorage.IntroForest) recule comme le fond de la carte
-- Rien dans la safe zone ni l'arène du boss (en hauteur) ni la ville détruite n'est touché.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local M = {}
local FIRST_W = 150.73
local SPAN_MIN = 60 -- une pièce plus longue que ça sur X (et alignée sur X) est étirée au lieu d'être déplacée
local SKIP = {BossArena = true, DestroyedCity = true, ["all base"] = true, AnimalModels = true, ["safe zone"] = true, ["all wall"] = true, walls = true}

local function zones()
	local list = {}
	for _, p in workspace:GetChildren() do
		if p:IsA("BasePart") and string.find(string.lower(p.Name), "egg zone") then table.insert(list, p) end
	end
	table.sort(list, function(a, b) return a.Position.X < b.Position.X end)
	return list
end

-- la règle : morceaux (ancien début, ancienne fin, nouveau début, facteur)
local function buildMap(grow)
	local list = zones()
	local segs = {}
	local cursor -- nouveau début de la zone en cours
	for i, z in list do
		local s, e = z.Position.X - z.Size.X / 2, z.Position.X + z.Size.X / 2
		if i == 1 then cursor = s end
		local w = FIRST_W * (1 + grow * (i - 1))
		if i == 1 then w = e - s end -- la première zone garde exactement sa taille
		table.insert(segs, {S = s, E = e, NS = cursor, K = w / (e - s), Part = z})
		cursor += w
		local nextZ = list[i + 1]
		if nextZ then cursor += (nextZ.Position.X - nextZ.Size.X / 2) - e end -- même bande qu'avant
	end
	local function f(x)
		if x <= segs[1].S then return x end
		for i, seg in segs do
			if x <= seg.E then return seg.NS + (x - seg.S) * seg.K end
			local nextSeg = segs[i + 1]
			if not nextSeg or x < nextSeg.S then return seg.NS + (seg.E - seg.S) * seg.K + (x - seg.E) end
		end
		return x
	end
	return f, segs
end

local function alignedX(p)
	local cf = p.CFrame
	if math.abs(cf.RightVector.X) > 0.999 then return "X" end
	if math.abs(cf.LookVector.X) > 0.999 then return "Z" end
	if math.abs(cf.UpVector.X) > 0.999 then return "Y" end
	return nil
end

function M.run(grow, apply)
	grow = grow or 0.2
	local f, segs = buildMap(grow)
	local report = {}
	for i, seg in segs do
		table.insert(report, string.format("%2d %-28s %7.1f..%7.1f -> %7.1f..%7.1f (x%.2f)", i, seg.Part.Name, seg.S, seg.E, seg.NS, seg.NS + (seg.E - seg.S) * seg.K, seg.K))
	end
	local lastEnd = segs[#segs].E
	local endDelta = f(lastEnd + 1) - (lastEnd + 1)
	table.insert(report, string.format("back of the map moves by %.1f studs", endDelta))
	if not apply then return table.concat(report, "\n"), f end

	local stretched, moved = 0, 0
	local function stretch(p, axis)
		local half = (axis == "X" and p.Size.X or axis == "Z" and p.Size.Z or p.Size.Y) / 2
		local a, b = f(p.Position.X - half), f(p.Position.X + half)
		local len = b - a
		local rot = p.CFrame.Rotation
		if axis == "X" then p.Size = Vector3.new(len, p.Size.Y, p.Size.Z)
		elseif axis == "Z" then p.Size = Vector3.new(p.Size.X, p.Size.Y, len)
		else p.Size = Vector3.new(p.Size.X, len, p.Size.Z) end
		p.CFrame = CFrame.new((a + b) / 2, p.Position.Y, p.Position.Z) * rot
		stretched += 1
	end
	local function shift(obj, x)
		local dx = f(x) - x
		if math.abs(dx) < 1e-3 then return end
		if obj:IsA("BasePart") then obj.CFrame += Vector3.new(dx, 0, 0)
		else obj:PivotTo(obj:GetPivot() + Vector3.new(dx, 0, 0)) end
		moved += 1
	end
	-- un élément : grande pièce alignée -> étirée ; modèle / pièce -> déplacé ; dossier -> chacun de ses enfants
	local function handle(obj, depth)
		if obj:IsA("BasePart") then
			local axis = alignedX(obj)
			local length = axis == "X" and obj.Size.X or axis == "Z" and obj.Size.Z or axis == "Y" and obj.Size.Y or 0
			if axis and length >= SPAN_MIN then stretch(obj, axis) else shift(obj, obj.Position.X) end
		elseif obj:IsA("Model") then
			-- un modèle qui contient lui-même de grandes pièces (plateaux...) : on descend dedans
			local hasSpan = false
			for _, d in obj:GetChildren() do
				if d:IsA("BasePart") then
					local axis = alignedX(d)
					local length = axis == "X" and d.Size.X or axis == "Z" and d.Size.Z or axis == "Y" and d.Size.Y or 0
					if axis and length >= SPAN_MIN then hasSpan = true break end
				end
			end
			if hasSpan and depth < 3 then
				for _, c in obj:GetChildren() do handle(c, depth + 1) end
			else
				local ok, pivot = pcall(function() return obj:GetPivot() end)
				if ok then shift(obj, pivot.Position.X) end
			end
		elseif obj:IsA("Folder") then
			for _, c in obj:GetChildren() do handle(c, depth + 1) end
		end
	end
	for _, c in workspace:GetChildren() do
		if SKIP[c.Name] or c:IsA("Terrain") or c:IsA("Camera") then continue end
		if c:IsA("BasePart") or c:IsA("Model") then
			local ok, pivot = pcall(function() return c:GetPivot() end)
			if ok and pivot.Position.Y < -300 then continue end -- rangé sous la carte (packs, modèles cachés)
			if ok and pivot.Position.Y > 300 then continue end -- en hauteur (arènes)
		end
		handle(c, 0)
	end
	local forest = ReplicatedStorage:FindFirstChild("IntroForest")
	if forest then forest:PivotTo(forest:GetPivot() + Vector3.new(endDelta, 0, 0)) moved += 1 end
	table.insert(report, "stretched parts: " .. stretched .. ", moved objects: " .. moved)
	return table.concat(report, "\n"), f
end
return M
