-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserService = game:GetService("UserService")
local v1 = require(ReplicatedStorage.Library.Modules.SmartCache).new(15, 3600, 60, function(p1) --[[ Line: 12 | Upvalues: Players (copy), UserService (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)

	if v1 then
		return true, v1.DisplayName
	end

	local v2 = UserService:GetUserInfosByUserIdsAsync({ p1 })[1]

	assert(v2 ~= nil, (("Missing user info for user id %*"):format(p1)))

	local DisplayName = v2.DisplayName

	assert(type(DisplayName) == "string", (("Invalid display name payload for user id %*"):format(p1)))
	assert(#DisplayName > 0, (("Empty display name for user id %*"):format(p1)))

	return true, DisplayName
end)

return function(p1) --[[ Line: 31 | Upvalues: v1 (copy) ]]
	local v12 = v1.get(p1, nil, true) or v1.get(p1)
	local v2 = if type(v12) == "string" then true else false

	assert(v2, (("Cached display name must be a string for user id %*"):format(p1)))

	return v12
end