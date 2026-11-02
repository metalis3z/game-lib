-- FightFilm.DemonCast : le démon de la cinématique "Demon City" et le TRUE DEMON du combat (même construction, en studs).
--   DemonCast.demon(o)          R6 articulé (Kit.makeR6) : cornes, yeux rouges, mâchoire mobile, griffes, armure, queue,
--                               fissures de lave lumineuses ; o.True = forme finale (plus sombre, ailes, couronne de cornes,
--                               3 yeux) ; o.Palette = "Shadow" pour la silhouette géante ; o.Scale = taille
--   DemonCast.actor(rig)        l'acteur Kit avec ses articulations en plus (Jaw, Tail, Tail2, WingR, WingL)
--   DemonCast.joints(rig)       toutes les articulations (pour l'animer sans Kit, dans l'arène) : {nom = {obj, base}}
--   DemonCast.pose(joints, p)   applique une pose (angles en degrés, mêmes conventions que FightFilm.Kit)
--   DemonCast.Poses             les poses du démon (partagées par la cinématique et le combat)
-- Allures : Kit.Gaits.demonStomp (marche lourde), Kit.Gaits.demonRun (charge). Tout regarde vers -Z.
local Kit = require(script.Parent:WaitForChild("Kit"))
local DemonCast = {}
local rgb = Color3.fromRGB
local rad, sin, cos, abs = math.rad, math.sin, math.cos, math.abs
local V = Vector3.new
local function C(x, y, z, rx, ry, rz) return CFrame.new(x, y, z) * CFrame.Angles(rad(rx or 0), rad(ry or 0), rad(rz or 0)) end

DemonCast.PALETTES = {
	Demon = {Skin = rgb(136, 28, 32), Armor = rgb(46, 22, 26), Bone = rgb(222, 206, 182), Tip = rgb(70, 36, 34), Glow = rgb(255, 104, 34),
		Eye = rgb(255, 46, 20), Cloth = rgb(32, 14, 16), Membrane = rgb(110, 20, 26), Dark = rgb(20, 6, 8)},
	True = {Skin = rgb(70, 12, 18), Armor = rgb(22, 10, 14), Bone = rgb(44, 34, 36), Tip = rgb(255, 40, 30), Glow = rgb(255, 44, 30),
		Eye = rgb(255, 96, 60), Cloth = rgb(14, 6, 8), Membrane = rgb(86, 10, 18), Dark = rgb(8, 2, 4)},
	Shadow = {Skin = rgb(16, 8, 10), Armor = rgb(9, 4, 6), Bone = rgb(22, 14, 16), Tip = rgb(255, 30, 20), Glow = rgb(255, 34, 22),
		Eye = rgb(255, 70, 40), Cloth = rgb(6, 2, 4), Membrane = rgb(24, 4, 8), Dark = rgb(4, 1, 2)},
}

-- triangle mince (deux coins) entre trois points : sert aux membranes des ailes
local function triangle(a, b, c)
	local ab, ac, bc = b - a, c - a, c - b
	local abd, acd, bcd = ab:Dot(ab), ac:Dot(ac), bc:Dot(bc)
	if abd > acd and abd > bcd then
		c, a = a, c
	elseif acd > bcd and acd > abd then
		a, b = b, a
	end
	ab, ac, bc = b - a, c - a, c - b
	local right = ac:Cross(ab).Unit
	local up = bc:Cross(right).Unit
	local back = bc.Unit
	local height = abs(ab:Dot(up))
	return V(0, height, abs(ab:Dot(back))), CFrame.fromMatrix((a + b) / 2, right, up, back),
		V(0, height, abs(ac:Dot(back))), CFrame.fromMatrix((a + c) / 2, -right, up, -back)
end

