-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: removeKeys, time of decompilation: Sun May  3 10:10:18 2026 ]]
local copy = require(script.Parent.copy)

return function(t1: {[any]: any}, ...) --[[ removeKeys ]] -- line: 20
	-- upvalues: copy (copy)
	local v3 = copy(t1)

	for _, v in ipairs({ ... }) do
		v3[v] = nil
	end

	return v3
end
