-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local v1 = nil

	if type(p1) == "number" then
		v1 = p1
	else
		local v2 = string.match(p1, "^rbxassetid://(%d+)$") or string.match(p1, "^http://www%.roblox%.com/asset/%?id=(%d+)$")

		if v2 then
			v1 = tonumber(v2)
		end
	end

	if v1 and (math.floor(v1) ~= v1 or (v1 == (1 / 0) or v1 == (-1 / 0))) then
		v1 = nil
	end

	return v1
end