---------------------------------------------------------------- construction
function DemonCast.demon(o)
	o = o or {}
	local s = o.Scale or 3
	local isTrue = o.True == true
	local pal = DemonCast.PALETTES[o.Palette or (isTrue and "True" or "Demon")]
	local rig = Kit.makeR6({Name = o.Name or (isTrue and "TrueDemon" or "Demon"), Scale = s, Colors = {Torso = pal.Skin, Head = pal.Skin, Arms = pal.Skin, Legs = pal.Skin}})
	local head, torso = rig.Head, rig.Torso
	local parts = {Eyes = {}, Glow = {}}
	-- pièce de costume : taille et position données pour un démon de taille 1 (multipliées par s)
	local function d(limb, size, cf, color, opts)
		opts = opts or {}
		local off = typeof(cf) == "Vector3" and CFrame.new(cf * s) or (CFrame.new(cf.Position * s) * cf.Rotation)
		local p, w = Kit.deco(limb, size * s, off, color, opts)
		if opts.Neon then table.insert(parts.Glow, p) end
		if opts.Ball then p.Shape = Enum.PartType.Ball end
		return p, w
	end
	-- barre entre deux points du membre (cornes, griffes, os des ailes)
	local function rod(limb, a, b, t, color, opts)
		local dir = b - a
		local up = abs(dir.Unit.Y) > 0.97 and V(0, 0, 1) or V(0, 1, 0)
		return d(limb, V(t, t, dir.Magnitude), CFrame.lookAt((a + b) / 2, b, up), color, opts)
	end
	local function tri(limb, a, b, c, color, t)
		local s1, cf1, s2, cf2 = triangle(a, b, c)
		if s1.Y > 0.02 and s1.Z > 0.02 then d(limb, V(t, s1.Y, s1.Z), cf1, color, {Wedge = true, Name = "Membrane"}) end
		if s2.Y > 0.02 and s2.Z > 0.02 then d(limb, V(t, s2.Y, s2.Z), cf2, color, {Wedge = true, Name = "Membrane"}) end
	end
	-- articulation soudée qui tourne autour d'un pivot (au lieu du centre de la pièce)
	local function hinge(w, pivot, jointName)
		local partCF = w.C0
		local h = CFrame.new(pivot * s)
		w.C0 = h
		w.C1 = (h:Inverse() * partCF):Inverse()
		w.Name = jointName .. "Joint"
		w:SetAttribute("Joint", jointName)
		return w
	end

	------------------------------------------------ tête : arcade sourcilière, yeux en fente, crocs, mâchoire, cornes
	d(head, V(1.38, 0.3, 0.42), C(0, 0.32, -0.5, 14, 0, 0), pal.Armor, {Name = "Brow"})
	for _, side in {-1, 1} do
		local eye = d(head, V(0.36, 0.13, 0.08), C(side * 0.3, 0.12, -0.67, 0, 0, side * -16), pal.Eye, {Neon = true, Name = "Eye"})
		table.insert(parts.Eyes, eye)
		d(head, V(0.1, 0.22, 0.1), C(side * 0.24, -0.43, -0.63), pal.Bone, {Name = "Fang"})
		d(head, V(0.2, 0.5, 0.5), C(side * 0.66, -0.12, -0.18, 0, 0, side * 8), pal.Armor, {Name = "Cheek"})
	end
	if isTrue then
		local third = d(head, V(0.12, 0.26, 0.08), C(0, 0.46, -0.69), pal.Eye, {Neon = true, Name = "Eye"})
		table.insert(parts.Eyes, third)
	end
	d(head, V(0.82, 0.16, 0.06), C(0, -0.3, -0.66), pal.Dark, {Name = "Mouth"})
	parts.MouthGlow = d(head, V(0.66, 0.07, 0.06), C(0, -0.3, -0.675), pal.Glow, {Neon = true, Name = "MouthGlow"})
	local jaw, jawWeld = d(head, V(1.0, 0.26, 0.72), C(0, -0.62, -0.38), pal.Skin, {Name = "Jaw"})
	hinge(jawWeld, V(0, -0.55, -0.05), "Jaw")
	for _, side in {-1, 1} do d(jaw, V(0.09, 0.2, 0.09), C(side * 0.28, 0.18, -0.3), pal.Bone, {Name = "Fang"}) end
	local k = isTrue and 1.3 or 1.15
	for _, side in {-1, 1} do
		local pts = {V(side * 0.6, 0.42, 0.05), V(side * 1.12, 0.78, 0.1), V(side * 1.42, 1.42, -0.05), V(side * 1.36, 2.05, -0.35)}
		if isTrue then table.insert(pts, V(side * 1.12, 2.55, -0.78)) end
		for i = 1, #pts - 1 do
			local a, b = pts[i] * V(1, 1, 1), pts[i + 1]
			local last = i == #pts - 1
			local t = (0.46 - i * 0.08) * k
			rod(head, a * V(k, k, 1), b * V(k, k, 1), math.max(t, 0.14), last and pal.Tip or pal.Bone, {Name = "Horn", Neon = last and isTrue})
		end
	end
	if isTrue then
		for _, x in {-0.32, 0, 0.32} do rod(head, V(x, 0.6, 0.12), V(x * 1.25, x == 0 and 1.3 or 1.12, 0.28), 0.16, pal.Bone, {Name = "Crown"}) end
	end

	------------------------------------------------ torse : plastron, fissures de lave, cœur, ceinture à crâne, pagne, piques
	d(torso, V(2.12, 1.05, 1.12), C(0, 0.4, 0), pal.Armor, {Name = "Chest"})
	d(torso, V(0.08, 0.86, 0.05), C(0, 0.32, -0.58), pal.Glow, {Neon = true, Name = "Crack"})
	for _, side in {-1, 1} do
		d(torso, V(0.07, 0.7, 0.05), C(side * 0.48, 0.42, -0.58, 0, 0, side * 32), pal.Glow, {Neon = true, Name = "Crack"})
		d(torso, V(0.06, 0.5, 0.05), C(side * 0.55, -0.4, -0.52, 0, 0, side * -24), pal.Glow, {Neon = true, Name = "Crack"})
	end
	parts.Core = d(torso, V(0.42, 0.42, 0.42), C(0, 0.38, -0.55), pal.Glow, {Neon = true, Ball = true, Name = "Core"})
	for _, y in {-0.22, -0.5} do d(torso, V(0.9, 0.06, 0.04), C(0, y, -0.52), pal.Armor, {Name = "Abs"}) end
	d(torso, V(2.16, 0.3, 1.16), C(0, -0.84, 0), pal.Armor, {Name = "Belt"})
	d(torso, V(0.42, 0.38, 0.1), C(0, -0.84, -0.62), pal.Bone, {Name = "Skull"})
	for _, side in {-1, 1} do d(torso, V(0.1, 0.1, 0.05), C(side * 0.1, -0.8, -0.68), pal.Glow, {Neon = true, Name = "SkullEye"}) end
	d(torso, V(0.95, 0.95, 0.08), C(0, -1.4, -0.56, -6, 0, 0), pal.Cloth, {Name = "Loincloth"})
	d(torso, V(1.6, 1.05, 0.08), C(0, -1.45, 0.56, 6, 0, 0), pal.Cloth, {Name = "Loincloth"})
	for i, y in {0.62, 0.18, -0.26} do rod(torso, V(0, y, 0.48), V(0, y + 0.32, 1.0 - i * 0.08), 0.22, pal.Bone, {Name = "Spine"}) end

	------------------------------------------------ bras : épaulières à piques, brassards, griffes
	for _, side in {-1, 1} do
		local arm = rig[side == 1 and "Right Arm" or "Left Arm"]
		d(arm, V(1.42, 0.72, 1.42), C(side * 0.15, 0.86, 0, 0, 0, side * -14), pal.Armor, {Name = "Pauldron"})
		rod(arm, V(side * 0.3, 1.1, -0.25), V(side * 0.78, 1.8, -0.3), 0.22, pal.Bone, {Name = "Spike"})
		rod(arm, V(side * 0.3, 1.1, 0.3), V(side * 0.7, 1.66, 0.48), 0.2, pal.Bone, {Name = "Spike"})
		d(arm, V(1.12, 0.66, 1.12), C(0, -0.46, 0), pal.Armor, {Name = "Bracer"})
		d(arm, V(1.14, 0.08, 1.14), C(0, -0.2, 0), pal.Glow, {Neon = true, Name = "Rune"})
		d(arm, V(0.06, 0.8, 0.05), C(side * 0.22, 0.22, -0.52, 0, 0, side * 20), pal.Glow, {Neon = true, Name = "Crack"})
		for i = -1, 1 do rod(arm, V(i * 0.3, -0.92, -0.32), V(i * 0.34, -1.56, -0.62), 0.14, pal.Bone, {Name = "Claw"}) end
	end

	------------------------------------------------ jambes : cuissards, jambières, sabots griffus
	for _, side in {-1, 1} do
		local leg = rig[side == 1 and "Right Leg" or "Left Leg"]
		d(leg, V(1.1, 0.7, 1.12), C(0, 0.55, 0), pal.Armor, {Name = "Thigh"})
		d(leg, V(1.12, 0.86, 1.16), C(0, -0.5, -0.02), pal.Armor, {Name = "Greave"})
		rod(leg, V(0, 0.05, -0.55), V(0, 0.38, -0.98), 0.2, pal.Bone, {Name = "KneeSpike"})
		d(leg, V(1.08, 0.36, 1.36), C(0, -0.84, -0.18), pal.Dark, {Name = "Hoof"})
		for _, x in {-0.3, 0.3} do rod(leg, V(x, -0.9, -0.8), V(x * 1.05, -0.98, -1.16), 0.15, pal.Bone, {Name = "Toe"}) end
	end

	------------------------------------------------ queue (deux articulations : elle ondule)
	local tail1, w1 = rod(torso, V(0, -0.8, 0.5), V(0, -1.35, 1.75), 0.44, pal.Skin, {Name = "Tail"})
	hinge(w1, V(0, -0.8, 0.5), "Tail")
	local L1 = (V(0, -1.35, 1.75) - V(0, -0.8, 0.5)).Magnitude
	local tail2, w2 = rod(tail1, V(0, 0, -L1 / 2), V(0, -0.35, -L1 / 2 - 1.35), 0.32, pal.Skin, {Name = "Tail"})
	hinge(w2, V(0, 0, -L1 / 2), "Tail2")
	local L2 = (V(0, -0.35, -1.35)).Magnitude
	rod(tail2, V(0, 0, -L2 / 2), V(0, 0.15, -L2 / 2 - 0.75), 0.22, isTrue and pal.Tip or pal.Bone, {Name = "TailSpike", Neon = isTrue})

	------------------------------------------------ ailes de chauve-souris (forme finale seulement) : os, doigts, membranes
	if isTrue or o.Wings then
		for _, side in {-1, 1} do
			local root, rw = d(torso, V(0.42, 0.42, 0.42), C(side * 0.55, 0.55, 0.62), pal.Armor, {Name = "WingRoot"})
			hinge(rw, V(side * 0.55, 0.55, 0.62), side == 1 and "WingR" or "WingL")
			local P0, P1 = V(0, 0, 0), V(side * 2.6, 1.9, 0.4)
			local F1, F2, F3, R2 = V(side * 6.2, 0.9, 0.9), V(side * 5.4, -1.4, 0.8), V(side * 3.4, -2.6, 0.6), V(side * 0.7, -1.5, 0.2)
			rod(root, P0, P1, 0.34, pal.Bone, {Name = "WingBone"})
			rod(root, P1, F1, 0.24, pal.Bone, {Name = "WingFinger"})
			rod(root, P1, F2, 0.22, pal.Bone, {Name = "WingFinger"})
			rod(root, P1, F3, 0.2, pal.Bone, {Name = "WingFinger"})
			rod(root, P1, P1 + V(side * 0.15, 0.7, 0.1), 0.18, pal.Tip, {Name = "WingClaw", Neon = isTrue})
			tri(root, P1, F1, F2, pal.Membrane, 0.08)
			tri(root, P1, F2, F3, pal.Membrane, 0.08)
			tri(root, P1, F3, R2, pal.Membrane, 0.08)
			tri(root, P0, P1, R2, pal.Membrane, 0.08)
		end
	end

	------------------------------------------------ tout en studs (sauf ce qui brille), lumière et aura
	for _, p in rig:GetDescendants() do
		if p:IsA("BasePart") then
			if p.Material ~= Enum.Material.Neon and p.Transparency < 1 then
				p.Material = Enum.Material.Plastic
				p.MaterialVariant = "Studs"
			end
			p.CastShadow = p.Material ~= Enum.Material.Neon and o.Palette ~= "Shadow"
		elseif (p:IsA("Motor6D") or p:IsA("Weld")) then
			p:SetAttribute("Base", p.C0)
		end
	end
	local light = Instance.new("PointLight")
	light.Name = "DemonLight"
	light.Color, light.Range, light.Brightness, light.Shadows = pal.Glow, 10 * s, 1.4, false
	light.Parent = parts.Core
	parts.Light = light
	if o.Aura ~= false then
		local smoke = Instance.new("ParticleEmitter")
		smoke.Name = "DemonAura"
		smoke.Texture = "rbxasset://textures/particles/smoke_main.dds"
		smoke.Color = ColorSequence.new(rgb(120, 10, 10), rgb(20, 0, 4))
		smoke.LightEmission, smoke.LightInfluence = 0.4, 0.3
		smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8 * s), NumberSequenceKeypoint.new(1, 2.2 * s)})
		smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 1)})
		smoke.Lifetime = NumberRange.new(1.2, 2)
		smoke.Rate = 10
		smoke.Speed = NumberRange.new(0.8 * s, 1.6 * s)
		smoke.SpreadAngle = Vector2.new(180, 180)
		smoke.Acceleration = V(0, 1.2 * s, 0)
		smoke.RotSpeed = NumberRange.new(-40, 40)
		smoke.Rotation = NumberRange.new(0, 360)
		smoke.Parent = torso
		local embers = Instance.new("ParticleEmitter")
		embers.Name = "DemonEmbers"
		embers.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		embers.Color = ColorSequence.new(rgb(255, 180, 90), pal.Glow)
		embers.LightEmission, embers.LightInfluence = 1, 0
		embers.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.16 * s), NumberSequenceKeypoint.new(1, 0)})
		embers.Lifetime = NumberRange.new(0.8, 1.6)
		embers.Rate = 14
		embers.Speed = NumberRange.new(0.6 * s, 1.4 * s)
		embers.SpreadAngle = Vector2.new(180, 180)
		embers.Acceleration = V(0, 1.5 * s, 0)
		embers.Parent = torso
		parts.Aura = {smoke, embers}
	end
	rig:SetAttribute("DemonScale", s)
	rig:SetAttribute("Stand", 3 * s) -- hauteur du centre (HumanoidRootPart) au-dessus du sol, debout
	return rig, parts
