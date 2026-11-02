-- Traînées : elles suivent le joueur quand il court et multiplient le speed gagné sur le tapis (Mult).
-- On les achète au stand TRAILS ; celle qui est équipée est l'attribut "Trail" du joueur (0 = aucune), celles possédées "Trails".
local rgb = Color3.fromRGB
local K = ColorSequenceKeypoint.new
local TrailConfig = {}

-- Icon : l'image de la carte dans la boutique (les quatre icônes du créateur, et leurs copies recolorées par recolor_icons.py)
-- Price : prix en argent, de 2,5K à 1Q (environ x14 d'une traînée à la suivante)
-- Robux : prix affiché sur le bouton rose ; ProductId : id du produit développeur (0 = pas encore créé, le bouton répond "coming soon")
TrailConfig.Trails = {
	{Name = "White Trail", Icon = "rbxassetid://98818394519673", Rarity = "Common", Mult = 2, Price = 2.5e3, Robux = 3, Color = rgb(245, 245, 250)},
	{Name = "Blue Trail", Icon = "rbxassetid://113287848907721", Rarity = "Uncommon", Mult = 4, Price = 3.5e4, Robux = 16, Color = rgb(70, 150, 255)},
	{Name = "Green Trail", Icon = "rbxassetid://101733309773012", Rarity = "Rare", Mult = 8, Price = 5e5, Robux = 24, Color = rgb(60, 220, 100)},
	{Name = "Purple Trail", Icon = "rbxassetid://127597913030132", Rarity = "Epic", Mult = 16, Price = 7.5e6, Robux = 64, Color = rgb(225, 80, 255)},
	{Name = "Red Trail", Icon = "rbxassetid://72904655944196", Rarity = "Legendary", Mult = 40, Price = 1e8, Robux = 104, Color = rgb(255, 70, 70)},
	{Name = "Golden Trail", Icon = "rbxassetid://72043434145134", Rarity = "Mythic", Mult = 100, Price = 1.5e9, Robux = 150, Color = rgb(255, 205, 50), Sparkle = true},
	{Name = "Rainbow Trail", Icon = "rbxassetid://93398451012341", Rarity = "Secret", Mult = 250, Price = 2e10, Robux = 200, Color = rgb(255, 120, 120), Sparkle = true,
		Sequence = ColorSequence.new({K(0, rgb(255, 80, 80)), K(0.2, rgb(255, 190, 60)), K(0.4, rgb(250, 245, 90)), K(0.6, rgb(100, 240, 120)), K(0.8, rgb(80, 180, 255)), K(1, rgb(190, 110, 255))})},
	{Name = "Galaxy Trail", Icon = "rbxassetid://90062964776272", Rarity = "Ancient", Mult = 600, Price = 3e11, Robux = 312, Color = rgb(130, 70, 255), Sparkle = true,
		Sequence = ColorSequence.new({K(0, rgb(255, 120, 240)), K(0.5, rgb(120, 70, 255)), K(1, rgb(40, 30, 120))})},
	{Name = "Zebra Trail", Icon = "rbxassetid://124923025448285", Rarity = "OG", Mult = 1500, Price = 4e12, Robux = 400, Color = rgb(250, 250, 250), Stripes = rgb(20, 20, 24),
		Sequence = ColorSequence.new({K(0, rgb(255, 255, 255)), K(0.24, rgb(255, 255, 255)), K(0.25, rgb(20, 20, 24)), K(0.49, rgb(20, 20, 24)), K(0.5, rgb(255, 255, 255)), K(0.74, rgb(255, 255, 255)), K(0.75, rgb(20, 20, 24)), K(1, rgb(20, 20, 24))})},
	{Name = "Laser Trail", Icon = "rbxassetid://97653115325126", Rarity = "Divine", Mult = 4000, Price = 6e13, Robux = 560, Color = rgb(255, 30, 50), Sparkle = true, Neon = true},
	{Name = "Moonlight Trail", Icon = "rbxassetid://98298589885228", Rarity = "Prismatic", Mult = 10000, Price = 1e15, Robux = 720, Color = rgb(120, 230, 255), Sparkle = true, Neon = true,
		Sequence = ColorSequence.new({K(0, rgb(255, 255, 255)), K(0.5, rgb(120, 230, 255)), K(1, rgb(60, 120, 255))})},
}
-- zone Galaxy : nébuleuse rose -> violet -> cyan, étoiles (icône : l'icône bleue du créateur recolorée)
table.insert(TrailConfig.Trails, {Name = "Nebula Trail", Icon = "rbxassetid://71204400856521", Rarity = "Galactic", Mult = 25000, Price = 1e16, Robux = 880, Color = rgb(170, 90, 255), Sparkle = true, Neon = true,
	Sequence = ColorSequence.new({K(0, rgb(255, 90, 220)), K(0.5, rgb(140, 70, 255)), K(1, rgb(70, 220, 255))})})
-- zone Phantom : âme cyan qui s'éteint dans le noir, brume fantôme derrière le joueur (Mist, TrailServer)
table.insert(TrailConfig.Trails, {Name = "Soul Trail", Icon = "rbxassetid://128276026949228", Rarity = "Phantom", Mult = 60000, Price = 1e17, Robux = 1040, Color = rgb(90, 255, 225), Sparkle = true, Neon = true, Mist = true,
	Sequence = ColorSequence.new({K(0, rgb(170, 255, 240)), K(0.45, rgb(130, 80, 230)), K(1, rgb(24, 16, 40))})})
for _, trail in TrailConfig.Trails do trail.ProductId = trail.ProductId or 0 end

function TrailConfig.Mult(index)
	local trail = TrailConfig.Trails[index or 0]
	return trail and trail.Mult or 1
end

-- "1,3,4" -> {[1] = true, [3] = true, [4] = true}
function TrailConfig.Owned(text)
	local owned = {}
	for number in string.gmatch(text or "", "%d+") do owned[tonumber(number)] = true end
	return owned
end

return TrailConfig
