-- Outil d'édition (pas utilisé en jeu) : les 10 niveaux du dragon, dans le style du dragon de l'oeuf Dragon
-- (grosses pièces simples, arêtes adoucies). Construit avec PetBuilderKit : mêmes articulations que les animaux
-- (Weld + attribut Anim : Leg, Neck, Head, Jaw, Tail, Wing, WingTip).
local Kit = require(script.Parent.PetBuilderKit)
local rgb, shade = Kit.rgb, Kit.shade
local V = Vector3.new
local rad, floor, max = math.rad, math.floor, math.max
local M = {}
local LEVELS = 10
local INK = rgb(30, 22, 40)

function M.height(level) return 2.5 * (10 ^ ((level - 1) / 9)) end -- 2.5 studs (niveau 1) -> 25 studs (niveau 10)

function M.build(level, parent)
	local t = (level - 1) / (LEVELS - 1)
	local function L(a, b) return a + (b - a) * t end
	local flame = max(0, (level - 5) / 5)
	local p = {
		Main = rgb(214, 48, 44), Deep = rgb(150, 22, 30), Scale = rgb(176, 30, 36), Belly = rgb(255, 214, 130), Belly2 = rgb(255, 180, 80),
		Eye = rgb(255, 214, 40), Horn = rgb(240, 226, 190), HornTip = rgb(255, 250, 230), Ring = rgb(255, 200, 50),
		Spike = flame > 0 and rgb(255, 140, 30) or rgb(255, 170, 60), SpikeTip = rgb(255, 228, 96),
		Bone = rgb(110, 16, 22), Claw = rgb(240, 226, 190), WingDark = rgb(176, 36, 20), WingLight = flame > 0 and rgb(255, 170, 50) or rgb(246, 124, 50),
		Mouth = rgb(70, 10, 20), Tongue = rgb(240, 110, 130), Teeth = rgb(255, 255, 250),
	}
	local k = Kit.new("Dragon Level " .. level)

	-- ------------------------------------------------------------ corps, pattes, cou, tête, queue (proportions par niveau)
	local W, H, Lb = L(4.4, 5.4), L(3.6, 4.4), L(6.6, 10.0)
	local hs = V(L(3.9, 3.5), L(3.3, 3.0), L(3.3, 3.6))
	local q = k:quad({
		Body = p.Main, Back = p.Deep, W = W, H = H, L = Lb, Leg = L(1.9, 3.4), LegW = L(1.35, 1.7), Hoof = p.Deep,
		Neck = L(1.6, 5.2), NeckTilt = L(30, 20), NeckW = L(2.3, 2.7), Head = hs,
		TailJoints = 4, TailY = 0.4, TailStep = L(1.4, 3.0), TailRise = -0.1,
	})
	-- ventre segmenté : plaques larges, deux tons
	local nb = 4 + floor(level / 3)
	for i = 0, nb - 1 do
		local z = -Lb / 2 + 0.6 + (i + 0.5) / nb * (Lb - 1.2)
		k:box(nil, V(W - 1.4, 0.34, (Lb - 1.2) / nb * 0.9), V(0, -H / 2 - 0.02, z), i % 2 == 0 and p.Belly or p.Belly2)
	end
	-- plastron sur le poitrail
	k:box(nil, V(W - 1.6, H - 1.4, 0.34), V(0, -0.15, Lb / 2 + 0.02), p.Belly)
	k:box(nil, V(W - 2.4, H - 2.2, 0.44), V(0, -0.15, Lb / 2 + 0.04), p.Belly2)
	-- écailles en losange sur les flancs
	local ns = 2 + floor(level / 3)
	for _, s in {1, -1} do
		for i = 0, ns - 1 do
			local z = -Lb / 2 + 1.4 + (i + 0.5) / ns * (Lb - 2.8)
			k:box(nil, V(0.22, 1.1, 1.1), CFrame.new(s * (W / 2 + 0.02), 0.35 + (i % 2) * 0.5, z) * CFrame.Angles(rad(45), 0, 0), i % 2 == 0 and p.Scale or shade(p.Scale, 1.2))
		end
	end
	-- crête dorsale : gros losanges, plus hauts au milieu
	local nsp = 3 + floor(level / 2)
	local spSize = L(1.1, 2.0)
	for i = 0, nsp - 1 do
		local f = (i + 0.5) / nsp
		local z = Lb / 2 - 0.8 - f * (Lb - 1.6)
		local s = spSize * (0.75 + 0.25 * math.sin(f * math.pi))
		k:box(nil, V(0.5, s, s), CFrame.new(0, H / 2 + s * 0.28, z) * CFrame.Angles(rad(45), 0, 0), p.Spike)
		if level >= 4 then k:box(nil, V(0.54, s * 0.5, s * 0.5), CFrame.new(0, H / 2 + s * 0.62, z) * CFrame.Angles(rad(45), 0, 0), p.SpikeTip) end
	end
	-- épaulières et pointes d'épaule (niveaux 4+)
	if level >= 4 then
		for _, s in {1, -1} do
			k:rbox(nil, V(1.0, 1.6, 2.2), CFrame.new(s * (W / 2 + 0.2), H * 0.22, Lb / 2 - 1.4), p.Deep, 0.25, {Studs = false})
			k:chain(nil, CFrame.new(s * (W / 2 + 0.5), H * 0.4, Lb / 2 - 1.4) * CFrame.Angles(0, 0, rad(-s * 60)), {{0.9, 0.6, 0, s * 25, p.Horn}, {0.7, 0.38, 0, 0, p.HornTip}})
		end
	end
	-- cou : plaque ventrale + losange sur la nuque
	local neckLen = L(1.6, 5.2)
	local ncf = CFrame.new(0, H / 2 - 0.6, Lb / 2 - 0.9) * CFrame.Angles(rad(L(30, 20)), 0, 0)
	k:box(q.Neck, V(L(1.3, 1.5), neckLen + 0.2, 0.3), ncf * CFrame.new(0, neckLen / 2, L(1.15, 1.35)), p.Belly)
	local nns = 1 + floor(level / 3)
	for i = 0, nns - 1 do
		local y = (i + 0.5) / nns * neckLen
		local s = spSize * 0.8
		k:box(q.Neck, V(0.45, s, s), ncf * CFrame.new(0, y, -L(1.15, 1.35) - s * 0.2) * CFrame.Angles(rad(45), 0, 0), p.Spike)
	end

	-- ------------------------------------------------------------ TÊTE : yeux, museau, dents du haut, cornes
	local face, head, hc = q.Face, q.Head, q.HeadCenter
	for _, s in {1, -1} do
		k:eye(head, face, s, {Dx = hs.X * 0.28, Dy = hs.Y * 0.17, Size = hs.Y * 0.29, Iris = p.Eye, Glow = true, Slit = true, White = rgb(255, 250, 220), Brow = p.Deep, BrowAngle = 22})
		-- joue
		k:box(head, V(0.3, hs.Y * 0.42, hs.Z * 0.5), hc + V(s * (hs.X / 2 + 0.02), -hs.Y * 0.2, -hs.Z * 0.05), p.Deep)
	end
	local sl = L(1.7, 3.6)                                   -- longueur du museau
	local snW, snH = hs.X * 0.70, hs.Y * 0.42
	local snY = -hs.Y * 0.08                                 -- centre du museau (par rapport au centre du visage)
	local snBottom = snY - snH / 2
	k:rbox(head, V(snW, snH, sl), face * CFrame.new(0, snY, sl / 2 - 0.15), p.Main, 0.28, {Top = shade(p.Main, 1.14)})
	k:box(head, V(snW * 0.34, 0.2, sl * 0.7), face * CFrame.new(0, snY + snH / 2 + 0.04, sl * 0.4), p.Deep)                 -- arête du nez
	for _, s in {1, -1} do                                                                                                    -- narines
		k:box(head, V(snW * 0.2, snH * 0.24, 0.3), face * CFrame.new(s * snW * 0.24, snY + snH * 0.2, sl - 0.18), p.Deep)
		k:box(head, V(snW * 0.1, snH * 0.12, 0.34), face * CFrame.new(s * snW * 0.24, snY + snH * 0.2, sl - 0.16), INK)
	end
	k:box(head, V(snW - 0.7, 0.16, sl - 0.5), face * CFrame.new(0, snBottom - 0.02, sl / 2 - 0.1), p.Mouth)                 -- palais
	-- dents du haut : une rangée de chaque côté + deux crocs à l'avant
	local nt = 3 + floor(level / 3)
	local th = L(0.5, 0.7)
	for _, s in {1, -1} do
		for i = 0, nt - 1 do
			local z = 0.45 + (i + 0.5) / nt * (sl - 1.1)
			local hgt = th * (i % 2 == 0 and 1 or 0.72)
			k:box(head, V(0.26, hgt, 0.3), face * CFrame.new(s * (snW / 2 - 0.24), snBottom - hgt / 2 + 0.04, z), p.Teeth)
		end
		k:box(head, V(0.3, th * 1.5, 0.3), face * CFrame.new(s * snW * 0.26, snBottom - th * 0.75 + 0.04, sl - 0.42), p.Teeth)  -- croc
	end

	-- MÂCHOIRE articulée : charnière à l'arrière du museau
	local jawPivot = (face * CFrame.new(0, snBottom - 0.16, 0.1)).Position
	local jaw = k:joint("Jaw", jawPivot, {Parent = head})
	local jawW, jawH, jawL = snW * 0.88, hs.Y * 0.2, sl * 0.94
	local jc = CFrame.new(jawPivot) * CFrame.new(0, -jawH * 0.7, jawL / 2 - 0.1)
	k:rbox(jaw, V(jawW, jawH, jawL), jc, p.Deep, 0.16, {Studs = false})
	k:box(jaw, V(jawW * 0.5, jawH * 0.5, jawL * 0.4), jc * CFrame.new(0, -jawH * 0.55, jawL * 0.2), p.Belly)                -- menton
	k:box(jaw, V(jawW - 0.6, 0.14, jawL - 0.4), jc * CFrame.new(0, jawH / 2 + 0.02, 0), p.Mouth)
	k:box(jaw, V(jawW * 0.42, 0.2, jawL * 0.72), jc * CFrame.new(0, jawH / 2 + 0.1, -jawL * 0.06), p.Tongue)                -- langue
	for _, s in {1, -1} do                                                                                                    -- dents du bas, décalées pour s'emboîter
		for i = 0, nt - 2 do
			local z = -jawL / 2 + 0.55 + (i + 1) / nt * (sl - 1.1)
			local hgt = th * 0.8 * (i % 2 == 1 and 1 or 0.72)
			k:box(jaw, V(0.24, hgt, 0.28), jc * CFrame.new(s * (jawW / 2 - 0.22), jawH / 2 + hgt / 2 - 0.04, z), p.Teeth)
		end
		if level >= 5 then k:box(jaw, V(0.28, th * 1.3, 0.28), jc * CFrame.new(s * jawW * 0.28, jawH / 2 + th * 0.6, jawL / 2 - 0.5), p.Teeth) end
	end

	-- cornes principales, puis cornes de joue (4+), deuxième couronne (7+), collerette (9+)
	local function horn(startCf, segs, len, thick, bendX, bendZ, ring)
		local steps = {}
		for i = 1, segs do
			local f = (i - 1) / (segs - 1)
			table.insert(steps, {len * (1 - f * 0.22), thick * (1 - f * 0.68), bendX, bendZ, i == segs and p.HornTip or p.Horn})
		end
		k:chain(head, startCf, steps)
		if ring then k:box(head, V(thick + 0.32, 0.3, thick + 0.32), startCf * CFrame.new(0, len * 0.55, 0), p.Ring) end
	end
	local hLen, hTh = L(0.95, 1.9), L(0.8, 1.0)
	for _, s in {1, -1} do
		horn(CFrame.new(hc + V(s * hs.X * 0.31, hs.Y / 2 - 0.1, -hs.Z * 0.24)) * CFrame.Angles(rad(-30), 0, rad(-s * 22)), level <= 2 and 3 or 4, hLen, hTh, 14, -s * 6, true)
		if level >= 4 then horn(CFrame.new(hc + V(s * (hs.X / 2 - 0.1), -hs.Y * 0.1, -hs.Z * 0.3)) * CFrame.Angles(rad(-70), 0, rad(-s * 60)), 3, hLen * 0.6, hTh * 0.7, 10, -s * 10) end
		if level >= 7 then horn(CFrame.new(hc + V(s * hs.X * 0.12, hs.Y / 2 - 0.1, -hs.Z * 0.36)) * CFrame.Angles(rad(-42), 0, rad(-s * 8)), 3, hLen * 0.7, hTh * 0.7, 12, 0) end
		if level >= 9 then
			for i = 0, 2 do -- collerette en éventail derrière les joues
				k:box(head, V(0.3, 1.5 - i * 0.2, 1.5 - i * 0.2), CFrame.new(hc + V(s * (hs.X / 2 + 0.1), hs.Y * (0.25 - i * 0.28), -hs.Z * 0.42)) * CFrame.Angles(rad(45), rad(-s * 25), 0), i % 2 == 0 and p.Spike or p.SpikeTip)
			end
		end
	end
	if level >= 5 then -- crête sur le crâne
		for i = 0, 2 do
			local s = 1.2 - i * 0.2
			k:box(head, V(0.42, s, s), CFrame.new(hc + V(0, hs.Y / 2 + s * 0.25, hs.Z * 0.1 - i * 0.9)) * CFrame.Angles(rad(45), 0, 0), i == 0 and p.SpikeTip or p.Spike)
		end
	end

	-- ------------------------------------------------------------ PATTES : griffes
	-- (les pattes viennent de quad ; on ajoute trois griffes par pied, accrochées à l'articulation de la patte)
	local legLen, lwid = L(1.9, 3.4), L(1.35, 1.7)
	for _, d in k.Model:GetDescendants() do
		if d:IsA("Weld") and d:GetAttribute("Anim") == "Leg" then
			local jp = d.Part1
			local rel = k.Origin:PointToObjectSpace(jp.Position)
			local handle = {Part = jp}
			for c = -1, 1 do
				k:box(handle, V(lwid * 0.26, 0.5, 0.6), V(rel.X + c * lwid * 0.34, rel.Y - legLen - 0.3, rel.Z + lwid / 2 + 0.3), p.Claw)
			end
			if level >= 6 then k:box(handle, V(lwid + 0.3, 0.5, lwid + 0.3), V(rel.X, rel.Y - legLen * 0.45, rel.Z), p.Deep) end -- genouillère
		end
	end

	-- ------------------------------------------------------------ AILES de chauve-souris (plus grandes à chaque niveau)
	for _, s in {1, -1} do
		k:batWing(s, V(s * (W / 2 - 0.5), H / 2 - 0.1, Lb * 0.14), {
			Bone = p.Bone, Claw = p.Claw, Dark = p.WingDark, Light = p.WingLight,
			L1 = L(3.0, 6.4), L2 = L(3.4, 8.0), Chord = L(3.4, 7.6), Scallops = level >= 5 and 3 or 2,
		})
	end

	-- ------------------------------------------------------------ QUEUE : 4 tronçons qui s'affinent, losanges dessus, pointe
	local step = L(1.4, 3.0)
	local sizes = {{L(1.9, 2.6), L(1.7, 2.3)}, {L(1.5, 2.0), L(1.4, 1.8)}, {L(1.1, 1.5), L(1.0, 1.3)}, {L(0.75, 1.0), L(0.7, 0.9)}}
	for i, tj in q.Tails do
		k:rbox(tj.Joint, V(sizes[i][1], sizes[i][2], step + 0.3), tj.Pos + V(0, 0, -step / 2), i % 2 == 1 and p.Main or p.Deep, 0.22, {Studs = false})
		k:box(tj.Joint, V(sizes[i][1] * 0.6, 0.2, step), tj.Pos + V(0, -sizes[i][2] / 2, -step / 2), i % 2 == 0 and p.Belly or p.Belly2)
		local s = spSize * (1 - i * 0.14)
		k:box(tj.Joint, V(0.4, s, s), CFrame.new(tj.Pos + V(0, sizes[i][2] / 2 + s * 0.22, -step / 2)) * CFrame.Angles(rad(45), 0, 0), p.Spike)
	end
	local last = q.Tails[4]
	local tipZ = -step - 0.6
	if flame > 0 then -- pointe en flamme : trois losanges
		k:box(last.Joint, V(1.4, 0.5, 1.9), CFrame.new(last.Pos + V(0, 0, tipZ)) * CFrame.Angles(0, rad(45), 0), rgb(255, 140, 30))
		k:box(last.Joint, V(0.9, 0.56, 1.3), CFrame.new(last.Pos + V(0, 0.1, tipZ - 0.5)) * CFrame.Angles(0, rad(45), 0), rgb(255, 228, 96))
		k:box(last.Joint, V(0.5, 1.5, 1.5), CFrame.new(last.Pos + V(0, 0.5, tipZ + 0.1)) * CFrame.Angles(rad(45), 0, 0), rgb(255, 180, 50))
	else
		k:box(last.Joint, V(1.6, 0.44, 1.6), CFrame.new(last.Pos + V(0, 0, tipZ)) * CFrame.Angles(0, rad(45), 0), p.Spike)
	end
	-- flammes mates sur les épaules et les hanches (niveaux 8+)
	if level >= 8 then
		for _, s in {1, -1} do
			for _, z in {Lb / 2 - 1.4, -Lb / 2 + 1.4} do
				k:box(nil, V(0.5, 1.6, 1.6), CFrame.new(s * (W / 2 - 0.3), H / 2 + 0.5, z) * CFrame.Angles(rad(45), rad(s * 20), 0), rgb(255, 140, 30))
				k:box(nil, V(0.54, 0.9, 0.9), CFrame.new(s * (W / 2 - 0.3), H / 2 + 1.0, z) * CFrame.Angles(rad(45), rad(s * 20), 0), rgb(255, 228, 96))
			end
		end
	end

	-- ------------------------------------------------------------ SELLE, siège du cavalier et point d'où sort le feu
	local saddleY = H / 2 + (level >= 4 and 0.5 or 0.3)
	k:rbox(nil, V(W * 0.62, 0.7, Lb * 0.26), V(0, saddleY, -Lb * 0.04), rgb(110, 70, 44), 0.18, {Top = rgb(130, 86, 54)})
	k:box(nil, V(W * 0.66, 0.9, 0.5), V(0, saddleY + 0.25, Lb * 0.09), rgb(255, 204, 70))          -- pommeau
	k:box(nil, V(W * 0.66, 1.1, 0.4), V(0, saddleY + 0.3, -Lb * 0.17), rgb(110, 70, 44))            -- troussequin
	k:box(nil, V(W + 0.3, 0.5, 0.8), V(0, 0.3, -Lb * 0.04), rgb(90, 56, 36))                        -- sangle
	local seat = Instance.new("Seat")
	seat.Name = "Seat"
	seat.Size = V(2.2, 0.3, 2.2)
	seat.CFrame = k.Origin * CFrame.new(0, saddleY + 0.5, -Lb * 0.04) * CFrame.Angles(0, math.pi, 0) -- le cavalier regarde vers +Z
	seat.Transparency = 1
	seat.Massless = true
	seat.CanCollide, seat.CanTouch, seat.CanQuery = false, false, false
	local seatWeld = Instance.new("WeldConstraint")
	seatWeld.Part0, seatWeld.Part1 = k.Root, seat
	seatWeld.Parent = seat
	seat.Parent = k.Model
	local mouth = Instance.new("Attachment")
	mouth.Name = "Mouth"
	mouth.Parent = head.Part
	mouth.WorldCFrame = k.Origin * face * CFrame.new(0, snBottom - 0.25, sl - 0.3) * CFrame.Angles(0, math.pi, 0) -- son -Z regarde vers l'avant
	k.Model:SetAttribute("SeatHeight", saddleY + 0.5)

	-- ------------------------------------------------------------ mise à l'échelle : sommet du crâne à la hauteur voulue
	local model, root = k.Model, k.Root
	local bottom = q.Bottom                               -- sous les pieds (unités de construction, relatif au Root)
	local top = hc.Y + hs.Y / 2
	local scale = M.height(level) / (top - bottom)
	model:ScaleTo(scale)
	seat.Size = V(2.2, 0.3, 2.2)
	model:SetAttribute("GroundOffset", -bottom * scale)   -- hauteur du Root au-dessus du sol
	model:SetAttribute("Level", level)
	model:SetAttribute("Height", M.height(level))
	root.PivotOffset = CFrame.new(0, bottom * scale, 0)   -- pivot du modèle = sol sous le corps
	local old = parent:FindFirstChild(model.Name)
	if old then old:Destroy() end
	model.Parent = parent
	return model, k.Count
end

return M
