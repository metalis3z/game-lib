-- Carte des zones d'œufs : 11 zones en ligne (les trois nouvelles : Dino, Candy, Angel ; la zone Halloween tout au fond),
-- couloir élargi de chaque côté par des bords surélevés, et sur ces bords les décors en blocs à studs du thème de chaque zone.
-- return function() -> rapport. Peut être relancé : il refait les bords et les décors ; le couloir n'est rallongé / élargi qu'une fois.
local V, C, A, rad = Vector3.new, CFrame.new, CFrame.Angles, math.rad
local rgb = Color3.fromRGB
local ZONE_W = 150.73  -- longueur de la première zone
local GROW = 0.1       -- chaque zone est plus longue que la précédente de 10 % de la première (x1, x1,1 ... x2 pour la 11e)
local GAP = 27.9       -- largeur de la bande entre deux zones : l'épaisseur d'un mur de la safe zone
local STRAW = rgb(226, 200, 120) -- couleur paille des bandes
local rng = Random.new(20261012)

---------------------------------------------------------------- briques
local function block(model, size, cf, color, o)
	o = o or {}
	local p = Instance.new("Part")
	p.Name = o.name or "Stud"
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Anchored = true
	p.CanCollide = o.collide ~= false
	p.CanTouch, p.CanQuery = false, o.collide ~= false
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Material = o.neon and Enum.Material.Neon or Enum.Material.Plastic
	if not o.neon then pcall(function() p.MaterialVariant = "Studs" end) end
	p.CastShadow = false -- anti-lag : les décors ne projettent pas d'ombre
	p.Parent = model
	return p
end
local function prop(name)
	local m = Instance.new("Model")
	m.Name = name
	m.WorldPivot = CFrame.new() -- les décors sont construits autour de l'origine, sol à y = 0
	return m
end
-- pose un décor construit autour de l'origine (sol à y = 0)
local function place(m, parent, cf, scale)
	m.WorldPivot = C()
	m.Parent = parent
	if scale and scale ~= 1 then m:ScaleTo(scale) end
	m:PivotTo(cf)
	return m
end
local function shade(color, k) return color:Lerp(k < 0 and Color3.new(0, 0, 0) or Color3.new(1, 1, 1), math.abs(k)) end
local function pick(list) return list[rng:NextInteger(1, #list)] end

---------------------------------------------------------------- DINO
local BONE, BONE2 = rgb(238, 230, 204), rgb(206, 194, 160)
local function cycad(height)
	local m = prop("PrehistoricTree")
	local browns = {rgb(110, 74, 40), rgb(132, 92, 52), rgb(92, 62, 34)}
	local n = math.floor(height / 3)
	for i = 0, n - 1 do
		local w = 4.2 - 1.2 * i / n
		block(m, V(w, 3, w), C(math.sin(i * 0.9) * 0.3, 1.5 + i * 3, math.cos(i * 1.3) * 0.3) * A(0, rad(i * 22), 0), browns[i % 3 + 1])
	end
	local top = n * 3
	local greens = {rgb(58, 150, 62), rgb(82, 178, 70), rgb(40, 120, 56)}
	for f = 0, 8 do -- palmes : trois tronçons qui retombent
		local cf = C(0, top, 0) * A(0, rad(f * 40), 0)
		for s = 0, 2 do
			cf = cf * A(rad(s == 0 and 22 or -24), 0, 0)
			block(m, V(2.6 - s * 0.5, 0.9, 5.2), cf * C(0, 0, -2.6), greens[(f + s) % 3 + 1], {collide = false})
			cf = cf * C(0, 0, -5.2)
		end
	end
	block(m, V(3, 2.4, 3), C(0, top + 0.6, 0), greens[1], {collide = false})
	return m
end
local function fern()
	local m = prop("Fern")
	local greens = {rgb(64, 160, 70), rgb(96, 190, 80), rgb(44, 128, 60)}
	for f = 0, 6 do
		local cf = C(0, 0.4, 0) * A(0, rad(f * 51 + 10), 0) * A(rad(48), 0, 0)
		for s = 0, 2 do
			block(m, V(1.6 - s * 0.35, 0.6, 2.6), cf * C(0, 0, -1.3), greens[(f + s) % 3 + 1], {collide = false})
			cf = cf * C(0, 0, -2.6) * A(rad(-26), 0, 0)
		end
	end
	return m
end
local function rock(size)
	local m = prop("Rock")
	local greys = {rgb(120, 116, 110), rgb(98, 96, 94), rgb(142, 136, 126)}
	block(m, V(size, size * 0.7, size * 0.9), C(0, size * 0.35, 0) * A(0, rad(rng:NextInteger(0, 80)), 0), greys[1])
	block(m, V(size * 0.6, size * 0.6, size * 0.6), C(size * 0.45, size * 0.3, size * 0.2) * A(0, rad(rng:NextInteger(0, 80)), 0), greys[2])
	block(m, V(size * 0.5, size * 0.45, size * 0.55), C(-size * 0.3, size * 0.9, 0) * A(0, rad(rng:NextInteger(0, 80)), 0), greys[3])
	return m
end
local function volcano()
	local m = prop("Volcano")
	local rocks = {rgb(84, 62, 52), rgb(70, 52, 46), rgb(100, 72, 58)}
	local layers = 11
	for i = 0, layers - 1 do
		local w = 44 - i * 3.3
		block(m, V(w, 3.4, w), C(0, 1.7 + i * 3.4, 0) * A(0, rad(i * 7), 0), rocks[i % 3 + 1])
	end
	local top = layers * 3.4
	block(m, V(6.5, 1, 6.5), C(0, top + 0.2, 0), rgb(255, 140, 30), {neon = true, collide = false})
	for s = 0, 2 do -- coulées de lave sur les flancs
		local cf = C(0, top, 0) * A(0, rad(20 + s * 120), 0)
		for i = 1, 8 do
			block(m, V(2.2 - i * 0.1, 0.5, 4.2), cf * C(0, -i * 3.4 + 1.9, -(4 + i * 1.66)) * A(rad(-46), 0, 0), i % 2 == 0 and rgb(255, 120, 20) or rgb(255, 190, 50), {neon = true, collide = false})
		end
	end
	local smoke = Instance.new("ParticleEmitter")
	smoke.Texture = "rbxasset://textures/particles/smoke_main.dds"
	smoke.Color = ColorSequence.new(rgb(90, 80, 80), rgb(40, 36, 36))
	smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4), NumberSequenceKeypoint.new(1, 14)})
	smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
	smoke.Lifetime, smoke.Rate, smoke.Speed = NumberRange.new(4, 6), 5, NumberRange.new(5, 8)
	smoke.SpreadAngle = Vector2.new(12, 12)
	local mouth = block(m, V(4, 1, 4), C(0, top + 1, 0), rgb(255, 170, 40), {neon = true, collide = false, name = "Mouth"})
	smoke.Parent = mouth
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = rgb(255, 140, 40), 40, 2
	light.Parent = mouth
	return m
end
local function skeleton()
	local m = prop("DinoSkeleton")
	-- colonne vertébrale, côtes, crâne, queue
	for i = 0, 9 do block(m, V(2, 2, 3.2), C(0, 10 + math.sin(i * 0.5) * 0.8, -14 + i * 3.2), i % 2 == 0 and BONE or BONE2) end
	for i = 0, 5 do
		local z = -11 + i * 4
		for _, side in {-1, 1} do
			local cf = C(side * 1, 10, z)
			block(m, V(4.6, 1.1, 1.1), cf * A(0, 0, rad(side * -18)) * C(side * 2.3, 0, 0), BONE)
			block(m, V(1.1, 6.6, 1.1), cf * C(side * 4.6, -4, 0) * A(0, 0, rad(side * 10)), BONE2)
			block(m, V(2.2, 1.1, 1.1), cf * C(side * 3.6, -7.6, 0), BONE)
		end
	end
	for i = 1, 6 do block(m, V(2 - i * 0.2, 2 - i * 0.2, 3.4), C(0, 10 - i * 1.3, 18 + i * 3) * A(rad(-22), 0, 0), i % 2 == 0 and BONE or BONE2) end
	for _, z in {-12, 14} do -- pattes
		for _, side in {-1, 1} do
			block(m, V(1.6, 7, 1.6), C(side * 5, 3.5, z), BONE2)
			block(m, V(2.6, 1, 3.4), C(side * 5, 0.5, z - 0.8), BONE)
		end
	end
	local head = C(0, 13, -21) * A(rad(-12), 0, 0)
	block(m, V(2, 2, 5), C(0, 11.5, -17) * A(rad(-25), 0, 0), BONE2)
	block(m, V(6, 5, 8), head, BONE)
	block(m, V(5, 1.6, 6.5), head * C(0, -3.6, -0.6) * A(rad(14), 0, 0), BONE2)
	for _, side in {-1, 1} do
		block(m, V(0.4, 1.8, 2), head * C(side * 3, 0.8, -1), rgb(40, 34, 30), {collide = false})
		for t = 0, 3 do block(m, V(0.7, 1.2, 0.7), head * C(side * 2, -2.9, -3.2 + t * 1.5), rgb(255, 250, 235), {collide = false}) end
	end
	return m
end
local function loneBone(len)
	local m = prop("Bone")
	block(m, V(1.6, len, 1.6), C(0, len / 2 - 1, 0) * A(rad(14), 0, rad(-9)), BONE)
	local top = C(0, len / 2 - 1, 0) * A(rad(14), 0, rad(-9)) * C(0, len / 2, 0)
	block(m, V(2.2, 1.8, 2.2), top * C(-0.9, 0.4, 0), BONE2)
	block(m, V(2.2, 1.8, 2.2), top * C(0.9, 0.4, 0), BONE2)
	return m
end

