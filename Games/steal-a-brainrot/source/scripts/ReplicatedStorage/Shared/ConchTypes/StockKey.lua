local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Conch = require(ReplicatedStorage.Packages.Conch)
local MerchantData = require(ReplicatedStorage.Datas.MerchantData)

local StockKeys = {}

for Index, Brainrot in ipairs(MerchantData.Brainrots) do
	table.insert(StockKeys, Brainrot.StockKey)
end

return Conch.register_type(
	"Stock Key",
	Conch.args.enum_new(StockKeys)
)