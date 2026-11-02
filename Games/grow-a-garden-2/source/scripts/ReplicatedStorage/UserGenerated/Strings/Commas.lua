--credit to prince games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrimmedNumberString = require(ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString)

return function(p1) --[[ Commas | Line: 35 | Upvalues: TrimmedNumberString (copy) ]]
	local v1 = if type(p1) == "string" then p1 else TrimmedNumberString(p1)
	local v3, v4, v5 = string.match(v1, "^(.-)([0-9,]+)(.*)$")

	if not v4 then
		return v1
	end

	local t = {}

	if v3 then
		table.insert(t, v3)
	end

	local v6 = string.gsub(v4, ",", "")
	local sum = 1
	local v7 = #v6 % 3
	local v8

	if v7 > 0 then
		table.insert(t, (string.sub(v6, sum, sum + v7 - 1)))
		v8, sum = v6, sum + v7
	else
		v8 = v6
	end

	while sum <= #v8 do
		if sum > 1 then
			table.insert(t, ",")
		end

		table.insert(t, (string.sub(v8, sum, sum + 2)))
		sum = sum + 3
	end

	if v5 then
		table.insert(t, v5)
	end

	return table.concat(t)
end