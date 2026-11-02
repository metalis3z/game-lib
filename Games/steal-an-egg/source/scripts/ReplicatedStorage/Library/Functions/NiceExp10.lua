-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
function NiceExp10(p1, p2) --[[ NiceExp10 | Line: 1 ]]
	if p2 == 0 then
		return p1
	end

	local v2 = tonumber((("%*e%*"):format(string.format("%f", p1), p2)))

	if v2 then
		return v2
	end

	local v3 = tostring(p1)
	local v4 = tostring(p2)

	error("x:" .. v3 .. " y:" .. v4 .. " fmt(x):" .. string.format("%f", p1))
end

return NiceExp10