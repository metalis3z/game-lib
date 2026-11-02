local module = {}
local WheelRemotes = game.ReplicatedStorage.WheelRemotes

WheelRemotes.GiveCurrency.OnServerEvent:Connect(function(Player,Amount,Currency)
	print(Amount)
	print(Currency)
	if Currency == "Coins" then
		Module.Give(Player,"Coins",tonumber(Amount));
	else
		Module.Give(Player,"Gems",tonumber(Amount));
	end
end)

WheelRemotes.GiveItem.OnServerEvent:Connect(function(Player,Item)
	print(Item)
	Module.GiveItem(Player, Item, 1, "Weapons")
	game.ReplicatedStorage.ItemGift:FireClient(Player, Item, "Weapons")
	Module.SaveData(Player)
end)
WheelRemotes.GiveRandom.OnServerEvent:Connect(function(Player,Type)

	local GodlyTable = {

		"Fang",
		"Heat",
		"PurpleSeer",
		"TheSeer",
		"RedSeer",
		"TheSeer",
		"Luger",


	}

	local ChromaTable = {

		"ChromaFang",
		"ChromaHeat",
		"ChromaSeer",
		"ChromaSaw",
		"ChromaShark",
		"ChromaGemstone",

	}

	local ChristmasTable = {
		"Jinglegun";
		"WinterEdge";
		"Iceflake";
		"Cookieblade";
		"Icefang";
		"Iceblade";
		"Starcane";
		"Jollycannon";
	}

	if Type == "RandomGodly" then

		local rng = math.random(1,#GodlyTable)
		local prize = GodlyTable[rng]

		Module.GiveItem(Player, prize, 1, "Weapons")
		game.ReplicatedStorage.ItemGift:FireClient(Player, prize, "Weapons")

	elseif Type == "RandomChroma" then

		local rng = math.random(1,#ChromaTable)
		local prize = ChromaTable[rng]

		Module.GiveItem(Player, prize, 1, "Weapons")
		game.ReplicatedStorage.ItemGift:FireClient(Player, prize, "Weapons")

	elseif Type == "RandomCGodly" then

		local rng = math.random(1,#ChristmasTable)
		local prize = ChristmasTable[rng]

		Module.GiveItem(Player, prize, 1, "Weapons")
		game.ReplicatedStorage.ItemGift:FireClient(Player, prize, "Weapons")
	end
end)
return module
