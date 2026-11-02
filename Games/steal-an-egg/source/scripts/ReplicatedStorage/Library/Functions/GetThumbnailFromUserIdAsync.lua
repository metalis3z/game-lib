-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Modules = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Modules")
local v1 = require(Modules.SmartCache).new(15, 3600, 60, function(p1) --[[ Line: 9 | Upvalues: Players (copy) ]]
	local v1 = p1:split("-")
	local v3 = tonumber(v1[1])

	assert(v3, (("missing userid for key %*"):format(p1)))

	local v5 = Enum.ThumbnailType[v1[2]]

	assert(v5, (("missing thumbnail type for: %*"):format(p1)))

	local v7 = Enum.ThumbnailSize[v1[3]]

	assert(v7, (("missing thumbnail size for: %*"):format(p1)))

	local v9 = Players:GetUserThumbnailAsync(v3, v5, v7)

	assert(type(v9) == "string", (("thumbnail url is not a string for key %*"):format(p1)))
	assert(if #v9 > 0 then if #v9 <= 100 then true else false else false, (("thumbnail url length is invalid for key %*"):format(p1)))

	return true, v9
end)

return function(p1, p2, p3) --[[ Line: 25 | Upvalues: v1 (copy) ]]
	local v12 = p1 .. "-" .. p2.Name .. "-" .. p3.Name

	return v1.get(v12, nil, true) or v1.get(v12)
end