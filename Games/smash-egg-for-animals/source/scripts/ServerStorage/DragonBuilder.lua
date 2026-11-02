-- Outil d'édition (pas utilisé en jeu) : dragons en blocs, niveaux 1 à 10.
-- Portage fidèle du générateur Blender (dragons.py) : mêmes formes, mêmes proportions, même hachage de couleurs.
-- Axes internes comme dans Blender : x = droite, y = avant (tête), z = haut. Converti à la construction (avant = +Z Roblox).
local M = {}
local LEVELS = 10
local PLAYER_HEIGHT = 5

M.Palette = {
	[0] = {214, 40, 34}, {164, 26, 28}, {238, 70, 50}, {255, 150, 40}, {255, 198, 70}, {236, 222, 184}, {255, 246, 222}, {255, 214, 80},
	{24, 18, 24}, {255, 255, 255}, {250, 124, 32}, {255, 178, 54}, {212, 82, 26}, {255, 228, 96}, {255, 214, 40}, {128, 16, 20}, {250, 246, 236}, {255, 140, 30},
}
local RED, DARK, LIGHT, BELLY, BELLY2, HORN, HORNTIP, CLAW, BLACK, WHITE, MEM, MEML, MEMD, FLAME, EYE, BONE, TEETH, FLAMEO = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17

local floor, ceil, max, min, abs = math.floor, math.ceil, math.max, math.min, math.abs
local V = Vector3.new
local function int(v) return v >= 0 and floor(v) or ceil(v) end
local function pyround(v) -- arrondi "au pair" comme Python
	local f = floor(v)
	local d = v - f
	if d > 0.5 then return f + 1 elseif d < 0.5 then return f end
	return f % 2 == 0 and f or f + 1
end
local function lerp(a, b, t) return a + (b - a) * t end
local function hash3(x, y, z)
	local h = (x * 73856093 + y * 19349663 + z * 83492791) % 4294967296
	h = bit32.bxor(h, bit32.rshift(h, 13))
	h = (h * 1103) % 4294967296
	h = bit32.bxor(h, bit32.rshift(h, 16))
	return bit32.band(h, 0xFFFF) / 65535
end

local OFF = 512
local function key(x, y, z) return ((z + OFF) * 1024 + (y + OFF)) * 1024 + (x + OFF) end
local function unkey(k)
	local x = k % 1024
	local r = (k - x) / 1024
	local y = r % 1024
	return x - OFF, y - OFF, (r - y) / 1024 - OFF
end

local function set(g, x, y, z, c)
	if z >= 0 then g[key(x, y, z)] = c end
end

local function fill(g, lx, ly, lz, hx, hy, hz, test)
	local x0, y0, z0 = floor(lx), floor(ly), max(floor(lz), 0)
	local x1, y1, z1 = ceil(hx), ceil(hy), ceil(hz)
	for x = x0, x1 do
		for y = y0, y1 do
			for z = z0, z1 do
				local c = test(V(x + 0.5, y + 0.5, z + 0.5))
				if c then g[key(x, y, z)] = c end
			end
		end
	end
end

local function capsule(g, p0, p1, r0, r1, color)
	local d = p1 - p0
	local dd = max(d:Dot(d), 1e-6)
	local rm = max(r0, r1)
	local fn = type(color) == "function"
	fill(g, min(p0.X, p1.X) - rm, min(p0.Y, p1.Y) - rm, min(p0.Z, p1.Z) - rm, max(p0.X, p1.X) + rm, max(p0.Y, p1.Y) + rm, max(p0.Z, p1.Z) + rm, function(p)
		local t = math.clamp((p - p0):Dot(d) / dd, 0, 1)
		local q = p0 + d * t
		local r = r0 + (r1 - r0) * t
		local e = p - q
		if e:Dot(e) <= r * r then
			if fn then return color(p, t, q, r) end
			return color
		end
		return nil
	end)
end

local function ellipsoid(g, c, rx, ry, rz, color)
	local fn = type(color) == "function"
	fill(g, c.X - rx, c.Y - ry, c.Z - rz, c.X + rx, c.Y + ry, c.Z + rz, function(p)
		local q = p - c
		if (q.X / rx) ^ 2 + (q.Y / ry) ^ 2 + (q.Z / rz) ^ 2 <= 1 then
			if fn then return color(p) end
			return color
		end
		return nil
	end)
