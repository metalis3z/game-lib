local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local Updates = require(ReplicatedStorage.Shared.Updates)

local UpdateFlags = {}

for Index, UpdateData in pairs(Updates.List) do
	if UpdateData.FFlag then
		table.insert(UpdateFlags, UpdateData.FFlag)
	end
end

table.sort(UpdateFlags)

return Conch.register_type(
	"Update",
	Conch.args.enum_new(UpdateFlags)
)