end

---------------------------------------------------------------- articulations
function DemonCast.actor(rig, name)
	local a = Kit.actor(rig, name)
	for _, w in rig:GetDescendants() do
		if w:IsA("Weld") and w:GetAttribute("Joint") then a:addWeldJoint(w:GetAttribute("Joint"), w) end
	end
	return a
end
function DemonCast.joints(rig)
	local j = {}
	for _, d in rig:GetDescendants() do
		if d:IsA("Motor6D") then
			j[d.Name] = {obj = d, base = d:GetAttribute("Base") or d.C0}
		elseif d:IsA("Weld") and d:GetAttribute("Joint") then
			j[d:GetAttribute("Joint")] = {obj = d, base = d:GetAttribute("Base") or d.C0}
		end
	end
	return j
end
function DemonCast.pose(joints, pose)
	for name, j in joints do
		local v = pose[name]
		j.obj.C0 = v and (j.base * CFrame.Angles(rad(v[1] or 0), rad(v[2] or 0), rad(v[3] or 0))) or j.base
	end
end

---------------------------------------------------------------- poses (R6 : Root = buste, x < 0 = penche en avant ; épaules x > 0 = bras vers l'avant,
-- épaule droite z > 0 = bras écarté ; hanches x > 0 = jambe vers l'avant ; Neck x > 0 = lève la tête ; Jaw x < 0 = gueule ouverte ;
-- ailes : WingR {0, -repli, battement}, WingL {0, repli, -battement})
local function mirror(pose)
	local out = {}
	for k, v in pose do
		local name = string.gsub(k, "Right", "#")
		name = string.gsub(name, "Left", "Right")
		name = string.gsub(name, "#", "Left")
		if k == "WingR" then name = "WingL" elseif k == "WingL" then name = "WingR" end
		local flip = (k == "Root" or k == "Neck" or k == "Tail" or k == "Tail2" or name ~= k)
		out[name] = flip and {v[1] or 0, -(v[2] or 0), -(v[3] or 0)} or v
	end
	return out
