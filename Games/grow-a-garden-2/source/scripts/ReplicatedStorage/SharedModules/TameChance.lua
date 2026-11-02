--credit to quartz games studio
local t = {}
local t2 = {
	Common = 2,
	Uncommon = 0.5,
	Rare = 0.2,
	Epic = 0.05,
	Legendary = 0.01,
	Mythic = 0.004,
	Super = 0.001,
	Secret = 0.0002
}

function t.GetMultiplier(p1) --[[ GetMultiplier | Line: 17 | Upvalues: t2 (copy) ]]
	return t2[p1] or 0
end
function t.GetMaxProgress() --[[ GetMaxProgress | Line: 21 ]]
	return 100
end
function t.ComputeProgress(p1, p2) --[[ ComputeProgress | Line: 29 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return 0
	end

	if type(p2) ~= "number" or p2 <= 0 then
		return 0
	end

	local v2 = p2 * v1

	if v2 < 0.25 then
		return 0.25
	end

	return v2
end

local function formatTrimmed(p1) --[[ formatTrimmed | Line: 40 ]]
	local v1 = math.floor(p1 * 100 + 0.5) / 100

	if v1 == math.floor(v1) then
		return string.format("%d", (math.floor(v1)))
	end

	return string.gsub(string.format("%.2f", v1), "0$", "")
end

function t.FormatPercent(p1) --[[ FormatPercent | Line: 52 | Upvalues: formatTrimmed (copy) ]]
	if type(p1) ~= "number" or p1 < 0 then
		p1 = 0
	end

	if p1 > 100 then
		p1 = 100
	end

	return formatTrimmed(p1) .. "% Tamed"
end
function t.FormatGain(p1) --[[ FormatGain | Line: 59 | Upvalues: formatTrimmed (copy) ]]
	if type(p1) == "number" and not (p1 <= 0) then
		return "+" .. formatTrimmed(p1) .. "% Tamed!"
	end

	return "+0% Tamed!"
end

return t