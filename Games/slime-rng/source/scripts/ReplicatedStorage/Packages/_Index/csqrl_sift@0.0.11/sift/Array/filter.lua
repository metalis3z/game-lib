-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: filter, time of decompilation: Sun May  3 10:09:55 2026 ]]
local ParentParent = script.Parent.Parent
local Util = require(ParentParent.Util)

return function(t1: {[any]: any}, p1: ((...any) -> ...any)?) --[[ filter ]] -- line: 26
	-- upvalues: Util (copy)
	local t2 = {}

	if type(p1) ~= "function" then
		p1 = Util.func.truthy
	end

	for i, v in ipairs(t1) do
		if p1(v, i, t1) then
			table.insert(t2, v)
		end
	end

	return t2
end
