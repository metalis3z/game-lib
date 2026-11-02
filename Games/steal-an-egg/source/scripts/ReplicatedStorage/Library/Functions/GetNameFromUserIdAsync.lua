-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Modules = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Modules")
local v1 = require(Modules.SmartCache).new(15, 3600, 60, function(p1) --[[ Line: 6 | Upvalues: Players (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)

	if v1 then
		return true, v1.Name
	end

	local v2 = Players:GetNameFromUserIdAsync(p1)

	assert(type(v2) == "string")
	assert(if #v2 > 0 then if #v2 <= 20 then true else false else false)

	return true, v2
end)

return function(p1) --[[ Line: 18 | Upvalues: v1 (copy) ]]
	return v1.get(p1, nil, true) or v1.get(p1)
end