---------------------------------------------------------------- CANDY
local CANDY = {rgb(255, 92, 150), rgb(120, 220, 255), rgb(255, 214, 80), rgb(170, 120, 255), rgb(120, 235, 150), rgb(255, 150, 70)}
local WHITE, RED = rgb(255, 250, 250), rgb(232, 44, 60)
local function candyCane(height, stripe)
	local m = prop("CandyCane")
	local s = 2.6
	local n = math.floor(height / s)
	local cf = C(0, 0, 0)
	for i = 0, n - 1 do block(m, V(s, s, s), C(0, s / 2 + i * s, 0), i % 2 == 0 and WHITE or stripe) end
	cf = C(0, n * s, 0)
	for i = 0, 5 do -- la crosse
		cf = cf * A(0, 0, rad(-30))
		block(m, V(s, s, s), cf * C(0, s / 2, 0), (n + i) % 2 == 0 and WHITE or stripe)
		cf = cf * C(0, s * 0.82, 0)
	end
	return m
end
local function lollipop(height, a, b)
	local m = prop("Lollipop")
	block(m, V(1.3, height, 1.3), C(0, height / 2, 0), WHITE)
	local c = C(0, height + 4.5, 0)
	block(m, V(11, 11, 1.6), c, a)
	block(m, V(8, 8, 2.1), c, b, {collide = false})
	block(m, V(5, 5, 2.6), c, a, {collide = false})
	block(m, V(2, 2, 3.1), c, b, {collide = false})
	return m
end
local function gumdrop(size, color)
	local m = prop("Gumdrop")
	for i = 0, 3 do
		local w = size * (1 - i * 0.2)
		block(m, V(w, size * 0.3, w), C(0, size * 0.15 + i * size * 0.3, 0), shade(color, i * 0.07))
	end
	for _ = 1, 10 do -- sucre
		local a, y = rng:NextNumber(0, 6.28), rng:NextNumber(0.1, 1.0) * size
		local r = size * (0.5 - y / size * 0.3)
		block(m, V(0.5, 0.5, 0.5), C(math.cos(a) * r, y, math.sin(a) * r), WHITE, {collide = false})
	end
	return m
end
local function cupcake(size, frosting)
	local m = prop("Cupcake")
	local wrap = {rgb(120, 200, 255), rgb(90, 170, 240)}
	for i = 0, 2 do block(m, V(size * (0.7 + i * 0.1), size * 0.22, size * (0.7 + i * 0.1)), C(0, size * (0.11 + i * 0.22), 0), wrap[i % 2 + 1]) end
	for i = 0, 3 do
		local w = size * (1.05 - i * 0.24)
		block(m, V(w, size * 0.2, w), C(0, size * (0.76 + i * 0.2), 0) * A(0, rad(i * 22), 0), shade(frosting, i * 0.1))
	end
	block(m, V(size * 0.2, size * 0.2, size * 0.2), C(0, size * 1.56, 0), RED)
	block(m, V(size * 0.05, size * 0.2, size * 0.05), C(size * 0.05, size * 1.74, 0) * A(0, 0, rad(-20)), rgb(70, 140, 60), {collide = false})
	for _ = 1, 14 do
		local a = rng:NextNumber(0, 6.28)
		block(m, V(0.9, 0.3, 0.3), C(math.cos(a) * size * 0.4, size * rng:NextNumber(0.9, 1.3), math.sin(a) * size * 0.4) * A(0, a, rad(30)), pick(CANDY), {collide = false})
	end
	return m
end
local function donut(radius, glaze)
	local m = prop("Donut")
	local dough = rgb(226, 170, 100)
	local t = radius * 0.62
	for i = 0, 11 do
		local cf = A(0, rad(i * 30), 0) * C(radius, 0, 0)
		block(m, V(t, t, radius * 0.6), C(0, t / 2, 0) * cf, dough)
		block(m, V(t * 0.86, t * 0.3, radius * 0.6), C(0, t + t * 0.1, 0) * cf, glaze, {collide = false})
		block(m, V(0.9, 0.3, 0.3), C(0, t * 1.28, 0) * cf * A(0, rad(rng:NextInteger(0, 180)), 0), pick(CANDY), {collide = false})
	end
	return m
end
local function iceCream(size)
	local m = prop("IceCream")
	local waffle = {rgb(226, 170, 96), rgb(204, 146, 76)}
	for i = 0, 6 do
		local w = size * (0.22 + i * 0.13)
		block(m, V(w, size * 0.32, w), C(0, size * (0.16 + i * 0.32), 0), waffle[i % 2 + 1])
	end
	local y = size * 2.24
	local scoops = {rgb(255, 170, 200), rgb(255, 244, 214), rgb(150, 220, 190)}
	for i = 0, 2 do
		local w = size * (1.2 - i * 0.18)
		block(m, V(w, size * 0.7, w), C(0, y + size * (0.35 + i * 0.62), 0) * A(0, rad(i * 30), 0), scoops[i + 1])
	end
	block(m, V(size * 0.25, size * 0.25, size * 0.25), C(0, y + size * 2.12, 0), RED)
	return m
end
local function chocolate(size)
	local m = prop("ChocolateBar")
	local brown, dark = rgb(112, 66, 40), rgb(88, 50, 30)
	block(m, V(size, size * 1.6, size * 0.2), C(0, size * 0.8, 0), dark)
	for x = 0, 2 do
		for y = 0, 3 do
			block(m, V(size * 0.27, size * 0.25, size * 0.1), C((x - 1) * size * 0.31, size * (0.84 + y * 0.2), -size * 0.12), brown, {collide = false})
		end
	end
	block(m, V(size * 1.04, size * 0.7, size * 0.26), C(0, size * 0.35, 0), rgb(232, 44, 60))
	block(m, V(size * 1.06, size * 0.1, size * 0.28), C(0, size * 0.72, 0), rgb(232, 232, 240), {collide = false})
	return m
end

---------------------------------------------------------------- SKY
local GOLD, MARBLE, CLOUD = rgb(255, 208, 70), rgb(244, 244, 250), rgb(255, 255, 255)
local function cloud(size, collide)
	local m = prop("Cloud")
	for i = 1, 8 do
		local w = size * rng:NextNumber(0.35, 0.7)
		block(m, V(w, size * rng:NextNumber(0.18, 0.34), w * rng:NextNumber(0.7, 1.1)),
			C(rng:NextNumber(-0.5, 0.5) * size, size * rng:NextNumber(0.1, 0.3), rng:NextNumber(-0.3, 0.3) * size), i % 3 == 0 and rgb(232, 240, 255) or CLOUD, {collide = collide, shadow = false})
	end
	return m
end
local function column(height)
	local m = prop("Column")
	block(m, V(7, 1.6, 7), C(0, 0.8, 0), MARBLE)
	block(m, V(5.6, 1, 5.6), C(0, 2.1, 0), GOLD)
	block(m, V(4, height, 4), C(0, 2.6 + height / 2, 0), MARBLE)
	for _, d in {V(1, 0, 0), V(-1, 0, 0), V(0, 0, 1), V(0, 0, -1)} do
		block(m, V(d.X ~= 0 and 0.5 or 1.4, height, d.Z ~= 0 and 0.5 or 1.4), C(d.X * 2.1, 2.6 + height / 2, d.Z * 2.1), rgb(226, 228, 240), {collide = false})
	end
	block(m, V(5.6, 1, 5.6), C(0, 3.1 + height, 0), GOLD)
	block(m, V(7, 1.6, 7), C(0, 4.4 + height, 0), MARBLE)
	return m
end
local function rainbow(radius)
	local m = prop("Rainbow")
	local colors = {rgb(255, 80, 80), rgb(255, 160, 60), rgb(255, 230, 80), rgb(110, 230, 110), rgb(90, 180, 255), rgb(150, 110, 255)}
	for band, color in colors do
		local r = radius - (band - 1) * 1.5
		local seg = math.pi * r / 18
		for i = 0, 17 do
			local a = math.pi * (i + 0.5) / 18
			block(m, V(seg * 1.08, 1.5, 2), C(math.cos(a) * r, math.sin(a) * r, 0) * A(0, 0, a + math.pi / 2), color, {collide = false, shadow = false})
		end
	end
	return m
end
local function star(size)
	local m = prop("Star")
	block(m, V(size, size * 0.34, size * 0.34), C(), rgb(255, 236, 120), {neon = true, collide = false, shadow = false})
	block(m, V(size * 0.34, size, size * 0.34), C(), rgb(255, 236, 120), {neon = true, collide = false, shadow = false})
	block(m, V(size * 0.6, size * 0.6, size * 0.3), C() * A(0, 0, rad(45)), rgb(255, 250, 190), {neon = true, collide = false, shadow = false})
	return m
end
local function temple()
	local m = prop("Temple")
	block(m, V(34, 2, 26), C(0, 1, 0), MARBLE)
	block(m, V(30, 1.6, 22), C(0, 2.8, 0), rgb(232, 234, 246))
	for _, x in {-12, -4, 4, 12} do
		for _, z in {-8, 8} do
			block(m, V(3, 16, 3), C(x, 11.6, z), MARBLE)
			block(m, V(4, 1, 4), C(x, 4.1, z), GOLD)
			block(m, V(4, 1, 4), C(x, 19.9, z), GOLD)
		end
	end
	block(m, V(32, 2, 24), C(0, 21.4, 0), MARBLE)
	for i = 0, 4 do block(m, V(30 - i * 6, 1.6, 24), C(0, 23.2 + i * 1.6, 0), i % 2 == 0 and GOLD or MARBLE) end
	local orb = block(m, V(4, 4, 4), C(0, 9, 0) * A(rad(45), rad(45), 0), rgb(255, 240, 150), {neon = true, collide = false})
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = rgb(255, 236, 150), 36, 2
	light.Parent = orb
	return m
end

