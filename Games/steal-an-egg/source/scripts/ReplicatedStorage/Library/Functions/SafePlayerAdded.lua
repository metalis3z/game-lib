-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")

return function(p1) --[[ safePlayerAdded | Line: 11 | Upvalues: Players (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		task.spawn(p1, v2)
	end

	return Players.PlayerAdded:Connect(p1)
end