-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: toSet, time of decompilation: Sun May  3 10:10:07 2026 ]]
local ParentParent = script.Parent.Parent

require(ParentParent.Types)

return function(t1: {[any]: any}) --[[ toSet ]] -- line: 20
	local t2 = {}

	for _, v in ipairs(t1) do
		t2[v] = true
	end

	return t2
end
