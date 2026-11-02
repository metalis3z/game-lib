--credit to leon games studio
local Util = require(script.Parent.Parent.Shared.Util)
local tbl = {
	Years = 31556926,
	Months = 2629744,
	Weeks = 604800,
	Days = 86400,
	Hours = 3600,
	Minutes = 60,
	Seconds = 1
}
local t = {}

for k, v in pairs(tbl) do
	table.insert(t, k)
end

local v1 = Util.MakeFuzzyFinder(t)

local function stringToSecondDuration(p1) --[[ stringToSecondDuration | Line: 19 | Upvalues: v1 (copy), tbl (copy) ]]
	if p1 == nil or p1 == "" then
		return nil
	end

	local v12 = tonumber(p1)

	if v12 and v12 == 0 then
		return 0, 0, true
	end

	local v2 = p1:gsub("-?%d+%a+", ""):match("-?%d+")

	if v2 then
		return nil, tonumber(v2), true
	end

	local sum = nil
	local v3 = nil

	for v5 in p1:gmatch("-?%d+%a+") do
		local v4
		local v6, v7 = v5:match("(-?%d+)(%a+)")
		local v8 = v1(v7)

		if #v8 == 0 then
			return nil, tonumber(v6)
		end

		if sum == nil then
			sum = 0
		end

		if v7:lower() == "m" then
			v3 = v6
			v4 = 60
		else
			v4 = tbl[v8[1]]
			v3 = v6
		end

		sum = sum + v4 * tonumber(v3)
	end

	if sum == nil then
		return nil
	end

	return sum, tonumber(v3)
end

local function mapUnits(p1, p2, p3, p4) --[[ mapUnits | Line: 58 ]]
	local v1 = p4 or 1
	local t = {}

	for k, v in pairs(p1) do
		if p3 == 1 then
			t[k] = p2 .. v:sub(v1, #v - 1)

			continue
		end

		t[k] = p2 .. v:sub(v1)
	end

	return t
end

local t2 = {
	Transform = function(p1) --[[ Transform | Line: 72 | Upvalues: stringToSecondDuration (copy) ]]
		return p1, stringToSecondDuration(p1)
	end,
	Validate = function(p1, p2) --[[ Validate | Line: 76 ]]
		return p2 ~= nil
	end,
	Autocomplete = function(p1, p2, p3, p4, p5) --[[ Autocomplete | Line: 80 | Upvalues: v1 (copy), mapUnits (copy) ]]
		local t = {}

		if p4 or p5 then
			local v12 = p4 == true and v1("") or p5

			if p4 == true then
				return mapUnits(v12, p1, p3)
			end

			return mapUnits(v12, p1, p1:match("^.*(%a+)$"):len() + 1)
		end

		if p2 ~= nil then
			local v2 = p1:match("^.*-?%d+(%a+)%s?$")
			local v3 = mapUnits(v1(v2), p1, p3, #v2 + 1)

			table.sort(v3)
			t = v3
		end

		return t
	end,
	Parse = function(p1, p2) --[[ Parse | Line: 104 ]]
		return p2
	end
}

return function(p1) --[[ Line: 109 | Upvalues: t2 (copy), Util (copy) ]]
	p1:RegisterType("duration", t2)
	p1:RegisterType("durations", Util.MakeListableType(t2))
end