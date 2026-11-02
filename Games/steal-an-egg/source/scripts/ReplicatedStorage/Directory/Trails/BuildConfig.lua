-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Default = require(script.Parent.BaseConfigs.Default)

require(script.Parent.Parent.Rarity)
require(script.Parent.Types.Interface)

return function(p1) --[[ Line: 20 | Upvalues: Default (copy) ]]
	return setmetatable(p1, {
		__index = Default
	})
end