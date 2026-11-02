--credit to quartz games studio
local t = {
	Big = 2,
	Huge = 4
}
local t2 = {
	Big = 2,
	Huge = 3
}
local t3 = {}

function t3.GetScale(p1, p2) --[[ GetScale | Line: 21 | Upvalues: t3 (copy), t (copy) ]]
	if type(p1) ~= "string" then
		return 1
	end

	local v1 = t3.Normalize(p1)

	if v1 == nil then
		return 1
	end

	if p2 ~= nil then
		local v2 = p2[v1]

		if type(v2) == "number" then
			return v2
		end
	end

	return t[v1] or 1
end
function t3.GetBoostMultiplier(p1) --[[ GetBoostMultiplier | Line: 34 | Upvalues: t3 (copy), t2 (copy) ]]
	local v1 = t3.Normalize(p1)

	if v1 then
		return t2[v1] or 1
	end

	return 1
end
function t3.Normalize(p1) --[[ Normalize | Line: 41 | Upvalues: t (copy) ]]
	if type(p1) ~= "string" then
		return nil
	end

	for v1 in t do
		if string.lower(p1) == string.lower(v1) then
			return v1
		end
	end

	return nil
end
function t3.DisplayName(p1, p2) --[[ DisplayName | Line: 51 | Upvalues: t3 (copy) ]]
	local v1 = t3.Normalize(p2)

	if v1 then
		return ("%* %*"):format(v1, p1)
	end

	return p1
end
t3.Scales = table.freeze(t)
t3.BoostMultipliers = table.freeze(t2)

return table.freeze(t3)