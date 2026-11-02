-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Modules = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Modules")
local v1 = require(Modules.SmartCache).new(15, 3600, 60, function(p1) --[[ Line: 4 | Upvalues: Players (copy) ]]
	local v1 = Players:FindFirstChild(p1)

	if v1 and v1:IsA("Player") then
		return true, v1.UserId
	end

	local v2 = Players:GetUserIdFromNameAsync(p1)

	assert(typeof(v2) == "number")

	return true, v2
end)

return function(p1) --[[ Line: 14 | Upvalues: v1 (copy) ]]
	return v1.get(p1, nil, true) or v1.get(p1)
end