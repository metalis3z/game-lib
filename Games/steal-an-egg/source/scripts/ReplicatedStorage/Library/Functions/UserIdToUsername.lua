-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local t = {}

return function(p1) --[[ Line: 4 | Upvalues: t (copy), Players (copy) ]]
	local v1 = t[p1]

	if v1 then
		return v1
	end

	local v2 = Players:GetPlayerByUserId(p1)

	if v2 then
		local v3 = v2.Name

		t[p1] = v3

		return v3
	end

	local ok, result = pcall(function() --[[ Line: 17 | Upvalues: Players (ref), p1 (copy) ]]
		return Players:GetNameFromUserIdAsync(p1)
	end)

	if not ok then
		return "??"
	end

	if result then
		t[p1] = result

		return result
	end

	return "???"
end