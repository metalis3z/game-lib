-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	k = "e3",
	m = "e6",
	b = "e9",
	t = "e12",
	q = "e15"
}

return function(p1) --[[ Line: 13 | Upvalues: t (copy) ]]
	if type(p1) == "string" then
		local v1 = p1:gsub("[,%s%c%z]", "")

		if #v1 > 0 then
			local v2 = t[v1:sub(#v1):lower()]

			p1 = if v2 then v1:sub(1, #v1 - 1) .. v2 else v1
		else
			p1 = v1
		end
	end

	return tonumber(p1)
end