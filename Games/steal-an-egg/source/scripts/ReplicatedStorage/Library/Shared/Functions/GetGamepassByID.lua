-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Directory = require(ReplicatedStorage.Directory.Gamepasses).Directory
local v1 = nil

return function(p1) --[[ GetGamepassByID | Line: 10 | Upvalues: v1 (ref), Directory (copy) ]]
	if not p1 then
		return nil
	end

	assert(type(p1) == "number", "GetGamepassByID: gamepassId must be a number")

	if not v1 then
		local t = {}

		for k, v in pairs(Directory) do
			if t[v.ProductId] then
				error(("Duplicate Product: %* / %*"):format(k, v.ProductId))
			end

			t[v.ProductId] = v
		end

		v1 = t
	end

	local v2 = v1[p1]

	if v2 then
		return v2, v2._id
	end

	return nil, nil
end