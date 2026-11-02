--credit to leon games studio
local t = { "BaseSpeed", "BaseJump", "ShovelPower", "MaxBackpack" }

local function makeFuzzyFinder(p1) --[[ makeFuzzyFinder | Line: 3 ]]
	return function(p1, p23) --[[ Line: 4 | Upvalues: p1 (copy) ]]
		local t2 = {}

		for v12, v2 in p1 do
			if v2:lower() == p1:lower() then
				if p23 then
					return v2
				end

				table.insert(t2, 1, v2)

				continue
			end

			if v2:lower():find(p1:lower(), 1, true) then
				table.insert(t2, v2)
			end
		end

		if p23 then
			return t2[1]
		end

		return t2
	end
end

return function(p1) --[[ Line: 19 | Upvalues: t (copy) ]]
	local v1 = t

	local function f2(p1, p23) --[[ Line: 4 | Upvalues: v1 (copy) ]]
		local t2 = {}

		for v12, v2 in v1 do
			if v2:lower() == p1:lower() then
				if p23 then
					return v2
				end

				table.insert(t2, 1, v2)

				continue
			end

			if v2:lower():find(p1:lower(), 1, true) then
				table.insert(t2, v2)
			end
		end

		if p23 then
			return t2[1]
		end

		return t2
	end

	p1:RegisterType("skillName", {
		Validate = function(p1) --[[ Validate | Line: 23 | Upvalues: f2 (copy), t (ref) ]]
			return f2(p1, true) ~= nil, string.format("%q is not a valid skill. Valid skills: %s", p1, table.concat(t, ", "))
		end,
		Autocomplete = function(p1) --[[ Autocomplete | Line: 27 | Upvalues: f2 (copy) ]]
			return f2(p1)
		end,
		Parse = function(p1) --[[ Parse | Line: 30 | Upvalues: f2 (copy) ]]
			return f2(p1, true)
		end
	})
end