end
DemonCast.mirror = mirror
local B = {}
B.IDLE = {RightShoulder = {14, 0, 22}, LeftShoulder = {14, 0, -22}, Root = {-8}, Neck = {6}, RightHip = {4, 0, 6}, LeftHip = {-4, 0, -6}, Tail = {-12}, Tail2 = {10},
	WingR = {0, -38, 8}, WingL = {0, 38, -8}}
B.ROAR = {Root = {16}, Neck = {32}, RightShoulder = {38, 0, 122}, LeftShoulder = {38, 0, -122}, RightHip = {6, 0, 10}, LeftHip = {-6, 0, -10}, Jaw = {-40},
	Tail = {22}, Tail2 = {16}, WingR = {0, 12, 34}, WingL = {0, -12, -34}}
B.FALL = {RightShoulder = {155, 0, 40}, LeftShoulder = {155, 0, -40}, Root = {12}, Neck = {-12}, RightHip = {-22, 0, 8}, LeftHip = {34, 0, -8}, Tail = {34}, Tail2 = {20}, Jaw = {-18}}
B.LAND = {Root = {-40}, RightShoulder = {64, 0, 12}, LeftShoulder = {-24, 0, -46}, RightHip = {72, 0, 6}, LeftHip = {-46, 0, -6}, Neck = {36}, Tail = {-24}, Tail2 = {-10},
	WingR = {0, -10, -20}, WingL = {0, 10, 20}}
