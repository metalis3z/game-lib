-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: differenceSymmetric, time of decompilation: Sun May  3 10:09:53 2026 ]]
require(script.Parent.Parent.Types)

local toSet = require(script.Parent.toSet)
local toArray = require(script.Parent.Parent.Set.toArray)
local differenceSymmetric = require(script.Parent.Parent.Set.differenceSymmetric)

return function(p1, ...) --[[ differenceSymmetric ]] -- line: 25
	-- upvalues: toSet (copy), differenceSymmetric (copy), toArray (copy)
	local v5 = toSet(p1)
	local t1 = {}

	for _, v8 in { ... } do
		if typeof(v8) == "table" then
			table.insert(t1, toSet(v8))
		end
	end

	local v9 = differenceSymmetric(v5, unpack(t1))

	return toArray(v9)
end
