local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)
local CupidBrainrotList = require(script.List)

return ConchModule.register_type(
	"Brainrot to Cupid",
	ConchModule.args.enum_new(CupidBrainrotList)
)