end

local function box(g, c, hx, hy, hz, color, bevel)
	local fn = type(color) == "function"
	bevel = bevel or 0
	fill(g, c.X - hx, c.Y - hy, c.Z - hz, c.X + hx, c.Y + hy, c.Z + hz, function(p)
		local qx, qy, qz = abs(p.X - c.X), abs(p.Y - c.Y), abs(p.Z - c.Z)
		if qx > hx or qy > hy or qz > hz then return nil end
		if bevel > 0 then
			local e = {hx - qx, hy - qy, hz - qz}
			table.sort(e)
			if e[1] + e[2] < bevel then return nil end
		end
		if fn then return color(p) end
		return color
	end)
end

local function tri(g, a, b, c, thick, color)
	local n = (b - a):Cross(c - a)
	if n.Magnitude < 1e-6 then return end
	n = n.Unit
	local v0, v1 = b - a, c - a
	local d00, d01, d11 = v0:Dot(v0), v0:Dot(v1), v1:Dot(v1)
	local den = d00 * d11 - d01 * d01
	local fn = type(color) == "function"
	fill(g, min(a.X, b.X, c.X) - thick, min(a.Y, b.Y, c.Y) - thick, min(a.Z, b.Z, c.Z) - thick, max(a.X, b.X, c.X) + thick, max(a.Y, b.Y, c.Y) + thick, max(a.Z, b.Z, c.Z) + thick, function(p)
		local dist = (p - a):Dot(n)
		if abs(dist) > thick then return nil end
		local v2 = (p - n * dist) - a
		local d20, d21 = v2:Dot(v0), v2:Dot(v1)
		local v = (d11 * d20 - d01 * d21) / den
		local w = (d00 * d21 - d01 * d20) / den
		local u = 1 - v - w
		if u >= -0.04 and v >= -0.04 and w >= -0.04 then
			if fn then return color(p, u, v, w) end
			return color
		end
		return nil
	end)
end

local function bezier(p0, p1, p2, p3, t)
	local s = 1 - t
	return p0 * (s ^ 3) + p1 * (3 * s * s * t) + p2 * (3 * s * t * t) + p3 * (t ^ 3)
end

