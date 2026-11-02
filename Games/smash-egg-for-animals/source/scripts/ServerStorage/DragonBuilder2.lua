-- Outil d'édition (pas utilisé en jeu) : dragons niveaux 1 à 10 en GROSSES pièces (blocs orientés, wedges, membranes lisses).
-- Repère : origine au sol sous le corps, avant = +Z, haut = +Y. U = hauteur de la tête en studs.
local M = {}
local LEVELS = 10
local PLAYER_HEIGHT = 5
local rgb = Color3.fromRGB
local C = {
	Red = rgb(214, 40, 34), Dark = rgb(160, 24, 28), Light = rgb(238, 72, 52), Belly = rgb(255, 150, 40), Belly2 = rgb(255, 196, 70),
	Horn = rgb(236, 222, 184), HornTip = rgb(255, 246, 222), Claw = rgb(255, 214, 80), Black = rgb(24, 18, 24), White = rgb(255, 255, 255),
	Mem = rgb(250, 124, 32), MemL = rgb(255, 178, 54), MemD = rgb(212, 82, 26), Flame = rgb(255, 228, 96), FlameO = rgb(255, 140, 30),
	Eye = rgb(255, 214, 40), Bone = rgb(128, 16, 20), Teeth = rgb(250, 246, 236),
}
local V = Vector3.new
local rad, max, min = math.rad, math.max, math.min
local function lerp(a, b, t) return a + (b - a) * t end
local function bezier(p0, p1, p2, p3, t)
	local s = 1 - t
	return p0 * (s ^ 3) + p1 * (3 * s * s * t) + p2 * (3 * s * t * t) + p3 * (t ^ 3)
end
function M.height(level) return PLAYER_HEIGHT * 0.5 * (10 ^ ((level - 1) / 9)) end

