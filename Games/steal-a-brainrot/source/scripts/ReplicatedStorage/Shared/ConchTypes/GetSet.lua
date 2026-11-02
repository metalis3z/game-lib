local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)

require(ReplicatedStorage.Datas.Mutations)

local GetSetActionList = {
	"get",
	"set",
}

return ConchModule.register_type(
	"Get & Set",
	ConchModule.args.enum_new(GetSetActionList)
)