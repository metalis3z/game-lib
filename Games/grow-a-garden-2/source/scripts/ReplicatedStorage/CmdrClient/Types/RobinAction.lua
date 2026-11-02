--credit to leon games studio
local t = { "perch", "eat", "circle", "dropseed" }

local function findAction(p1, p2) --[[ findAction | Line: 3 | Upvalues: t (copy) ]]
	local t2 = {}

	for v1, v2 in t do
		if v2:lower() == p1:lower() then
			if p2 then
				return v2
			end

			table.insert(t2, 1, v2)

			continue
		end

		if v2:lower():find(p1:lower(), 1, true) then
			table.insert(t2, v2)
		end
	end

	if p2 then
		return t2[1]
	end

	return t2
end

return function(p1) --[[ Line: 17 | Upvalues: findAction (copy), t (copy) ]]
	p1:RegisterType("robinAction", {
		Validate = function(p1) --[[ Validate | Line: 19 | Upvalues: findAction (ref), t (ref) ]]
			return findAction(p1, true) ~= nil, string.format("%q is not a valid action. Valid actions: %s", p1, table.concat(t, ", "))
		end,
		Autocomplete = function(p1) --[[ Autocomplete | Line: 23 | Upvalues: findAction (ref) ]]
			return findAction(p1)
		end,
		Parse = function(p1) --[[ Parse | Line: 26 | Upvalues: findAction (ref) ]]
			return findAction(p1, true)
		end
	})
end