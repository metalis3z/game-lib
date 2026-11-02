-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Products = require(ReplicatedStorage.Directory.Products)

require(ReplicatedStorage.Directory.Products.Types.Interface)

local v1 = nil

return function(p1) --[[ GetProductByID | Line: 17 | Upvalues: v1 (ref), Products (copy) ]]
	if v1 == nil then
		local t = {}

		for k, v in pairs(Products.Directory) do
			if t[v.ProductId] then
				error(("Duplicate Product: %* / %*"):format(k, v.ProductId))
			end

			t[v.ProductId] = v
		end

		v1 = t
	end

	local v2 = assert(v1)[p1]

	if v2 then
		return v2, v2._id
	end

	return nil, nil
end