---------------------------------------------------------------- portail d'entrée : deux piliers contre les murs et une poutre à travers le couloir
local function gate(folder, x, floorY, zNorth, zSouth, key)
	local m = prop("EntranceGate")
	local width = zNorth - zSouth
	local zMid = (zNorth + zSouth) / 2
	local beamY = 54
	if key == "Dino" then
		for _, z in {zNorth - 2.5, zSouth + 2.5} do
			for i = 0, 17 do block(m, V(5 - (i % 2) * 0.6, 3, 5 - (i % 2) * 0.6), C(x, floorY + 1.5 + i * 3, z) * A(0, rad(i * 12), 0), i % 2 == 0 and rgb(120, 116, 110) or rgb(98, 96, 94)) end
		end
		for i = 0, math.floor(width / 5) - 1 do -- poutre d'os
			local z = zSouth + 2.5 + i * 5
			block(m, V(2.6, 2.6, 5.1), C(x, floorY + beamY, z), i % 2 == 0 and BONE or BONE2, {collide = false})
			if i % 3 == 1 then -- lianes
				local len = rng:NextInteger(6, 16)
				block(m, V(0.6, len, 0.6), C(x, floorY + beamY - 1.3 - len / 2, z), rgb(50, 130, 60), {collide = false})
				block(m, V(2, 1.2, 2), C(x, floorY + beamY - 1.3 - len, z), rgb(82, 178, 70), {collide = false})
			end
		end
		-- crâne au milieu
		local head = C(x - 1, floorY + beamY + 3.4, zMid) * A(0, rad(90), 0)
		block(m, V(9, 7, 10), head, BONE, {collide = false})
		for _, side in {-1, 1} do
			block(m, V(2.2, 2.4, 0.6), head * C(side * 2.3, 0.8, -5.1), rgb(40, 34, 30), {collide = false})
			block(m, V(1.4, 5, 1.4), head * C(side * 3.6, 5, 2) * A(0, 0, rad(side * -20)), BONE2, {collide = false})
		end
	elseif key == "Candy" then
		for _, z in {zNorth - 2.5, zSouth + 2.5} do
			for i = 0, 17 do block(m, V(5, 3, 5), C(x, floorY + 1.5 + i * 3, z), i % 2 == 0 and WHITE or RED) end
		end
		for i = 0, math.floor(width / 5) - 1 do
			local z = zSouth + 2.5 + i * 5
			block(m, V(3, 3, 5.1), C(x, floorY + beamY, z), i % 2 == 0 and RED or WHITE, {collide = false})
			if i % 4 == 2 then -- sucettes suspendues
				local len = rng:NextInteger(5, 11)
				block(m, V(0.5, len, 0.5), C(x, floorY + beamY - 1.5 - len / 2, z), WHITE, {collide = false})
				local color = pick(CANDY)
				block(m, V(1.4, 5, 5), C(x, floorY + beamY - 4 - len, z), color, {collide = false})
				block(m, V(1.8, 3, 3), C(x, floorY + beamY - 4 - len, z), WHITE, {collide = false})
			end
		end
	else
		for _, z in {zNorth - 3.5, zSouth + 3.5} do
			local col = column(47)
			place(col, m, C(x, floorY, z))
		end
		for i = 0, math.floor(width / 5) - 1 do
			local z = zSouth + 2.5 + i * 5
			block(m, V(4, 3, 5.1), C(x, floorY + beamY, z), i % 2 == 0 and GOLD or MARBLE, {collide = false})
			if i % 4 == 2 then -- étoiles suspendues
				local len = rng:NextInteger(5, 12)
				block(m, V(0.3, len, 0.3), C(x, floorY + beamY - 1.5 - len / 2, z), GOLD, {collide = false})
				place(star(3.4), m, C(x, floorY + beamY - 3 - len, z) * A(0, rad(90), 0))
			end
		end
	end
	m.Parent = folder
end

---------------------------------------------------------------- FOREST
local LEAF = {rgb(70, 170, 70), rgb(96, 196, 84), rgb(48, 138, 62)}
local WOOD = {rgb(118, 80, 46), rgb(98, 66, 38)}
local function oak(height)
	local m = prop("Oak")
	local n = math.floor(height * 0.45 / 3)
	for i = 0, n - 1 do block(m, V(4, 3, 4), C(0, 1.5 + i * 3, 0) * A(0, rad(i * 15), 0), WOOD[i % 2 + 1]) end
	local y = n * 3
	local w = height * 0.5
	block(m, V(w, w * 0.6, w), C(0, y + w * 0.3, 0), LEAF[1])
	block(m, V(w * 0.7, w * 0.5, w * 0.7), C(w * 0.3, y + w * 0.7, w * 0.15) * A(0, rad(20), 0), LEAF[2], {collide = false})
	block(m, V(w * 0.65, w * 0.45, w * 0.65), C(-w * 0.3, y + w * 0.62, -w * 0.2) * A(0, rad(-25), 0), LEAF[3], {collide = false})
	block(m, V(w * 0.55, w * 0.45, w * 0.55), C(0, y + w * 1.0, 0) * A(0, rad(40), 0), LEAF[2], {collide = false})
	for _ = 1, 4 do block(m, V(1.2, 1.2, 1.2), C(rng:NextNumber(-0.45, 0.45) * w, y + rng:NextNumber(0.1, 0.5) * w, (rng:NextNumber() < 0.5 and -1 or 1) * w * 0.5), rgb(232, 50, 50), {collide = false}) end
	return m
end
local function pine(height, snowy)
	local m = prop("Pine")
	block(m, V(3, height * 0.25, 3), C(0, height * 0.125, 0), WOOD[1])
	local layers = 6
	for i = 0, layers - 1 do
		local w = height * 0.52 * (1 - i / layers * 0.85)
		local y = height * 0.25 + i * height * 0.125
		block(m, V(w, height * 0.13, w), C(0, y + height * 0.065, 0) * A(0, rad(i * 45), 0), snowy and rgb(60, 130, 110) or LEAF[i % 3 + 1])
		if snowy then block(m, V(w * 0.8, height * 0.03, w * 0.8), C(0, y + height * 0.14, 0) * A(0, rad(i * 45), 0), rgb(250, 252, 255), {collide = false}) end
	end
	return m
end
local function bush()
	local m = prop("Bush")
	for i = 1, 4 do
		local w = rng:NextNumber(2.4, 4.2)
		block(m, V(w, w * 0.8, w), C(rng:NextNumber(-1.6, 1.6), w * 0.4, rng:NextNumber(-1.6, 1.6)) * A(0, rad(rng:NextInteger(0, 80)), 0), LEAF[i % 3 + 1], {collide = false})
	end
	for _ = 1, 3 do block(m, V(0.8, 0.8, 0.8), C(rng:NextNumber(-2, 2), rng:NextNumber(1.6, 3), rng:NextNumber(-2, 2)), pick({rgb(255, 90, 140), rgb(255, 220, 80), rgb(255, 255, 255)}), {collide = false}) end
	return m
end
local function mushroom(size, cap)
	local m = prop("Mushroom")
	block(m, V(size * 0.35, size * 0.7, size * 0.35), C(0, size * 0.35, 0), rgb(244, 236, 214))
	block(m, V(size * 1.2, size * 0.3, size * 1.2), C(0, size * 0.85, 0), cap)
	block(m, V(size * 0.8, size * 0.25, size * 0.8), C(0, size * 1.12, 0), cap)
	for _ = 1, 5 do block(m, V(size * 0.16, size * 0.08, size * 0.16), C(rng:NextNumber(-0.45, 0.45) * size, size * 1.01, rng:NextNumber(-0.45, 0.45) * size), WHITE, {collide = false}) end
	return m
end
local function log()
	local m = prop("Log")
	for i = 0, 3 do block(m, V(3, 3, 3), C(i * 3 - 4.5, 1.5, 0), WOOD[i % 2 + 1]) end
	block(m, V(0.3, 2.2, 2.2), C(-6.1, 1.5, 0), rgb(214, 176, 120), {collide = false})
	block(m, V(2, 0.6, 2), C(1, 3.2, 0), LEAF[2], {collide = false})
	return m
end
local function flowers()
	local m = prop("Flowers")
	for _ = 1, 5 do
		local x, z, h = rng:NextNumber(-2.5, 2.5), rng:NextNumber(-2.5, 2.5), rng:NextNumber(1.2, 2.4)
		block(m, V(0.3, h, 0.3), C(x, h / 2, z), rgb(60, 150, 60), {collide = false})
		block(m, V(1, 1, 1), C(x, h + 0.4, z), pick({rgb(255, 90, 140), rgb(255, 220, 80), rgb(170, 120, 255), rgb(255, 255, 255), rgb(255, 140, 60)}), {collide = false})
	end
	return m
end

---------------------------------------------------------------- JUNGLE
local function jungleTree(height)
	local m = prop("JungleTree")
	local n = math.floor(height * 0.7 / 3)
	for i = 0, n - 1 do block(m, V(4.4 - i * 0.08, 3, 4.4 - i * 0.08), C(math.sin(i * 0.7) * 0.5, 1.5 + i * 3, 0) * A(0, rad(i * 10), 0), i % 3 == 0 and rgb(82, 100, 50) or WOOD[i % 2 + 1]) end
	local y = n * 3
	for i = 0, 2 do
		local w = height * (0.62 - i * 0.16)
		block(m, V(w, 2.6, w), C(0, y + i * 2.6, 0) * A(0, rad(i * 30), 0), rgb(30 + i * 14, 120 + i * 22, 50), {collide = i == 0})
	end
	for i = 1, 7 do -- lianes
		local a, len = rng:NextNumber(0, 6.28), rng:NextNumber(4, height * 0.45)
		local r = height * 0.26
		block(m, V(0.6, len, 0.6), C(math.cos(a) * r, y - len / 2, math.sin(a) * r), rgb(46, 130, 56), {collide = false})
	end
	return m
end
local function totem(height)
	local m = prop("Totem")
	local colors = {rgb(196, 80, 50), rgb(60, 150, 170), rgb(232, 180, 60), rgb(110, 76, 44)}
	local n = math.floor(height / 4)
	for i = 0, n - 1 do
		local c = colors[i % 4 + 1]
		block(m, V(4.4, 4, 4.4), C(0, 2 + i * 4, 0), c)
		for _, side in {-1, 1} do block(m, V(1, 1, 0.5), C(side * 1.1, 2.8 + i * 4, -2.3), WHITE, {collide = false}) end
		block(m, V(2.4, 0.7, 0.5), C(0, 1.1 + i * 4, -2.3), rgb(40, 30, 26), {collide = false})
		if i == n - 1 then for _, side in {-1, 1} do block(m, V(3.4, 1.4, 1), C(side * 3.6, 3 + i * 4, 0) * A(0, 0, rad(side * 18)), colors[(i + 1) % 4 + 1], {collide = false}) end end
	end
	return m
