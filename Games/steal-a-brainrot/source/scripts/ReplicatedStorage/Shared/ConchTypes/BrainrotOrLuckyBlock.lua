local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)

local BrainrotOrLuckyBlock = {}

for AnimalName in AnimalsData do
	table.insert(BrainrotOrLuckyBlock, AnimalName)
end

return ConchModule.register_type(
	"Brainrot or Lucky Block",
	ConchModule.args.enum_new(BrainrotOrLuckyBlock)
)