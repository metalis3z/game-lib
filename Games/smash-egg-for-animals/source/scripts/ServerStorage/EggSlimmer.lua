-- Outil d'édition (pas utilisé en jeu) : allège les modèles d'œufs (ReplicatedStorage.EggSystem.EggModels) sans changer leur look.
-- Règle : 10 pièces au plus pour l'œuf (Root, coquille, nid) + 4 accessoires au plus (ailes, cornes, couronne, auréole...).
-- Comment : des unions (une union = UNE pièce, qui garde les couleurs et matières de ce qu'elle contient).
--   * coquille + taches  -> une seule pièce "Stud" (le nom attendu par TraitDeco ; ses effets sont gardés)
--   * paille du nid       -> une seule pièce "Straw" (bol et lit gardés) ; nid en pièces séparées (œufs Galaxy) -> une pièce
--   * accessoires         -> les pièces qui se touchent forment un accessoire ; on en garde 4 au plus (les plus proches sont
--                            fusionnés). Les ailes en image (Decal) ne peuvent pas être fusionnées : on garde les 2 plus grandes.
-- require(game.ServerStorage.EggSlimmer).slim(modele) -> rapport ; .run(dossier) -> rapport pour tous les modèles du dossier
local GeometryService = game:GetService("GeometryService")
local M = {}
local MAX_ACCESSORIES = 4

local function union(parts, name, parent)
	if #parts == 0 then return nil end
	if #parts == 1 then parts[1].Name = name return parts[1] end
	local first = parts[1]
	local ok, res = pcall(function()
		return GeometryService:UnionAsync(first, {table.unpack(parts, 2)}, {SplitApart = false, CollisionFidelity = Enum.CollisionFidelity.Box,
			RenderFidelity = Enum.RenderFidelity.Automatic})
	end)
	if not ok or not res or not res[1] then warn("[EggSlimmer] union failed (" .. name .. "): " .. tostring(res)) return nil end
	local u = res[1]
	u.Name = name
	u.Anchored = true
	u.CanCollide, u.CanTouch = false, false
	u.CanQuery = first.CanQuery
	u.CastShadow = first.CastShadow
	u.Transparency = first.Transparency
	for k, v in first:GetAttributes() do u:SetAttribute(k, v) end
	-- effets, lumières, attaches... des anciennes pièces : déplacés sur la nouvelle
	for _, p in parts do
		for _, c in p:GetChildren() do
			if not c:IsA("DataModelMesh") and not c:IsA("TouchTransmitter") then c.Parent = u end
		end
	end
	u.Parent = parent
	for _, p in parts do p:Destroy() end
	return u
end

-- distance entre deux pièces (boîtes, approchée) : 0 si elles se touchent
local function gapBetween(a, b)
	local d = (a.Position - b.Position).Magnitude
	return d - (a.Size.Magnitude + b.Size.Magnitude) / 2 * 0.62
end

function M.slim(model)
	local before = 0
	for _, d in model:GetDescendants() do if d:IsA("BasePart") then before += 1 end end
	local root = model:FindFirstChild("Root") or model.PrimaryPart
	-- 1. coquille + taches
	local shell = model:FindFirstChild("Stud")
	if not shell then -- (œuf construit autrement : la plus grosse pièce)
		local vol = 0
		for _, p in model:GetChildren() do
			if p:IsA("BasePart") and p ~= root and p.Size.X * p.Size.Y * p.Size.Z > vol then shell, vol = p, p.Size.X * p.Size.Y * p.Size.Z end
		end
	end
	local shellParts = {shell}
	for _, p in model:GetChildren() do if p:IsA("BasePart") and p.Name == "Spot" then table.insert(shellParts, p) end end
	if shell then union(shellParts, "Stud", model) end
	-- 2. nid
	local nest = model:FindFirstChild("Nest")
	if nest and nest:IsA("Model") then
		-- bottes de paille en mesh (texturées) : une union les abîme. On en garde une sur deux, un peu plus larges : le nid reste plein
		local straws = {}
		for _, p in nest:GetChildren() do if p:IsA("BasePart") and p.Name == "Straw" then table.insert(straws, p) end end
		if #straws > 6 then
			local nestCenter = nest:GetBoundingBox().Position
			table.sort(straws, function(x, y)
				local ox, oy = x.Position - nestCenter, y.Position - nestCenter
				return math.atan2(ox.Z, ox.X) < math.atan2(oy.Z, oy.X)
			end)
			local keep = {}
			for i, p in straws do if i % 2 == 1 and #keep < 6 then table.insert(keep, p) end end
			for _, p in straws do
				if table.find(keep, p) then
					local cf = p.CFrame
					p.Size = Vector3.new(p.Size.X * 1.45, p.Size.Y * 1.15, p.Size.Z * 1.45)
					p.CFrame = cf
				else
					p:Destroy()
				end
			end
		end
	end
	local looseNest = {}
	for _, p in model:GetChildren() do if p:IsA("BasePart") and p.Name == "Nest" then table.insert(looseNest, p) end end
	if #looseNest > 0 then
		local holder = Instance.new("Model")
		holder.Name = "Nest"
		holder.Parent = model
		-- (pièces de couleurs / matières différentes : l'union les garde)
		union(looseNest, "Straw", holder)
	end
	-- 3. accessoires
	local decals, solids = {}, {}
	for _, p in model:GetChildren() do
		if p:IsA("BasePart") and p ~= root and p.Name ~= "Stud" then
			if p:FindFirstChildOfClass("Decal") or p:FindFirstChildOfClass("Texture") then table.insert(decals, p) else table.insert(solids, p) end
		end
	end
	-- ailes en image : la plus grande de chaque côté
	local keepDecals = {}
	if #decals > 0 then
		local best = {}
		for _, p in decals do
			local side = root and (root.CFrame:PointToObjectSpace(p.Position).X >= 0 and 1 or -1) or 1
			local area = p.Size.X * p.Size.Y
			if not best[side] or area > best[side].Area then best[side] = {Part = p, Area = area} end
		end
		for _, b in best do table.insert(keepDecals, b.Part) end
		for _, p in decals do if not table.find(keepDecals, p) then p:Destroy() end end
	end
	-- pièces qui se touchent = un accessoire (même transparence)
	local groups = {}
	for _, p in solids do
		local key = math.floor(p.Transparency * 10 + 0.5)
		local joined
		for _, g in groups do
			if g.Key == key then
				for _, q in g.Parts do
					if gapBetween(p, q) <= 0.15 then joined = g break end
				end
			end
			if joined then break end
		end
		if joined then table.insert(joined.Parts, p) else table.insert(groups, {Key = key, Parts = {p}}) end
	end
	-- groupes reliés entre eux après coup (une pièce pouvait toucher deux groupes)
	local changed = true
	while changed do
		changed = false
		for i = #groups, 2, -1 do
			for j = 1, i - 1 do
				local a, b = groups[i], groups[j]
				if a.Key == b.Key then
					local touch = false
					for _, p in a.Parts do
						for _, q in b.Parts do if gapBetween(p, q) <= 0.15 then touch = true break end end
						if touch then break end
					end
					if touch then
						for _, p in a.Parts do table.insert(b.Parts, p) end
						table.remove(groups, i)
						changed = true
						break
					end
				end
			end
			if changed then break end
		end
	end
	-- au plus 4 accessoires en tout : on fusionne les deux groupes les plus proches (même transparence d'abord)
	local function center(g)
		local s = Vector3.zero
		for _, p in g.Parts do s += p.Position end
		return s / #g.Parts
	end
	while #groups > math.max(0, MAX_ACCESSORIES - #keepDecals) do
		local bi, bj, bd
		for i = 1, #groups do
			for j = i + 1, #groups do
				local d = (center(groups[i]) - center(groups[j])).Magnitude + (groups[i].Key ~= groups[j].Key and 1000 or 0)
				if not bd or d < bd then bi, bj, bd = i, j, d end
			end
		end
		if not bi then break end
		for _, p in groups[bj].Parts do table.insert(groups[bi].Parts, p) end
		table.remove(groups, bj)
	end
	for i, g in groups do union(g.Parts, g.Parts[1].Name, model) end
	local after, accessories = 0, #keepDecals + #groups
	for _, d in model:GetDescendants() do if d:IsA("BasePart") then after += 1 end end
	return before, after, accessories
end

function M.run(folder)
	local lines, total0, total1 = {}, 0, 0
	for _, model in folder:GetChildren() do
		if model:IsA("Model") then
			local ok, a, b, acc = pcall(M.slim, model)
			if ok then
				total0 += a total1 += b
				if b - acc > 10 or acc > MAX_ACCESSORIES then table.insert(lines, "OVER LIMIT " .. model.Name .. " " .. b .. " parts, " .. acc .. " accessories") end
			else
				table.insert(lines, "ERROR " .. model.Name .. ": " .. tostring(a))
			end
		end
	end
	table.insert(lines, 1, "parts: " .. total0 .. " -> " .. total1)
	return table.concat(lines, "\n")
end
return M
