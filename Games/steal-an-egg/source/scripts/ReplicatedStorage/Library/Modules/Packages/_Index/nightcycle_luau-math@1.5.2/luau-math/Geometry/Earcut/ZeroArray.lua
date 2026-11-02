-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	new = function(p1) --[[ new | Line: 3 ]]
		local v1 = newproxy(true)
		local v2 = getmetatable(v1)

		v2.Array = if p1 then p1 else {}
		function v2.__index(p1, p2) --[[ __index | Line: 9 | Upvalues: v2 (copy) ]]
			return v2.Array[p2 + 1]
		end
		function v2.__newindex(p1, p2, p3) --[[ __newindex | Line: 13 | Upvalues: v2 (copy) ]]
			v2.Array[p2 + 1] = p3
		end
		function v2.__len() --[[ __len | Line: 17 | Upvalues: v2 (copy) ]]
			return #v2.Array
		end

		return v1
	end,
	getOneIndex = function(p1) --[[ getOneIndex | Line: 24 ]]
		return getmetatable(p1).Array
	end,
	push = function(p1, p2) --[[ push | Line: 29 ]]
		p1[#p1] = p2
	end
}

function t.sort(p1, p2) --[[ sort | Line: 33 | Upvalues: t (copy) ]]
	table.sort(t.getOneIndex(p1), p2)
end
function t.pop(p1) --[[ pop | Line: 37 ]]
	local v1 = #p1 - 1
	local v2 = p1[v1]

	p1[v1] = nil

	return v2
end

return t