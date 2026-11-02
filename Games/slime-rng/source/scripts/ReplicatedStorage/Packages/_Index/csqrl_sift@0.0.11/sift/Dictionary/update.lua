-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: update, time of decompilation: Sun May  3 10:10:20 2026 ]]
local copy = require(script.Parent.copy)

return function(t1: {[any]: any}, p1, p2: ((...any) -> ...any)?, p3: ((...any) -> ...any)?) --[[ update ]] -- line: 30
	-- upvalues: copy (copy)
	local v6 = copy(t1)

	if v6[p1] then
		if p2 then
			v6[p1] = p2(v6[p1], p1)

			return v6
		end
	elseif typeof(p3) == "function" then
		v6[p1] = p3(p1)
	end

	return v6
end
