-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	local function formatDoubleZero(p1) --[[ formatDoubleZero | Line: 3 ]]
		local count = 0

		for v1 in p1:gmatch("(00:)") do
			count = count + 1
		end

		if count == 0 then
			return "00:" .. p1
		end

		if count == 1 then
			return p1
		end

		local v2, v3 = p1:match("^(00:)(.*)")

		assert(v2, v3)

		return v2 .. v3:gsub("(00:)", "")
	end

	local v1 = math.round(p1 / 60 / 60 / 24 - 0.5)
	local v2 = os.date("!%X", p1)

	if v1 and v1 > 0 then
		v2 = v1 .. ":" .. v2
	end

	if p1 >= 86400 then
		local v3 = game:GetService("Workspace"):GetServerTimeNow()
		local day = os.date("*t", v3 + p1).day

		return os.date("%B ", v3 + p1) .. day .. (if day % 10 == 1 and day ~= 11 then "st" elseif day % 10 == 2 and day ~= 12 then "nd" elseif day % 10 == 3 and day ~= 13 then "rd" else "th")
	end

	if p2 then
		return formatDoubleZero(v2)
	end

	return v2
end