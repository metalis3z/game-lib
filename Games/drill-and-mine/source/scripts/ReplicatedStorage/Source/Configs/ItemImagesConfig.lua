--[[
	ItemImagesConfig -- 2D card art for loot, uploaded to the HighKick group
	via Asset Manager bulk import (2026-07-18). Copied verbatim from
	"+1 Kick Door Per Click" 2026-07-19 (same catalog, same art). When an
	entry exists the UIs show the flat art instead of building a live
	ModelViewport:
	  IndexController           -- index cards (undiscovered = black tint)
	  LuckyBlockStoreController -- store cards' loot-strip slots
	  RarityLootClient          -- hotbar loot-stack slots
	Keys match the template names under ReplicatedStorage.RarityItems.<Rarity>
	(Items) and ReplicatedStorage.LuckyBlockLoot.<Tier> (LuckyBlockLoot).
	No entry = that slot keeps its 3D viewport. Currently missing art:
	  Items: Ruby, Bag of Money, Diamond, Golden Goblet, Gold Bar, Ancient Pot,
	  Golden Hat, Gem, Phoenix Feather, Throne, Night Fedora, Phoenix Fire
	  Arrow, Nuclear Waste, UFO, Divine Scepter, Crystal Ball, Periastron
	  Sword, Fire Dominus, Magic Carpet, Dark Heart, Black Hole
	  LuckyBlockLoot: BlackHole
	Upload-name quirks (upload -> key): Emerald -> Cristal (the green crystal;
	Ruby is red), YellowLookingGlassThing -> Bloxy Award, Thanos Glove ->
	Infinity Gauntlet, Chest -> Treasure Chest, coil -> Gravity Coil.
]]

local ItemImagesConfig = {}

ItemImagesConfig.Items = {
	-- Common
	["Apple"] = "rbxassetid://81982461402761",
	["Mushroom"] = "rbxassetid://114928643617781",
	["Duck"] = "rbxassetid://105009600964254",
	["Coin"] = "rbxassetid://71340845612500",
	["Bone"] = "rbxassetid://115822635232947",
	["Meat"] = "rbxassetid://119021382279042",
	-- Uncommon
	["Ring"] = "rbxassetid://86416174362736",
	["Pearl"] = "rbxassetid://122482593965529",
	["Cash"] = "rbxassetid://117884160997001",
	-- Rare
	["Compass"] = "rbxassetid://133144993985139",
	["Hourglass"] = "rbxassetid://88193628406528",
	["Telescope"] = "rbxassetid://92727245935405",
	["Golden Key"] = "rbxassetid://97233641189557",
	["Treasure Map"] = "rbxassetid://138377436729731",
	["Gold Ingot"] = "rbxassetid://82123455058871",
	["Linked Sword"] = "rbxassetid://132554365051859",
	-- Epic
	["Crossbow"] = "rbxassetid://77712457913172",
	["Diamond Gem"] = "rbxassetid://87563008395765",
	["Treasure Chest"] = "rbxassetid://115037310546193",
	["Robux Cash Stack"] = "rbxassetid://75293949059828",
	-- Legendary
	["Sapphire Crystal"] = "rbxassetid://112142261875787",
	["Crystal Cluster"] = "rbxassetid://101751017376888",
	["Celestial Star Orb"] = "rbxassetid://106180306971970",
	["Cristal"] = "rbxassetid://81612352588677",
	["Gravity Coil"] = "rbxassetid://74152622639201",
	["Magic Sword"] = "rbxassetid://95915148646667",
	-- Mythic
	["Moai Statue"] = "rbxassetid://134968399138680",
	["Thunder Hammer"] = "rbxassetid://72089870218445",
	["Crystal Orb"] = "rbxassetid://138288388002915",
	["Ancient Spellbook"] = "rbxassetid://128718827814295",
	["Dragon Egg"] = "rbxassetid://94603755376330",
	["Magic Orb"] = "rbxassetid://102170454623910",
	["Ancient Drum"] = "rbxassetid://76590026415343",
	-- Godly
	["Golden Idol Statue"] = "rbxassetid://98842264460574",
	["Bloxy Award"] = "rbxassetid://85137625067868",
	["Roblox Trophy"] = "rbxassetid://92879687649449",
	["Golden Trophy"] = "rbxassetid://84331890354369",
	-- Secret
	["Royal Scepter"] = "rbxassetid://110363602671042",
	["Cosmos Magic Staff"] = "rbxassetid://99352142644535",
	["Lyre Harp"] = "rbxassetid://112952457865838",
	["Dragon Skull"] = "rbxassetid://108300489230436",
	["void ball"] = "rbxassetid://125725837945401",
	["Horned Skull"] = "rbxassetid://119500021767999",
	-- Divine
	["Magic Portal"] = "rbxassetid://121852407167464",
	["Infinity Gauntlet"] = "rbxassetid://129562556368360",
	-- Rainbow
	["Rainbow Gem"] = "rbxassetid://71284006223627",
}

ItemImagesConfig.LuckyBlockLoot = {
	-- Legendary
	["Crystal"] = "rbxassetid://82184457071683",
	["PinkOrb"] = "rbxassetid://85757932085452",
	["VictoriousHelmet"] = "rbxassetid://124103162605691",
	["NebulaOrb"] = "rbxassetid://138352846733074",
	-- Godly
	["CopperOre"] = "rbxassetid://107641518021001",
	["IronOre"] = "rbxassetid://81516820258015",
	["GoldOre"] = "rbxassetid://95947332949628",
	["DiamondOre"] = "rbxassetid://108379849001044",
	-- Secret
	["ElectrifiedOrb"] = "rbxassetid://82983958164990",
	["TheVoid"] = "rbxassetid://72695475377452",
}

return ItemImagesConfig