local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local FuseMachineData = require(ReplicatedStorage.Datas.FuseMachineData)

local LuckMultiplierMap = {}

for Index, Multiplier in pairs(FuseMachineData.LuckMultipliers) do
	LuckMultiplierMap[tostring(Multiplier)] = Multiplier
end

return Conch.register_type(
	"FuseMachineLuck",
	Conch.args.enum_map(LuckMultiplierMap)
)