function M.voxels(level)
	local t = (level - 1) / (LEVELS - 1)
	local N = ({16, 18, 20, 22, 24, 27, 30, 33, 36, 38})[level]
	local U = N
	local cell = N < 20 and 1 or (N < 30 and 2 or 3)
	local g = {}
	local function L(a, b) return lerp(a, b, t) end
	local function red(p)
		local h = hash3(floor(int(p.X) / cell), floor(int(p.Y) / cell), floor(int(p.Z) / cell))
		if h < 0.22 then return DARK end
		if h > 0.86 then return LIGHT end
		return RED
	end
	local function hp(p) return hash3(int(p.X), int(p.Y), int(p.Z)) end

	-- proportions
	local hipz = L(0.14, 0.22) * U
	local rc, rh = L(0.22, 0.29) * U, L(0.20, 0.25) * U
	local bl = L(0.26, 0.66) * U
	local chest = V(0, bl / 2, hipz + rc * 0.5 + L(0.0, 0.14) * U)
	local hips = V(0, -bl / 2, hipz + rh * 0.1)
	local hs = L(0.50, 0.30) * U
	local nlen = L(0.02, 0.30) * U
	local head = V(0, chest.Y + rc * 0.35 + nlen * 0.42 + L(0.02, 0.0) * U, U - hs * 0.46)
	local wf = L(1.0, 0.82)
	local flame = max(0, (level - 5) / 5)

	-- corps
	capsule(g, hips, chest, rh, rc, function(p, s, q, r)
		local d = p - q
		local ventral = V(0, 0.9 * s * s, -1).Unit
		if d.Magnitude > 0.01 and d.Unit:Dot(ventral) > 0.5 and abs(d.X) < r * 0.62 then
			local band = int((s * bl) / max(2.0, U * 0.07))
			return band % 2 == 0 and BELLY or BELLY2
		end
		return red(p)
	end)

	-- cou
	local nbase = chest + V(0, rc * 0.45, rc * 0.45)
	local ntop = head + V(0, -hs * 0.22, -hs * 0.30)
	local nr0, nr1 = L(0.16, 0.21) * U, L(0.16, 0.14) * U
	local c1 = nbase + V(0, -nlen * 0.12, nlen * 0.50)
	local c2 = ntop + V(0, -nlen * 0.30, -nlen * 0.25)
	local neck = {}
	for i = 0, 12 do neck[i] = bezier(nbase, c1, c2, ntop, i / 12) end
	for i = 0, 11 do
		local tan = (neck[min(i + 1, 12)] - neck[i]).Unit
		local front = V(0, tan.Z, -tan.Y)
		capsule(g, neck[i], neck[i + 1], lerp(nr0, nr1, i / 12), lerp(nr0, nr1, (i + 1) / 12), function(p, s, q, r)
			local d = p - q
			if d.Magnitude > 0.01 and d.Unit:Dot(front) > 0.45 and abs(d.X) < r * 0.6 then
				return i % 2 == 0 and BELLY or BELLY2
			end
			return red(p)
		end)
	end

	-- crâne, museau, mâchoire
	local sk0, sk1, sk2 = hs * 0.5 * wf, hs * 0.5, hs * 0.46
	box(g, head, sk0, sk1, sk2, red, max(1.0, hs * 0.12))
	local sl = hs * L(0.22, 0.95)
	local sn0, sn1, sn2 = hs * L(0.30, 0.30), sl / 2, hs * L(0.16, 0.20)
	local snout = head + V(0, hs * 0.5 + sl / 2 - 1, -hs * L(0.24, 0.10))
	box(g, snout, sn0, sn1, sn2, red, max(1.0, hs * 0.08))
	if level >= 2 then
		local jaw = snout + V(0, -sl * 0.08, -sn2 - max(1.0, hs * 0.07))
		box(g, jaw, sn0 * 0.86, sl / 2 * 0.95, max(1.0, hs * 0.08), level < 4 and BELLY or DARK, 0.6)
		if level >= 3 then
			local zt = int(pyround(snout.Z - sn2 - 1))
			for _, side in {1, -1} do
				local xs = int(pyround(side * (sn0 - 0.5) - 0.5))
				local y = snout.Y - sl * 0.25
				local k = 0
				while y < snout.Y + sl / 2 - 0.5 do
					if k % 2 == 0 then
						set(g, xs, int(y), zt, TEETH)
						if level >= 7 and k % 4 == 0 then set(g, xs, int(y), zt - 1, TEETH) end
					end
					y += 1
					k += 1
				end
			end
			for x = int(-sn0 + 1), int(sn0) - 1 do
				if x % 2 == 0 then set(g, x, int(snout.Y + sl / 2 - 0.6), zt, TEETH) end
			end
		end
	end
	local ny = int(snout.Y + sl / 2 - 1.2)
	local nz = int(snout.Z + sn2 - 0.2)
	for _, side in {1, -1} do
		set(g, int(side * sn0 * 0.45 - (side > 0 and 0 or 1)), ny, nz, BLACK)
	end

	-- yeux
	if level <= 2 then
		local ew, eh = max(1, int(pyround(hs * 0.16))), max(2, int(pyround(hs * 0.30)))
		local fy = floor(head.Y + hs * 0.5 - 0.01)
		for _, side in {1, -1} do
			local cx = side * hs * 0.27 * wf
			local x0 = int(pyround(cx - ew / 2))
			local z0 = int(pyround(head.Z - hs * 0.02))
			for dx = 0, ew - 1 do
				for dz = 0, eh - 1 do set(g, x0 + dx, fy, z0 + dz, BLACK) end
			end
			set(g, x0 + (side < 0 and ew - 1 or 0), fy, z0 + eh - 1, WHITE)
		end
	else
		local ew, eh = max(2, int(pyround(hs * 0.30))), max(2, int(pyround(hs * 0.20)))
		for _, side in {1, -1} do
			local xs = side > 0 and floor(sk0 - 0.01) or floor(-sk0 + 0.01)
			local y0 = int(pyround(head.Y + hs * 0.14))
			local z0 = int(pyround(head.Z + hs * 0.04))
			for dy = 0, ew - 1 do
				for dz = 0, eh - 1 do set(g, xs, y0 + dy, z0 + dz, EYE) end
			end
			set(g, xs, y0 + ew - 1, z0, BLACK)
			if eh > 1 then set(g, xs, y0 + ew - 1, z0 + eh - 1, BLACK) end
			for dy = -1, ew do
				set(g, xs, y0 + dy, z0 + eh, DARK)
				set(g, xs + (side > 0 and 1 or -1), y0 + dy, z0 + eh, DARK)
			end
			local fy = floor(head.Y + hs * 0.5 - 0.01)
			local fw = max(2, int(pyround(hs * 0.2)))
			for dx = 0, fw - 1 do
				local xf = floor(side * (sk0 - 1.0 - dx))
				for dz = 0, eh - 1 do set(g, xf, fy, z0 + dz, dx == fw - 1 and BLACK or EYE) end
				local zb = z0 + eh + (dx == 0 and 1 or 0)
				set(g, xf, fy, zb, DARK)
				set(g, xf, fy + 1, zb, DARK)
			end
		end
	end

	-- cornes
	local function horn(start, d1, d2, length, r0)
		local p0 = start
		local p1 = start + d1 * (length * 0.4)
		local p2 = start + d1 * (length * 0.6) + d2 * (length * 0.3)
		local p3 = start + d1 * (length * 0.75) + d2 * (length * 0.6)
		local n = max(4, int(length))
		for i = 0, n - 1 do
			local a, b = bezier(p0, p1, p2, p3, i / n), bezier(p0, p1, p2, p3, (i + 1) / n)
			capsule(g, a, b, lerp(r0, 0.45, i / n), lerp(r0, 0.45, (i + 1) / n), i >= n - max(1, floor(n / 4)) and HORNTIP or HORN)
		end
	end
	local hl = L(0.20, 0.42) * U
	local hr = max(1.1, L(0.065, 0.065) * U)
	for _, side in {1, -1} do
		horn(head + V(side * hs * 0.30 * wf, -hs * 0.22, hs * 0.40), V(side * 0.35, -0.45, 0.85).Unit, V(side * 0.1, 0.5, 0.75).Unit, hl, hr)
		if level >= 4 then
			horn(head + V(side * hs * 0.46 * wf, -hs * 0.30, -hs * 0.10), V(side * 0.8, -0.55, 0.15).Unit, V(side * 0.2, -0.3, 0.6).Unit, hl * 0.5, hr * 0.8)
		end
		if level >= 7 then
			horn(head + V(side * hs * 0.14 * wf, -hs * 0.38, hs * 0.42), V(side * 0.15, -0.6, 0.8).Unit, V(0, 0.3, 0.9).Unit, hl * 0.62, hr * 0.8)
		end
		if level >= 9 then
			horn(head + V(side * hs * 0.44 * wf, -hs * 0.05, -hs * 0.40), V(side * 0.7, -0.3, -0.6).Unit, V(side * 0.2, -0.6, 0.2).Unit, hl * 0.34, hr * 0.7)
		end
	end

	-- pattes
	local lr = max(1.0, L(0.08, 0.105) * U)
	local clawN = level <= 2 and 2 or 3
	local function foot(center, w, l, h)
		box(g, center, w, l, h, function(p)
			if hp(p) < flame * 0.5 then return FLAMEO end
			return red(p)
		end, 0.5)
		for k = 0, clawN - 1 do
			local cx = center.X + (k - (clawN - 1) / 2) * (2 * w / clawN)
			local cl = max(1, int(pyround(L(1, 2.4))))
			for j = 0, cl - 1 do
				set(g, floor(cx), floor(center.Y + l + j), max(0, floor(center.Z - h)), CLAW)
			end
			if level >= 5 then set(g, floor(cx), floor(center.Y + l), floor(center.Z - h + 1), CLAW) end
		end
	end
	for _, side in {1, -1} do
		local sh = chest + V(side * rc * 0.72, rc * 0.10, -rc * 0.25)
		local elbow = V(side * (rc * 0.95), chest.Y + rc * 0.05 - L(0, 0.03) * U, hipz * 0.50)
		local fpos = V(side * rc * 1.0, chest.Y + rc * 0.30, 0.0)
		capsule(g, sh, elbow, lr * 1.25, lr, red)
		capsule(g, elbow, fpos + V(0, -rc * 0.1, lr), lr, lr * 0.9, red)
		local fw, fl, fh = max(1.0, lr * 1.15), max(1.2, lr * 1.5), max(0.6, L(0.03, 0.035) * U)
		foot(fpos + V(0, fl * 0.4, fh), fw, fl, fh)
		local th = hips + V(side * rh * 0.85, rh * 0.15, -rh * 0.15)
		ellipsoid(g, th, rh * 0.62, rh * L(0.8, 1.05), rh * L(0.8, 1.0), red)
		local knee = V(side * rh * 1.05, hips.Y + rh * 0.7, hipz * 0.55)
		local ankle = V(side * rh * 1.05, hips.Y + rh * 0.05, lr * 1.1)
		capsule(g, th, knee, lr * 1.3, lr * 1.1, red)
		capsule(g, knee, ankle, lr * 1.1, lr * 0.9, red)
		foot(V(side * rh * 1.05, hips.Y + rh * 0.55, fh), fw * 1.1, fl * 1.25, fh)
	end

	-- queue
	local tl = L(0.32, 1.0) * U
	local tr0 = rh * 0.8
	local t0 = hips + V(0, -rh * 0.55, 0)
	local t1 = V(0, hips.Y - tl * 0.50, max(tr0 * 0.8, hipz * 0.55))
	local t2 = V(tl * 0.42, hips.Y - tl * 0.72, tr0 * 0.45)
	local t3 = V(tl * 0.62, hips.Y - tl * 0.22, max(1.0, U * 0.02))
	local tn = max(10, int(tl))
	local tail = {}
	for i = 0, tn do tail[i] = bezier(t0, t1, t2, t3, i / tn) end
	local tmin = max(0.7, U * 0.018)
	for i = 0, tn - 1 do
		capsule(g, tail[i], tail[i + 1], lerp(tr0, tmin, (i / tn) ^ 0.8), lerp(tr0, tmin, ((i + 1) / tn) ^ 0.8), function(p, s, q, r)
			local d = p - q
			if d.Magnitude > 0.01 and d.Unit.Z < -0.45 and r > 1.4 then
				return floor(i / 2) % 2 == 0 and BELLY or BELLY2
			end
			if flame > 0 and i > tn * (1 - 0.35 * flame) and hp(p) < 0.35 then return FLAMEO end
			return red(p)
		end)
	end
	local tip = tail[tn]
	local tdir = (tail[tn] - tail[tn - 2]).Unit
	local ts = max(1.2, L(0.03, 0.075) * U)
	local tipcol = level < 6 and HORN or FLAME
	tri(g, tip + V(0, 0, ts * 1.6), tip + tdir * ts * 2.4, tip + V(0, 0, -0.2) - tdir * ts * 0.4, max(0.6, ts * 0.35), function(p)
		if level >= 6 and hp(p) < 0.45 then return FLAMEO end
		return tipcol
	end)

	-- piquants le long de l'échine
	local spH = L(0.045, 0.13) * U
	local spW = max(2.0, L(0.06, 0.085) * U)
	local spCol = level < 6 and HORN or (level < 8 and FLAMEO or FLAME)
	local spTh = N < 26 and 0.55 or 1.05
	local function spike(base, tan, nrm, scale, col)
		local h, w = spH * scale, spW * (0.75 + 0.25 * scale)
		tri(g, base - tan * (w / 2), base + tan * (w / 2), base + nrm * h - tan * (h * 0.35), spTh, function(p, u, v, ww)
			if col == HORN and ww > 0.6 then return HORNTIP end
			if col ~= HORN and ww > 0.55 then return FLAME end
			return col
		end)
	end
	if level >= 2 then
		local step = max(2, int(pyround(spW * 0.9)))
		local acc = 0
		for i = 1, 11 do
			acc += (neck[i] - neck[i - 1]).Magnitude
			if acc >= step then
				acc = 0
				local tan = (neck[i] - neck[i - 1]).Unit
				local nrm = V(0, -tan.Z, tan.Y)
				spike(neck[i] + nrm * (lerp(nr0, nr1, i / 12) - 0.6), tan, nrm, 0.85, spCol)
			end
		end
		local nb = max(2, int(bl / step))
		local btan = (chest - hips).Unit
		local bnrm = V(0, -btan.Z, btan.Y)
		for i = 0, nb do
			local s = i / nb
			spike(hips:Lerp(chest, s) + bnrm * (lerp(rh, rc, s) - 0.6), btan, bnrm, (i > 0 and i < nb) and 1.0 or 0.8, spCol)
		end
		acc = 0
		for i = 2, tn - 2 do
			acc += (tail[i] - tail[i - 1]).Magnitude
			if acc >= step then
				acc = 0
				local f = i / tn
				local ra = lerp(tr0, tmin, f ^ 0.8)
				spike(tail[i] + V(0, 0, ra - 0.5), (tail[i - 1] - tail[i]).Unit, V(0, 0, 1), max(0.35, 1 - f), spCol)
			end
		end
	end
	if level >= 5 then
		for k = 0, 2 do
			spike(head + V(0, -hs * (0.05 + 0.18 * k), hs * 0.44), V(0, 1, 0), V(0, 0, 1), 0.7 - 0.12 * k, spCol)
		end
	end

	-- ailes
	local ws = L(0.45, 1.05) * U
	local wth = 0.55
	local br = max(0.8, L(0.03, 0.03) * U)
	for _, side in {1, -1} do
		local root = chest + V(side * rc * 0.55, -rc * 0.35, rc * 0.75)
		local elbow = root + V(side * ws * 0.22, -ws * 0.10, ws * 0.42)
		local wrist = elbow + V(side * ws * 0.30, -ws * 0.04, ws * 0.30)
		local f1 = wrist + V(side * ws * 0.50, -ws * 0.10, ws * 0.16)
		local f2 = wrist + V(side * ws * 0.56, -ws * 0.16, -ws * 0.28)
		local f3 = wrist + V(side * ws * 0.30, -ws * 0.20, -ws * 0.62)
		local f4 = root + V(side * ws * 0.16, -ws * 0.24, -ws * 0.20)
		local tips = {f1, f2, f3}
		if level >= 6 then
			tips = {f1, wrist + V(side * ws * 0.60, -ws * 0.13, -ws * 0.05), f2, f3}
		end
		local function mem(p)
			local d = (p - wrist).Magnitude / (ws * 0.62)
			if flame > 0 and d > 1.0 - 0.22 * flame then
				return d > 1.0 - 0.10 * flame and FLAME or FLAMEO
			end
			if d > 0.74 then return MEML end
			if d < 0.34 then return MEMD end
			return MEM
		end
		local function panel(a, b, c)
			local bc = (b + c) / 2
			local mid = bc + (a - bc) * 0.22
			tri(g, a, b, mid, wth, mem)
			tri(g, a, mid, c, wth, mem)
		end
		for i = 1, #tips - 1 do panel(wrist, tips[i], tips[i + 1]) end
		panel(elbow, tips[#tips], f4)
		tri(g, wrist, tips[#tips], elbow, wth, mem)
		tri(g, root, elbow, f4, wth, mem)
		capsule(g, root, elbow, br * 1.5, br * 1.2, red)
		capsule(g, elbow, wrist, br * 1.2, br, red)
		for _, tp in tips do capsule(g, wrist, tp, br * 0.9, 0.5, BONE) end
		capsule(g, elbow, f4, br * 0.7, 0.5, BONE)
		local cw = max(1.0, br)
		if level >= 3 then capsule(g, wrist, wrist + V(side * cw, 0, cw * 2.6), cw * 0.8, 0.4, HORN) end
		if level >= 5 then capsule(g, elbow, elbow + V(-side * cw * 0.5, 0, cw * 2.2), cw * 0.7, 0.4, HORN) end
	end

	-- touffes de flammes (niveaux 6+), mates
	if flame > 0 then
		local function tuft(c, r, h)
			ellipsoid(g, c + V(0, 0, h * 0.35), r, r, h * 0.6, function(p)
				return (p - c).Magnitude < r * 0.75 and FLAME or FLAMEO
			end)
			ellipsoid(g, c + V(0, -r * 0.3, h * 0.85), r * 0.55, r * 0.55, h * 0.5, FLAME)
		end
		local fr = max(1.4, U * 0.045 * (0.6 + flame))
		local fh = U * 0.11 * (0.6 + flame)
		for _, side in {1, -1} do
			tuft(chest + V(side * rc * 0.95, -rc * 0.1, rc * 0.55), fr, fh)
			if level >= 8 then
				tuft(hips + V(side * rh * 1.0, rh * 0.1, rh * 0.75), fr * 0.9, fh * 0.9)
				tuft(V(side * rc * 1.15, chest.Y + rc * 0.05, hipz * 0.55), fr * 0.7, fh * 0.7)
			end
			if level >= 9 then
				tuft(head + V(side * hs * 0.5 * wf, -hs * 0.35, hs * 0.1), fr * 0.7, fh * 0.8)
			end
		end
		tuft(tail[tn] + V(0, 0, 1), fr * 1.3, fh * 1.6)
		if level >= 10 then
			local stepI = max(3, floor(tn / 7))
			local i = 3
			while i < tn - 2 do
				tuft(tail[i] + V(0, 0, tr0 * 0.4), fr * 0.7, fh * 0.8)
				i += stepI
			end
			tuft(head + V(0, -hs * 0.45, hs * 0.5), fr, fh * 1.2)
		end
	end
	return g, N
end

-- enlève les blocs complètement enfermés (gros dragons)
local function hollow(g)
	local out = {}
	for k, c in g do
		local x, y, z = unkey(k)
		if not (g[key(x + 1, y, z)] and g[key(x - 1, y, z)] and g[key(x, y + 1, z)] and g[key(x, y - 1, z)] and g[key(x, y, z + 1)] and g[key(x, y, z - 1)]) then
			out[k] = c
		end
	end
	return out
end

-- regroupe les blocs voisins de même couleur en grandes pièces
local function merge(g)
	local keys = {}
	for k in g do table.insert(keys, k) end
	table.sort(keys)
	local boxes = {}
	for _, k in keys do
		local c = g[k]
		if c then
			local x, y, z = unkey(k)
			local sx = 1
			while g[key(x + sx, y, z)] == c do sx += 1 end
			local sy = 1
			while true do
				local ok = true
				for i = 0, sx - 1 do if g[key(x + i, y + sy, z)] ~= c then ok = false break end end
				if not ok then break end
				sy += 1
			end
			local sz = 1
			while true do
				local ok = true
				for i = 0, sx - 1 do
					for j = 0, sy - 1 do if g[key(x + i, y + j, z + sz)] ~= c then ok = false break end end
					if not ok then break end
				end
				if not ok then break end
				sz += 1
			end
			for i = 0, sx - 1 do for j = 0, sy - 1 do for kk = 0, sz - 1 do g[key(x + i, y + j, z + kk)] = nil end end end
			table.insert(boxes, {x, y, z, sx, sy, sz, c})
		end
	end
	return boxes
end

function M.height(level) return PLAYER_HEIGHT * 0.5 * (10 ^ ((level - 1) / 9)) end

-- construit le modèle : pivot au sol sous le corps, avant = +Z
function M.build(level, parent)
	local g, N = M.voxels(level)
	local count = 0
	for _ in g do count += 1 end
	local voxel = M.height(level) / N
	local boxes = merge(count > 6000 and hollow(g) or g)
	local model = Instance.new("Model")
	model.Name = string.format("Dragon Level %d", level)
	local colors = {}
	for i, c in M.Palette do colors[i] = Color3.fromRGB(c[1], c[2], c[3]) end
	for _, b in boxes do
		local p = Instance.new("Part")
		p.Name = "Stud"
		p.Anchored = true
		p.Material = Enum.Material.Plastic
		p.TopSurface = Enum.SurfaceType.Studs
		p.BottomSurface = Enum.SurfaceType.Inlet
		p.Size = Vector3.new(b[4], b[6], b[5]) * voxel
		p.Position = Vector3.new(b[1] + b[4] / 2, b[3] + b[6] / 2, b[2] + b[5] / 2) * voxel
		p.Color = colors[b[7]]
		p.Parent = model
	end
	model.WorldPivot = CFrame.new(0, 0, 0)
	model:SetAttribute("Level", level)
	model:SetAttribute("VoxelSize", voxel)
	model.Parent = parent
	return model, count, #boxes
end

return M