B.RISE = {Root = {-14}, RightShoulder = {22, 0, 32}, LeftShoulder = {22, 0, -32}, RightHip = {30, 0, 6}, LeftHip = {-20, 0, -6}, Neck = {22}, Tail = {-6}}
B.GLARE = {Root = {-12}, Neck = {-6, 0, 0}, RightShoulder = {28, 0, 30}, LeftShoulder = {28, 0, -30}, RightHip = {8, 0, 8}, LeftHip = {-8, 0, -8}, Jaw = {-8}, Tail = {-8}}
B.SWIPE_WIND = {Root = {-8, -40, 0}, RightShoulder = {-32, 0, 82}, LeftShoulder = {40, 0, -25}, RightHip = {20}, LeftHip = {-15}, Neck = {10, 30, 0}, Tail = {0, 30, 0}, Jaw = {-14}}
B.SWIPE = {Root = {-22, 45, 0}, RightShoulder = {106, 0, -40}, LeftShoulder = {-30, 0, -30}, RightHip = {-15}, LeftHip = {35}, Neck = {18, -30, 0}, Tail = {0, -30, 0}}
B.SWIPE_L_WIND = mirror(B.SWIPE_WIND)
B.SWIPE_L = mirror(B.SWIPE)
B.BACKHAND_WIND = {Root = {-6, 36, 0}, LeftShoulder = {96, 0, 40}, RightShoulder = {20, 0, 20}, Neck = {10, -25, 0}, RightHip = {-10}, LeftHip = {20}, Tail = {0, -20, 0}}
B.BACKHAND = {Root = {-12, -46, 0}, LeftShoulder = {72, 0, -96}, RightShoulder = {10, 0, 25}, Neck = {14, 30, 0}, RightHip = {25}, LeftHip = {-15}, Tail = {0, 25, 0}, Jaw = {-20}}
B.SLAM_WIND = {RightShoulder = {170, 0, -10}, LeftShoulder = {170, 0, 10}, Root = {18}, Neck = {-6}, RightHip = {10}, LeftHip = {-8}, Jaw = {-22}, Tail = {30}, Tail2 = {20},
	WingR = {0, -8, 42}, WingL = {0, 8, -42}}
