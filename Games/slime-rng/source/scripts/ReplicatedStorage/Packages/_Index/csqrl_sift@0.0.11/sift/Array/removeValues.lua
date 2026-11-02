-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: removeValues, time of decompilation: Sun May  3 10:10:04 2026 ]]
local toSet = require(script.Parent.toSet)

return function(t1: {[any]: any}, ...) --[[ removeValues ]] -- line: 20
	-- upvalues: toSet (copy)
	local v3 = toSet({ ... })
	local t2 = {}

	for _, v in ipairs(t1) do
		if not v3[v] then
			table.insert(t2, v)
		end
	end

	return t2
end
