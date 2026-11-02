-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: dedupe, time of decompilation: Sun May  3 10:09:52 2026 ]]
local fromArray = require(script.Parent.Parent.Set.fromArray)
local toArray = require(script.Parent.Parent.Set.toArray)

return function(t1: {[any]: any}) --[[ dedupe ]] -- line: 4
	-- upvalues: toArray (copy), fromArray (copy)
	return toArray(fromArray(t1))
end
