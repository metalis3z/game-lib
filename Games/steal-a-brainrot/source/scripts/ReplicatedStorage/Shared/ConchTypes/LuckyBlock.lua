local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local Animals = require(ReplicatedStorage.Datas.Animals)

local LuckyBlockList = {}

for AnimalName, AnimalData in pairs(Animals) do
	if AnimalData.LuckyBlock ~= nil then
		table.insert(LuckyBlockList, AnimalName)
	end
end

table.sort(LuckyBlockList)

return Conch.register_type(
	"LuckyBlock",
	Conch.args.enum_new(LuckyBlockList)
)