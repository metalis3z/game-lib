-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GetPriceValueForItem = require(script.Parent.GetPriceValueForItem)
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1) --[[ Line: 11 | Upvalues: Asserts (copy), GetPriceValueForItem (copy) ]]
	Asserts.Tool(p1)

	local v1 = p1:GetAttribute("Category")
	local v2 = p1:GetAttribute("Mutations")
	local v3 = p1:GetAttribute("Scale")
	local v4 = p1:GetAttribute("IsFavorite")

	if v1 == nil or (v2 == nil or v3 == nil) then
		return 0
	end

	local t = {}

	for v5 in string.gmatch(v2, "[^,]+") do
		table.insert(t, (string.gsub(v5, "^%s*(.-)%s*$", "%1")))
	end

	local t2 = {
		Category = v1,
		Mutations = t,
		Scale = v3
	}

	t2.IsFavorite = v4 == true

	return GetPriceValueForItem(t2)
end