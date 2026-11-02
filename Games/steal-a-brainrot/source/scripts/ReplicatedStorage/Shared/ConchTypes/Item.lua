local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)

require(ReplicatedStorage.Datas.Animals)
require(ReplicatedStorage.Datas.Items)

local ItemsFolder = ReplicatedStorage:WaitForChild("Items")

local ItemList = {}

for Index, Item in ipairs(ItemsFolder:GetChildren()) do
	table.insert(ItemList, Item.Name)
end

table.sort(ItemList)

return Conch.register_type(
	"Item",
	Conch.args.enum_new(ItemList)
)