-- BossDogBuilder : les deux chiens explosifs sans tête du combat contre le Headless (BossArenaServer).
--   build("Small") : FUSE PUP, petit lévrier nerveux et fin, violet/rose, une bombe ronde sur le dos, longue queue fouet
--   build("Big")   : BLAST HOUND, gros molosse cuirassé, bleu acier/cyan, deux obus sur le dos, pointes d'épaule, queue courte
-- Même principe que Zorvex : pièces simples en plastique "Studs", néons, un Model par articulation (JointPart + Weld attribut DJ),
-- animés par BossDogsClient. Le modèle regarde vers +Z, pattes au sol à y = 0. Root : pièce physique (déplacée par le serveur).
local rgb, V, CF, A, rad = Color3.fromRGB, Vector3.new, CFrame.new, CFrame.Angles, math.rad
local BALL, CYL = Enum.PartType.Ball, Enum.PartType.Cylinder

local function make(spec)
	local model = Instance.new("Model")
	model.Name = spec.Name
	local root = Instance.new("Part")
	root.Name = "Root"
	root.Size = V(1.5, 1.5, 1.5)
	root.Position = V(0, spec.RootY, 0)
	root.Transparency = 1
	root.Anchored, root.CanCollide, root.CanQuery, root.CanTouch = false, false, false, false
	root.Parent = model
	model.PrimaryPart = root
	root.PivotOffset = CF(0, -spec.RootY, 0)
	local jp = {Root = root}
	for _, j in spec.Joints do
		local jm = Instance.new("Model")
		jm.Name = j[1]
		jm.Parent = model
		local p = Instance.new("Part")
		p.Name = "JointPart"
		p.Size = V(0.3, 0.3, 0.3)
		p.CFrame = CF(j[3])
		p.Transparency = 1
		p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.Massless = false, false, false, false, true
		p.Parent = jm
		local parent = jp[j[2]]
		local w = Instance.new("Weld")
		w.Part0, w.Part1 = parent, p
		w.C0 = parent.CFrame:ToObjectSpace(p.CFrame)
		w:SetAttribute("DJ", j[1])
		w.Parent = p
		jp[j[1]] = p
	end
	local function part(joint, name, size, cf, color, o)
		o = o or {}
		local p = Instance.new(o.wedge and "WedgePart" or "Part")
		p.Name = name
		if o.shape then p.Shape = o.shape end
		p.Size = size
		p.CFrame = typeof(cf) == "Vector3" and CF(cf) or cf
		p.Color = color
		p.Material = o.neon and Enum.Material.Neon or Enum.Material.Plastic
		if p.Material == Enum.Material.Plastic then p.MaterialVariant = "Studs" end
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.Massless = false, false, false, false, true
		p.CastShadow = not o.neon
		p.Parent = jp[joint].Parent
		local wc = Instance.new("WeldConstraint")
		wc.Part0, wc.Part1 = jp[joint], p
		wc.Parent = p
		return p
	end
	spec.Build(part)
	model:SetAttribute("Rig", "BossDog")
	model:SetAttribute("DogKind", spec.Kind)
	model:SetAttribute("DJoints", #spec.Joints)
	model:SetAttribute("Height", spec.Height)
	model.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	return model
end

local SPECS = {}
---------------------------------------------------------------- FUSE PUP (petit) : fin, haut sur pattes, dos cambré
do
	local FUR, FUR2, DARK = rgb(150, 62, 214), rgb(118, 44, 180), rgb(30, 20, 52)
	local PINK, RED, GOLD = rgb(255, 90, 220), rgb(255, 60, 70), rgb(255, 210, 80)
	local Y = 2.9 -- hauteur du dos
	SPECS.Small = {Name = "FusePup", Kind = "Small", RootY = 2.4, Height = 5,
		Joints = {
			{"Body", "Root", V(0, 2.4, 0)},
			{"LegFL", "Root", V(0.55, 2.25, 1.15)}, {"LegFR", "Root", V(-0.55, 2.25, 1.15)},
			{"LegBL", "Root", V(0.55, 2.35, -1.05)}, {"LegBR", "Root", V(-0.55, 2.35, -1.05)},
			{"LowFL", "LegFL", V(0.55, 1.2, 1.2)}, {"LowFR", "LegFR", V(-0.55, 1.2, 1.2)},
			{"LowBL", "LegBL", V(0.55, 1.25, -1.25)}, {"LowBR", "LegBR", V(-0.55, 1.25, -1.25)},
			{"Tail1", "Body", V(0, 2.8, -1.7)}, {"Tail2", "Tail1", V(0, 3.15, -2.3)}, {"Tail3", "Tail2", V(0, 3.45, -2.9)},
		},
		Build = function(part)
			-- corps : poitrail haut, taille fine, croupe ; ventre sombre ; cou tranché qui fume (pas de tête)
			part("Body", "Chest", V(1.4, 1.35, 1.4), V(0, 2.75, 0.85), FUR)
			part("Body", "Waist", V(1.05, 0.95, 1.2), V(0, 2.7, -0.15), FUR2)
			part("Body", "Hips", V(1.3, 1.15, 1.1), V(0, 2.8, -1.05), FUR)
			part("Body", "Belly", V(0.9, 0.35, 2.4), V(0, 2.1, 0), DARK)
			part("Body", "Neck", V(0.9, 0.9, 0.8), CF(0, 3.35, 1.55) * A(rad(-35), 0, 0), FUR2)
			local stump = part("Body", "Stump", V(0.95, 0.25, 0.85), CF(0, 3.75, 1.85) * A(rad(-35), 0, 0), PINK, {neon = true})
			stump:SetAttribute("Stump", true)
			for i, z in {0.75, 0.15, -0.45, -1.05} do -- crête dorsale lumineuse
				part("Body", "Spine", V(0.18, 0.45 - i * 0.05, 0.4), CF(0, Y + 0.6 - i * 0.03, z) * A(rad(-20), 0, 0), PINK, {neon = true})
			end
			-- la bombe ronde, sanglée sur le dos, et sa mèche
			part("Body", "Strap", V(1.5, 0.25, 0.35), V(0, 3.0, 0.25), DARK)
			local bomb = part("Body", "Bomb", V(1.15, 1.15, 1.15), V(0, 3.75, 0.2), rgb(40, 34, 64), {shape = BALL})
			bomb:SetAttribute("Bomb", true)
			part("Body", "BombBand", V(0.25, 1.2, 1.2), CF(0, 3.75, 0.2) * A(0, rad(90), 0), RED, {shape = CYL, neon = true})
			part("Body", "Cap", V(0.45, 0.3, 0.45), V(0.2, 4.35, 0.1), rgb(110, 106, 140))
			part("Body", "Fuse", V(0.12, 0.45, 0.12), CF(0.3, 4.6, 0.05) * A(0, 0, rad(-25)), rgb(210, 170, 110))
			part("Body", "FuseTip", V(0.3, 0.3, 0.3), V(0.42, 4.85, 0.05), GOLD, {shape = BALL, neon = true}):SetAttribute("FuseTip", true)
			-- pattes fines (cuisse + canon + patte), coussinets sombres
			for _, n in {"FL", "FR", "BL", "BR"} do
				local x = (n == "FL" or n == "BL") and 0.55 or -0.55
				local front = n == "FL" or n == "FR"
				local z = front and 1.15 or -1.05
				part("Leg" .. n, "Thigh", V(0.42, 1.15, 0.55), CF(x, front and 1.7 or 1.8, z + (front and 0.02 or -0.1)), front and FUR2 or FUR)
				local lz = front and 1.2 or -1.25
				part("Low" .. n, "Shin", V(0.32, 1.0, 0.36), V(x, 0.72, lz), FUR2)
				part("Low" .. n, "Paw", V(0.46, 0.24, 0.62), V(x, 0.12, lz + 0.12), DARK)
				part("Low" .. n, "Claw", V(0.36, 0.1, 0.12), V(x, 0.12, lz + 0.48), PINK, {neon = true})
			end
			-- queue fouet (trois segments, ressorts)
			part("Tail1", "Tail", V(0.3, 0.3, 0.7), CF(V(0, 2.98, -2.0), V(0, 3.15, -2.3)) * A(0, 0, 0), FUR)
			part("Tail2", "Tail", V(0.25, 0.25, 0.65), CF(V(0, 3.3, -2.6), V(0, 3.45, -2.9)), FUR2)
			part("Tail3", "Tail", V(0.2, 0.2, 0.55), V(0, 3.55, -3.15), FUR)
			part("Tail3", "TailTip", V(0.32, 0.32, 0.32), V(0, 3.6, -3.45), PINK, {shape = BALL, neon = true})
		end}
end
---------------------------------------------------------------- BLAST HOUND (grand) : massif, bas, cuirassé, avant-train énorme
do
	local STEEL, PLATE, DARK = rgb(46, 56, 118), rgb(72, 96, 210), rgb(22, 24, 48)
	local CYAN, ORANGE, GOLD = rgb(90, 235, 255), rgb(255, 140, 40), rgb(255, 210, 80)
	SPECS.Big = {Name = "BlastHound", Kind = "Big", RootY = 3.6, Height = 7,
		Joints = {
			{"Body", "Root", V(0, 3.6, 0)},
			{"LegFL", "Root", V(1.25, 3.4, 1.7)}, {"LegFR", "Root", V(-1.25, 3.4, 1.7)},
			{"LegBL", "Root", V(1.05, 3.4, -1.9)}, {"LegBR", "Root", V(-1.05, 3.4, -1.9)},
			{"LowFL", "LegFL", V(1.25, 1.75, 1.85)}, {"LowFR", "LegFR", V(-1.25, 1.75, 1.85)},
			{"LowBL", "LegBL", V(1.05, 1.8, -2.15)}, {"LowBR", "LegBR", V(-1.05, 1.8, -2.15)},
			{"Tail1", "Body", V(0, 4.2, -2.9)}, {"Tail2", "Tail1", V(0, 4.55, -3.5)},
		},
		Build = function(part)
			-- avant-train massif, arrière plus étroit : silhouette de molosse
			part("Body", "Chest", V(3.1, 2.5, 2.6), V(0, 4.25, 1.1), STEEL)
			part("Body", "ChestPlate", V(2.4, 1.6, 0.3), V(0, 3.9, 2.45), PLATE)
			part("Body", "Core", V(0.8, 0.8, 0.3), V(0, 4.0, 2.62), CYAN, {neon = true})
			part("Body", "Rear", V(2.4, 2.0, 2.3), V(0, 4.1, -1.4), STEEL)
			part("Body", "Belly", V(2.0, 0.5, 4.0), V(0, 3.0, -0.1), DARK)
			-- plaques d'armure sur le dos et les flancs
			part("Body", "BackPlate", V(2.8, 0.45, 1.9), CF(0, 5.6, 1.0) * A(rad(-6), 0, 0), PLATE)
			part("Body", "BackPlate", V(2.3, 0.45, 1.8), CF(0, 5.2, -1.3) * A(rad(6), 0, 0), PLATE)
			for _, sx in {-1, 1} do
				part("Body", "SidePlate", V(0.3, 1.5, 2.0), V(sx * 1.6, 4.2, 1.0), PLATE)
				part("Body", "SideGlow", V(0.34, 0.25, 1.8), V(sx * 1.62, 4.55, 1.0), CYAN, {neon = true})
				-- pointes d'épaule
				part("Body", "ShoulderSpike", V(0.5, 1.3, 0.5), CF(sx * 1.45, 5.6, 1.7) * A(rad(-25), 0, rad(-sx * 30)), DARK)
				part("Body", "SpikeTip", V(0.3, 0.45, 0.3), CF(sx * 1.45, 5.6, 1.7) * A(rad(-25), 0, rad(-sx * 30)) * CF(0, 0.75, 0), CYAN, {neon = true})
				-- les deux obus explosifs sur le dos
				local shell = part("Body", "Shell", V(2.4, 0.95, 0.95), CF(sx * 0.62, 6.25, -0.35) * A(0, rad(90), 0), rgb(50, 44, 80), {shape = CYL})
				shell:SetAttribute("Bomb", true)
				part("Body", "ShellBand", V(0.3, 1.0, 1.0), CF(sx * 0.62, 6.25, 0.2) * A(0, rad(90), 0), ORANGE, {shape = CYL, neon = true})
				part("Body", "ShellBand", V(0.3, 1.0, 1.0), CF(sx * 0.62, 6.25, -0.9) * A(0, rad(90), 0), ORANGE, {shape = CYL, neon = true})
			end
			part("Body", "Fuse", V(0.16, 0.6, 0.16), CF(0, 6.9, -0.35) * A(0, 0, rad(15)), rgb(210, 170, 110))
			part("Body", "FuseTip", V(0.42, 0.42, 0.42), V(-0.1, 7.25, -0.35), GOLD, {shape = BALL, neon = true}):SetAttribute("FuseTip", true)
			-- cou épais, collier à pointes, moignon brûlant
			part("Body", "Neck", V(1.8, 1.6, 1.3), CF(0, 5.0, 2.55) * A(rad(-30), 0, 0), STEEL)
			part("Body", "Collar", V(2.1, 0.45, 1.6), CF(0, 4.75, 2.45) * A(rad(-30), 0, 0), DARK)
			for i = -1, 1 do part("Body", "CollarSpike", V(0.3, 0.55, 0.3), CF(i * 0.7, 5.0, 3.1) * A(rad(40), 0, 0), CYAN, {neon = true}) end
			local stump = part("Body", "Stump", V(1.7, 0.3, 1.2), CF(0, 5.7, 2.95) * A(rad(-30), 0, 0), ORANGE, {neon = true})
			stump:SetAttribute("Stump", true)
			-- pattes épaisses, griffes lumineuses
			for _, n in {"FL", "FR", "BL", "BR"} do
				local left = n == "FL" or n == "BL"
				local front = n == "FL" or n == "FR"
				local x = (front and 1.25 or 1.05) * (left and 1 or -1)
				local z = front and 1.7 or -1.9
				part("Leg" .. n, "Thigh", V(front and 1.05 or 0.95, 1.75, 1.15), V(x, 2.6, z + (front and 0.08 or -0.12)), front and STEEL or PLATE)
				local lz = front and 1.85 or -2.15
				part("Low" .. n, "Shin", V(0.85, 1.5, 0.9), V(x, 1.05, lz), STEEL)
				part("Low" .. n, "Paw", V(1.15, 0.4, 1.35), V(x, 0.2, lz + 0.2), DARK)
				for _, dx in {-0.35, 0, 0.35} do part("Low" .. n, "Claw", V(0.22, 0.22, 0.4), V(x + dx, 0.2, lz + 0.95), CYAN, {neon = true}) end
			end
			-- queue courte et épineuse
			part("Tail1", "Tail", V(0.6, 0.6, 0.8), CF(V(0, 4.35, -3.15), V(0, 4.55, -3.5)), STEEL)
			part("Tail2", "Tail", V(0.45, 0.45, 0.7), V(0, 4.7, -3.8), PLATE)
			part("Tail2", "TailSpike", V(0.3, 0.6, 0.3), CF(0, 5.05, -3.9) * A(rad(-30), 0, 0), CYAN, {neon = true})
		end}
end

return function(kind)
	return make(SPECS[kind] or SPECS.Small)
end
