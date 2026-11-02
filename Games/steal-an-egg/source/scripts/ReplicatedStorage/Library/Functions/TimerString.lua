-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 1 ]]
	local v1 = os.date("!%X", p1)

	if p1 <= 3600 then
		v1 = v1:sub(4)
	end

	if p1 > 86400 then
		v1 = tostring((math.floor(p1 / 86400))) .. ":" .. v1
	end

	if p2 then
		v1 = v1 .. "." .. string.format("%.2f", p1):match("%d+$")
	end

	if p3 then
		v1 = v1:gsub("00:", "")
	end

	return v1
end