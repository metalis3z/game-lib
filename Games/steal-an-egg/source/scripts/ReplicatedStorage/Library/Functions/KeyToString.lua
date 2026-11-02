-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local v1 = tostring(p1)

	if typeof(p1) == "string" then
		return "\"" .. v1 .. "\""
	end

	return v1
end