function M.build(level, parent)
	local t = (level - 1) / (LEVELS - 1)
	local U = M.height(level)
	local function L(a, b) return lerp(a, b, t) end
	local model = Instance.new("Model")
	model.Name = string.format("Dragon Level %d", level)
	local count = 0

	local function part(size, cf, color, opts)
		local p = Instance.new(opts and opts.Wedge and "WedgePart" or "Part")
		p.Name = opts and opts.Name or "Part"
		p.Anchored = true
		p.Size = V(max(size.X, 0.05), max(size.Y, 0.05), max(size.Z, 0.05))
		p.CFrame = cf
		p.Color = color
		p.Material = Enum.Material.Plastic
		p.TopSurface = (opts and opts.Smooth) and Enum.SurfaceType.Smooth or Enum.SurfaceType.Studs
		p.BottomSurface = Enum.SurfaceType.Smooth
		p.Parent = model
		count += 1
		return p
	end
	-- bloc aux arêtes adoucies
	local function rbox(size, cf, color, bevel, top)
		local b = min(bevel or size.Y * 0.18, size.X * 0.3, size.Y * 0.3, size.Z * 0.3)
		part(V(size.X, size.Y - 2 * b, size.Z - 2 * b), cf, color, {Smooth = true})
		part(V(size.X - 2 * b, size.Y, size.Z - 2 * b), cf, top or color)
		part(V(size.X - 2 * b, size.Y - 2 * b, size.Z), cf, color, {Smooth = true})
	end
	-- repère d'un segment p0 -> p1 : -Z vers p1, +Y = dos
	local function frame(p0, p1)
		local d = p1 - p0
		local up = math.abs(d.Unit.Y) > 0.97 and V(0, 0, -1) or V(0, 1, 0)
		return CFrame.lookAt((p0 + p1) / 2, p1, up), d.Magnitude
	end
	local function seg(p0, p1, w, h, color, round, top)
		local cf, len = frame(p0, p1)
		if round then rbox(V(w, h, len + min(w, h) * 0.35), cf, color, min(w, h) * 0.2, top) else part(V(w, h, len + min(w, h) * 0.3), cf, color, {Smooth = true}) end
		return cf, len
	end
	-- triangle plein (2 wedges) : membranes des ailes
	local function tri(a, b, c, th, color)
		local ab, ac, bc = b - a, c - a, c - b
		local abd, acd, bcd = ab:Dot(ab), ac:Dot(ac), bc:Dot(bc)
		if abd > acd and abd > bcd then c, a = a, c elseif acd > bcd and acd > abd then a, b = b, a end
		ab, ac, bc = b - a, c - a, c - b
		local right = ac:Cross(ab)
		if right.Magnitude < 1e-4 then return end
		right = right.Unit
		local up = bc:Cross(right).Unit
		local back = bc.Unit
		local height = math.abs(ab:Dot(up))
		part(V(th, height, math.abs(ab:Dot(back))), CFrame.fromMatrix((a + b) / 2, right, up, back), color, {Wedge = true, Smooth = true})
		part(V(th, height, math.abs(ac:Dot(back))), CFrame.fromMatrix((a + c) / 2, -right, up, -back), color, {Wedge = true, Smooth = true})
	end
	-- piquant : losange fin posé sur le dos d'un segment
	local function spike(cf, r, size, color, tipColor)
		local th = max(0.08, size * 0.22)
		part(V(th, size, size), cf * CFrame.new(0, r + size * 0.25, 0) * CFrame.Angles(rad(45), 0, 0), color, {Smooth = true})
		if tipColor then part(V(th * 1.05, size * 0.5, size * 0.5), cf * CFrame.new(0, r + size * 0.62, 0) * CFrame.Angles(rad(45), 0, 0), tipColor, {Smooth = true}) end
	end
	local function tuft(pos, s) -- touffe de flammes mate
		part(V(s, s * 1.5, s), CFrame.new(pos + V(0, s * 0.5, 0)) * CFrame.Angles(rad(45), rad(20), rad(45)), C.FlameO, {Smooth = true})
		part(V(s * 0.6, s * 1.3, s * 0.6), CFrame.new(pos + V(0, s * 1.1, -s * 0.15)) * CFrame.Angles(rad(40), rad(60), rad(40)), C.Flame, {Smooth = true})
		part(V(s * 0.5, s * 0.9, s * 0.5), CFrame.new(pos + V(s * 0.35, s * 0.5, s * 0.2)) * CFrame.Angles(rad(30), rad(10), rad(50)), C.Flame, {Smooth = true})
	end

	-- ------------------------------------------------------------ proportions (mêmes que la version Blender)
	local hipY = L(0.14, 0.22) * U
	local rc, rh = L(0.22, 0.29) * U, L(0.20, 0.25) * U
	local bl = L(0.26, 0.66) * U
	local chest = V(0, hipY + rc * 0.5 + L(0.0, 0.14) * U, bl / 2)
	local hips = V(0, hipY + rh * 0.1, -bl / 2)
	local hs = L(0.50, 0.30) * U
	local nlen = L(0.02, 0.30) * U
	local head = V(0, U - hs * 0.46, chest.Z + rc * 0.35 + nlen * 0.42 + L(0.02, 0.0) * U)
	local wf = L(1.0, 0.82)
	local flame = max(0, (level - 5) / 5)
	local spikeCol = level < 6 and C.Horn or C.FlameO
	local spikeTip = level < 6 and C.HornTip or C.Flame

	-- ------------------------------------------------------------ corps : bassin + poitrail, plaques ventrales, piquants
	local axis = (chest - hips).Unit
	local mid = hips:Lerp(chest, 0.5)
	local hipCf = seg(hips - axis * rh * 0.55, mid + axis * rh * 0.15, rh * 2.0, rh * 1.9, C.Red, true, C.Dark)
	local chestCf = seg(mid - axis * rc * 0.25, chest + axis * rc * 0.55, rc * 2.05, rc * 2.0, C.Red, true, C.Dark)
	local nb = 3 + math.floor(level / 2)
	for i = 0, nb - 1 do
		local s = (i + 0.5) / nb
		local q = (hips - axis * rh * 0.5):Lerp(chest + axis * rc * 0.5, s)
		local r = lerp(rh, rc, s)
		local cf = CFrame.lookAt(q, q + axis)
		part(V(r * 1.25, r * 0.35, (bl + rh * 0.5 + rc * 0.5) / nb * 0.92), cf * CFrame.new(0, -r * 0.92, 0), i % 2 == 0 and C.Belly or C.Belly2, {Smooth = true})
	end
	-- plaque de poitrail
	part(V(rc * 1.3, rc * 1.3, rc * 0.3), CFrame.lookAt(chest + axis * rc * 0.62, chest + axis * rc * 2) , C.Belly, {Smooth = true})
	if level >= 2 then
		local ns = 2 + math.floor(level / 3)
		for i = 0, ns do
			local s = i / ns
			local q = hips:Lerp(chest, s)
			spike(CFrame.lookAt(q, q + axis), lerp(rh, rc, s) * 0.95, L(0.07, 0.15) * U * ((i > 0 and i < ns) and 1 or 0.8), spikeCol, spikeTip)
		end
	end
	-- écailles sombres sur les flancs
	if level >= 4 then
		for _, side in {1, -1} do
			for i = 0, 1 + math.floor(level / 4) do
				local s = 0.2 + i * 0.25
				local q = hips:Lerp(chest, s)
				local r = lerp(rh, rc, s)
				part(V(r * 0.2, r * 0.7, r * 0.7), CFrame.lookAt(q, q + axis) * CFrame.new(side * r * 0.96, r * 0.25, 0) * CFrame.Angles(rad(45), 0, 0), i % 2 == 0 and C.Dark or C.Light, {Smooth = true})
			end
		end
	end

	-- ------------------------------------------------------------ cou
	local nbase = chest + V(0, rc * 0.45, rc * 0.45)
	local ntop = head + V(0, -hs * 0.30, -hs * 0.22)
	local nr0, nr1 = L(0.16, 0.21) * U, L(0.16, 0.14) * U
	local c1 = nbase + V(0, nlen * 0.50, -nlen * 0.12)
	local c2 = ntop + V(0, -nlen * 0.25, -nlen * 0.30)
	local nn = 2 + math.floor(level / 2)
	local prev = nbase
	for i = 1, nn do
		local p = bezier(nbase, c1, c2, ntop, i / nn)
		local r = lerp(nr0, nr1, (i - 0.5) / nn)
		local cf, len = seg(prev, p, r * 1.9, r * 2.0, C.Red, true, C.Dark)
		part(V(r * 1.2, r * 0.4, len * 0.95 + r * 0.2), cf * CFrame.new(0, -r * 0.9, 0), i % 2 == 0 and C.Belly or C.Belly2, {Smooth = true})
		if level >= 3 then spike(cf, r * 0.95, L(0.06, 0.12) * U, spikeCol, spikeTip) end
		prev = p
	end

	-- ------------------------------------------------------------ tête
	local skull = V(hs * wf, hs * 0.92, hs)
	rbox(skull, CFrame.new(head), C.Red, hs * 0.12, C.Red)
	local sl = hs * L(0.22, 0.95)
	local snW, snH = hs * L(0.62, 0.60), hs * L(0.34, 0.40)
	local snout = head + V(0, -hs * L(0.24, 0.10), hs * 0.5 + sl / 2 - hs * 0.06)
	rbox(V(snW, snH, sl), CFrame.new(snout), C.Red, snH * 0.2, C.Light)
	if level >= 3 then -- bout du museau plus étroit
		rbox(V(snW * 0.78, snH * 0.8, sl * 0.3), CFrame.new(snout + V(0, -snH * 0.06, sl * 0.5)), C.Red, snH * 0.16, C.Light)
	end
	local tipZ = snout.Z + sl / 2 + (level >= 3 and sl * 0.15 or 0)
	for _, side in {1, -1} do -- naseaux
		part(V(snW * 0.12, snH * 0.14, snW * 0.14), CFrame.new(side * snW * 0.2, snout.Y + snH * 0.42, tipZ - snW * 0.12), C.Black, {Smooth = true})
	end
	if level >= 2 then -- mâchoire entrouverte
		local jawLen = sl * 0.95 + (level >= 3 and sl * 0.1 or 0)
		local jcf = CFrame.new(head.X, snout.Y - snH * 0.5, head.Z + hs * 0.3) * CFrame.Angles(rad(level >= 3 and 9 or 4), 0, 0)
		rbox(V(snW * 0.82, snH * 0.38, jawLen), jcf * CFrame.new(0, -snH * 0.22, jawLen / 2), level < 4 and C.Belly or C.Dark, snH * 0.08)
		if level >= 3 then
			local nt = 2 + math.floor(level / 2)
			local th = snH * L(0.22, 0.34)
			for _, side in {1, -1} do
				for k = 0, nt - 1 do
					local z = snout.Z - sl * 0.3 + (k + 0.5) / nt * sl * 0.9
					part(V(snW * 0.07, th * (k % 2 == 0 and 1 or 0.7), snW * 0.09), CFrame.new(side * snW * 0.42, snout.Y - snH * 0.5 - th * 0.3, z) * CFrame.Angles(rad(180), 0, 0), C.Teeth, {Wedge = true, Smooth = true})
				end
			end
			for k = -1, 1 do part(V(snW * 0.09, th, snW * 0.07), CFrame.new(k * snW * 0.24, snout.Y - snH * 0.5 - th * 0.3, tipZ - snW * 0.05), C.Teeth, {Smooth = true}) end
		end
	end
	-- yeux
	local frontZ = head.Z + hs * 0.5
	if level <= 2 then
		for _, side in {1, -1} do
			local ex, ey = side * hs * 0.27 * wf, head.Y + hs * 0.14
			part(V(hs * 0.17, hs * 0.30, hs * 0.04), CFrame.new(ex, ey, frontZ), C.Black, {Smooth = true})
			part(V(hs * 0.07, hs * 0.09, hs * 0.05), CFrame.new(ex - side * hs * 0.035, ey + hs * 0.085, frontZ + hs * 0.01), C.White, {Smooth = true})
			part(V(hs * 0.16, hs * 0.07, hs * 0.03), CFrame.new(side * hs * 0.36 * wf, head.Y - hs * 0.12, frontZ), rgb(255, 130, 120), {Smooth = true})
		end
	else
		for _, side in {1, -1} do
			local ew, eh = hs * 0.26, hs * 0.17
			local ey = head.Y + hs * 0.12
			-- face avant, à côté du museau
			local fx = side * hs * 0.31 * wf
			part(V(ew, eh, hs * 0.04), CFrame.new(fx, ey, frontZ), C.Eye, {Smooth = true})
			part(V(ew * 0.22, eh * 0.9, hs * 0.05), CFrame.new(fx - side * ew * 0.12, ey, frontZ + hs * 0.005), C.Black, {Smooth = true})
			part(V(ew * 1.35, eh * 0.55, hs * 0.14), CFrame.new(fx, ey + eh * 0.72, frontZ - hs * 0.02) * CFrame.Angles(0, 0, rad(side * 20)), C.Dark, {Smooth = true})
			-- côté du crâne
			local sx = side * (skull.X / 2)
			part(V(hs * 0.04, eh, ew), CFrame.new(sx, ey, head.Z + hs * 0.26), C.Eye, {Smooth = true})
			part(V(hs * 0.05, eh * 0.9, ew * 0.22), CFrame.new(sx, ey, head.Z + hs * 0.33), C.Black, {Smooth = true})
			part(V(hs * 0.12, eh * 0.5, ew * 1.5), CFrame.new(sx, ey + eh * 0.72, head.Z + hs * 0.24) * CFrame.Angles(rad(-12), 0, 0), C.Dark, {Smooth = true})
		end
	end
	-- cornes : chaînes de blocs qui s'affinent
	local function horn(start, d1, d2, length, w)
		local p0, p1, p2, p3 = start, start + d1 * (length * 0.4), start + d1 * (length * 0.6) + d2 * (length * 0.3), start + d1 * (length * 0.75) + d2 * (length * 0.6)
		local n = level <= 2 and 3 or 5
		local a = p0
		for i = 1, n do
			local b = bezier(p0, p1, p2, p3, i / n)
			local ww = lerp(w, w * 0.25, (i - 0.5) / n)
			seg(a, b, ww, ww, i == n and C.HornTip or C.Horn)
			a = b
		end
	end
	local hl, hw = L(0.20, 0.42) * U, L(0.12, 0.12) * U
	for _, side in {1, -1} do
		horn(head + V(side * hs * 0.30 * wf, hs * 0.40, -hs * 0.22), V(side * 0.35, 0.85, -0.45).Unit, V(side * 0.1, 0.75, 0.5).Unit, hl, hw)
		if level >= 4 then horn(head + V(side * hs * 0.46 * wf, -hs * 0.10, -hs * 0.30), V(side * 0.8, 0.15, -0.55).Unit, V(side * 0.2, 0.6, -0.3).Unit, hl * 0.5, hw * 0.75) end
		if level >= 7 then horn(head + V(side * hs * 0.14 * wf, hs * 0.42, -hs * 0.38), V(side * 0.15, 0.8, -0.6).Unit, V(0, 0.9, 0.3).Unit, hl * 0.62, hw * 0.75) end
		if level >= 9 then horn(head + V(side * hs * 0.44 * wf, -hs * 0.40, -hs * 0.05), V(side * 0.7, -0.6, -0.3).Unit, V(side * 0.2, 0.2, -0.6).Unit, hl * 0.34, hw * 0.6) end
	end
	if level >= 5 then
		for k = 0, 2 do spike(CFrame.new(head + V(0, 0, -hs * (0.05 + 0.18 * k))) * CFrame.Angles(0, math.pi, 0), hs * 0.44, hs * (0.3 - 0.05 * k), spikeCol, spikeTip) end
	end

	-- ------------------------------------------------------------ pattes
	local lr = L(0.08, 0.105) * U
	local nClaw = level <= 2 and 2 or 3
	local function foot(pos, w, l, h)
		rbox(V(w, h, l), CFrame.new(pos + V(0, h / 2, 0)), C.Red, h * 0.25, C.Light)
		for k = 0, nClaw - 1 do
			local cx = pos.X + (k - (nClaw - 1) / 2) * (w / nClaw)
			local cl = l * L(0.26, 0.36)
			part(V(w / nClaw * 0.6, h * 0.8, cl), CFrame.new(cx, pos.Y + h * 0.4, pos.Z + l / 2 + cl * 0.4) * CFrame.Angles(0, math.pi, 0), C.Claw, {Wedge = true, Smooth = true})
		end
	end
	for _, side in {1, -1} do
		-- avant
		local sh = chest + V(side * rc * 0.78, -rc * 0.25, rc * 0.10)
		local elbow = V(side * rc * 1.0, hipY * 0.55, chest.Z - L(0, 0.03) * U)
		local fpos = V(side * rc * 1.05, 0, chest.Z + rc * 0.30)
		seg(sh, elbow, lr * 2.7, lr * 2.7, C.Red, true)
		seg(elbow, fpos + V(0, lr * 0.9, -rc * 0.08), lr * 2.1, lr * 2.1, C.Red, true)
		foot(fpos + V(0, 0, lr * 0.5), lr * 2.9, lr * 3.4, lr * 1.2)
		-- arrière : grosse cuisse
		local th = hips + V(side * rh * 0.9, -rh * 0.1, rh * 0.15)
		rbox(V(rh * 1.0, rh * 1.9, rh * 1.9), CFrame.new(th) * CFrame.Angles(rad(-18), 0, rad(-side * 6)), C.Red, rh * 0.28, C.Dark)
		local knee = V(side * rh * 1.1, hipY * 0.6, hips.Z + rh * 0.8)
		local ankle = V(side * rh * 1.1, lr * 1.1, hips.Z + rh * 0.1)
		seg(knee, ankle, lr * 2.3, lr * 2.3, C.Red, true)
		foot(V(side * rh * 1.1, 0, hips.Z + rh * 0.6), lr * 3.2, lr * 4.2, lr * 1.25)
		if flame > 0 then
			tuft(sh + V(side * rc * 0.2, rc * 0.5, -rc * 0.2), L(0.05, 0.11) * U)
			if level >= 8 then
				tuft(th + V(side * rh * 0.35, rh * 0.8, 0), L(0.05, 0.1) * U)
				tuft(elbow + V(side * lr, 0, -lr), L(0.04, 0.08) * U)
			end
		end
	end

	-- ------------------------------------------------------------ queue : chaîne qui s'affine et s'enroule
	local tl = L(0.32, 1.0) * U
	local tr0 = rh * 0.8
	local t0 = hips + V(0, 0, -rh * 0.55)
	local t1 = V(0, max(tr0 * 0.8, hipY * 0.55), hips.Z - tl * 0.50)
	local t2 = V(tl * 0.42, tr0 * 0.45, hips.Z - tl * 0.72)
	local t3 = V(tl * 0.62, max(0.03, 0.02) * U + 0.02 * U, hips.Z - tl * 0.22)
	local tn = 4 + level
	local a = t0
	local lastCf
	for i = 1, tn do
		local b = bezier(t0, t1, t2, t3, i / tn)
		local f = (i - 0.5) / tn
		local r = lerp(tr0, 0.035 * U, f ^ 0.8)
		local cf, len = seg(a, b, r * 1.9, r * 1.9, i % 2 == 0 and C.Red or C.Dark, r > 0.08 * U)
		if r > 0.06 * U then part(V(r * 1.1, r * 0.35, len), cf * CFrame.new(0, -r * 0.85, 0), i % 2 == 0 and C.Belly or C.Belly2, {Smooth = true}) end
		if level >= 2 and i < tn then spike(cf, r * 0.9, L(0.06, 0.13) * U * max(0.35, 1 - f), spikeCol, spikeTip) end
		if level >= 10 and i % 3 == 0 then tuft(b + V(0, r, 0), 0.07 * U) end
		a = b
		lastCf = cf
	end
	local ts = L(0.07, 0.13) * U
	part(V(ts * 0.3, ts * 1.5, ts * 1.5), lastCf * CFrame.new(0, ts * 0.2, -ts * 0.9) * CFrame.Angles(rad(45), 0, 0), level < 6 and C.Horn or C.FlameO, {Smooth = true})
	if flame > 0 then tuft((lastCf * CFrame.new(0, 0, -ts * 1.2)).Position, ts * 1.3) end

	-- ------------------------------------------------------------ ailes : os + membranes lisses en triangles
	local ws = L(0.45, 1.05) * U
	local bw = L(0.05, 0.06) * U
	local mth = max(0.08, 0.012 * U)
	for _, side in {1, -1} do
		local root = chest + V(side * rc * 0.55, rc * 0.75, -rc * 0.35)
		local elbow = root + V(side * ws * 0.22, ws * 0.42, -ws * 0.10)
		local wrist = elbow + V(side * ws * 0.30, ws * 0.30, -ws * 0.04)
		local f1 = wrist + V(side * ws * 0.50, ws * 0.16, -ws * 0.10)
		local f2 = wrist + V(side * ws * 0.56, -ws * 0.28, -ws * 0.16)
		local f3 = wrist + V(side * ws * 0.30, -ws * 0.62, -ws * 0.20)
		local f4 = root + V(side * ws * 0.16, -ws * 0.20, -ws * 0.24)
		local tips = {f1, f2, f3}
		if level >= 6 then tips = {f1, wrist + V(side * ws * 0.60, -ws * 0.05, -ws * 0.13), f2, f3} end
		-- un panneau festonné entre deux doigts : intérieur sombre, bord clair (ou flamme)
		local function panel(o, b, c)
			local bc = (b + c) / 2
			local m = bc + (o - bc) * 0.22
			local k = 0.58
			local b2, c2, m2 = o:Lerp(b, k), o:Lerp(c, k), o:Lerp(m, k)
			local edge = flame > 0 and C.FlameO or C.MemL
			tri(o, b2, m2, mth, C.MemD)
			tri(o, m2, c2, mth, C.MemD)
			tri(b2, b, m, mth, edge)
			tri(b2, m, m2, mth, C.Mem)
			tri(m2, m, c, mth, edge)
			tri(m2, c, c2, mth, C.Mem)
		end
		for i = 1, #tips - 1 do panel(wrist, tips[i], tips[i + 1]) end
		panel(elbow, tips[#tips], f4)
		tri(wrist, tips[#tips], elbow, mth, C.MemD)
		tri(root, elbow, f4, mth, C.MemD)
		seg(root, elbow, bw * 2.0, bw * 2.0, C.Red, true)
		seg(elbow, wrist, bw * 1.6, bw * 1.6, C.Red, true)
		for _, tp in tips do
			local midp = wrist:Lerp(tp, 0.5)
			seg(wrist, midp, bw * 1.1, bw * 1.1, C.Bone)
			seg(midp, tp, bw * 0.7, bw * 0.7, C.Bone)
			if level >= 3 then part(V(bw * 0.6, bw * 1.4, bw * 0.6), CFrame.new(tp) * CFrame.Angles(rad(45), 0, rad(45)), flame > 0 and C.Flame or C.Horn, {Smooth = true}) end
		end
		seg(elbow, f4, bw * 0.8, bw * 0.8, C.Bone)
		if level >= 3 then seg(wrist, wrist + V(side * bw, bw * 3.2, 0), bw * 1.0, bw * 1.0, C.Horn) end
		if level >= 5 then seg(elbow, elbow + V(-side * bw * 0.5, bw * 2.6, 0), bw * 0.9, bw * 0.9, C.Horn) end
	end
	if level >= 9 then
		for _, side in {1, -1} do tuft(head + V(side * hs * 0.5 * wf, hs * 0.1, -hs * 0.35), 0.06 * U) end
	end
	if level >= 10 then tuft(head + V(0, hs * 0.5, -hs * 0.45), 0.09 * U) end

	model.WorldPivot = CFrame.new(0, 0, 0)
	model:SetAttribute("Level", level)
	model.Parent = parent
	return model, count
end

return M
