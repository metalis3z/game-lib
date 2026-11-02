local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)

require(ReplicatedStorage.Datas.Animals)

local Traits = require(ReplicatedStorage.Datas.Traits)

local TraitList = {}

for TraitName in pairs(Traits) do
	table.insert(TraitList, TraitName)
end

return Conch.register_type(
	"Trait",
	Conch.args.enum_new(TraitList)
)