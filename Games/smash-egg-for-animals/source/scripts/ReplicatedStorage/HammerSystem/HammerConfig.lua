-- Marteaux : on casse les œufs avec. Chaque zone demande un marteau assez bon (EggConfig.ZoneHammer), le suivant s'achète au stand HAMMERS.
-- Le marteau du joueur est son attribut "Hammer" (numéro dans cette liste), sauvegardé par PetServer.
local rgb = Color3.fromRGB
local HammerConfig = {}

-- Damage : points de vie enlevés à un œuf par coup. Head / Face / Band / Shaft : couleurs du modèle. Glow : lueur et étincelles.
HammerConfig.Tiers = {
	-- Par paires de même rareté, côte à côte : le premier est le moins bon de sa rareté, le second le meilleur.
	-- Puissance : environ x4 à chaque marteau. Prix : environ x4,6 à chaque marteau ; Void 1Q, Planet 5Q, Sun 20Q, Spectral 100Q, Reaper 500Q.
	-- Common
	{Name = "Wooden Hammer", Rarity = "Common", Price = 0, Damage = 1, Head = rgb(150, 100, 56), Face = rgb(186, 134, 82), Band = rgb(96, 62, 34), Shaft = rgb(196, 150, 96)},
	{Name = "Obsidian Hammer", Rarity = "Common", Price = 1e3, Damage = 4, Head = rgb(60, 50, 70), Face = rgb(90, 80, 100), Band = rgb(40, 35, 45), Shaft = rgb(80, 70, 90)},
	-- Uncommon
	{Name = "Stone Hammer", Rarity = "Uncommon", Price = 5e3, Damage = 15, Head = rgb(128, 130, 138), Face = rgb(168, 170, 178), Band = rgb(84, 86, 94), Shaft = rgb(150, 104, 60)},
	{Name = "Emerald Hammer", Rarity = "Uncommon", Price = 2e4, Damage = 60, Head = rgb(60, 180, 100), Face = rgb(120, 230, 150), Band = rgb(40, 120, 70), Shaft = rgb(200, 180, 140)},
	-- Rare
	{Name = "Iron Hammer", Rarity = "Rare", Price = 1e5, Damage = 250, Head = rgb(176, 184, 198), Face = rgb(222, 228, 238), Band = rgb(70, 110, 190), Shaft = rgb(110, 72, 44)},
	{Name = "Sapphire Hammer", Rarity = "Rare", Price = 5e5, Damage = 1e3, Head = rgb(40, 80, 200), Face = rgb(100, 150, 255), Band = rgb(30, 60, 160), Shaft = rgb(220, 230, 250), Glow = rgb(80, 140, 255)},
	-- Epic
	{Name = "Gold Hammer", Rarity = "Epic", Price = 2e6, Damage = 4e3, Head = rgb(255, 200, 50), Face = rgb(255, 232, 130), Band = rgb(226, 60, 70), Shaft = rgb(250, 244, 230), Glow = rgb(255, 220, 110)},
	{Name = "Inferno Hammer", Rarity = "Epic", Price = 1e7, Damage = 15e3, Head = rgb(200, 60, 20), Face = rgb(255, 140, 30), Band = rgb(180, 40, 10), Shaft = rgb(80, 30, 20), Glow = rgb(255, 100, 30)},
	-- Legendary
	{Name = "Diamond Hammer", Rarity = "Legendary", Price = 5e7, Damage = 6e4, Head = rgb(110, 222, 255), Face = rgb(210, 248, 255), Band = rgb(40, 110, 230), Shaft = rgb(240, 246, 255), Glow = rgb(140, 230, 255)},
	{Name = "Frost Hammer", Rarity = "Legendary", Price = 2e8, Damage = 25e4, Head = rgb(150, 220, 255), Face = rgb(220, 250, 255), Band = rgb(80, 180, 220), Shaft = rgb(200, 240, 255), Glow = rgb(180, 240, 255)},
	-- Mythic
	{Name = "Mythic Hammer", Rarity = "Mythic", Price = 1e9, Damage = 1e6, Head = rgb(160, 40, 20), Face = rgb(255, 160, 40), Band = rgb(255, 100, 20), Shaft = rgb(40, 22, 18), Glow = rgb(255, 120, 30)},
	{Name = "Thunder Hammer", Rarity = "Mythic", Price = 5e9, Damage = 4e6, Head = rgb(255, 220, 60), Face = rgb(255, 250, 180), Band = rgb(255, 180, 20), Shaft = rgb(60, 50, 40), Glow = rgb(255, 240, 100)},
	-- Secret
	{Name = "Secret Hammer", Rarity = "Secret", Price = 2e10, Damage = 15e6, Head = rgb(50, 15, 55), Face = rgb(200, 30, 40), Band = rgb(140, 25, 35), Shaft = rgb(16, 10, 20), Glow = rgb(140, 20, 40)},
	{Name = "Shadow Hammer", Rarity = "Secret", Price = 1e11, Damage = 6e7, Head = rgb(30, 25, 35), Face = rgb(180, 30, 50), Band = rgb(120, 20, 35), Shaft = rgb(15, 12, 18), Glow = rgb(200, 40, 60)},
	-- Ancient
	{Name = "Ancient Hammer", Rarity = "Ancient", Price = 5e11, Damage = 25e7, Head = rgb(20, 80, 55), Face = rgb(60, 255, 180), Band = rgb(40, 180, 120), Shaft = rgb(30, 50, 42), Glow = rgb(80, 255, 190)},
	{Name = "Cosmos Hammer", Rarity = "Ancient", Price = 2e12, Damage = 1e9, Head = rgb(20, 60, 100), Face = rgb(60, 200, 255), Band = rgb(255, 200, 80), Shaft = rgb(20, 40, 60), Glow = rgb(80, 220, 255)},
	-- Divine
	{Name = "Divine Hammer", Rarity = "Divine", Price = 1e13, Damage = 4e9, Head = rgb(250, 250, 255), Face = rgb(120, 200, 255), Band = rgb(255, 220, 120), Shaft = rgb(235, 235, 245), Glow = rgb(255, 250, 200)},
	{Name = "Holy Hammer", Rarity = "Divine", Price = 5e13, Damage = 15e9, Head = rgb(255, 245, 200), Face = rgb(255, 230, 150), Band = rgb(255, 200, 80), Shaft = rgb(255, 250, 240), Glow = rgb(255, 240, 180)},
	-- Prismatic
	{Name = "Prismatic Hammer", Rarity = "Prismatic", Price = 2e14, Damage = 6e10, Head = rgb(190, 110, 255), Face = rgb(255, 150, 230), Band = rgb(110, 255, 200), Shaft = rgb(40, 34, 60), Glow = rgb(230, 140, 255), Rainbow = true},
	{Name = "Void Hammer", Rarity = "Prismatic", Price = 1e15, Damage = 25e10, Head = rgb(80, 20, 100), Face = rgb(150, 50, 180), Band = rgb(60, 10, 80), Shaft = rgb(40, 20, 50), Glow = rgb(180, 60, 220), Rainbow = true},
	-- Galactic (Galaxy Zone) : une planète à anneaux sur la tête, puis le soleil (le meilleur et le plus cher du jeu)
	{Name = "Planet Hammer", Rarity = "Galactic", Price = 5e15, Damage = 1e12, Head = rgb(40, 30, 110), Face = rgb(110, 90, 255), Band = rgb(80, 200, 255), Shaft = rgb(28, 22, 60), Glow = rgb(130, 170, 255)},
	{Name = "Sun Hammer", Rarity = "Galactic", Price = 2e16, Damage = 4e12, Head = rgb(255, 150, 30), Face = rgb(255, 220, 90), Band = rgb(255, 90, 30), Shaft = rgb(60, 30, 20), Glow = rgb(255, 200, 60)},
	-- Phantom (Phantom Zone) : un marteau de verre fantôme avec sa lanterne d'âme, puis le marteau du Reaper (crânes, lame de faux),
	-- les meilleurs et les plus chers du jeu (100Q et 500Q ; ServerStorage.HammerBuilder, thèmes spectral / reaper)
	{Name = "Spectral Hammer", Rarity = "Phantom", Price = 1e17, Damage = 16e12, Head = rgb(40, 60, 80), Face = rgb(120, 255, 230), Band = rgb(110, 60, 180), Shaft = rgb(20, 18, 28), Glow = rgb(110, 255, 230)},
	{Name = "Reaper Hammer", Rarity = "Phantom", Price = 5e17, Damage = 64e12, Head = rgb(22, 20, 30), Face = rgb(60, 54, 76), Band = rgb(150, 90, 255), Shaft = rgb(40, 30, 38), Glow = rgb(170, 110, 255)},
}

function HammerConfig.Get(tier)
	return HammerConfig.Tiers[math.clamp(math.floor(tonumber(tier) or 1), 1, #HammerConfig.Tiers)]
end

return HammerConfig
