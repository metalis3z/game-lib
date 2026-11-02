-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	new = function(p1) --[[ new | Line: 7 ]]
		local t = {}
		local t2 = {}

		t.__index = t2

		if p1 then
			for k, v in pairs(getmetatable(p1).__index) do
				t2[k] = v
			end
		end

		function t.__newindex(p1, p2, p3) --[[ __newindex | Line: 18 | Upvalues: t2 (copy) ]]
			local v1 = if t2[p2] == nil then true else false
			local format = string.format

			assert(v1, format("Cannot reassign %s in context", (tostring(p2))))
			t2[p2] = p3
		end

		return setmetatable({}, t)
	end
}