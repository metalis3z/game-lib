-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")

return function() --[[ Line: 5 | Upvalues: Players (copy) ]]
	local t = {}

	for k, v in pairs(Players:GetPlayers()) do
		if v.Character then
			table.insert(t, v.Character)
		end
	end

	return t
end