local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)

require(ReplicatedStorage.Datas.Mutations)

local ManageOptionsActionList = {
	"add",
	"remove",
	"list",
}

return ConchModule.register_type(
	"Manage options",
	ConchModule.args.enum_new(ManageOptionsActionList)
)