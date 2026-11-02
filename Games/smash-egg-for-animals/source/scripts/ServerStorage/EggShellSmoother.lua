-- Outil d'édition (pas utilisé en jeu) : refait la coquille des oeufs de ReplicatedStorage.EggSystem.EggModels.
--   require(game.ServerStorage.EggShellSmoother).run()             tous les oeufs
--   require(game.ServerStorage.EggShellSmoother).smooth(modele)    un seul
-- Avant : 9 étages empilés en escalier (3 blocs lisses par étage). Après : le même profil d'oeuf, mais à huit pans
-- inclinés qui suivent la courbe (blocs + wedges), en plastique à studs. Les couleurs de chaque étage sont gardées
-- (rayures, ceintures), et le visage, les oreilles et le nid ne bougent pas. Les brindilles les plus fines du nid sont
-- retirées pour ne pas alourdir le modèle. Les oeufs d'Halloween (autre construction) sont laissés tels quels.
local M = {}
local THICK = 0.9                 -- épaisseur des pans (vers l'intérieur)
local MAIN, CORNER = 0.345, 0.5975 -- demi-largeur d'un grand pan et distance d'un pan d'angle, en part de la largeur de l'étage
local STUD_VARIANT = game:GetService("MaterialService"):FindFirstChild("Studs") and "Studs" or ""

local function finish(p, model, color)
	p.Name = "Stud"
	p.Anchored = true
	p.Color = color
	p.Material = Enum.Material.Plastic
	p.MaterialVariant = STUD_VARIANT
	p.Parent = model
	return p
end
local function block(model, size, cf, color)
	local p = Instance.new("Part")
	p.Size, p.CFrame = size, cf
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	return finish(p, model, color)
end
local function wedge(model, size, cf, color)
	local p = Instance.new("WedgePart")
	p.Size, p.CFrame = size, cf
	return finish(p, model, color)
end

function M.smooth(model)
	local root = model.PrimaryPart
	if not root then return false, "no root" end
	local scale = model:GetScale()
	model:ScaleTo(1)
	local origin = CFrame.new(root.Position)
	-- étages de l'ancienne coquille : hauteur du centre, largeur, épaisseur, couleur
	local old, byY = {}, {}
	for _, p in model:GetChildren() do
		if p:IsA("BasePart") and p.Name == "Stud" then
			table.insert(old, p)
			local key = math.floor((p.Position.Y - origin.Y) * 20 + 0.5)
			local layer = byY[key]
			if not layer then
				layer = {Y = p.Position.Y - origin.Y, W = 0, H = p.Size.Y, Color = p.Color, N = 0}
				byY[key] = layer
			end
			layer.N += 1
			layer.W = math.max(layer.W, p.Size.X, p.Size.Z)
		end
	end
	local layers = {}
	for _, layer in byY do table.insert(layers, layer) end
	table.sort(layers, function(a, b) return a.Y < b.Y end)
	local ok = #layers == 9 and #old == 27
	for _, layer in layers do if layer.N ~= 3 then ok = false end end
	if not ok then -- oeufs d'Halloween, ou coquille déjà refaite
		model:ScaleTo(scale)
		return false, "not a 9-step shell"
	end
	for _, p in old do p:Destroy() end

	-- largeur de l'oeuf aux frontières entre étages (moyenne des deux voisins), plus resserrée tout en bas et tout en haut
	local bounds = {layers[1].W * 0.78}
	for i = 1, 8 do bounds[i + 1] = (layers[i].W + layers[i + 1].W) / 2 end
	bounds[10] = layers[9].W * 0.66
	local count = 0
	for i, layer in layers do
		local w0, w1 = bounds[i], bounds[i + 1]
		local y0, y1 = layer.Y - layer.H / 2, layer.Y + layer.H / 2
		local wide, narrow = math.max(w0, w1), math.min(w0, w1)
		for k = 0, 7 do
			local corner = k % 2 == 1
			local reach = corner and CORNER or 0.5 -- distance du pan au centre, en part de la largeur
			local a0, a1 = reach * w0, reach * w1
			local tilt = math.atan((a0 - a1) / (y1 - y0))
			local slant = math.sqrt((y1 - y0) ^ 2 + (a0 - a1) ^ 2)
			local face = origin * CFrame.Angles(0, k * math.pi / 4, 0) * CFrame.new(0, (y0 + y1) / 2, (a0 + a1) / 2) * CFrame.Angles(-tilt, 0, 0)
			if corner then -- pan d'angle : un bloc étroit
				block(model, Vector3.new(0.219 * (w0 + w1) / 2 + 0.06, slant + 0.05, THICK), face * CFrame.new(0, 0, -THICK / 2), layer.Color)
				count += 1
			else -- grand pan : un trapèze = un bloc au milieu + un wedge de chaque côté
				local half = MAIN * narrow
				local extra = MAIN * (wide - narrow)
				block(model, Vector3.new(2 * half + 0.04, slant + 0.05, THICK), face * CFrame.new(0, 0, -THICK / 2), layer.Color)
				count += 1
				if extra > 0.45 and i > 1 then -- wedges seulement là où l'oeuf se resserre vraiment (et pas tout en bas, caché dans le nid)
					local up = w0 >= w1 and 1 or -1 -- le côté large du trapèze est en bas (1) ou en haut (-1)
					for _, side in {1, -1} do
						local yAxis = Vector3.new(0, up, 0)
						local zAxis = Vector3.new(-side, 0, 0) -- l'angle droit du wedge touche le bloc du milieu
						local xAxis = yAxis:Cross(zAxis)
						wedge(model, Vector3.new(THICK, slant + 0.05, extra + 0.03), face * CFrame.fromMatrix(Vector3.new(side * (half + extra / 2), 0, -THICK / 2), xAxis, yAxis, zAxis), layer.Color)
						count += 1
					end
				end
			end
		end
	end
	-- fond (caché dans le nid) et sommet arrondi
	local first, last = layers[1], layers[9]
	block(model, Vector3.new(bounds[1] * 0.96, 0.5, bounds[1] * 0.96), origin * CFrame.new(0, first.Y - first.H / 2 + 0.2, 0), first.Color)
	local top = last.Y + last.H / 2
	block(model, Vector3.new(bounds[10] * 1.02, 0.5, bounds[10] * 1.02), origin * CFrame.new(0, top + 0.18, 0), last.Color)
	block(model, Vector3.new(bounds[10] * 0.86, 0.5, bounds[10] * 0.86), origin * CFrame.new(0, top + 0.2, 0) * CFrame.Angles(0, math.pi / 4, 0), last.Color)
	block(model, Vector3.new(bounds[10] * 0.56, 0.4, bounds[10] * 0.56), origin * CFrame.new(0, top + 0.6, 0), last.Color)
	count += 4
	-- nid : on retire les brindilles les plus fines (invisibles à la taille de l'oeuf)
	local removed = 0
	for _, p in model:GetChildren() do
		if p:IsA("BasePart") and p.Name == "Nest" and math.min(p.Size.X, p.Size.Y) <= 0.36 and math.max(p.Size.X, p.Size.Y, p.Size.Z) >= 2.5 then
			p:Destroy()
			removed += 1
		end
	end
	model:SetAttribute("SmoothShell", true)
	model:ScaleTo(scale)
	return true, ("coquille %d pièces, nid -%d"):format(count, removed)
end

function M.run(folder)
	folder = folder or game:GetService("ReplicatedStorage").EggSystem.EggModels
	local done, skipped = 0, {}
	for _, model in folder:GetChildren() do
		local ok = M.smooth(model)
		if ok then done += 1 else table.insert(skipped, model.Name) end
	end
	return ("%d oeufs refaits ; laissés tels quels : %s"):format(done, #skipped > 0 and table.concat(skipped, ", ") or "aucun")
end

return M