B.SLAM = {RightShoulder = {46}, LeftShoulder = {42}, Root = {-44}, Neck = {28}, RightHip = {48}, LeftHip = {-14}, Tail = {-26}, Tail2 = {-12}, WingR = {0, -42, -12}, WingL = {0, 42, 12}}
B.RECOIL = {Root = {24}, RightShoulder = {-40, 0, 60}, LeftShoulder = {-40, 0, -60}, RightHip = {26}, LeftHip = {-10}, Neck = {-22}, Jaw = {-22}, Tail = {14}}
B.STAGGER = {Root = {-26, 20, 12}, RightShoulder = {50, 0, 60}, LeftShoulder = {-30, 0, -50}, RightHip = {38}, LeftHip = {-14}, Neck = {22, 0, 15}, Jaw = {-16}}
B.HURT = {Root = {14, 0, 8}, Neck = {-18, 0, 10}, RightShoulder = {-10, 0, 40}, LeftShoulder = {-15, 0, -40}, RightHip = {-10}, LeftHip = {18}, Jaw = {-24}}
B.FLY = {Root = {30}, RightShoulder = {150, 0, 60}, LeftShoulder = {150, 0, -60}, RightHip = {-30, 0, 20}, LeftHip = {40, 0, -20}, Neck = {-25}, Jaw = {-28}, Tail = {40}, Tail2 = {24}}
B.SPLAT = {RightShoulder = {172, 0, 52}, LeftShoulder = {172, 0, -52}, RightHip = {10, 0, 20}, LeftHip = {10, 0, -20}, Neck = {-12}, Jaw = {-12}, Tail = {-30}}
B.SLUMP = {Root = {-22}, RightHip = {86, 0, 12}, LeftHip = {80, 0, -12}, RightShoulder = {8, 0, 32}, LeftShoulder = {18, 0, -26}, Neck = {-32}, Jaw = {-6}, Tail = {-20}}
B.CHANNEL = {RightShoulder = {166, 0, 30}, LeftShoulder = {166, 0, -30}, Root = {10}, Neck = {30}, RightHip = {6, 0, 12}, LeftHip = {-6, 0, -12}, Jaw = {-32}, Tail = {26}, Tail2 = {18},
	WingR = {0, 14, 44}, WingL = {0, -14, -44}}
