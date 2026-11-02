-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
require(v1.Registries.MutationRegistry)
require(v1.Registries.RarityRegistry)
local v2 = {
	["PipiKiwi"] = {
		["Rarity"] = "Common",
		["CashPerSec"] = 1,
		["Weight"] = 100
	},
	["LiriliLarila"] = {
		["Rarity"] = "Common",
		["CashPerSec"] = 2,
		["Weight"] = 90
	},
	["NoobiniPizzanini"] = {
		["Rarity"] = "Common",
		["CashPerSec"] = 3,
		["Weight"] = 80
	},
	["TrippiTroppi"] = {
		["Rarity"] = "Common",
		["CashPerSec"] = 5,
		["Weight"] = 70
	},
	["TimCheese"] = {
		["Rarity"] = "Common",
		["CashPerSec"] = 10,
		["Weight"] = 60
	},
	["FluriFlura"] = {
		["Rarity"] = "Common",
		["CashPerSec"] = 25,
		["Weight"] = 50
	},
	["BonecaAmbalabu"] = {
		["Rarity"] = "Common",
		["CashPerSec"] = 50,
		["Weight"] = 40
	},
	["BambiniCrostini"] = {
		["Rarity"] = "Rare",
		["CashPerSec"] = 60,
		["Weight"] = 30
	},
	["TricTracBaraboom"] = {
		["Rarity"] = "Rare",
		["CashPerSec"] = 75,
		["Weight"] = 20
	},
	["TalpaDiFerro"] = {
		["Rarity"] = "Rare",
		["CashPerSec"] = 90,
		["Weight"] = 10
	},
	["BrrBrrPatapim"] = {
		["Rarity"] = "Rare",
		["CashPerSec"] = 100,
		["Weight"] = 100
	},
	["TrulimeroTrulichina"] = {
		["Rarity"] = "Rare",
		["CashPerSec"] = 150,
		["Weight"] = 90
	},
	["BananitaDolphinita"] = {
		["Rarity"] = "Rare",
		["CashPerSec"] = 250,
		["Weight"] = 80
	},
	["CactoHipopotamo"] = {
		["Rarity"] = "Rare",
		["CashPerSec"] = 350,
		["Weight"] = 70
	},
	["SvininoBombomdino"] = {
		["Rarity"] = "Epic",
		["CashPerSec"] = 450,
		["Weight"] = 60
	},
	["TaTaTaSahur"] = {
		["Rarity"] = "Epic",
		["CashPerSec"] = 500,
		["Weight"] = 45
	},
	["AvocadiniAntilopini"] = {
		["Rarity"] = "Epic",
		["CashPerSec"] = 600,
		["Weight"] = 30
	},
	["AvocadiniGuffo"] = {
		["Rarity"] = "Epic",
		["CashPerSec"] = 650,
		["Weight"] = 15
	},
	["BlueberriniOctopussini"] = {
		["Rarity"] = "Epic",
		["CashPerSec"] = 700,
		["Weight"] = 10
	},
	["ChimpanziniBananini"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 750,
		["Weight"] = 100
	},
	["SalaminoPinguino"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 850,
		["Weight"] = 90
	},
	["LionelCactuseli"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 900,
		["Weight"] = 80
	},
	["GangsterFootera"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 1000,
		["Weight"] = 70
	},
	["CappuccinoAssassino"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 1250,
		["Weight"] = 60
	},
	["FrigoCamelo"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 1500,
		["Weight"] = 45
	},
	["BombombiniGusini"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 2000,
		["Weight"] = 35
	},
	["BallerinaCappuccina"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 2500,
		["Weight"] = 25
	},
	["OrangutiniAnanasini"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 3000,
		["Weight"] = 20
	},
	["BombardiroCrocodilo"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 3500,
		["Weight"] = 15
	},
	["BrriBrriBicusDicusBombicus"] = {
		["Rarity"] = "Legendary",
		["CashPerSec"] = 4000,
		["Weight"] = 10
	},
	["BurbaloniLuliloli"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 9000,
		["Weight"] = 0,
		["Luck"] = 1,
		["HiddenUntilUpdate"] = true
	},
	["LosTalpitos"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 10000,
		["Weight"] = 60,
		["Luck"] = 1.5
	},
	["CocofantoElefanto"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 20000,
		["Weight"] = 50,
		["Luck"] = 2
	},
	["BisonteGiuppitere"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 30000,
		["Weight"] = 40,
		["Luck"] = 4
	},
	["Garama"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 40000,
		["Weight"] = 30,
		["Luck"] = 8
	},
	["DragonfrutinaDolphinita"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 45000,
		["Weight"] = 0,
		["Luck"] = 13,
		["HiddenUntilUpdate"] = true
	},
	["TralaleroTralala"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 50000,
		["Weight"] = 25,
		["Luck"] = 15
	},
	["WaterBottellini"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 60000,
		["Weight"] = 0
	},
	["UdinDinDinDun"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 75000,
		["Weight"] = 25,
		["Luck"] = 30
	},
	["Calculino"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 67000,
		["Weight"] = 0
	},
	["Alessio"] = {
		["Rarity"] = "Mythic",
		["CashPerSec"] = 90000,
		["Weight"] = 0,
		["Luck"] = 45,
		["HiddenUntilUpdate"] = true
	},
	["LaVaccaSaturnoSaturnita"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 100000,
		["Weight"] = 100,
		["Luck"] = 1
	},
	["TorrtuginniDragonfrutini"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 110000,
		["Weight"] = 0,
		["Luck"] = 1.5,
		["HiddenUntilUpdate"] = true
	},
	["LosTralaleritos"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 200000,
		["Weight"] = 90,
		["Luck"] = 2
	},
	["AgarriniLaPalini"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 350000,
		["Weight"] = 0,
		["Luck"] = 2.5,
		["HiddenUntilUpdate"] = true
	},
	["JobJobJobSahur"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 400000,
		["Weight"] = 80,
		["Luck"] = 3
	},
	["ToToToSahur"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 500000,
		["Weight"] = 70,
		["Luck"] = 5
	},
	["LasVaquitasSaturnitas"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 600000,
		["Weight"] = 60,
		["Luck"] = 8
	},
	["GorilloWatermelondrillo"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 650000,
		["Weight"] = 50,
		["Luck"] = 15
	},
	["Madundung"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 700000,
		["Weight"] = 40,
		["Luck"] = 30
	},
	["ElefantoFrigo"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 450000,
		["Weight"] = 0
	},
	["GuerriroDigitale"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 900000,
		["Weight"] = 0,
		["Luck"] = 45,
		["HiddenUntilUpdate"] = true
	},
	["StrawberriniJamini"] = {
		["Rarity"] = "Secret",
		["CashPerSec"] = 1000000,
		["Weight"] = 0
	},
	["CastlinoFortini"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 3200000,
		["Weight"] = 0,
		["Luck"] = 1,
		["HiddenUntilUpdate"] = true
	},
	["CompactaroniDiskaloni"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 4000000,
		["Weight"] = 70,
		["Luck"] = 1.5
	},
	["SwagSoda"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 4500000,
		["Weight"] = 0
	},
	["ChillinChilli"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 5000000,
		["Weight"] = 35,
		["Luck"] = 2
	},
	["StoppoLuminino"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 5500000,
		["Weight"] = 0,
		["Luck"] = 2.5,
		["HiddenUntilUpdate"] = true
	},
	["CrazylonePizaione"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 6000000,
		["Weight"] = 10,
		["Luck"] = 3
	},
	["TicTacSahur"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 7000000,
		["Weight"] = 6,
		["Luck"] = 4
	},
	["67"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 8500000,
		["Weight"] = 4,
		["Luck"] = 8
	},
	["NuclearoDinossauro"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 8800000,
		["Weight"] = 0,
		["Luck"] = 10,
		["HiddenUntilUpdate"] = true
	},
	["StrawberryElephant"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 12000000,
		["Weight"] = 0.25,
		["Luck"] = 12
	},
	["LosStrawberryElephantitos"] = {
		["Rarity"] = "Celestial",
		["CashPerSec"] = 15000000,
		["Weight"] = 0.125,
		["Luck"] = 20
	},
	["Caylusaurus"] = {
		["Rarity"] = "Godly",
		["CashPerSec"] = 30000000,
		["Weight"] = 0.425,
		["Luck"] = 1
	},
	["SteakMeatallini"] = {
		["Rarity"] = "Godly",
		["CashPerSec"] = 30000000,
		["Weight"] = 0.425,
		["Luck"] = 1
	},
	["DragonCannelloni"] = {
		["Rarity"] = "Godly",
		["CashPerSec"] = 50000000,
		["Weight"] = 0.15,
		["Luck"] = 2
	},
	["LosPlanetitos"] = {
		["Rarity"] = "Secret",
		["Weight"] = 75,
		["CashPerSec"] = 450000,
		["Luck"] = 1,
		["HiddenUntilUpdate"] = true
	},
	["IlPlutoElefanto"] = {
		["Rarity"] = "Mythic",
		["Weight"] = 15,
		["CashPerSec"] = 65000,
		["Luck"] = 1,
		["HiddenUntilUpdate"] = true
	},
	["GiraffaCelestre"] = {
		["Rarity"] = "Legendary",
		["Weight"] = 9,
		["CashPerSec"] = 4750,
		["Luck"] = 1,
		["HiddenUntilUpdate"] = true
	},
	["SpazioPolare"] = {
		["Rarity"] = "Celestial",
		["Weight"] = 10,
		["CashPerSec"] = 5500000,
		["Luck"] = 1,
		["HiddenUntilUpdate"] = true
	},
	["LunaSpaventosa"] = {
		["Rarity"] = "Celestial",
		["Weight"] = 0.275,
		["CashPerSec"] = 9000000,
		["Luck"] = 1,
		["HiddenUntilUpdate"] = true
	},
	["NooMyValentine"] = {
		["Rarity"] = "Celestial",
		["Weight"] = 0,
		["CashPerSec"] = 4800000,
		["Luck"] = 1
	},
	["LaLaLavaLaLaChicken"] = {
		["Rarity"] = "Secret",
		["Weight"] = 0,
		["CashPerSec"] = 475000,
		["Luck"] = 1
	},
	["ElefanteLavante"] = {
		["Rarity"] = "Godly",
		["Weight"] = 0,
		["CashPerSec"] = 20000000,
		["Luck"] = 1
	},
	["LavaleroLavala"] = {
		["Rarity"] = "Celestial",
		["Weight"] = 0,
		["CashPerSec"] = 4300000,
		["Luck"] = 1
	},
	["PazzoVulcano"] = {
		["Rarity"] = "Secret",
		["Weight"] = 0,
		["CashPerSec"] = 720000,
		["Luck"] = 1
	},
	["PBandJ"] = {
		["DisplayName"] = "PB & J",
		["Rarity"] = "Celestial",
		["Weight"] = 0,
		["CashPerSec"] = 10000000,
		["Luck"] = 1
	},
	["DragoniPizzaroni"] = {
		["Rarity"] = "Godly",
		["Weight"] = 0,
		["CashPerSec"] = 25000000,
		["Luck"] = 1
	},
	["FireFireFireSahur"] = {
		["Rarity"] = "Legendary",
		["Weight"] = 0,
		["CashPerSec"] = 3500,
		["Luck"] = 1
	},
	["CornCornCornSahur"] = {
		["Rarity"] = "Secret",
		["Weight"] = 0,
		["CashPerSec"] = 260000,
		["Luck"] = 1
	},
	["BlackholeGoat"] = {
		["Rarity"] = "Mythic",
		["Weight"] = 0,
		["CashPerSec"] = 55000,
		["Luck"] = 1
	},
	["SpaghettiToiletti"] = {
		["Rarity"] = "Celestial",
		["Weight"] = 0,
		["CashPerSec"] = 6200000,
		["Luck"] = 1
	},
	["Bangello"] = {
		["Rarity"] = "Rare",
		["Weight"] = 0,
		["CashPerSec"] = 275,
		["Luck"] = 1
	},
	["PolloDrumini"] = {
		["Rarity"] = "Secret",
		["Weight"] = 0,
		["CashPerSec"] = 780000,
		["Luck"] = 1
	},
	["ElefanteCroissante"] = {
		["Rarity"] = "Godly",
		["Weight"] = 0,
		["CashPerSec"] = 35000000,
		["Luck"] = 1
	},
	["ChillinPickle"] = {
		["Rarity"] = "Celestial",
		["Weight"] = 0,
		["CashPerSec"] = 4700000,
		["Luck"] = 1
	},
	["YessMyHotspot"] = {
		["Rarity"] = "Celestial",
		["Weight"] = 0,
		["CashPerSec"] = 3800000,
		["Luck"] = 1
	},
	["SodiniMachini"] = {
		["Rarity"] = "Celestial",
		["Weight"] = 0,
		["CashPerSec"] = 8600000,
		["Luck"] = 1
	},
	["MangocelloParatello"] = {
		["Rarity"] = "Epic",
		["Weight"] = 0,
		["CashPerSec"] = 650,
		["Luck"] = 1
	},
	["CameroDocumentazione"] = {
		["Rarity"] = "Rare",
		["Weight"] = 0,
		["CashPerSec"] = 125,
		["Luck"] = 1
	},
	["SodiniBaffini"] = {
		["Rarity"] = "Common",
		["Weight"] = 0,
		["CashPerSec"] = 15,
		["Luck"] = 1
	},
	["QuestiniExclamini"] = {
		["Rarity"] = "Secret",
		["Weight"] = 0,
		["CashPerSec"] = 380000,
		["Luck"] = 1
	},
	["PoppinPizza"] = {
		["Rarity"] = "Secret",
		["Weight"] = 0,
		["CashPerSec"] = 1200000,
		["Luck"] = 1
	}
}
return v2