end
local function ruin(height)
	local m = prop("Ruin")
	local stones = {rgb(132, 136, 120), rgb(110, 116, 104), rgb(96, 128, 84)}
	local n = math.floor(height / 2.6)
	for i = 0, n - 1 do
		local w = 5 - (i == n - 1 and 1.6 or 0)
		block(m, V(w, 2.6, w), C(i == n - 1 and 0.8 or 0, 1.3 + i * 2.6, 0) * A(0, rad((i % 2) * 6), 0), stones[rng:NextInteger(1, 3)])
	end
	block(m, V(3, 2.2, 4.4), C(5.4, 1.1, 1) * A(0, rad(24), rad(8)), stones[1])
	block(m, V(2.2, 0.6, 3), C(0, n * 2.6 + 0.2, 0.6), LEAF[3], {collide = false})
	return m
end

---------------------------------------------------------------- AQUATIC
local function coral(height, color)
	local m = prop("Coral")
	local function branch(cf, len, depth)
		block(m, V(1.5 - depth * 0.25, len, 1.5 - depth * 0.25), cf * C(0, len / 2, 0), shade(color, depth * 0.12), {collide = depth == 0})
		if depth < 2 then
			for _, side in {-1, 1} do
				branch(cf * C(0, len * rng:NextNumber(0.5, 0.95), 0) * A(rad(rng:NextInteger(-25, 25)), rad(rng:NextInteger(0, 90)), rad(side * rng:NextInteger(28, 44))), len * 0.62, depth + 1)
			end
		end
	end
	for i = 1, 3 do branch(C((i - 2) * 2.2, 0, rng:NextNumber(-1, 1)) * A(0, rad(i * 60), rad((i - 2) * 12)), height * rng:NextNumber(0.4, 0.55), 0) end
	return m
end
local function seaweed(height)
	local m = prop("Seaweed")
	for s = 0, 2 do
		local n = math.floor(height * rng:NextNumber(0.6, 1) / 1.8)
		for i = 0, n - 1 do
			block(m, V(1.4, 1.8, 0.5), C((s - 1) * 1.8 + math.sin(i * 0.9 + s) * 0.6, 0.9 + i * 1.8, (s - 1) * 0.8) * A(0, rad(s * 40), 0), i % 2 == 0 and rgb(40, 150, 100) or rgb(60, 180, 110), {collide = false})
		end
	end
	return m
end
local function clam(size)
	local m = prop("Clam")
	local pinks = {rgb(255, 190, 210), rgb(240, 150, 190)}
	block(m, V(size, size * 0.25, size * 0.9), C(0, size * 0.125, 0), pinks[1])
	block(m, V(size, size * 0.25, size * 0.9), C(0, size * 0.55, size * 0.3) * A(rad(-48), 0, 0), pinks[2], {collide = false})
	for i = -2, 2 do block(m, V(size * 0.08, size * 0.27, size * 0.9), C(i * size * 0.2, size * 0.13, 0), pinks[2], {collide = false}) end
	local pearl = block(m, V(size * 0.3, size * 0.3, size * 0.3), C(0, size * 0.4, -size * 0.1), rgb(255, 255, 255), {neon = true, collide = false})
	return m
end
local function starfish(size)
	local m = prop("Starfish")
	local c = pick({rgb(255, 150, 70), rgb(255, 110, 130), rgb(255, 210, 90)})
	for i = 0, 4 do block(m, V(size * 0.28, size * 0.2, size * 0.6), A(0, rad(i * 72), 0) * C(0, size * 0.1, -size * 0.3), c, {collide = false}) end
	block(m, V(size * 0.36, size * 0.26, size * 0.36), C(0, size * 0.13, 0), shade(c, 0.2), {collide = false})
	return m
end
local function bubbles()
	local m = prop("Bubbles")
	for _ = 1, 7 do
		local s = rng:NextNumber(0.8, 2.4)
		local p = block(m, V(s, s, s), C(rng:NextNumber(-3, 3), rng:NextNumber(4, 26), rng:NextNumber(-3, 3)), rgb(190, 235, 255), {collide = false, shadow = false})
		p.Transparency = 0.45
	end
	return m
end
local function seaRock(size)
	local m = rock(size)
	m.Name = "SeaRock"
	block(m, V(size * 0.5, 0.5, size * 0.4), C(0, size * 0.72, 0), rgb(60, 180, 110), {collide = false})
	return m
end

---------------------------------------------------------------- ICE
local ICE_COLORS = {rgb(170, 225, 255), rgb(205, 240, 255), rgb(130, 200, 250)}
local function iceSpike(height)
	local m = prop("IceSpikes")
	for s = 1, 4 do
		local h = height * (s == 1 and 1 or rng:NextNumber(0.35, 0.7))
		local cf = C(s == 1 and 0 or rng:NextNumber(-4, 4), 0, s == 1 and 0 or rng:NextNumber(-4, 4)) * A(rad(rng:NextInteger(-10, 10)), rad(rng:NextInteger(0, 90)), rad(rng:NextInteger(-10, 10)))
		local n = 5
		for i = 0, n - 1 do
			local w = (height * 0.2) * (1 - i / n) * (s == 1 and 1 or 0.7) + 0.5
			local p = block(m, V(w, h / n, w), cf * C(0, h / n * (i + 0.5), 0), ICE_COLORS[(i + s) % 3 + 1], {collide = s == 1})
			p.Transparency = 0.15
			p.Reflectance = 0.15
		end
	end
	return m
end
local function igloo(size)
	local m = prop("Igloo")
	local snow = {rgb(246, 250, 255), rgb(226, 238, 252)}
	for i = 0, 4 do
		local w = size * (1 - (i / 5) ^ 2 * 0.75)
		block(m, V(w, size * 0.14, w), C(0, size * (0.07 + i * 0.14), 0) * A(0, rad(i * 9), 0), snow[i % 2 + 1])
	end
	block(m, V(size * 0.36, size * 0.36, size * 0.3), C(0, size * 0.18, -size * 0.52), snow[2])
	block(m, V(size * 0.22, size * 0.26, size * 0.08), C(0, size * 0.13, -size * 0.68), rgb(40, 50, 70), {collide = false})
	return m
end
local function snowman(size)
	local m = prop("Snowman")
	block(m, V(size, size * 0.8, size), C(0, size * 0.4, 0), rgb(250, 252, 255))
	block(m, V(size * 0.75, size * 0.6, size * 0.75), C(0, size * 1.1, 0), rgb(240, 246, 255))
	block(m, V(size * 0.55, size * 0.5, size * 0.55), C(0, size * 1.65, 0), rgb(250, 252, 255))
	block(m, V(size * 0.14, size * 0.14, size * 0.4), C(0, size * 1.65, -size * 0.45), rgb(255, 140, 40), {collide = false})
	for _, side in {-1, 1} do
		block(m, V(size * 0.09, size * 0.09, 0.2), C(side * size * 0.13, size * 1.76, -size * 0.28), rgb(30, 30, 36), {collide = false})
		block(m, V(size * 0.7, size * 0.08, size * 0.08), C(side * size * 0.7, size * 1.2, 0) * A(0, 0, rad(side * 25)), WOOD[1], {collide = false})
	end
	block(m, V(size * 0.7, size * 0.08, size * 0.7), C(0, size * 1.93, 0), rgb(30, 30, 36), {collide = false})
	block(m, V(size * 0.42, size * 0.4, size * 0.42), C(0, size * 2.16, 0), rgb(30, 30, 36), {collide = false})
	block(m, V(size * 0.8, size * 0.12, size * 0.8), C(0, size * 1.38, 0), rgb(220, 50, 60), {collide = false})
	return m
end

---------------------------------------------------------------- DESERT
local SAND = {rgb(236, 204, 120), rgb(222, 186, 100), rgb(246, 220, 140)}
local function pyramid(size)
	local m = prop("Pyramid")
	local layers = 9
	for i = 0, layers - 1 do
		local w = size * (1 - i / layers)
		block(m, V(w, size * 0.075, w), C(0, size * 0.075 * (i + 0.5), 0), SAND[i % 3 + 1])
	end
	block(m, V(size * 0.09, size * 0.09, size * 0.09), C(0, size * 0.075 * layers + size * 0.04, 0), GOLD, {neon = true, collide = false})
	block(m, V(size * 0.14, size * 0.2, 0.6), C(0, size * 0.1, -size * 0.5), rgb(60, 44, 30), {collide = false})
	return m
end
local function cactus(height)
	local m = prop("Cactus")
	local greens = {rgb(70, 160, 80), rgb(56, 138, 70)}
	local n = math.floor(height / 2.4)
	for i = 0, n - 1 do block(m, V(2.6, 2.4, 2.6), C(0, 1.2 + i * 2.4, 0), greens[i % 2 + 1]) end
	for _, side in {-1, 1} do
		local y = height * (side == 1 and 0.4 or 0.55)
		block(m, V(2.6, 1.8, 1.8), C(side * 2.4, y, 0), greens[2], {collide = false})
		block(m, V(1.8, height * 0.3, 1.8), C(side * 3.3, y + height * 0.15, 0), greens[1], {collide = false})
	end
	block(m, V(1.2, 1, 1.2), C(0, n * 2.4 + 0.4, 0), rgb(255, 110, 170), {collide = false})
	return m
end
local function desertPalm(height)
	local m = prop("Palm")
	local n = math.floor(height / 2.6)
	for i = 0, n - 1 do block(m, V(2.6, 2.6, 2.6), C(math.sin(i / n * 1.5) * 4, 1.3 + i * 2.6, 0) * A(0, rad(i * 20), 0), i % 2 == 0 and rgb(150, 110, 60) or rgb(170, 128, 72)) end
	local top = C(math.sin(1.5) * 4, n * 2.6, 0)
	for f = 0, 6 do
		local cf = top * A(0, rad(f * 51), 0)
		for s = 0, 2 do
			cf = cf * A(rad(s == 0 and 18 or -26), 0, 0)
			block(m, V(2.4 - s * 0.5, 0.7, 4.6), cf * C(0, 0, -2.3), LEAF[(f + s) % 3 + 1], {collide = false})
			cf = cf * C(0, 0, -4.6)
		end
	end
	for i = 1, 3 do block(m, V(1.4, 1.4, 1.4), top * C(math.cos(i * 2.1) * 1.4, -1.2, math.sin(i * 2.1) * 1.4), rgb(120, 76, 40), {collide = false}) end
	return m
