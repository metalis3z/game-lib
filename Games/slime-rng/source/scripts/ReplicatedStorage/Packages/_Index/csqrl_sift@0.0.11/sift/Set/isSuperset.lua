-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: isSuperset, time of decompilation: Sun May  3 10:10:26 2026 ]]
local isSubset = require(script.Parent.isSubset)

return function(t1: {[any]: any}, t2: {[any]: any}) --[[ isSuperset ]] -- line: 21
	-- upvalues: isSubset (copy)
	return isSubset(t2, t1)
end
