local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)
local TradeBrainrotList = require(script.List)

return ConchModule.register_type(
	"Brainrot to Trade",
	ConchModule.args.enum_new(TradeBrainrotList)
)