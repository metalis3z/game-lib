local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local Mutations = require(ReplicatedStorage.Datas.Mutations)

local MutationList = {
	"Normal"
}

for MutationName in pairs(Mutations) do
	table.insert(MutationList, MutationName)
end

return Conch.register_type(
	"Mutation",
	Conch.args.enum_new(MutationList)
)