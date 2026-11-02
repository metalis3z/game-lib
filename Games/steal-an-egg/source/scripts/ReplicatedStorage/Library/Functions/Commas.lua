-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	assert(type(p1) == "number")

	if p1 ~= p1 then
		return "NaN"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	local v2

	if p1 < 0 then
		p1 = -p1
		v2 = "-"
	else
		v2 = ""
	end

	local v4 = tostring((math.round(p1)))
	local sum = 1
	local v5 = #v4 % 3
	local v6

	if v5 > 0 then
		v6 = v2 .. v4:sub(sum, sum + v5 - 1)
		sum = sum + v5
	else
		v6 = v2
	end

	while sum <= #v4 do
		if sum > 1 then
			v6 = v6 .. ","
		end

		v6 = v6 .. v4:sub(sum, sum + 2)
		sum = sum + 3
	end

	return v6
end