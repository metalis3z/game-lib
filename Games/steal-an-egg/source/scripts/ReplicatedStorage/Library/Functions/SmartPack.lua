-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(...) --[[ Line: 1 ]]
	local v1 = ...

	if not v1 then
		return {}
	end

	if type(v1) ~= "table" then
		return { ... }
	end

	if #v1 <= 0 and next(v1) then
		return { ... }
	end

	return v1
end