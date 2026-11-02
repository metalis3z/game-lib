-- Parure des animaux « ange » : au lieu d'un mesh tout blanc, des yeux divins (jaune lumineux), un diadème à gemme, une gemme
-- sur le poitrail, des sabots / griffes dorés, des plaques bleu ciel bordées d'or sur le dos et une flamme dorée au bout de la queue.
-- Tout est placé en sondant la surface du mesh (rayons) : ça marche pour n'importe quel animal du kit, à une ou plusieurs têtes.
-- Les pièces sont soudées à un pivot invisible par os (soudure "AngelGear" racine -> pivot, attribut Bone) : MeshAnimalClient
-- fait suivre son os à chaque pivot.
--   adorn(model, height, weldTo, angelPart) -> nombre de soudures animées ajoutées.
-- Le modèle doit être à l'origine, l'avant en +Z (comme le pose AnimalWiring). Il est mis dans le Workspace le temps du sondage.
local GOLD, DEEP = Color3.fromRGB(255, 206, 70), Color3.fromRGB(214, 140, 20)
local EYE, GEM, SKY = Color3.fromRGB(255, 238, 70), Color3.fromRGB(70, 220, 255), Color3.fromRGB(70, 150, 255)

return function(model, height, weldTo, angelPart)
	local root, body = model.PrimaryPart, model:FindFirstChild("Body")
	local home = model.Parent
	local H = height
	model.Parent = workspace
	local fidelity, query = body.CollisionFidelity, body.CanQuery
	body.CollisionFidelity = Enum.CollisionFidelity.PreciseConvexDecomposition
	body.CanQuery = true
	task.wait(0.2) -- le temps que la forme précise soit calculée
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = {body}
	local function probe(from, to)
		local hit = workspace:Raycast(from, to - from, params)
		if hit then return hit.Position, hit.Normal end
		return nil
	end
	local center, size = body.Position, body.Size
	local W, L = size.X, size.Z
	local floorY = center.Y - size.Y / 2
	local frontZ, backZ = center.Z + L / 2 + 1, center.Z - L / 2 - 1

	local bones, names = {}, {}
	for _, b in body:GetDescendants() do
		if b:IsA("Bone") then
			table.insert(bones, b)
			names[b.Name] = (names[b.Name] or 0) + 1
		end
	end
	local function boneNear(p)
		local best, bestD
		for _, b in bones do
			local d = (b.WorldPosition - p).Magnitude
			if not bestD or d < bestD then best, bestD = b, d end
		end
		return best and names[best.Name] == 1 and best.Name or nil
	end
	local count = 0
	local pivots = {}
	local function gear(name, sizeV, cf, color, neon)
		local p = angelPart(model, name, sizeV, cf, color, neon)
		if not neon then
			p.Material = Enum.Material.SmoothPlastic
			pcall(function() p.MaterialVariant = "" end)
		end
		-- une seule soudure animée par os : les pièces d'un même os sont soudées à un pivot invisible, et c'est lui qui suit l'os
		local boneName = boneNear(cf.Position)
		local key = boneName or ""
		local pivot = pivots[key]
		if not pivot then
			pivot = angelPart(model, "GearPivot", Vector3.one * 0.1, CFrame.new(cf.Position), GOLD, false)
			pivot.Transparency = 1
			weldTo(root, pivot, "AngelGear"):SetAttribute("Bone", boneName)
			pivots[key] = pivot
			count += 1
		end
		weldTo(pivot, p, "GearWeld")
		return p
	end
	local function facing(pos, normal) -- repère posé sur la surface, -Z vers l'extérieur
		local up = math.abs(normal.Y) > 0.95 and Vector3.zAxis or Vector3.yAxis
		return CFrame.lookAt(pos, pos + normal, up)
	end

	---------------------------------------------------------------- têtes : les bosses les plus en avant, dans la moitié haute
	local NX, NY = 41, 31
	local depth = {} -- [ix][iy] = z de la surface vue de face
	local zMax = -math.huge
	for ix = 1, NX do
		depth[ix] = {}
		local x = center.X - W / 2 + (ix - 0.5) / NX * W
		for iy = 1, NY do
			local y = floorY + (iy - 0.5) / NY * size.Y
			local pos = probe(Vector3.new(x, y, frontZ), Vector3.new(x, y, backZ))
			if pos then
				depth[ix][iy] = pos.Z
				if y > floorY + size.Y * 0.4 and pos.Z > zMax then zMax = pos.Z end
			end
		end
	end
	local heads = {}
	do
		local band = math.max(L * 0.14, H * 0.1)
		local column = {} -- [ix] = {somme y, n, z max} des cellules de tête de cette colonne
		for ix = 1, NX do
			for iy = 1, NY do
				local z = depth[ix][iy]
				local y = floorY + (iy - 0.5) / NY * size.Y
				if z and z > zMax - band and y > floorY + size.Y * 0.4 then
					local c = column[ix] or {0, 0, -math.huge}
					c[1] += y
					c[2] += 1
					c[3] = math.max(c[3], z)
					column[ix] = c
				end
			end
		end
		local run
		for ix = 1, NX + 1 do
			local c = column[ix]
			if c then
				run = run or {x = 0, y = 0, n = 0, z = -math.huge, cols = 0}
				local x = center.X - W / 2 + (ix - 0.5) / NX * W
				run.x += x * c[2]
				run.y += c[1]
				run.n += c[2]
				run.cols += 1
				run.z = math.max(run.z, c[3])
			elseif run then
				if run.n >= 3 then
					table.insert(heads, {Front = Vector3.new(run.x / run.n, run.y / run.n, run.z), Width = run.cols / NX * W})
				end
				run = nil
			end
		end
	end

	for _, head in heads do
		local R = math.clamp(head.Width * 0.9, H * 0.16, H * 0.34)
		local core = head.Front - Vector3.new(0, 0, R * 0.55) -- un point dans la tête
		-- yeux : de face, de part et d'autre du museau, à mi-hauteur entre le museau et le haut de la tête. Si la tête est trop
		-- étroite pour ça (oiseau, cheval), ils vont sur ses côtés.
		local cx, cy, fz = head.Front.X, head.Front.Y, head.Front.Z
		local topY = cy
		for i = 1, 12 do
			local y = cy + i * H * 0.03
			local p = probe(Vector3.new(cx, y, frontZ), Vector3.new(cx, y, backZ))
			if p and p.Z > fz - H * 0.32 then topY = y else break end
		end
		local eyeY = cy + (topY - cy) * 0.5 + H * 0.01
		local spread = math.clamp(head.Width * 0.32, H * 0.05, H * 0.1)
		for _, side in {-1, 1} do
			local x = cx + side * spread
			local pos, normal = probe(Vector3.new(x, eyeY, frontZ), Vector3.new(x, eyeY, backZ))
			if pos and pos.Z > fz - H * 0.3 then
				normal = (normal + Vector3.zAxis * 0.9).Unit -- tournés surtout vers l'avant
			else
				local z = fz - H * 0.13
				pos, normal = probe(Vector3.new(cx + side * H, eyeY, z), Vector3.new(cx, eyeY, z))
				if pos and math.abs(pos.X - cx) > H * 0.3 then pos = nil end
			end
			if pos then
				local cf = facing(pos, normal)
				gear("EyeRim", Vector3.new(H * 0.066, H * 0.084, H * 0.02), cf * CFrame.new(0, 0, -H * 0.004), DEEP, false)
				gear("Eye", Vector3.new(H * 0.042, H * 0.058, H * 0.02), cf * CFrame.new(0, 0, -H * 0.012), EYE, true)
			end
		end
		-- diadème : une barre dorée sur le haut du front, une gemme au milieu, deux pointes
		local top, topNormal = probe(core + Vector3.new(0, R * 2.4, R * 0.25), core + Vector3.new(0, 0, R * 0.25))
		if top then
			local cf = CFrame.new(top)
			gear("Tiara", Vector3.new(math.min(head.Width * 0.7, H * 0.2), H * 0.03, H * 0.035), cf * CFrame.new(0, H * 0.012, 0), GOLD, false)
			gear("TiaraGem", Vector3.one * H * 0.05, cf * CFrame.new(0, H * 0.05, 0) * CFrame.Angles(0, 0, math.rad(45)), GEM, true)
			for _, side in {-1, 1} do
				gear("TiaraSpike", Vector3.new(H * 0.024, H * 0.06, H * 0.024), cf * CFrame.new(side * math.min(head.Width * 0.24, H * 0.07), H * 0.045, 0), GOLD, false)
			end
		end
	end

	---------------------------------------------------------------- gemme du poitrail
	do
		local headLow = #heads > 0 and heads[1].Front.Y or floorY + size.Y * 0.8
		local y = floorY + (headLow - floorY) * 0.62
		local pos, normal = probe(Vector3.new(center.X, y, frontZ), Vector3.new(center.X, y, backZ))
		if pos then
			local cf = facing(pos, normal)
			gear("ChestPlate", Vector3.new(H * 0.12, H * 0.12, H * 0.02), cf * CFrame.Angles(0, 0, math.rad(45)), GOLD, false)
			gear("ChestGem", Vector3.new(H * 0.075, H * 0.075, H * 0.03), cf * CFrame.new(0, 0, -H * 0.008) * CFrame.Angles(0, 0, math.rad(45)), GEM, true)
		end
	end

	---------------------------------------------------------------- sabots / griffes dorés : un bloc autour de chaque pied
	do
		local feet = {}
		for _, b in bones do
			local p = b.WorldPosition
			if p.Y < floorY + H * 0.12 then
				local found
				for _, f in feet do
					if (Vector3.new(f.sum.X / f.n - p.X, 0, f.sum.Z / f.n - p.Z)).Magnitude < H * 0.1 then found = f break end
				end
				if found then found.sum += p found.n += 1 else table.insert(feet, {sum = p, n = 1}) end
			end
		end
		for _, f in feet do
			local c = f.sum / f.n
			local y = floorY + H * 0.05
			local lo, hi = Vector3.new(c.X - H * 0.05, 0, c.Z - H * 0.06), Vector3.new(c.X + H * 0.05, 0, c.Z + H * 0.06)
			-- on élargit jusqu'à la surface du pied, vue des quatre côtés
			local reach = H * 0.11 -- (pas plus loin : on toucherait la patte voisine)
			local a = probe(Vector3.new(c.X - reach, y, c.Z), Vector3.new(c.X, y, c.Z)) if a then lo = Vector3.new(a.X, 0, lo.Z) end
			local b2 = probe(Vector3.new(c.X + reach, y, c.Z), Vector3.new(c.X, y, c.Z)) if b2 then hi = Vector3.new(b2.X, 0, hi.Z) end
			local c1 = probe(Vector3.new(c.X, y, c.Z - reach), Vector3.new(c.X, y, c.Z)) if c1 then lo = Vector3.new(lo.X, 0, c1.Z) end
			local c2 = probe(Vector3.new(c.X, y, c.Z + reach), Vector3.new(c.X, y, c.Z)) if c2 then hi = Vector3.new(hi.X, 0, c2.Z) end
			local sx = math.clamp(hi.X - lo.X + H * 0.025, H * 0.07, H * 0.17)
			local sz = math.clamp(hi.Z - lo.Z + H * 0.025, H * 0.07, H * 0.2)
			gear("Boot", Vector3.new(sx, H * 0.1, sz), CFrame.new((lo.X + hi.X) / 2, floorY + H * 0.05, (lo.Z + hi.Z) / 2), GOLD, false)
			gear("BootRim", Vector3.new(sx + H * 0.02, H * 0.025, sz + H * 0.02), CFrame.new((lo.X + hi.X) / 2, floorY + H * 0.105, (lo.Z + hi.Z) / 2), DEEP, false)
		end
	end

	---------------------------------------------------------------- dos : deux plaques bleu ciel bordées d'or
	for _, k in {0.1, -0.12} do
		local z = center.Z + k * L
		local pos = probe(Vector3.new(center.X, floorY + size.Y + 1, z), Vector3.new(center.X, floorY, z))
		if pos and pos.Y > floorY + H * 0.35 then
			local wide = H * 0.3
			local left = probe(Vector3.new(center.X - W, pos.Y - H * 0.05, z), Vector3.new(center.X, pos.Y - H * 0.05, z))
			if left then wide = math.clamp((center.X - left.X) * 2 * 0.8, H * 0.14, H * 0.42) end
			gear("BackRim", Vector3.new(wide + H * 0.03, H * 0.022, H * 0.2), CFrame.new(pos + Vector3.new(0, H * 0.008, 0)), GOLD, false)
			gear("BackPlate", Vector3.new(wide, H * 0.03, H * 0.16), CFrame.new(pos + Vector3.new(0, H * 0.02, 0)), SKY, false)
		end
	end

	---------------------------------------------------------------- bout de la queue : une flamme dorée
	do
		local best
		for i = 0, 14 do
			local y = floorY + size.Y * (0.15 + 0.8 * i / 14)
			local pos = probe(Vector3.new(center.X, y, backZ), Vector3.new(center.X, y, frontZ))
			if pos and (not best or pos.Z < best.Z) then best = pos end
		end
		if best then
			gear("TailFlame", Vector3.one * H * 0.085, CFrame.new(best + Vector3.new(0, 0, -H * 0.02)) * CFrame.Angles(math.rad(45), 0, math.rad(45)), EYE, true)
			gear("TailRing", Vector3.new(H * 0.11, H * 0.11, H * 0.035), CFrame.new(best + Vector3.new(0, 0, H * 0.04)), GOLD, false)
		end
	end

	body.CollisionFidelity = fidelity
	body.CanQuery = query
	model.Parent = home
	return count, #heads
end
