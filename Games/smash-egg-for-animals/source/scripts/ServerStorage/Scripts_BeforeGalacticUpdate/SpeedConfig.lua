-- Speed : on le gagne en courant sur le tapis de sa base, il fait courir plus vite.
-- Le niveau du tapis (0 à 10) est l'attribut TreadmillLevel du joueur, son speed l'attribut Speed.
local SpeedConfig = {}

SpeedConfig.MaxLevel = 10    -- nombre d'améliorations du tapis (chacune change de tapis)
SpeedConfig.Tick = 0.25      -- secondes entre deux gains quand on court sur le tapis

-- gain par pas (4 pas par seconde) à chaque niveau, de 0 à 10 : de 4 par seconde au départ à 120K par seconde au dernier niveau
-- (environ x2,8 par niveau). Les traînées et les passes multiplient ce gain.
SpeedConfig.Gains = {[0] = 1, 3, 8, 22, 60, 170, 475, 1350, 3750, 10750, 30000}
function SpeedConfig.Gain(level)
	return SpeedConfig.Gains[math.clamp(level, 0, SpeedConfig.MaxLevel)]
end
function SpeedConfig.GainPerSecond(level)
	return SpeedConfig.Gain(level) / SpeedConfig.Tick
end

-- prix (argent) pour passer du niveau "level" au suivant : 10K, 1M, 50M, 1B, 100B, 1T, 10T, 100T, 500T, 1Q
SpeedConfig.Costs = {[0] = 1e4, 1e6, 5e7, 1e9, 1e11, 1e12, 1e13, 1e14, 5e14, 1e15}
function SpeedConfig.Cost(level)
	return SpeedConfig.Costs[math.clamp(level, 0, SpeedConfig.MaxLevel - 1)]
end

-- bouton Robux du panneau : un niveau de plus. Crée un produit développeur (Creator Dashboard > Monetization > Developer Products)
-- au prix RobuxPrice et colle son id ici ; tant que l'id vaut 0 le bouton répond "coming soon".
SpeedConfig.RobuxProductId = 0
SpeedConfig.RobuxPrice = 400

