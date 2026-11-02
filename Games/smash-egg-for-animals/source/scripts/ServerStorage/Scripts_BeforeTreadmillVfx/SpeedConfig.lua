-- Speed : on le gagne en courant sur le tapis de sa base, il fait courir plus vite.
-- Le niveau du tapis (0 à 50) est l'attribut TreadmillLevel du joueur, son speed l'attribut Speed.
local SpeedConfig = {}

SpeedConfig.MaxLevel = 50    -- nombre d'améliorations du tapis
SpeedConfig.Tick = 0.25      -- secondes entre deux gains quand on court sur le tapis

-- arrondi à "digits" chiffres significatifs
local function round(n, digits)
	if n <= 0 then return 0 end
	local magnitude = 10 ^ math.max(0, math.floor(math.log10(n)) - (digits - 1))
	return math.floor(n / magnitude + 0.5) * magnitude
end

-- gain par pas (4 pas par seconde) : 1, 5, 40, puis 250 au niveau 3 (1K par seconde) et x1,9 par niveau
SpeedConfig.FirstGains = {[0] = 1, 5, 40}
SpeedConfig.GainAt3 = 250
SpeedConfig.GainGrowth = 1.9
function SpeedConfig.Gain(level)
	level = math.clamp(level, 0, SpeedConfig.MaxLevel)
	return SpeedConfig.FirstGains[level] or round(SpeedConfig.GainAt3 * SpeedConfig.GainGrowth ^ (level - 3), 2)
end
function SpeedConfig.GainPerSecond(level)
	return SpeedConfig.Gain(level) / SpeedConfig.Tick
end

-- prix (argent) pour passer du niveau "level" au suivant : 10K, 500K, 10M, puis une montée régulière jusqu'à 100Qi pour la dernière
SpeedConfig.FirstCosts = {[0] = 1e4, 5e5}
SpeedConfig.CostAt2 = 1e7
SpeedConfig.LastCost = 1e20
function SpeedConfig.Cost(level)
	local last = SpeedConfig.MaxLevel - 1
	if level >= last then return SpeedConfig.LastCost end
	if SpeedConfig.FirstCosts[level] then return SpeedConfig.FirstCosts[level] end
	local t = (level - 2) / (last - 2)
	return round(SpeedConfig.CostAt2 * (SpeedConfig.LastCost / SpeedConfig.CostAt2) ^ t, 2)
end

-- bouton Robux du panneau : un niveau de plus. Crée un produit développeur (Creator Dashboard > Monetization > Developer Products)
-- au prix RobuxPrice et colle son id ici ; tant que l'id vaut 0 le bouton répond "coming soon".
SpeedConfig.RobuxProductId = 0
SpeedConfig.RobuxPrice = 400

-- vitesse de course (WalkSpeed) pour un speed donné : 16 au départ, 35 à 100K, plafonnée à 300 (atteinte vers 100B)
SpeedConfig.BaseWalk = 16
SpeedConfig.MaxWalk = 300
function SpeedConfig.Walk(speed)
	return math.clamp(SpeedConfig.BaseWalk + 2 * math.max(speed, 0) ^ 0.196, SpeedConfig.BaseWalk, SpeedConfig.MaxWalk)
end

-- apparence du tapis : elle change tous les 5 niveaux
-- NeonTrim : les pièces sombres deviennent lumineuses ; Fx : particules sur le socle ; Anim : animation jouée côté joueur
local rgb = Color3.fromRGB
SpeedConfig.Skins = {
	{Level = 0, Name = "Stone", Frame = rgb(128, 132, 142), Trim = rgb(74, 77, 86), Glow = rgb(235, 240, 255)},
	{Level = 5, Name = "Bronze", Frame = rgb(205, 127, 62), Trim = rgb(112, 62, 26), Glow = rgb(255, 196, 130)},
	{Level = 10, Name = "Gold", Frame = rgb(255, 200, 45), Trim = rgb(196, 124, 14), Glow = rgb(255, 240, 150),
		Fx = {Kind = "Sparkle", Color = rgb(255, 235, 130), Rate = 6}},
	{Level = 15, Name = "Diamond", Frame = rgb(120, 226, 255), Trim = rgb(38, 128, 222), Glow = rgb(215, 250, 255),
		Fx = {Kind = "Sparkle", Color = rgb(200, 245, 255), Rate = 10}},
	{Level = 20, Name = "Flash", Frame = rgb(30, 30, 38), Trim = rgb(255, 225, 40), Glow = rgb(255, 250, 170), NeonTrim = true, Anim = "Flash",
		Fx = {Kind = "Bolt", Color = rgb(255, 240, 90), Rate = 26}},
	{Level = 25, Name = "Emerald", Frame = rgb(70, 226, 120), Trim = rgb(14, 132, 70), Glow = rgb(190, 255, 170), Anim = "Pulse",
		Fx = {Kind = "Sparkle", Color = rgb(150, 255, 170), Rate = 12}},
	{Level = 30, Name = "Lava", Frame = rgb(44, 26, 24), Trim = rgb(255, 96, 20), Glow = rgb(255, 190, 60), NeonTrim = true, Anim = "Pulse",
		Fx = {Kind = "Fire", Color = rgb(255, 130, 30), Rate = 22}},
	{Level = 35, Name = "Frost", Frame = rgb(226, 244, 255), Trim = rgb(110, 190, 255), Glow = rgb(170, 235, 255), NeonTrim = true, Anim = "Pulse",
		Fx = {Kind = "Snow", Color = rgb(235, 250, 255), Rate = 20}},
	{Level = 40, Name = "Galaxy", Frame = rgb(40, 24, 92), Trim = rgb(150, 70, 255), Glow = rgb(120, 220, 255), NeonTrim = true, Anim = "Pulse",
		Fx = {Kind = "Sparkle", Color = rgb(200, 160, 255), Rate = 24}},
	{Level = 45, Name = "Rainbow", Frame = rgb(245, 245, 250), Trim = rgb(255, 80, 80), Glow = rgb(255, 255, 255), NeonTrim = true, Anim = "Rainbow",
		Fx = {Kind = "Sparkle", Color = rgb(255, 255, 255), Rate = 26}},
	{Level = 50, Name = "Void", Frame = rgb(14, 10, 22), Trim = rgb(190, 60, 255), Glow = rgb(255, 80, 200), NeonTrim = true, Anim = "Flash",
		Fx = {Kind = "Smoke", Color = rgb(120, 40, 200), Rate = 18}},
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
