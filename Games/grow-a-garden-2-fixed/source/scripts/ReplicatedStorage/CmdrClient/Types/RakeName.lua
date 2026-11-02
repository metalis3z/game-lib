--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function makeFuzzyFinder(p1) --[[ makeFuzzyFinder | Line: 3 ]]
	return function(p1, p23) --[[ Line: 4 | Upvalues: p1 (copy) ]]
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

return function(p1) --[[ Line: 19 | Upvalues: ReplicatedStorage (copy) ]]
	local t = {}

	for v1, v2 in require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("RakeData")) do
		table.insert(t, v2.RakeName)
	end

	local function f3(p1, p23) --[[ Line: 4 | Upvalues: t (copy) ]]
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

	p1:RegisterType("rakeName", {
		Validate = function(p1) --[[ Validate | Line: 30 | Upvalues: f3 (copy), t (copy) ]]
			return f3(p1, true) ~= nil, string.format("%q is not a valid rake. Valid: %s", p1, table.concat(t, ", "))
		end,
		Autocomplete = function(p1) --[[ Autocomplete | Line: 34 | Upvalues: f3 (copy) ]]
			return f3(p1)
		end,
		Parse = function(p1) --[[ Parse | Line: 37 | Upvalues: f3 (copy) ]]
			return f3(p1, true)
		end
	})
end