B.THROW = {RightShoulder = {96, 0, -8}, LeftShoulder = {96, 0, 8}, Root = {-30}, Neck = {14}, RightHip = {-15}, LeftHip = {40}, Jaw = {-32}, Tail = {-22}, WingR = {0, -30, -20}, WingL = {0, 30, 20}}
B.DOWN = {RightShoulder = {20, 0, 80}, LeftShoulder = {10, 0, -70}, RightHip = {0, 0, 16}, LeftHip = {0, 0, -12}, Neck = {-10, 25, 0}, Jaw = {-10}, Tail = {0, 0, 20}}
B.KNEEL = {Root = {-22}, RightHip = {88}, LeftHip = {-70}, RightShoulder = {10, 0, 25}, LeftShoulder = {30, 0, -15}, Neck = {-12}, Jaw = {-14}, Tail = {-20}}
B.CHARGE = {Root = {-34}, RightShoulder = {-50, 0, 30}, LeftShoulder = {-50, 0, -30}, RightHip = {30}, LeftHip = {-20}, Neck = {30}, Jaw = {-26}, Tail = {16}, WingR = {0, -62, 0}, WingL = {0, 62, 0}}
B.METEOR = {RightShoulder = {176, 0, 10}, LeftShoulder = {80, 0, -30}, Root = {8}, Neck = {26}, Jaw = {-32}, RightHip = {6, 0, 8}, LeftHip = {-6, 0, -8}, Tail = {20},
	WingR = {0, 4, 46}, WingL = {0, -4, -46}}
B.SPREAD = {RightShoulder = {40, 0, 70}, LeftShoulder = {40, 0, -70}, Root = {10}, Neck = {24}, RightHip = {6, 0, 10}, LeftHip = {-6, 0, -10}, Jaw = {-34}, Tail = {24},
	WingR = {0, 20, 26}, WingL = {0, -20, -26}}
DemonCast.Poses = B

---------------------------------------------------------------- allures (cycle : la phase avance avec la distance parcourue)
local G = Kit.Gaits
-- marche lourde : le buste roule, les bras griffus balancent, la queue fouette, les ailes repliées suivent le pas
G.demonStomp = {stride = 3.6, fn = function(p)
	local s, c = sin(p), cos(p)
	return {RightHip = {30 * s}, LeftHip = {-30 * s}, RightShoulder = {16 - 20 * s, 0, 22}, LeftShoulder = {16 + 20 * s, 0, -22},
		Root = {-10 + 3 * abs(c), 6 * s, 3 * s}, Neck = {8, -5 * s, 0}, Tail = {-10, 18 * s, 0}, Tail2 = {8, 14 * sin(p - 0.8), 0},
		WingR = {0, -38, 8 + 5 * c}, WingL = {0, 38, -8 - 5 * c}}
end}
-- charge : penché en avant, griffes en arrière, grandes foulées
G.demonRun = {stride = 7, fn = function(p)
	local s = sin(p)
	return {RightHip = {18 + 52 * s}, LeftHip = {18 - 52 * s}, RightShoulder = {-46 + 30 * s, 0, 26}, LeftShoulder = {-46 - 30 * s, 0, -26},
		Root = {-32, 5 * s, 0}, Neck = {30}, Jaw = {-20}, Tail = {14, 14 * s, 0}, WingR = {0, -60, 4 * s}, WingL = {0, 60, -4 * s}}
end}

return DemonCast
