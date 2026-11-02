local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local ServerLuckData = require(ReplicatedStorage.Datas.ServerLuck)

local ServerLuckEnum = {}

for LuckName, LuckData in pairs(ServerLuckData) do
	ServerLuckEnum[tostring(LuckData.Multiplier)] = LuckName
end

return Conch.register_type(
	"ServerLuck",
	Conch.args.enum_map(ServerLuckEnum)
)