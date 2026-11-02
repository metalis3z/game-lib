-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: removeValues, time of decompilation: Sun May  3 10:10:19 2026 ]]
local ParentParent = script.Parent.Parent
local toSet = require(ParentParent.Array.toSet)

return function(t1: {[any]: any}, ...) --[[ removeValues ]] -- line: 23
	-- upvalues: toSet (copy)
	local v4 = toSet({ ... })
	local t2 = {}

	for k, v in pairs(t1) do
		if not v4[v] then
			t2[k] = v
		end
	end

	return t2
end
