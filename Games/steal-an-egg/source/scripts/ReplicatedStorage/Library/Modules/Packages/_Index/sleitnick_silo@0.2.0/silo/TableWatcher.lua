-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Util = require(script.Parent.Util)
local t = {}

setmetatable(t, {
	__mode = "k"
})

local t2 = {
	__index = function(p1, p2) --[[ __index | Line: 21 | Upvalues: t (copy), Util (copy) ]]
		local v1 = t[p1]
		local v2 = v1.Changes[p2]

		if v2 == nil then
			return v1.Tbl[p2]
		end

		if v2 == Util.None then
			return nil
		end

		return v2
	end,
	__newindex = function(p1, p2, p3) --[[ __newindex | Line: 34 | Upvalues: t (copy), Util (copy) ]]
		local v1 = t[p1]

		if v1.Tbl[p2] == p3 then
			return
		end

		if p3 == nil then
			v1.Changes[p2] = Util.None
		else
			v1.Changes[p2] = p3
		end
	end,
	__call = function(p1) --[[ __call | Line: 46 | Upvalues: t (copy), Util (copy) ]]
		local v1 = t[p1]

		if next(v1.Changes) == nil then
			return v1.Tbl
		end

		return Util.Extend(v1.Tbl, v1.Changes)
	end
}

return function(p1) --[[ TableWatcher | Line: 54 | Upvalues: t2 (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	t[v2] = {
		Changes = {},
		Tbl = p1
	}

	return v2
end