-- vitesse de course (WalkSpeed) pour un speed donné : 16 au départ, 28 à 1K, 48 à 1M, 62 à 10M, 131 à 1B, 165 à 10B, 254 à 1Q,
-- 300 à 100Qi (le maximum). Courbe relevée deux fois : avec beaucoup de speed on va nettement plus vite
-- (à l'origine : 25 à 1M, 26 à 10M, 75 à 1B, 100 à 10B).
SpeedConfig.BaseWalk = 16
SpeedConfig.MaxWalk = 300
SpeedConfig.WalkPoints = {{0, 16}, {3, 28}, {6, 48}, {7, 62}, {10, 165}, {13, 225}, {16, 268}, {20, 300}} -- {puissance de 10 du speed, vitesse de course}
-- gardiens des zones : ils gardent l'ANCIENNE courbe (le joueur va plus vite, eux non : il les distance mieux)
SpeedConfig.BossWalkPoints = {{0, 16}, {7, 26}, {10, 100}, {16, 200}, {20, 300}}
local function curve(points, speed)
	local power = math.log10(math.max(speed, 1))
	for i = 2, #points do
		local a, b = points[i - 1], points[i]
		if power <= b[1] then return a[2] + (b[2] - a[2]) * (power - a[1]) / (b[1] - a[1]) end
	end
	return SpeedConfig.MaxWalk
end
function SpeedConfig.Walk(speed) return curve(SpeedConfig.WalkPoints, speed) end
function SpeedConfig.BossWalk(speed) return curve(SpeedConfig.BossWalkPoints, speed) end

-- apparence du tapis : un modèle par niveau
-- NeonTrim : les pièces sombres deviennent lumineuses ; Fx : les effets du tapis (ses couleurs, elles, ne bougent pas)
local rgb = Color3.fromRGB
-- Textures des effets : elles viennent de la réserve du jeu (ServerStorage["ALL VFX"]["vfx 2 "])
SpeedConfig.FxTextures = {
	Star = "rbxassetid://1084970835",          -- star thing
	Rays = "rbxassetid://1084975295",          -- light rays
	Spinny = "rbxassetid://1084969997",        -- spinny
	Flare = "rbxassetid://14684195806",        -- flare
	Glow = "rbxassetid://4509687978",          -- glow
	Pentagon = "rbxassetid://8099267640",      -- pentagon
	Octagon = "rbxassetid://8095997435",       -- octagon
	LightRing = "rbxassetid://8271495905",     -- light ring
	LightningRing = "rbxassetid://7150933366", -- lightning ring
	Vortex = "rbxassetid://6700005265",        -- vortex
	Fog = "rbxassetid://5872447086",           -- smoke/fog
}
-- Fx : liste d'effets du tapis (aucun pour le tapis de départ). Chaque effet :
--   Tex (clé de FxTextures), Color (Color3 ou ColorSequence), Rate, Life {min, max}, Speed {min, max}, Size,
--   Spread (degrés), Accel (Vector3), Spin (degrés/s), Alpha (transparence au plus visible), LE (LightEmission),
--   Grow = true : grossit au lieu de naître et mourir petit ; Flat = true : posé à plat au milieu de la bande (anneaux, tourbillons)
local RAINBOW = ColorSequence.new({
	ColorSequenceKeypoint.new(0, rgb(255, 80, 80)), ColorSequenceKeypoint.new(0.2, rgb(255, 200, 60)), ColorSequenceKeypoint.new(0.4, rgb(110, 255, 110)),
	ColorSequenceKeypoint.new(0.6, rgb(80, 220, 255)), ColorSequenceKeypoint.new(0.8, rgb(150, 110, 255)), ColorSequenceKeypoint.new(1, rgb(255, 110, 220))})
SpeedConfig.Skins = {
	{Level = 0, Name = "Stone", Frame = rgb(128, 132, 142), Trim = rgb(74, 77, 86), Glow = rgb(235, 240, 255)},
	{Level = 1, Name = "Bronze", Frame = rgb(205, 127, 62), Trim = rgb(112, 62, 26), Glow = rgb(255, 196, 130), Fx = {
		{Tex = "Glow", Color = rgb(255, 170, 90), Rate = 5, Life = {1.2, 2}, Speed = {1.5, 3}, Size = 1.2, Alpha = 0.45},
		{Tex = "Star", Color = rgb(255, 214, 150), Rate = 3, Life = {0.8, 1.3}, Speed = {2, 4}, Size = 0.7},
	}},
	{Level = 2, Name = "Gold", Frame = rgb(255, 200, 45), Trim = rgb(196, 124, 14), Glow = rgb(255, 240, 150), Fx = {
		{Tex = "Star", Color = rgb(255, 230, 110), Rate = 9, Life = {0.9, 1.5}, Speed = {2.5, 5}, Size = 1.0, Spin = 140},
		{Tex = "Rays", Color = rgb(255, 214, 90), Rate = 0.8, Life = {2.6, 3.2}, Speed = {0, 0}, Size = 9, Spin = 25, Alpha = 0.6, Flat = true},
		{Tex = "Flare", Color = rgb(255, 246, 190), Rate = 3, Life = {0.35, 0.6}, Speed = {0, 0.6}, Size = 1.5},
	}},
	{Level = 3, Name = "Diamond", Frame = rgb(120, 226, 255), Trim = rgb(38, 128, 222), Glow = rgb(215, 250, 255), Fx = {
		{Tex = "Pentagon", Color = rgb(150, 232, 255), Rate = 7, Life = {1.4, 2.2}, Speed = {2, 4}, Size = 0.8, Spin = 150},
		{Tex = "Octagon", Color = rgb(240, 252, 255), Rate = 4, Life = {1.2, 2}, Speed = {2, 4.5}, Size = 0.6, Spin = 150},
		{Tex = "Flare", Color = rgb(255, 255, 255), Rate = 6, Life = {0.3, 0.5}, Speed = {0, 0.5}, Size = 1.7},
		{Tex = "LightRing", Color = rgb(170, 236, 255), Rate = 0.6, Life = {1.5, 1.7}, Speed = {0, 0}, Size = 10, Alpha = 0.45, Grow = true, Flat = true},
	}},
	{Level = 4, Name = "Flash", Frame = rgb(30, 30, 38), Trim = rgb(255, 225, 40), Glow = rgb(255, 250, 170), NeonTrim = true, Fx = {
		{Tex = "LightningRing", Color = rgb(255, 240, 110), Rate = 2.2, Life = {0.3, 0.42}, Speed = {0, 0}, Size = 11, Alpha = 0.15, Grow = true, Flat = true},
		{Tex = "Flare", Color = rgb(255, 244, 120), Rate = 26, Life = {0.2, 0.42}, Speed = {14, 26}, Size = 1.0, Spread = 70, Accel = Vector3.new(0, -30, 0)},
		{Tex = "Glow", Color = rgb(255, 236, 90), Rate = 4, Life = {0.4, 0.7}, Speed = {0, 1}, Size = 2.4, Alpha = 0.5},
	}},
	{Level = 5, Name = "Emerald", Frame = rgb(70, 226, 120), Trim = rgb(14, 132, 70), Glow = rgb(190, 255, 170), Fx = {
		{Tex = "Octagon", Color = rgb(120, 255, 150), Rate = 8, Life = {1.3, 2.1}, Speed = {2, 4}, Size = 0.8, Spin = 150},
		{Tex = "Spinny", Color = rgb(90, 240, 130), Rate = 0.7, Life = {2.2, 2.6}, Speed = {0, 0}, Size = 9, Spin = 90, Alpha = 0.55, Flat = true},
		{Tex = "Glow", Color = rgb(150, 255, 170), Rate = 4, Life = {1, 1.6}, Speed = {1, 2.5}, Size = 1.4, Alpha = 0.45},
	}},
	{Level = 6, Name = "Lava", Frame = rgb(44, 26, 24), Trim = rgb(255, 96, 20), Glow = rgb(255, 190, 60), NeonTrim = true, Fx = {
		{Tex = "Fog", Color = rgb(70, 26, 14), Rate = 8, Life = {1.4, 2.2}, Speed = {2, 4}, Size = 2.8, Alpha = 0.5, LE = 0.2, Grow = true},
		{Tex = "Flare", Color = rgb(255, 150, 40), Rate = 20, Life = {0.8, 1.4}, Speed = {5, 9}, Size = 0.5, Spread = 28, Accel = Vector3.new(0, 3, 0)},
		{Tex = "Glow", Color = rgb(255, 110, 30), Rate = 5, Life = {0.8, 1.3}, Speed = {1, 2}, Size = 2.2, Alpha = 0.5},
	}},
	{Level = 7, Name = "Frost", Frame = rgb(226, 244, 255), Trim = rgb(110, 190, 255), Glow = rgb(170, 235, 255), NeonTrim = true, Fx = {
		{Tex = "Star", Color = rgb(240, 250, 255), Rate = 14, Life = {1.6, 2.4}, Speed = {4, 7}, Size = 0.55, Spread = 35, Accel = Vector3.new(0, -6, 0), Spin = 120},
		{Tex = "Fog", Color = rgb(190, 228, 255), Rate = 5, Life = {1.6, 2.4}, Speed = {0.5, 1.5}, Size = 3.2, Alpha = 0.72, LE = 0.6, Grow = true},
		{Tex = "LightRing", Color = rgb(190, 236, 255), Rate = 0.5, Life = {1.8, 2}, Speed = {0, 0}, Size = 10, Alpha = 0.5, Grow = true, Flat = true},
	}},
	{Level = 8, Name = "Galaxy", Frame = rgb(40, 24, 92), Trim = rgb(150, 70, 255), Glow = rgb(120, 220, 255), NeonTrim = true, Fx = {
		{Tex = "Vortex", Color = rgb(170, 100, 255), Rate = 0.8, Life = {2.8, 3.2}, Speed = {0, 0}, Size = 11, Spin = 120, Alpha = 0.35, Flat = true},
		{Tex = "Star", Color = ColorSequence.new(rgb(210, 170, 255), rgb(120, 220, 255)), Rate = 16, Life = {1, 1.8}, Speed = {2, 5}, Size = 0.8, Spin = 140},
		{Tex = "Glow", Color = rgb(150, 90, 255), Rate = 4, Life = {1, 1.6}, Speed = {1, 2}, Size = 1.9, Alpha = 0.5},
	}},
	{Level = 9, Name = "Rainbow", Frame = rgb(245, 245, 250), Trim = rgb(255, 80, 160), Glow = rgb(120, 230, 255), NeonTrim = true, Fx = {
		{Tex = "Star", Color = RAINBOW, Rate = 22, Life = {1, 1.7}, Speed = {3, 6}, Size = 1.0, Spin = 150},
		{Tex = "Rays", Color = RAINBOW, Rate = 0.8, Life = {2.6, 3.2}, Speed = {0, 0}, Size = 10, Spin = 30, Alpha = 0.55, Flat = true},
		{Tex = "Flare", Color = RAINBOW, Rate = 6, Life = {0.4, 0.7}, Speed = {0, 1}, Size = 1.6},
	}},
	{Level = 10, Name = "Void", Frame = rgb(14, 10, 22), Trim = rgb(190, 60, 255), Glow = rgb(255, 80, 200), NeonTrim = true, Fx = {
		{Tex = "Vortex", Color = rgb(200, 70, 255), Rate = 1, Life = {2.6, 3}, Speed = {0, 0}, Size = 12, Spin = 170, Alpha = 0.25, Flat = true},
		{Tex = "Fog", Color = rgb(70, 20, 120), Rate = 9, Life = {1.4, 2.2}, Speed = {1.5, 3}, Size = 3.2, Alpha = 0.5, LE = 0.3, Grow = true},
		{Tex = "Flare", Color = rgb(255, 80, 200), Rate = 8, Life = {0.7, 1.2}, Speed = {3, 6}, Size = 0.85, Spread = 30},
	}},
}
function SpeedConfig.Skin(level)
	local skin = SpeedConfig.Skins[1]
	for _, s in SpeedConfig.Skins do if level >= s.Level then skin = s end end
	return skin
end

-- 1 500 -> "1.5K" ; après 999T vient 1Q, après 999Q vient 1Qi, puis Sx, Sp, Oc, No, Dc
SpeedConfig.Suffixes = {"K", "M", "B", "T", "Q", "Qi", "Sx", "Sp", "Oc", "No", "Dc"}
function SpeedConfig.Format(n)
	n = math.floor(n + 0.5)
	if n < 1000 then return tostring(n) end
	local i = math.min(math.floor(math.log10(n) / 3 + 1e-9), #SpeedConfig.Suffixes)
	local v = n / 10 ^ (i * 3)
	local text = v >= 100 and string.format("%.0f", v) or (string.format("%.1f", v):gsub("%.0$", ""))
	if text == "1000" and i < #SpeedConfig.Suffixes then i += 1 text = "1" end
	return text .. SpeedConfig.Suffixes[i]
end

return SpeedConfig
