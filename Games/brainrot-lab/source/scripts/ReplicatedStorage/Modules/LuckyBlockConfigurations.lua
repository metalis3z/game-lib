--!strict
-- LOCATION: ReplicatedStorage/Modules/LuckyBlockConfigurations

local LuckyBlockConfigurations = {}

LuckyBlockConfigurations.Blocks = {
	["YellowLuckyBlock"] = {
		PowerRequirement = 0,
		Drops = {"RhinoToasterino", "TungTungSahur"} -- Low Commons
	},
	["GreenBulkyLuckyBlock"] = {
		PowerRequirement = 50,
		Drops = {"BambiniCrostini", "BananitoDelfinito"} -- Mid Commons
	},
	["ShieldLuckyBlock"] = {
		PowerRequirement = 150,
		Drops = {"Tralaledon", "PipiKiwi"} -- High Commons
	},
	["Blue67LuckyBlock"] = {
		PowerRequirement = 400,
		Drops = {"BalerinaCapucina", "BanditoBobrito"} -- Low Uncommons
	},
	["LuckyBlockPlanetYellow"] = {
		PowerRequirement = 1000,
		Drops = {"BrrBrrPatapim", "BurbaloniLoliloli"} -- Mid Uncommons
	},
	["PurpleAngelLuckyBlock"] = {
		PowerRequirement = 2500,
		Drops = {"CapitanoMoby", "CookieAndMilk"} -- High Uncommon / Low Rare
	},
	["UFOLuckyBlock"] = {
		PowerRequirement = 5000,
		Drops = {"BombardiroCrocodilo", "BombombiniGusini"} -- Mid Rares
	},
	["PurpleDragonLuckyBlock"] = {
		PowerRequirement = 10000,
		Drops = {"CactoHipopotamo", "CarameliniBrasilini"} -- High Rares
	},
	["HeavenLuckyBlock"] = {
		PowerRequirement = 20000,
		Drops = {"EspressoSignora", "FluriFlura"} -- Low Epics
	},
	["KingLuckyBlock"] = {
		PowerRequirement = 35000,
		Drops = {"GangsterFootera", "GirafaCelestre"} -- Mid Epics
	},
	["DarkLuckyBlock"] = {
		PowerRequirement = 55000,
		Drops = {"GorilloWatermelondrillo", "LaVaccaSaturnoSaturnita"} -- High Epic / Low Legendary
	},
	["DemonLuckyBlock"] = {
		PowerRequirement = 75000,
		Drops = {"NuclearoDinosauro", "PandacciniBananini", "QuesadillaCrocodila"} -- High Legendaries
	},
	["BulkyHeavenLuckyBlock"] = {
		PowerRequirement = 100000, -- Capped at 100k!
		Drops = {"SmurfCat", "StrawberryElephant", "TralaleroTralala"} -- Mythicals
	},
}

function LuckyBlockConfigurations.GetBlockByPower(power: number)
	local bestBlock = nil
	local highestReq = -1

	for blockName, data in pairs(LuckyBlockConfigurations.Blocks) do
		if power >= data.PowerRequirement and data.PowerRequirement > highestReq then
			highestReq = data.PowerRequirement
			bestBlock = blockName
		end
	end

	if not bestBlock then
		for name, _ in pairs(LuckyBlockConfigurations.Blocks) do return name end
	end

	return bestBlock
end

function LuckyBlockConfigurations.GetRandomDrop(blockName: string)
	local blockData = LuckyBlockConfigurations.Blocks[blockName]
	if not blockData or not blockData.Drops or #blockData.Drops == 0 then return nil end

	return blockData.Drops[math.random(1, #blockData.Drops)]
end

return LuckyBlockConfigurations