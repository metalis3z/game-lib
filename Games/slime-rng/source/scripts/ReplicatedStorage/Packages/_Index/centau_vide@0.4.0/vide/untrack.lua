-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: untrack, time of decompilation: Sun May  3 10:09:46 2026 ]]
local get_scope = require("./graph").get_scope

return function(p1: ((...any) -> ...any)) --[[ untrack ]] -- line: 5
	-- upvalues: get_scope (copy)
	local v3 = get_scope()

	if v3 then
		local effect = v3.effect

		v3.effect = false

		local ok, result = xpcall(p1, debug.traceback)

		v3.effect = effect

		if not ok then
			error(result, 0)
		end

		return result
	end

	return p1()
end
