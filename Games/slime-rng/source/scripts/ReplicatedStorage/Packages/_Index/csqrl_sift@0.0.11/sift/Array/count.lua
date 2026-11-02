-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: count, time of decompilation: Sun May  3 10:09:51 2026 ]]
local ParentParent = script.Parent.Parent
local Util = require(ParentParent.Util)

return function(t1: {[any]: any}, p1: ((...any) -> ...any)?) --[[ count ]] -- line: 25
	-- upvalues: Util (copy)
	local n1 = 0

	if type(p1) ~= "function" then
		p1 = Util.func.truthy
	end

	for i, v in ipairs(t1) do
		if p1(v, i, t1) then
			n1 += 1
		end
	end

	return n1
end
