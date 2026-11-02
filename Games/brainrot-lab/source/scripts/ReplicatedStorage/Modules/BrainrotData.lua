--!strict
-- LOCATION: ReplicatedStorage/Modules/BrainrotData
-- Lista completa de brainrots do jogo com:
--   Rarity  -> raridade do brainrot
--   Income  -> quanto ele gera no slot por segundo ($/s)
--   Price   -> quanto custa para comprar na esteira (Income * 50)
--
-- Nota: PipiKiwi e TimCheese sao GRATUITOS na esteira (Price = 0).

local BrainrotData = {}

-- PRICE_MULTIPLIER espelha o valor usado em BrainrotConveyor (Income * 50)
local PRICE_MULTIPLIER = 50

-- Brainrots gratuitos na esteira
local FREE_BRAINROTS = {
	PipiKiwi = true,
	TimCheese = true,
}

local function conveyorPrice(income: number, name: string): number
	if FREE_BRAINROTS[name] then return 0 end
	return income * PRICE_MULTIPLIER
end

-- Dados completos: Rarity, Income ($/s no slot), Price (compra na esteira)
BrainrotData.Items = {
	-- Common
	{ Name = "TimCheese", Rarity = "Common", Income = 1, Price = 0 },
	{ Name = "GlorboFruttodrillo", Rarity = "Common", Income = 5, Price = 100 },

	-- Uncommon
	{ Name = "TrippiTroppi", Rarity = "Uncommon", Income = 10, Price = 200 },

	-- Rare
	{ Name = "PipiKiwi", Rarity = "Rare", Income = 25, Price = 500 },
	{ Name = "RhinoToasterino", Rarity = "Rare", Income = 30, Price = 600 },
	{ Name = "CupcakeKoala", Rarity = "Rare", Income = 40, Price = 800 },
	{ Name = "CactoHipopotamo", Rarity = "Rare", Income = 50, Price = 1000 },
	{ Name = "ChimpanziniBananini", Rarity = "Rare", Income = 65, Price = 1300 },
	{ Name = "FrigoCamelo", Rarity = "Rare", Income = 80, Price = 1600 },
	{ Name = "PandacciniBananini", Rarity = "Rare", Income = 95, Price = 1900 },
	{ Name = "PenguinoCocosino", Rarity = "Rare", Income = 110, Price = 2200 },
	{ Name = "SmurfCat", Rarity = "Rare", Income = 125, Price = 2500 },
	{ Name = "SvininaBombardino", Rarity = "Rare", Income = 140, Price = 2800 },
	{ Name = "TatatataSahur", Rarity = "Rare", Income = 150, Price = 3000 },
	{ Name = "BonecaAmbalabu", Rarity = "Rare", Income = 175, Price = 3500 },

	-- Epic
	{ Name = "BambiniCrostini", Rarity = "Epic", Income = 250, Price = 5000 },
	{ Name = "BananitoDelfinito", Rarity = "Epic", Income = 300, Price = 6000 },
	{ Name = "BrrBicusDicus", Rarity = "Epic", Income = 350, Price = 7000 },
	{ Name = "PipiPotato", Rarity = "Epic", Income = 400, Price = 8000 },
	{ Name = "BanditoBobrito", Rarity = "Epic", Income = 450, Price = 9000 },
	{ Name = "BrrBrrPatapim", Rarity = "Epic", Income = 500, Price = 10000 },
	{ Name = "BombombiniGusini", Rarity = "Epic", Income = 550, Price = 11000 },
	{ Name = "CappuccinoAssassino", Rarity = "Epic", Income = 600, Price = 12000 },
	{ Name = "CavalloVirtuoso", Rarity = "Epic", Income = 650, Price = 13000 },
	{ Name = "ChicleteiraBicicleteira", Rarity = "Epic", Income = 700, Price = 14000 },
	{ Name = "ChicleteirinaBicicleteirina", Rarity = "Epic", Income = 750, Price = 15000 },
	{ Name = "LiriliLarila", Rarity = "Epic", Income = 800, Price = 16000 },
	{ Name = "OrangutiniAnanassini", Rarity = "Epic", Income = 850, Price = 17000 },
	{ Name = "StrawberrelliFlamingelli", Rarity = "Epic", Income = 900, Price = 18000 },
	{ Name = "TralaleroTralala", Rarity = "Epic", Income = 950, Price = 19000 },
	{ Name = "TricTracBarabum", Rarity = "Epic", Income = 1000, Price = 20000 },
	{ Name = "AvocadiniGuffo", Rarity = "Epic", Income = 1200, Price = 24000 },

	-- Legendary
	{ Name = "TungTungSahur", Rarity = "Legendary", Income = 1500, Price = 30000 },
	{ Name = "BalerinaCapucina", Rarity = "Legendary", Income = 1800, Price = 36000 },
	{ Name = "BlueberrinniOctopusini", Rarity = "Legendary", Income = 2100, Price = 42000 },
	{ Name = "BurbaloniLoliloli", Rarity = "Legendary", Income = 2400, Price = 48000 },
	{ Name = "EsokSekolah", Rarity = "Legendary", Income = 2700, Price = 54000 },
	{ Name = "BombardiroCrocodilo", Rarity = "Legendary", Income = 3000, Price = 60000 },
	{ Name = "CarameliniBrasilini", Rarity = "Legendary", Income = 3500, Price = 70000 },
	{ Name = "ChefCrabracadabra", Rarity = "Legendary", Income = 4000, Price = 80000 },
	{ Name = "ElefantoCocofanto", Rarity = "Legendary", Income = 4500, Price = 90000 },
	{ Name = "ElefantoGeladerini", Rarity = "Legendary", Income = 5000, Price = 100000 },
	{ Name = "EspressoSignora", Rarity = "Legendary", Income = 5500, Price = 110000 },
	{ Name = "FluriFlura", Rarity = "Legendary", Income = 6000, Price = 120000 },
	{ Name = "GanganzelliTrulala", Rarity = "Legendary", Income = 6500, Price = 130000 },
	{ Name = "GangsterFootera", Rarity = "Legendary", Income = 7000, Price = 140000 },
	{ Name = "GirafaCelestre", Rarity = "Legendary", Income = 7500, Price = 150000 },
	{ Name = "NuclearoDinosauro", Rarity = "Legendary", Income = 8000, Price = 160000 },
	{ Name = "QuesadillaCrocodila", Rarity = "Legendary", Income = 8500, Price = 170000 },
	{ Name = "StrawberryElephant", Rarity = "Legendary", Income = 9000, Price = 180000 },
	{ Name = "TalpaDiFero", Rarity = "Legendary", Income = 10000, Price = 200000 },

	-- Mythical
	{ Name = "Matteo", Rarity = "Mythical", Income = 15000, Price = 300000 },
	{ Name = "GorilloWatermelondrillo", Rarity = "Mythical", Income = 25000, Price = 500000 },
	{ Name = "TigroligreFrutonni", Rarity = "Mythical", Income = 40000, Price = 800000 },

	-- Secret
	{ Name = "Meowl", Rarity = "Secret", Income = 75000, Price = 1500000 },
	{ Name = "Tralaledon", Rarity = "Secret", Income = 100000, Price = 2000000 },
	{ Name = "CapitanoClashWarnini", Rarity = "Secret", Income = 150000, Price = 3000000 },
	{ Name = "CapitanoMoby", Rarity = "Secret", Income = 200000, Price = 4000000 },
	{ Name = "CookieAndMilk", Rarity = "Secret", Income = 250000, Price = 5000000 },
	{ Name = "GaramaAndMadundung", Rarity = "Secret", Income = 300000, Price = 6000000 },
	{ Name = "GraipussiMedussi", Rarity = "Secret", Income = 350000, Price = 7000000 },
	{ Name = "LaVaccaSaturnoSaturnita", Rarity = "Secret", Income = 400000, Price = 8000000 },
	{ Name = "TorrtuginniDragonfrutini", Rarity = "Secret", Income = 500000, Price = 10000000 },

	-- Especial
	{ Name = "LuckyBlock", Rarity = "Especial", Income = 1000000, Price = 20000000 },
}

-- Retorna a lista completa (com Price ja definido)
function BrainrotData.GetAll(): {any}
	return BrainrotData.Items
end

-- Retorna os dados de um brainrot pelo nome
function BrainrotData.Get(name: string)
	for _, item in ipairs(BrainrotData.Items) do
		if item.Name == name then return item end
	end
	return nil
end

-- Imprime a lista completa no console (util para conferencia)
function BrainrotData.PrintAll()
	for _, item in ipairs(BrainrotData.Items) do
		print(string.format("[%s] %s | $%d/s | Esteira: $%d", item.Rarity, item.Name, item.Income, item.Price))
	end
end

return BrainrotData
