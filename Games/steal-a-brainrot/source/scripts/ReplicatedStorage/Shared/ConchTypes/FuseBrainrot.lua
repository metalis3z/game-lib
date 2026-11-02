local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)
local FuseList = require(script.List)

return ConchModule.register_type(
	"Fuse Brainrot",
	ConchModule.args.enum_new(FuseList)
)