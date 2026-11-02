-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1, p2) --[[ Line: 8 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)
	Asserts.optional.string(p2)

	local v1 = p2 or "unknown"

	setmetatable(p1, {
		__index = function(p1, p2) --[[ __index | Line: 15 | Upvalues: v1 (copy) ]]
			error(("Attempted to index missing key \'%*\' in registry: (root: \'%*\')"):format(p2, v1), 2)
		end,
		__newindex = function(p1, p2) --[[ __newindex | Line: 18 | Upvalues: v1 (copy) ]]
			error(("Attempted to set new key \'%*\' in registry: (root: \'%*\')"):format(p2, v1), 2)
		end
	})

	return p1
end