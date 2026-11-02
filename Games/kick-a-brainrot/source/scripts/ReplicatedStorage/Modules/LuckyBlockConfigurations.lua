--!strict
-- LOCATION: ReplicatedStorage/Modules/LuckyBlockConfigurations

local LuckyBlockConfigurations = {}

LuckyBlockConfigurations.Blocks = {
	["Yellow"] = {
		PowerRequirement = 0,
		Drops = {"Love"} -- Low Commons
	},
	["Starter"] = {
		PowerRequirement = 50,
		Drops = {"Rubber Fruit"} -- Mid Commons
	},
	["Strawberry"] = {
		PowerRequirement = 150,
		Drops = {"Dough Fruit"} -- High Commons
	},
	["Orangutani"] = {
		PowerRequirement = 400,
		Drops = {"spirit fruit"} -- Low Uncommons
	},
	["Hacky"] = {
		PowerRequirement = 1000,
		Drops = {"Yeti Fruit"} -- Mid Uncommons
	},
	["Hacker Lucky Block"] = {
		PowerRequirement = 2500,
		Drops = {"Soul Fruit"} -- High Uncommon / Low Rare
	},
	["Forbidden Lucky Block"] = {
		PowerRequirement = 5000,
		Drops = {"Leopard Fruit"} -- Mid Rares
	},
	["Food Lucky Block"] = {
		PowerRequirement = 10000,
		Drops = {"Gas Fruit"} -- High Rares
	},
	["Banned LuckyBlock"] = {
		PowerRequirement = 20000,
		Drops = {"Madung", "Kitsune"} -- Low Epics
	},
	["BANNED Lucky Block"] = {
		PowerRequirement = 35000,
		Drops = {"Dragon Fruit"} -- Mid Epics
	},
	["YOUTUBE Lucky Block"] = {
		PowerRequirement = 55000,
		Drops = {"Kage"} -- High Epic / Low Legendary
	},
	["Mr Beast Lucky Block"] = {
		PowerRequirement = 75000,
		Drops = {"Gura"} -- High Legendaries
	},
	["Cursed Lucky Block"] = {
		PowerRequirement = 100000, -- Capped at 100k!
		Drops = {"Goro"} -- Mythicals
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