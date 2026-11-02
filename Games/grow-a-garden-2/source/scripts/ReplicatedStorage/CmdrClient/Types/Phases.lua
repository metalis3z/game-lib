--credit to prince games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function makeFuzzyFinder(p1) --[[ makeFuzzyFinder | Line: 4 ]]
	return function(p1, p23) --[[ Line: 5 | Upvalues: p1 (copy) ]]
		local t2 = {}

		for v1, v2 in p1 do
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

return function(p1) --[[ Line: 20 | Upvalues: ReplicatedStorage (copy) ]]
	local t = {}

	for v1, v2 in require(ReplicatedStorage.SharedModules.TimeCycleData).Data do
		table.insert(t, v1)
	end

	local function f3(p1, p23) --[[ Line: 5 | Upvalues: t (copy) ]]
		local t2 = {}

		for v1, v2 in t do
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

	p1:RegisterType("phase", {
		Validate = function(p1) --[[ Validate | Line: 35 | Upvalues: f3 (copy), t (copy) ]]
			return f3(p1, true) ~= nil, string.format("%q is not a valid phase. Valid phase: %s", p1, table.concat(t, ", "))
		end,
		Autocomplete = function(p1) --[[ Autocomplete | Line: 39 | Upvalues: f3 (copy) ]]
			return f3(p1)
		end,
		Parse = function(p1) --[[ Parse | Line: 42 | Upvalues: f3 (copy) ]]
			return f3(p1, true)
		end
	})
end