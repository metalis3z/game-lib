local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local Index = require(ReplicatedStorage.Datas.Index)

local BaseSkins = {}

for IndexName, MutationData in pairs(Index) do
	if MutationData.BaseColors then
		table.insert(BaseSkins, IndexName)
	end
end

return Conch.register_type(
	"Base Skin",
	Conch.args.enum_new(BaseSkins)
)