-- Marteaux : on casse les œufs avec. Chaque zone demande un marteau assez bon (EggConfig.ZoneHammer), le suivant s'achète au stand HAMMERS.
-- Le marteau du joueur est son attribut "Hammer" (numéro dans cette liste), sauvegardé par PetServer.
local rgb = Color3.fromRGB
local HammerConfig = {}

-- Damage : points de vie enlevés à un œuf par coup. Head / Face / Band / Shaft : couleurs du modèle. Glow : lueur et étincelles.
HammerConfig.Tiers = {
	{Name = "Wooden Hammer", Price = 0, Damage = 1, Head = rgb(150, 100, 56), Face = rgb(186, 134, 82), Band = rgb(96, 62, 34), Shaft = rgb(196, 150, 96)},
	{Name = "Stone Hammer", Price = 5e4, Damage = 8, Head = rgb(128, 130, 138), Face = rgb(168, 170, 178), Band = rgb(84, 86, 94), Shaft = rgb(150, 104, 60)},
	{Name = "Iron Hammer", Price = 5e7, Damage = 64, Head = rgb(176, 184, 198), Face = rgb(222, 228, 238), Band = rgb(70, 110, 190), Shaft = rgb(110, 72, 44)},
	{Name = "Gold Hammer", Price = 5e10, Damage = 512, Head = rgb(255, 200, 50), Face = rgb(255, 232, 130), Band = rgb(226, 60, 70), Shaft = rgb(250, 244, 230), Glow = rgb(255, 220, 110)},
	{Name = "Diamond Hammer", Price = 5e12, Damage = 4096, Head = rgb(110, 222, 255), Face = rgb(210, 248, 255), Band = rgb(40, 110, 230), Shaft = rgb(240, 246, 255), Glow = rgb(140, 230, 255)},
	{Name = "Prismatic Hammer", Price = 5e14, Damage = 32768, Head = rgb(190, 110, 255), Face = rgb(255, 150, 230), Band = rgb(110, 255, 200), Shaft = rgb(40, 34, 60), Glow = rgb(230, 140, 255), Rainbow = true},
	{Name = "Mythic Hammer", Price = 5e16, Damage = 262144, Head = rgb(160, 40, 20), Face = rgb(255, 160, 40), Band = rgb(255, 100, 20), Shaft = rgb(40, 22, 18), Glow = rgb(255, 120, 30)},
	{Name = "Secret Hammer", Price = 5e18, Damage = 2097152, Head = rgb(50, 15, 55), Face = rgb(200, 30, 40), Band = rgb(140, 25, 35), Shaft = rgb(16, 10, 20), Glow = rgb(140, 20, 40)},
	{Name = "Divine Hammer", Price = 5e20, Damage = 16777216, Head = rgb(250, 250, 255), Face = rgb(120, 200, 255), Band = rgb(255, 220, 120), Shaft = rgb(235, 235, 245), Glow = rgb(255, 250, 200)},
	{Name = "Ancient Hammer", Price = 5e22, Damage = 134217728, Head = rgb(20, 80, 55), Face = rgb(60, 255, 180), Band = rgb(40, 180, 120), Shaft = rgb(30, 50, 42), Glow = rgb(80, 255, 190)},
	{Name = "Obsidian Hammer", Price = 5e24, Damage = 1073741824, Head = rgb(60, 50, 70), Face = rgb(90, 80, 100), Band = rgb(40, 35, 45), Shaft = rgb(80, 70, 90)},
	{Name = "Emerald Hammer", Price = 5e26, Damage = 8589934592, Head = rgb(60, 180, 100), Face = rgb(120, 230, 150), Band = rgb(40, 120, 70), Shaft = rgb(200, 180, 140)},
	{Name = "Sapphire Hammer", Price = 5e28, Damage = 68719476736, Head = rgb(40, 80, 200), Face = rgb(100, 150, 255), Band = rgb(30, 60, 160), Shaft = rgb(220, 230, 250), Glow = rgb(80, 140, 255)},
	{Name = "Inferno Hammer", Price = 5e30, Damage = 549755813888, Head = rgb(200, 60, 20), Face = rgb(255, 140, 30), Band = rgb(180, 40, 10), Shaft = rgb(80, 30, 20), Glow = rgb(255, 100, 30)},
	{Name = "Frost Hammer", Price = 5e32, Damage = 4398046511104, Head = rgb(150, 220, 255), Face = rgb(220, 250, 255), Band = rgb(80, 180, 220), Shaft = rgb(200, 240, 255), Glow = rgb(180, 240, 255)},
	{Name = "Void Hammer", Price = 5e34, Damage = 35184372088832, Head = rgb(80, 20, 100), Face = rgb(150, 50, 180), Band = rgb(60, 10, 80), Shaft = rgb(40, 20, 50), Glow = rgb(180, 60, 220), Rainbow = true},
	{Name = "Thunder Hammer", Price = 5e36, Damage = 281474976710656, Head = rgb(255, 220, 60), Face = rgb(255, 250, 180), Band = rgb(255, 180, 20), Shaft = rgb(60, 50, 40), Glow = rgb(255, 240, 100)},
	{Name = "Shadow Hammer", Price = 5e38, Damage = 2251799813685248, Head = rgb(30, 25, 35), Face = rgb(180, 30, 50), Band = rgb(120, 20, 35), Shaft = rgb(15, 12, 18), Glow = rgb(200, 40, 60)},
	{Name = "Holy Hammer", Price = 5e40, Damage = 18014398509481984, Head = rgb(255, 245, 200), Face = rgb(255, 230, 150), Band = rgb(255, 200, 80), Shaft = rgb(255, 250, 240), Glow = rgb(255, 240, 180)},
	{Name = "Cosmos Hammer", Price = 5e42, Damage = 144115188075855872, Head = rgb(20, 60, 100), Face = rgb(60, 200, 255), Band = rgb(255, 200, 80), Shaft = rgb(20, 40, 60), Glow = rgb(80, 220, 255)},
}

function HammerConfig.Get(tier)
	return HammerConfig.Tiers[math.clamp(math.floor(tonumber(tier) or 1), 1, #HammerConfig.Tiers)]
end

return HammerConfig