end
local function obelisk(height)
	local m = prop("Obelisk")
	block(m, V(5, 1.6, 5), C(0, 0.8, 0), SAND[2])
	for i = 0, 5 do block(m, V(3.4 - i * 0.3, height / 6, 3.4 - i * 0.3), C(0, 1.6 + height / 6 * (i + 0.5), 0), SAND[i % 3 + 1]) end
	block(m, V(1.6, 1.6, 1.6), C(0, height + 2.2, 0) * A(0, rad(45), 0), GOLD, {neon = true, collide = false})
	for i = 0, 3 do block(m, V(1.2, 0.8, 0.3), C(0, 4 + i * height * 0.18, -1.75 + i * 0.07), rgb(70, 150, 190), {collide = false}) end
	return m
end
local function dune(size)
	local m = prop("Dune")
	for i = 0, 3 do block(m, V(size * (1 - i * 0.22), size * 0.1, size * 0.6 * (1 - i * 0.2)), C(i * size * 0.05, size * 0.1 * (i + 0.5), 0), SAND[i % 3 + 1], {collide = false}) end
	return m
end

---------------------------------------------------------------- LAVA
local function lavaRock(size)
	local m = prop("LavaRock")
	local darks = {rgb(54, 40, 40), rgb(40, 30, 32), rgb(70, 50, 46)}
	block(m, V(size, size * 0.8, size * 0.9), C(0, size * 0.4, 0) * A(0, rad(rng:NextInteger(0, 80)), 0), darks[1])
	block(m, V(size * 0.6, size * 0.7, size * 0.6), C(size * 0.4, size * 0.9, 0.2 * size) * A(0, rad(rng:NextInteger(0, 80)), 0), darks[2])
	block(m, V(size * 0.5, size * 0.5, size * 0.55), C(-size * 0.42, size * 0.25, -size * 0.3), darks[3])
	for _ = 1, 4 do -- fissures de lave
		block(m, V(size * 0.08, size * rng:NextNumber(0.3, 0.6), size * 0.08), C(rng:NextNumber(-0.4, 0.4) * size, size * rng:NextNumber(0.3, 0.7), -size * 0.46) * A(0, 0, rad(rng:NextInteger(-35, 35))), rgb(255, 130, 30), {neon = true, collide = false})
	end
	return m
end
local function charredTree(height)
	local m = prop("CharredTree")
	local black = {rgb(40, 32, 30), rgb(58, 44, 40)}
	local n = math.floor(height * 0.6 / 3)
	for i = 0, n - 1 do block(m, V(3.2 - i * 0.15, 3, 3.2 - i * 0.15), C(math.sin(i * 0.8) * 0.5, 1.5 + i * 3, 0) * A(0, rad(i * 14), 0), black[i % 2 + 1]) end
	for b = 0, 4 do
		local cf = C(0, n * 3 - rng:NextNumber(0, 5), 0) * A(0, rad(b * 72 + 10), 0) * A(rad(-48), 0, 0)
		for s = 0, 2 do
			block(m, V(1.5 - s * 0.35, 1.5 - s * 0.35, 4.4), cf * C(0, 0, -2.2), black[(b + s) % 2 + 1], {collide = false})
			cf = cf * C(0, 0, -4.4) * A(rad(-rng:NextInteger(8, 26)), rad(rng:NextInteger(-25, 25)), 0)
		end
		block(m, V(0.9, 0.9, 0.9), cf, rgb(255, 150, 40), {neon = true, collide = false})
	end
	return m
end
local function lavaPool(size)
	local m = prop("LavaPool")
	local lava = block(m, V(size, 0.6, size * 0.7), C(0, 0.3, 0), rgb(255, 120, 20), {neon = true, collide = false})
	for i = 0, 9 do
		local a = i / 10 * 6.28
		block(m, V(size * 0.32, rng:NextNumber(1, 2.6), size * 0.2), C(math.cos(a) * size * 0.5, 0.8, math.sin(a) * size * 0.36) * A(0, -a + math.pi / 2, 0), rgb(48, 36, 36))
	end
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = rgb(255, 130, 40), 24, 1.6
	light.Parent = lava
	local fire = Instance.new("ParticleEmitter")
	fire.Texture = "rbxasset://textures/particles/fire_main.dds"
	fire.Color = ColorSequence.new(rgb(255, 200, 80), rgb(255, 70, 20))
	fire.LightEmission = 1
	fire.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.6), NumberSequenceKeypoint.new(1, 0)})
	fire.Lifetime, fire.Rate, fire.Speed = NumberRange.new(0.8, 1.6), 8, NumberRange.new(3, 7)
	fire.EmissionDirection = Enum.NormalId.Top
	fire.Parent = lava
	return m
end

---------------------------------------------------------------- DEMON
local OBSIDIAN = {rgb(34, 26, 46), rgb(46, 34, 62), rgb(24, 18, 34)}
local function darkSpire(height)
	local m = prop("DarkSpire")
	local n = 7
	for i = 0, n - 1 do
		local w = height * 0.24 * (1 - i / n) + 0.8
		block(m, V(w, height / n, w), C(0, height / n * (i + 0.5), 0) * A(0, rad(i * 18), 0), OBSIDIAN[i % 3 + 1])
	end
	block(m, V(1.4, 2.4, 1.4), C(0, height + 1, 0) * A(0, rad(45), 0), rgb(200, 70, 255), {neon = true, collide = false})
	for s = 1, 3 do
		local a = s * 2.1
		local h = height * rng:NextNumber(0.25, 0.45)
		block(m, V(2, h, 2), C(math.cos(a) * height * 0.16, h / 2, math.sin(a) * height * 0.16) * A(rad(math.sin(a) * 12), 0, rad(-math.cos(a) * 12)), OBSIDIAN[s])
	end
	return m
end
local function crystals(size, color)
	local m = prop("Crystals")
	for s = 1, 5 do
		local h = size * (s == 1 and 1 or rng:NextNumber(0.4, 0.75))
		local w = size * 0.2 * (s == 1 and 1 or 0.7)
		local cf = C(s == 1 and 0 or rng:NextNumber(-0.4, 0.4) * size, 0, s == 1 and 0 or rng:NextNumber(-0.4, 0.4) * size) * A(rad(rng:NextInteger(-22, 22)), rad(rng:NextInteger(0, 90)), rad(rng:NextInteger(-22, 22)))
		local p = block(m, V(w, h, w), cf * C(0, h / 2, 0), shade(color, (s % 3) * 0.12), {neon = true, collide = s == 1})
		p.Transparency = 0.1
	end
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = color, 18, 1.4
	light.Parent = m:FindFirstChildWhichIsA("BasePart")
	return m
end
local function skullPillar(height)
	local m = prop("SkullPillar")
	block(m, V(6, 1.6, 6), C(0, 0.8, 0), OBSIDIAN[3])
	block(m, V(4, height, 4), C(0, 1.6 + height / 2, 0), OBSIDIAN[1])
	block(m, V(5, 1.2, 5), C(0, 2.2 + height, 0), OBSIDIAN[2])
	local head = C(0, height + 5.6, 0)
	block(m, V(5.4, 5, 5.4), head, rgb(226, 220, 204))
	block(m, V(3.6, 1.4, 4), head * C(0, -3, -0.4), rgb(206, 198, 180), {collide = false})
	for _, side in {-1, 1} do
		block(m, V(1.5, 1.6, 0.5), head * C(side * 1.3, 0.3, -2.6), rgb(255, 40, 60), {neon = true, collide = false})
		block(m, V(1.2, 4, 1.2), head * C(side * 3, 3, 0) * A(0, 0, rad(side * -28)), OBSIDIAN[3], {collide = false})
	end
	return m
end
local function demonEye(size)
	local m = prop("DemonEye")
	block(m, V(1, size * 2.2, 1), C(0, size * 1.1, 0), OBSIDIAN[1])
	block(m, V(size, size, size), C(0, size * 2.6, 0) * A(rad(20), rad(30), 0), rgb(240, 236, 226), {collide = false})
	block(m, V(size * 0.5, size * 0.5, size * 0.3), C(0, size * 2.6, 0) * A(rad(20), rad(30), 0) * C(0, 0, -size * 0.42), rgb(255, 30, 50), {neon = true, collide = false})
	return m
end

---------------------------------------------------------------- HALLOWEEN : copies des décors de la zone (Workspace["Halloween Zone Decor"])
local halloweenSource = {}
local function halloween(kind, minSize, maxSize)
	local list = halloweenSource[kind]
	if not list or #list == 0 then return nil end
	local candidates = {}
	for _, src in list do
		local size = src:GetExtentsSize()
		local footprint = math.max(size.X, size.Z)
		if footprint >= (minSize or 0) and footprint <= (maxSize or 1e9) then table.insert(candidates, src) end
	end
	local src = #candidates > 0 and pick(candidates) or pick(list)
	local m = src:Clone()
	local cf, size = m:GetBoundingBox()
	m.WorldPivot = CFrame.new(cf.Position - Vector3.new(0, size.Y / 2, 0)) -- pivot au sol, sous le centre
	return m
end

