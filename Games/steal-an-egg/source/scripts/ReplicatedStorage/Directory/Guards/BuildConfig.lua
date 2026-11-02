-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Directory.Rarity)

local Default = require(script.Parent.BaseConfigs.Default)

require(script.Parent.Types.Interface)

return function(p1) --[[ Line: 22 | Upvalues: Default (copy) ]]
	return setmetatable(p1, {
		__index = Default
	})
end