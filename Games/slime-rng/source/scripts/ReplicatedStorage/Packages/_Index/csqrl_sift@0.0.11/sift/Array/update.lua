-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: update, time of decompilation: Sun May  3 10:10:08 2026 ]]
local ParentParent = script.Parent.Parent
local Util = require(ParentParent.Util)
local copy = require(script.Parent.copy)

return function(t1: {[any]: any}, n1: number, p1: ((...any) -> ...any)?, p2: ((...any) -> ...any)?) --[[ update ]] -- line: 44
	-- upvalues: copy (copy), Util (copy)
	local v10 = #t1
	local v11 = copy(t1)

	if n1 < 1 then
		n1 += v10
	end

	if type(p1) ~= "function" then
		p1 = Util.func.returned
	end

	if v11[n1] ~= nil then
		v11[n1] = p1(v11[n1], n1)

		return v11
	end

	v11[n1] = if type(p2) ~= "function" then nil else p2(n1)

	return v11
end
