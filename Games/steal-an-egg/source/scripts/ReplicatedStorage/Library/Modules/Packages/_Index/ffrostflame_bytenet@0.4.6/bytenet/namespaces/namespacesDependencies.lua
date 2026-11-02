-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = nil
local v2 = nil

return {
	start = function(p1) --[[ start | Line: 10 | Upvalues: v1 (ref), v2 (ref) ]]
		v1 = {}
		v2 = p1
	end,
	add = function(p1) --[[ add | Line: 15 | Upvalues: v1 (ref) ]]
		if v1 then
			table.insert(v1, p1)
		end
	end,
	currentLength = function() --[[ currentLength | Line: 23 | Upvalues: v1 (ref) ]]
		if v1 then
			return #v1
		end

		return 0
	end,
	currentName = function() --[[ currentName | Line: 27 | Upvalues: v2 (ref) ]]
		return v2
	end,
	empty = function() --[[ empty | Line: 31 | Upvalues: v1 (ref) ]]
		if v1 == nil then
			return {}
		end

		local v12 = v1

		v1 = nil

		return v12
	end
}