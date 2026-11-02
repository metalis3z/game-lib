local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local Animals = require(ReplicatedStorage.Datas.Animals)

local BrainrotList = {}

for AnimalName, AnimalData in pairs(Animals) do
	if not AnimalData.LuckyBlock then
		table.insert(BrainrotList, AnimalName)
	end
end

return Conch.register_type(
	"Brainrot",
	Conch.args.enum_new(BrainrotList)
)