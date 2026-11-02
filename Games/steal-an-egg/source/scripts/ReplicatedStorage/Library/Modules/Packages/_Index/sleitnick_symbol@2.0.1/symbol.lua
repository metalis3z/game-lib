-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Symbol | Line: 45 ]]
	local v1 = newproxy(true)

	if not p1 then
		p1 = ""
	end

	getmetatable(v1).__tostring = function() --[[ Line: 50 | Upvalues: p1 (ref) ]]
		return "Symbol(" .. p1 .. ")"
	end

	return v1
end