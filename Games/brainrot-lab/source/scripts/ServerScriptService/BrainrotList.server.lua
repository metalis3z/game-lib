--!strict
-- LOCATION: ServerScriptService/BrainrotList
-- LISTA DE BRAINROTS - BALANCEAMENTO FIEL AO STEAL A BRAINROT

local BRAINROTS = {
	-- Common ($1/s - $5/s)
	{ Nome = "TimCheese", Raridade = "Common", PorSegundo = 1, PrecoEsteira = 0 }, -- Grátis (Starter)
	{ Nome = "GlorboFruttodrillo", Raridade = "Common", PorSegundo = 5, PrecoEsteira = 100 },

	-- Uncommon ($10/s)
	{ Nome = "TrippiTroppi", Raridade = "Uncommon", PorSegundo = 10, PrecoEsteira = 200 },

	-- Rare ($25/s - $150/s)
	{ Nome = "PipiKiwi", Raridade = "Rare", PorSegundo = 25, PrecoEsteira = 500 }, 
	{ Nome = "RhinoToasterino", Raridade = "Rare", PorSegundo = 30, PrecoEsteira = 600 },
	{ Nome = "CupcakeKoala", Raridade = "Rare", PorSegundo = 40, PrecoEsteira = 800 },
	{ Nome = "CactoHipopotamo", Raridade = "Rare", PorSegundo = 50, PrecoEsteira = 1000 },
	{ Nome = "ChimpanziniBananini", Raridade = "Rare", PorSegundo = 65, PrecoEsteira = 1300 },
	{ Nome = "FrigoCamelo", Raridade = "Rare", PorSegundo = 80, PrecoEsteira = 1600 },
	{ Nome = "PandacciniBananini", Raridade = "Rare", PorSegundo = 95, PrecoEsteira = 1900 },
	{ Nome = "PenguinoCocosino", Raridade = "Rare", PorSegundo = 110, PrecoEsteira = 2200 },
	{ Nome = "SmurfCat", Raridade = "Rare", PorSegundo = 125, PrecoEsteira = 2500 },
	{ Nome = "SvininaBombardino", Raridade = "Rare", PorSegundo = 140, PrecoEsteira = 2800 },
	{ Nome = "TatatataSahur", Raridade = "Rare", PorSegundo = 150, PrecoEsteira = 3000 },
	{ Nome = "BonecaAmbalabu", Raridade = "Rare", PorSegundo = 175, PrecoEsteira = 3500 },

	-- Epic ($250/s - $1.000/s)
	{ Nome = "BambiniCrostini", Raridade = "Epic", PorSegundo = 250, PrecoEsteira = 5000 },
	{ Nome = "BananitoDelfinito", Raridade = "Epic", PorSegundo = 300, PrecoEsteira = 6000 },
	{ Nome = "BrrBicusDicus", Raridade = "Epic", PorSegundo = 350, PrecoEsteira = 7000 },
	{ Nome = "PipiPotato", Raridade = "Epic", PorSegundo = 400, PrecoEsteira = 8000 },
	{ Nome = "BanditoBobrito", Raridade = "Epic", PorSegundo = 450, PrecoEsteira = 9000 },
	{ Nome = "BrrBrrPatapim", Raridade = "Epic", PorSegundo = 500, PrecoEsteira = 10000 },
	{ Nome = "BombombiniGusini", Raridade = "Epic", PorSegundo = 550, PrecoEsteira = 11000 },
	{ Nome = "CappuccinoAssassino", Raridade = "Epic", PorSegundo = 600, PrecoEsteira = 12000 },
	{ Nome = "CavalloVirtuoso", Raridade = "Epic", PorSegundo = 650, PrecoEsteira = 13000 },
	{ Nome = "ChicleteiraBicicleteira", Raridade = "Epic", PorSegundo = 700, PrecoEsteira = 14000 },
	{ Nome = "ChicleteirinaBicicleteirina", Raridade = "Epic", PorSegundo = 750, PrecoEsteira = 15000 },
	{ Nome = "LiriliLarila", Raridade = "Epic", PorSegundo = 800, PrecoEsteira = 16000 },
	{ Nome = "OrangutiniAnanassini", Raridade = "Epic", PorSegundo = 850, PrecoEsteira = 17000 },
	{ Nome = "StrawberrelliFlamingelli", Raridade = "Epic", PorSegundo = 900, PrecoEsteira = 18000 },
	{ Nome = "TralaleroTralala", Raridade = "Epic", PorSegundo = 950, PrecoEsteira = 19000 },
	{ Nome = "TricTracBarabum", Raridade = "Epic", PorSegundo = 1000, PrecoEsteira = 20000 },
	{ Nome = "AvocadiniGuffo", Raridade = "Epic", PorSegundo = 1200, PrecoEsteira = 24000 },

	-- Legendary ($1.500/s - $7.500/s)
	{ Nome = "TungTungSahur", Raridade = "Legendary", PorSegundo = 1500, PrecoEsteira = 30000 },
	{ Nome = "BalerinaCapucina", Raridade = "Legendary", PorSegundo = 1800, PrecoEsteira = 36000 },
	{ Nome = "BlueberrinniOctopusini", Raridade = "Legendary", PorSegundo = 2100, PrecoEsteira = 42000 },
	{ Nome = "BurbaloniLoliloli", Raridade = "Legendary", PorSegundo = 2400, PrecoEsteira = 48000 },
	{ Nome = "EsokSekolah", Raridade = "Legendary", PorSegundo = 2700, PrecoEsteira = 54000 },
	{ Nome = "BombardiroCrocodilo", Raridade = "Legendary", PorSegundo = 3000, PrecoEsteira = 60000 },
	{ Nome = "CarameliniBrasilini", Raridade = "Legendary", PorSegundo = 3500, PrecoEsteira = 70000 },
	{ Nome = "ChefCrabracadabra", Raridade = "Legendary", PorSegundo = 4000, PrecoEsteira = 80000 },
	{ Nome = "ElefantoCocofanto", Raridade = "Legendary", PorSegundo = 4500, PrecoEsteira = 90000 },
	{ Nome = "ElefantoGeladerini", Raridade = "Legendary", PorSegundo = 5000, PrecoEsteira = 100000 },
	{ Nome = "EspressoSignora", Raridade = "Legendary", PorSegundo = 5500, PrecoEsteira = 110000 },
	{ Nome = "FluriFlura", Raridade = "Legendary", PorSegundo = 6000, PrecoEsteira = 120000 },
	{ Nome = "GanganzelliTrulala", Raridade = "Legendary", PorSegundo = 6500, PrecoEsteira = 130000 },
	{ Nome = "GangsterFootera", Raridade = "Legendary", PorSegundo = 7000, PrecoEsteira = 140000 },
	{ Nome = "GirafaCelestre", Raridade = "Legendary", PorSegundo = 7500, PrecoEsteira = 150000 },
	{ Nome = "NuclearoDinosauro", Raridade = "Legendary", PorSegundo = 8000, PrecoEsteira = 160000 },
	{ Nome = "QuesadillaCrocodila", Raridade = "Legendary", PorSegundo = 8500, PrecoEsteira = 170000 },
	{ Nome = "StrawberryElephant", Raridade = "Legendary", PorSegundo = 9000, PrecoEsteira = 180000 },
	{ Nome = "TalpaDiFero", Raridade = "Legendary", PorSegundo = 10000, PrecoEsteira = 200000 },

	-- Mythical ($15.000/s - $40.000/s)
	{ Nome = "Matteo", Raridade = "Mythical", PorSegundo = 15000, PrecoEsteira = 300000 },
	{ Nome = "GorilloWatermelondrillo", Raridade = "Mythical", PorSegundo = 25000, PrecoEsteira = 500000 },
	{ Nome = "TigroligreFrutonni", Raridade = "Mythical", PorSegundo = 40000, PrecoEsteira = 800000 },

	-- Secret ($75.000/s - $500.000/s)
	{ Nome = "Meowl", Raridade = "Secret", PorSegundo = 75000, PrecoEsteira = 1500000 },
	{ Nome = "Tralaledon", Raridade = "Secret", PorSegundo = 100000, PrecoEsteira = 2000000 },
	{ Nome = "CapitanoClashWarnini", Raridade = "Secret", PorSegundo = 150000, PrecoEsteira = 3000000 },
	{ Nome = "CapitanoMoby", Raridade = "Secret", PorSegundo = 200000, PrecoEsteira = 4000000 },
	{ Nome = "CookieAndMilk", Raridade = "Secret", PorSegundo = 250000, PrecoEsteira = 5000000 },
	{ Nome = "GaramaAndMadundung", Raridade = "Secret", PorSegundo = 300000, PrecoEsteira = 6000000 },
	{ Nome = "GraipussiMedussi", Raridade = "Secret", PorSegundo = 350000, PrecoEsteira = 7000000 },
	{ Nome = "LaVaccaSaturnoSaturnita", Raridade = "Secret", PorSegundo = 400000, PrecoEsteira = 8000000 },
	{ Nome = "TorrtuginniDragonfrutini", Raridade = "Secret", PorSegundo = 500000, PrecoEsteira = 10000000 },

	-- Especial ($1.000.000/s)
	{ Nome = "LuckyBlock", Raridade = "Especial", PorSegundo = 1000000, PrecoEsteira = 20000000 },
}

print("===== LISTA COMPLETA DE BRAINROTS (STEAL A BRAINROT STYLE) =====")
for _, b in ipairs(BRAINROTS) do
	local preco = b.PrecoEsteira
	local precoTexto = (preco == 0) and "GRATIS" or ("$" .. tostring(preco))
	print(string.format("[%s] %s | Renda: $%d/s | Preco para comprar: %s", b.Raridade, b.Nome, b.PorSegundo, precoTexto))
end
print("------------------------------------------------------------")
print(string.format("Total de brainrots: %d", #BRAINROTS))