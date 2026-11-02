-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Directory.Gears.Types.ToolConfigs)

local Gears = require(ReplicatedStorage.Directory.Gears)
local t = {}

for k, v in pairs(Gears.Directory) do
	if v.ToolController == "Gun" then
		table.insert(t, v._id)
	end
end

table.freeze(t)

return {
	GetAvailableGuns = function() --[[ GetAvailableGuns | Line: 28 | Upvalues: t (copy) ]]
		return table.clone(t)
	end
}