---------------------------------------------------------------- ce que chaque zone montre sur ses bords
-- Big : grands décors (un tous les ~26 studs, au fond contre le mur) ; Small : petits décors devant ; Air : décors flottants
local THEMES = {
	Forest = {
		Big = {function() return oak(rng:NextInteger(22, 32)) end, function() return pine(rng:NextInteger(24, 34)) end, function() return oak(rng:NextInteger(18, 26)) end},
		Small = {bush, function() return mushroom(rng:NextNumber(2.4, 5), pick({rgb(226, 50, 50), rgb(255, 170, 60), rgb(170, 110, 220)})) end, log, flowers, function() return rock(rng:NextNumber(3, 5)) end},
	},
	Jungle = {
		Big = {function() return jungleTree(rng:NextInteger(30, 42)) end, function() return cycad(rng:NextInteger(20, 28)) end, function() return totem(rng:NextInteger(16, 24)) end, function() return jungleTree(rng:NextInteger(26, 36)) end},
		Small = {fern, function() return ruin(rng:NextInteger(6, 12)) end, bush, fern, function() return mushroom(rng:NextNumber(2.4, 4), rgb(60, 200, 190)) end},
		SmallScale = {1.3, 2},
	},
	Aquatic = {
		Big = {function() return coral(rng:NextInteger(18, 28), pick({rgb(255, 110, 150), rgb(255, 150, 70), rgb(180, 110, 255), rgb(255, 90, 90)})) end, function() return seaweed(rng:NextInteger(18, 30)) end, function() return seaRock(rng:NextNumber(9, 13)) end},
		Small = {function() return clam(rng:NextNumber(4, 6.5)) end, function() return starfish(rng:NextNumber(3, 5)) end, function() return seaweed(rng:NextInteger(6, 11)) end, function() return coral(rng:NextInteger(6, 10), pick({rgb(255, 110, 150), rgb(120, 220, 255), rgb(255, 210, 90)})) end, bubbles},
	},
	Ice = {
		Big = {function() return iceSpike(rng:NextInteger(22, 34)) end, function() return pine(rng:NextInteger(24, 32), true) end, function() return igloo(rng:NextNumber(14, 18)) end, function() return iceSpike(rng:NextInteger(18, 26)) end},
		Small = {function() return snowman(rng:NextNumber(3, 4.6)) end, function() return iceSpike(rng:NextInteger(6, 10)) end, function() return rock(rng:NextNumber(3, 5)) end, function() return pine(rng:NextInteger(8, 12), true) end},
	},
	Desert = {
		Big = {function() return pyramid(rng:NextNumber(22, 27)) end, function() return desertPalm(rng:NextInteger(20, 28)) end, function() return obelisk(rng:NextInteger(20, 28)) end, function() return desertPalm(rng:NextInteger(18, 24)) end},
		Small = {function() return cactus(rng:NextInteger(7, 13)) end, function() return dune(rng:NextNumber(8, 12)) end, function() return rock(rng:NextNumber(3, 5)) end, function() return cactus(rng:NextInteger(5, 9)) end},
	},
	Lava = {
		Big = {function() return volcano() end, function() return charredTree(rng:NextInteger(22, 30)) end, function() return lavaRock(rng:NextNumber(10, 14)) end, function() return charredTree(rng:NextInteger(18, 26)) end},
		BigFit = 26,
		Small = {function() return lavaPool(rng:NextNumber(7, 10)) end, function() return lavaRock(rng:NextNumber(3.5, 6)) end, function() return crystals(rng:NextNumber(5, 8), rgb(255, 120, 30)) end},
	},
	Demon = {
		Big = {function() return darkSpire(rng:NextInteger(28, 40)) end, function() return skullPillar(rng:NextInteger(16, 22)) end, function() return crystals(rng:NextNumber(16, 22), rgb(190, 70, 255)) end, function() return darkSpire(rng:NextInteger(22, 30)) end},
		Small = {function() return crystals(rng:NextNumber(5, 8), pick({rgb(190, 70, 255), rgb(255, 50, 80)})) end, function() return demonEye(rng:NextNumber(2.4, 3.4)) end, function() return darkSpire(rng:NextInteger(7, 11)) end, function() return lavaRock(rng:NextNumber(3, 5)) end},
	},
	Dino = {
		Big = {function() return cycad(rng:NextInteger(24, 34)) end, function() return volcano() end, function() return skeleton() end, function() return cycad(rng:NextInteger(22, 30)) end},
		BigFit = 30,
		Small = {fern, function() return rock(rng:NextNumber(4, 7)) end, function() return loneBone(rng:NextInteger(6, 10)) end, fern},
		SmallScale = {1.2, 2},
	},
	Candy = {
		Big = {function() return candyCane(rng:NextInteger(22, 30), pick({RED, rgb(255, 92, 150), rgb(90, 200, 120)})) end, function() return lollipop(rng:NextInteger(18, 26), pick(CANDY), WHITE) end,
			function() return cupcake(rng:NextNumber(12, 16), pick({rgb(255, 150, 200), rgb(190, 150, 255), rgb(255, 236, 170)})) end, function() return iceCream(rng:NextNumber(6, 8)) end, function() return donut(rng:NextNumber(8, 10), pick({rgb(255, 130, 190), rgb(140, 220, 255)})) end},
		Small = {function() return gumdrop(rng:NextNumber(3.5, 6), pick(CANDY)) end, function() return chocolate(rng:NextNumber(4, 6)) end, function() return gumdrop(rng:NextNumber(3, 5), pick(CANDY)) end, function() return lollipop(rng:NextInteger(5, 8), pick(CANDY), WHITE) end},
	},
	Angel = {
		Big = {function() return column(rng:NextInteger(22, 32)) end, function() return temple() end, function() return column(rng:NextInteger(20, 28)) end, function() return rainbow(13) end},
		BigFit = 28,
		Small = {function() return cloud(rng:NextNumber(8, 13), true) end, function() return column(rng:NextInteger(6, 10)) end, function() return cloud(rng:NextNumber(7, 11), true) end},
		Air = {function() return cloud(rng:NextNumber(10, 16), false) end, function() return star(rng:NextNumber(2, 3.6)) end},
	},
	Halloween = {
		Big = {function() return halloween("DeadTree") end, function() return halloween("Pumpkin", 9) end, function() return halloween("DeadTree") end, function() return halloween("Cauldron") end},
		BigFit = 24,
		Small = {function() return halloween("Pumpkin", 0, 8) end, function() return halloween("Gravestone") end, function() return halloween("Candles") end, function() return halloween("Pumpkin", 0, 6) end},
		SmallFit = 9,
	},
}

-- les zones, de la safe zone vers le fond : nom de la pièce (ou son début), thème, couleur du sol des zones créées ici
local LAYOUT = {
	{Name = "common egg zone", Theme = "Forest"},
	{Name = "UNcommon jungle egg zone", Theme = "Jungle"},
	{Name = "RARE aquatic egg zone", Theme = "Aquatic"},
	{Name = "EPIC Ice egg zone", Theme = "Ice"},
	{Name = "legendary egg zone", Theme = "Desert"},
	{Name = "Mythic lava egg zone", Theme = "Lava"},
	{Name = "SECRET demon egg zone", Theme = "Demon"},
	{Name = "ANCIENT dino egg zone", Theme = "Dino", Color = rgb(134, 158, 78), Gate = "Dino"},
	{Name = "OG candy egg zone", Theme = "Candy", Color = rgb(255, 176, 214), Gate = "Candy", Old = "EXOTIC candy egg zone"},
	{Name = "DIVINE angel egg zone", Theme = "Angel", Color = rgb(206, 230, 255), Gate = "Angel", Old = "DIVINE sky egg zone"},
	{Name = "Halloween demon egg zone", Theme = "Halloween"},
}
local SIDE = 60        -- largeur des plateaux de chaque côté du couloir, pour les décors
local LEDGE_UP = 45.2    -- hauteur des plateaux au-dessus du sol des zones : les zones sont au fond d'une tranchée
local OLD_NORTH, OLD_SOUTH = -84.3, -251.3 -- faces intérieures des murs avant l'élargissement (bords des zones)

local function fitted(m, parent, cf, maxFootprint)
	m.Parent = parent
	if maxFootprint then
		local size = m:GetExtentsSize()
		local footprint = math.max(size.X, size.Z)
		if footprint > maxFootprint then m:ScaleTo(m:GetScale() * maxFootprint / footprint) end
	end
	m:PivotTo(cf)
end

