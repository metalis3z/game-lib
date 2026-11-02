-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local v1 = tostring(p1)
	local v2 = v1:sub(-1)
	local v3 = v1:sub(-2, -2)

	if v2 == "1" and v3 ~= "1" then
		return v1 .. "st"
	end

	if v2 == "2" and v3 ~= "1" then
		return v1 .. "nd"
	end

	if v2 == "3" and v3 ~= "1" then
		return v1 .. "rd"
	end

	return v1 .. "th"
end