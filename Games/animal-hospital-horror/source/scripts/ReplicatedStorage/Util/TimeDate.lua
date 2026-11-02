local t = {}

function Format(p1) --[[ Format | Line: 3 ]]
	return string.format("%02i", p1)
end
function t.ToDHMS(p1) --[[ ToDHMS | Line: 8 ]]
	local v1 = (p1 - p1 % 60) / 60
	local v2 = (v1 - v1 % 60) / 60
	local v3 = (v2 - v2 % 24) / 24

	return Format(v3) .. ":" .. Format(v2 - v3 * 24) .. ":" .. Format(v1 - v2 * 60) .. ":" .. Format(p1 - v1 * 60)
end
function t.ToHMS(p1) --[[ ToHMS | Line: 20 ]]
	local v1 = (p1 - p1 % 60) / 60
	local v2 = (v1 - v1 % 60) / 60

	return Format(v2) .. ":" .. Format(v1 - v2 * 60) .. ":" .. Format(p1 - v1 * 60)
end

return t