return function()
	local report = {}
	local corridor = workspace:WaitForChild("Corridor")
	local SS = game:GetService("ServerStorage")
	local first = workspace:FindFirstChild(LAYOUT[1].Name)
	local halloweenZone = workspace:FindFirstChild("Halloween demon egg zone")
	assert(first and halloweenZone, "zone parts not found")

	-- 0. décors du désert restés dans la zone aquatique, mur oublié... : rangés dans ServerStorage
	local backup = SS:FindFirstChild("MapBackup_OldCorridorDecor")
	if not backup then
		backup = Instance.new("Folder")
		backup.Name = "MapBackup_OldCorridorDecor"
		backup.Parent = SS
		local moved = 0
		for _, c in workspace:GetChildren() do
			local n = c.Name
			local misplaced = string.match(n, "^Cactus%d$") or n == "Pyramid" or n == "Dune" or n == "PalmLeaf" or n == "PalmTrunk" or n == "SphinxL" or n == "SphinxR" or n == "Pine2"
			if not misplaced and n == "Wall" and c:IsA("BasePart") and math.abs(c.Position.X - 406.4) < 2 and math.abs(c.Position.Z + 70) < 3 then misplaced = true end
			if misplaced then c.Parent = backup moved += 1 end
		end
		table.insert(report, moved .. " misplaced decor objects moved to ServerStorage.MapBackup_OldCorridorDecor")
	end

	-- 1. couloir rallongé de trois zones (une seule fois)
	local grow = ZONE_W * 3
	if not corridor:GetAttribute("ExtendedForNewZones") then
		for _, p in corridor:GetChildren() do
			if p:IsA("BasePart") then
				if string.sub(p.Name, 1, 3) == "End" then p.Position += V(grow, 0, 0) else p.Size += V(grow, 0, 0) p.Position += V(grow / 2, 0, 0) end
			end
		end
		corridor:SetAttribute("ExtendedForNewZones", true)
	end
	-- 2. couloir élargi jusqu'à SIDE studs de chaque côté (seulement de ce qui manque) : les zones gardent leur taille
	local done = corridor:GetAttribute("WidenedBy") or (corridor:GetAttribute("Widened") and 30 or 0)
	local delta = SIDE - done
	if delta ~= 0 then
		for _, p in corridor:GetChildren() do
			if p:IsA("BasePart") then
				local name = p.Name
				if string.sub(name, 1, 5) == "North" then p.Position += V(0, 0, delta)
				elseif string.sub(name, 1, 5) == "South" then p.Position -= V(0, 0, delta)
				else p.Size += V(0, 0, delta * 2) end -- plafond et mur du fond
			end
		end
		local lava = workspace:FindFirstChild("lava realiste")
		if lava then
			for _, p in lava:GetDescendants() do
				if p:IsA("BasePart") then
					p.Size += V(0, 0, delta * 2)
					if done == 0 then -- la lave suit aussi le couloir rallongé
						if p.Size.X > 300 then p.Size += V(grow, 0, 0) p.Position += V(grow / 2, 0, 0) else p.Position += V(grow, 0, 0) end
					end
				end
			end
		end
		corridor:SetAttribute("WidenedBy", SIDE)
		table.insert(report, "corridor widened to " .. SIDE .. " on each side")
	end
	-- les hauts murs bruns disparaissent : on voit les plateaux et le ciel (ils restent là, invisibles, pour fermer la carte)
	for _, p in corridor:GetChildren() do
		if p:IsA("BasePart") and (string.find(p.Name, "Wall") or string.find(p.Name, "Trim")) then
			p.Transparency = 1
			p.CastShadow = false
			for _, t in p:GetChildren() do if t:IsA("Texture") or t:IsA("Decal") then t.Transparency = 1 end end
		end
	end
	-- coulées de lave qui pendaient des hauts murs de la zone de lave : rangées avec les anciens décors
	for _, c in workspace:GetChildren() do
		if c.Name == "CouleeDeLave" and c:IsA("Model") and c:GetBoundingBox().Position.X > 700 then c.Parent = backup end
	end

	-- 3. ordre et taille des zones, de la safe zone vers le fond. Chaque zone est plus longue que la précédente : x1 pour la
	--    première, x1,1 pour la suivante... x2 pour la zone Halloween (GROW par zone). Entre deux zones, une bande couleur paille
	--    large comme un mur (GAP). Tout ce qui est posé à la main dans le couloir suit sa zone : décors de la zone Halloween,
	--    coulées de lave, arbres, pièces rangées dans une zone, forêt de la cinématique derrière la dernière zone.
	local decorOfHalloween = workspace:FindFirstChild("Halloween Zone Decor")
	for _, info in LAYOUT do
		local part = workspace:FindFirstChild(info.Name) or (info.Old and workspace:FindFirstChild(info.Old))
		if not part then
			part = halloweenZone:Clone()
			for _, k in part:GetChildren() do if not k:IsA("Texture") then k:Destroy() end end
			part.Parent = workspace
		end
		part.Name = info.Name
		if info.Color then part.Color = info.Color end
		info.Part = part
	end
	local old, new = {}, {} -- [zone] = {début, fin} le long du couloir : maintenant, et après
	do
		local x = first.Position.X - first.Size.X / 2
		for index, info in LAYOUT do
			local part = info.Part
			old[index] = {part.Position.X - part.Size.X / 2, part.Position.X + part.Size.X / 2}
			local width = ZONE_W * (1 + GROW * (index - 1))
			new[index] = {x, x + width}
			x += width + GAP
		end
	end
	-- où va un point du couloir : il garde sa place dans sa zone (ou dans sa bande), qui s'allonge
	local function remap(px)
		if px <= old[1][1] then return px end
		for i = 1, #old do
			local a, b = old[i][1], old[i][2]
			if px <= b then
				if px >= a then return new[i][1] + (px - a) / (b - a) * (new[i][2] - new[i][1]) end
				local before = old[i - 1][2]
				return new[i - 1][2] + (px - before) / math.max(a - before, 1e-3) * (new[i][1] - new[i - 1][2])
			end
		end
		return px + (new[#new][2] - old[#old][2]) -- derrière la dernière zone
	end
	local shift = new[#new][2] - old[#old][2]
	local changed = false
	for i = 1, #old do
		if math.abs(old[i][1] - new[i][1]) > 0.05 or math.abs(old[i][2] - new[i][2]) > 0.05 then changed = true end
	end
	if changed then
		local zoneParts = {}
		for _, info in LAYOUT do zoneParts[info.Part] = true end
		local zLow, zHigh = OLD_SOUTH - SIDE - 40, OLD_NORTH + SIDE + 40
		local moved = 0
		-- déplace un objet entier le long du couloir, avec sa zone (sa taille ne change pas)
		local function slide(inst)
			local c
			if inst:IsA("BasePart") then
				c = inst.Position
			else
				local ok, cf = pcall(function() return (inst:GetBoundingBox()) end)
				c = ok and cf.Position or nil
			end
			if not c or c.X <= old[1][1] or math.abs(c.Y) > 400 or c.Z < zLow or c.Z > zHigh then return end
			local dx = remap(c.X) - c.X
			if math.abs(dx) < 0.01 then return end
			if inst:IsA("BasePart") then inst.Position += V(dx, 0, 0) else inst:PivotTo(inst:GetPivot() + V(dx, 0, 0)) end
			moved += 1
		end
		local function children(container) -- les objets rangés dans une pièce ou un modèle
			for _, c in container:GetChildren() do
				if c:IsA("BasePart") or c:IsA("Model") then slide(c) end
			end
		end
		if decorOfHalloween then children(decorOfHalloween) end
		for _, c in workspace:GetChildren() do
			if zoneParts[c] or c == corridor or c == decorOfHalloween or c.Name == "lava realiste" or c:IsA("Terrain") or c:IsA("Camera") then continue end
			if c:IsA("BasePart") then
				local a, b = c.Position.X - c.Size.X / 2, c.Position.X + c.Size.X / 2
				local spans
				for i = 1, #old do
					if math.abs(a - old[i][1]) < 2 and math.abs(b - old[i][2]) < 2 then spans = i end
				end
				if spans then -- une pièce de la taille d'une zone (couches sous la zone du désert) : elle grandit avec elle
					children(c)
					c.Size = V(new[spans][2] - new[spans][1], c.Size.Y, c.Size.Z)
					c.Position = V((new[spans][1] + new[spans][2]) / 2, c.Position.Y, c.Position.Z)
					moved += 1
				else
					slide(c)
				end
			elseif c:IsA("Model") then
				slide(c)
			end
		end
		for index, info in LAYOUT do
			local part = info.Part
			children(part)
			part.Size = V(new[index][2] - new[index][1], part.Size.Y, part.Size.Z)
			part.Position = V((new[index][1] + new[index][2]) / 2, part.Position.Y, part.Position.Z)
		end
		-- le couloir invisible et la lave du fond s'allongent d'autant (une pièce ne dépasse pas 2 048 studs : au-delà, elle est coupée en deux)
		local function stretch(p, amount)
			local start = p.Position.X - p.Size.X / 2
			local length = p.Size.X + amount
			if length <= 2000 then
				p.Size = V(length, p.Size.Y, p.Size.Z)
				p.Position = V(start + length / 2, p.Position.Y, p.Position.Z)
			else
				local half = length / 2
				p.Size = V(half, p.Size.Y, p.Size.Z)
				p.Position = V(start + half / 2, p.Position.Y, p.Position.Z)
				local second = p:Clone()
				second.Name = p.Name .. "2"
				second.Position = V(start + half * 1.5, p.Position.Y, p.Position.Z)
				second.Parent = p.Parent
			end
		end
		for _, p in corridor:GetChildren() do
			if p:IsA("BasePart") then
				if string.sub(p.Name, 1, 3) == "End" then p.Position += V(shift, 0, 0) else stretch(p, shift) end
			end
		end
		local lava = workspace:FindFirstChild("lava realiste")
		if lava then
			for _, p in lava:GetDescendants() do
				if p:IsA("BasePart") then
					if p.Size.X > 300 then stretch(p, shift) else p.Position += V(shift, 0, 0) end
				end
			end
		end
		table.insert(report, string.format("zones resized (x1 to x%.1f, %d-stud strips between them): corridor %.0f studs longer, %d hand-placed objects moved", 1 + GROW * (#LAYOUT - 1), GAP, shift, moved))
	end
	-- bandes couleur paille entre les zones (refaites à chaque passage)
	do
		local previous = workspace:FindFirstChild("ZoneSeparators")
		if previous then previous:Destroy() end
		local separators = Instance.new("Folder")
		separators.Name = "ZoneSeparators"
		separators.Parent = workspace
		for index = 1, #LAYOUT - 1 do
			local a, b = LAYOUT[index].Part, LAYOUT[index + 1].Part
			local x0, x1 = a.Position.X + a.Size.X / 2, b.Position.X - b.Size.X / 2
			if x1 - x0 > 0.5 then
				local top = math.max(a.Position.Y + a.Size.Y / 2, b.Position.Y + b.Size.Y / 2)
				local strip = Instance.new("Part")
				strip.Name = "ZoneSeparator"
				strip.Anchored = true
				strip.Size = V(x1 - x0, 30, a.Size.Z)
				strip.Position = V((x0 + x1) / 2, top - 15, a.Position.Z)
				strip.Color = STRAW
				strip.Material = Enum.Material.Plastic
				pcall(function() strip.MaterialVariant = "Studs" end)
				strip.TopSurface, strip.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
				strip.CastShadow = false
				strip.Parent = separators
			end
		end
	end

	-- modèles Halloween à copier sur les bords
	halloweenSource = {}
	if decorOfHalloween then
		for _, c in decorOfHalloween:GetChildren() do
			if c:IsA("Model") then
				halloweenSource[c.Name] = halloweenSource[c.Name] or {}
				table.insert(halloweenSource[c.Name], c)
			end
		end
	end

	-- 4. bords surélevés et décors
	local raisedBy = workspace:FindFirstChild("ZoneLedges") and workspace.ZoneLedges:GetAttribute("RaisedBy")
	for _, name in {"NewZonesDecor", "ZoneLedges", "ZoneDecor"} do
		local old = workspace:FindFirstChild(name)
		if old then old:Destroy() end
	end
	local ledges = Instance.new("Folder")
	ledges.Name = "ZoneLedges"
	ledges:SetAttribute("RaisedBy", raisedBy)
	ledges.Parent = workspace
	local decor = Instance.new("Folder")
	decor.Name = "ZoneDecor"
	decor.Parent = workspace
	local wallStart = corridor.NorthWall.Position.X - corridor.NorthWall.Size.X / 2 -- les murs du couloir commencent un peu après le début de la première zone
	for index, info in LAYOUT do
		local part = info.Part
		local theme = THEMES[info.Theme]
		local floorY = part.Position.Y + part.Size.Y / 2
		local top = floorY + LEDGE_UP
		local x0, x1 = math.max(part.Position.X - part.Size.X / 2, wallStart), part.Position.X + part.Size.X / 2
		if index > 1 then x0 -= GAP / 2 end -- les plateaux bordent aussi la bande entre deux zones
		if index < #LAYOUT then x1 += GAP / 2 end
		local folder = Instance.new("Folder")
		folder.Name = info.Theme
		folder:SetAttribute("CenterX", part.Position.X) -- lu par AntiLagClient : les décors des zones lointaines ne sont pas affichés
		folder:SetAttribute("HalfX", part.Size.X / 2)
		folder.Parent = decor
		for _, side in {1, -1} do -- 1 = nord (+Z), -1 = sud
			local edge = side == 1 and OLD_NORTH or OLD_SOUTH
			local zMid = edge + side * SIDE / 2
			local ledge = Instance.new("Part")
			ledge.Name = info.Theme .. (side == 1 and "North" or "South")
			ledge.Anchored = true
			ledge.Size = V(x1 - x0, 44, SIDE)
			ledge.Position = V((x0 + x1) / 2, top - 23.2, zMid)
			ledge.Color = shade(part.Color, -0.42) -- flanc de la tranchée, plus sombre que le sol
			ledge.Material = part.Material
			pcall(function() ledge.MaterialVariant = part.MaterialVariant end)
			ledge.TopSurface, ledge.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
			local texture = part:FindFirstChildOfClass("Texture")
			if texture then texture:Clone().Parent = ledge end
			ledge.Parent = ledges
			local trim = Instance.new("Part") -- dessus du plateau, de la couleur de la zone
			trim.Name = "Top"
			trim.Anchored = true
			trim.Size = V(x1 - x0, 1.2, SIDE)
			trim.Position = V((x0 + x1) / 2, top - 0.6, zMid)
			trim.Color = shade(part.Color, 0.08)
			if texture then texture:Clone().Parent = trim end
			trim.Material = Enum.Material.Plastic
			pcall(function() trim.MaterialVariant = "Studs" end)
			trim.Parent = ledges

			-- deux rangées de grands décors au fond, petits décors devant et entre eux, décors flottants
			local yawBase = side == 1 and 0 or 180 -- les décors orientés regardent la zone
			local span = x1 - x0 - 8
			for row = 1, 2 do
				local depth = row == 1 and 24 or 46
				local count = math.max(1, math.floor(span / (row == 1 and 30 or 26)))
				for i = 1, count do
					local maker = theme.Big[(i * row + index + (side == 1 and 0 or 2)) % #theme.Big + 1]
					local m = maker()
					if m then
						local x = x0 + 4 + span * (i - (row == 1 and 0.5 or 0.15)) / count + rng:NextNumber(-3, 3)
						fitted(m, folder, C(math.clamp(x, x0 + 6, x1 - 6), top, edge + side * (depth + rng:NextNumber(-3, 3))) * A(0, rad(yawBase + rng:NextInteger(-14, 14)), 0), theme.BigFit or 24)
					end
				end
			end
			local smallCount = math.floor(span / (info.Theme == "Halloween" and 14 or 8))
			for i = 1, smallCount do
				local m = pick(theme.Small)()
				if m then
					local x = x0 + 3 + (x1 - x0 - 6) * (i - 0.5) / smallCount + rng:NextNumber(-2.5, 2.5)
					local z = edge + side * ((i % 3 == 0) and rng:NextNumber(30, 54) or rng:NextNumber(4, 16))
					m.Parent = folder
					if theme.SmallScale then m:ScaleTo(m:GetScale() * rng:NextNumber(theme.SmallScale[1], theme.SmallScale[2])) end
					fitted(m, folder, C(x, top, z) * A(0, rad(yawBase + rng:NextInteger(-40, 40)), 0), theme.SmallFit or 12)
				end
			end
			if theme.Air then
				for i = 1, 6 do
					local m = pick(theme.Air)()
					fitted(m, folder, C(rng:NextNumber(x0 + 6, x1 - 6), top + rng:NextNumber(24, 46), edge + side * rng:NextNumber(4, SIDE - 4)) * A(0, rad(rng:NextInteger(0, 180)), 0))
				end
			end
		end
		if info.Gate then gate(folder, part.Position.X - part.Size.X / 2 + 3, floorY, OLD_NORTH, OLD_SOUTH, info.Gate) end
		if info.Theme == "Angel" then -- nuages et étoiles au-dessus de la zone
			for _ = 1, 8 do fitted(cloud(rng:NextNumber(12, 20), false), folder, C(rng:NextNumber(x0 + 10, x1 - 10), floorY + rng:NextNumber(40, 58), rng:NextNumber(OLD_SOUTH + 12, OLD_NORTH - 12))) end
			for _ = 1, 12 do fitted(star(rng:NextNumber(2, 4)), folder, C(rng:NextNumber(x0 + 8, x1 - 8), floorY + rng:NextNumber(32, 60), rng:NextNumber(OLD_SOUTH + 6, OLD_NORTH - 6)) * A(0, rad(rng:NextInteger(0, 180)), 0)) end
		elseif info.Theme == "Candy" then
			local sprinkles = prop("Sprinkles") -- vermicelles posés au sol
			for _ = 1, 150 do
				block(sprinkles, V(1.7, 0.3, 0.55), C(rng:NextNumber(x0 + 6, x1 - 4), floorY + 0.15, rng:NextNumber(OLD_SOUTH + 3, OLD_NORTH - 3)) * A(0, rad(rng:NextInteger(0, 180)), 0), pick(CANDY), {collide = false, shadow = false})
			end
			sprinkles.Parent = folder
		end
		-- quelques décors posés dans la zone elle-même (la zone Halloween a déjà les siens)
		if info.Theme ~= "Halloween" then
			local zx0, zx1 = part.Position.X - part.Size.X / 2, part.Position.X + part.Size.X / 2
			local bigCount = math.floor(6 * part.Size.X / ZONE_W + 0.5) -- une zone plus longue reçoit plus de décors
			for i = 1, bigCount do -- grands, près des bords
				local m = theme.Big[(i + index) % #theme.Big + 1]()
				if m then
					local nearNorth = i % 2 == 0
					local z = nearNorth and (OLD_NORTH - rng:NextNumber(8, 20)) or (OLD_SOUTH + rng:NextNumber(8, 20))
					fitted(m, folder, C(zx0 + 14 + (zx1 - zx0 - 28) * (i - 0.5) / bigCount + rng:NextNumber(-4, 4), floorY, z) * A(0, rad(rng:NextInteger(0, 360)), 0), 15)
				end
			end
			for _ = 1, math.floor(10 * part.Size.X / ZONE_W + 0.5) do -- petits, partout
				local m = pick(theme.Small)()
				if m then fitted(m, folder, C(rng:NextNumber(zx0 + 8, zx1 - 8), floorY, rng:NextNumber(OLD_SOUTH + 8, OLD_NORTH - 8)) * A(0, rad(rng:NextInteger(0, 360)), 0), 9) end
			end
		end
		-- on passe à travers tous les décors : ils ne bloquent ni les joueurs, ni les œufs, ni la caméra
		for _, d in folder:GetDescendants() do
			if d:IsA("BasePart") then d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = false, false, false, false end
		end
		task.wait()
		table.insert(report, string.format("%-26s %-9s X %.0f..%.0f  %d decor instances", info.Name, info.Theme, x0, x1, #folder:GetDescendants()))
	end
	-- 5. plateau du fond, derrière la dernière zone, avec ses décors
	do
		local info = LAYOUT[#LAYOUT]
		local part, theme = info.Part, THEMES[info.Theme]
		local floorY = part.Position.Y + part.Size.Y / 2
		local top = floorY + LEDGE_UP
		local x1 = part.Position.X + part.Size.X / 2
		local width = OLD_NORTH - OLD_SOUTH + SIDE * 2
		local zMid = (OLD_NORTH + OLD_SOUTH) / 2
		local ledge = Instance.new("Part")
		ledge.Name = "EndPlateau"
		ledge.Anchored = true
		ledge.Size = V(SIDE, 44, width)
		ledge.Position = V(x1 + SIDE / 2, top - 23.2, zMid)
		ledge.Color = shade(part.Color, -0.42)
		ledge.Material = part.Material
		pcall(function() ledge.MaterialVariant = part.MaterialVariant end)
		ledge.Parent = ledges
		local topPart = ledge:Clone()
		topPart.Name = "Top"
		topPart.Size = V(SIDE, 1.2, width)
		topPart.Position = V(x1 + SIDE / 2, top - 0.6, zMid)
		topPart.Color = shade(part.Color, 0.08)
		local texture = part:FindFirstChildOfClass("Texture")
		if texture then texture:Clone().Parent = topPart end
		topPart.Parent = ledges
		local folder = decor:FindFirstChild(info.Theme)
		for i = 1, 8 do
			local m = theme.Big[i % #theme.Big + 1]()
			if m then fitted(m, folder, C(x1 + rng:NextNumber(14, SIDE - 12), top, zMid - width / 2 + width * (i - 0.5) / 8) * A(0, rad(-90 + rng:NextInteger(-14, 14)), 0), theme.BigFit or 24) end
		end
		for i = 1, 22 do
			local m = pick(theme.Small)()
			if m then fitted(m, folder, C(x1 + rng:NextNumber(4, 14), top, zMid - width / 2 + width * (i - 0.5) / 22) * A(0, rad(-90 + rng:NextInteger(-40, 40)), 0), theme.SmallFit or 12) end
		end
	end
	for _, d in decor:GetDescendants() do
		if d:IsA("BasePart") then d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = false, false, false, false end
	end
	return table.concat(report, "\n")
end
