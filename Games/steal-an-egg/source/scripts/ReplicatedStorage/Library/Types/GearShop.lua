-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gears = require(ReplicatedStorage.Directory.Gears)

local function buildCatalog(p1) --[[ buildCatalog | Line: 25 ]]
	local t = {}

	for k, v in pairs(p1) do
		if v.DisplayInShop ~= false and v.EventShopType == nil then
			t[k] = true
		end
	end

	return table.freeze(t)
end

local function buildCatalogEntries(p1) --[[ buildCatalogEntries | Line: 36 ]]
	local t = {}

	for k, v in pairs(p1) do
		if v.DisplayInShop ~= false and v.EventShopType == nil then
			t[#t + 1] = table.freeze({
				Name = k,
				Cost = v.MoneyCost or 0,
				Config = v
			})
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 49 ]]
		if p1.Cost == p2.Cost then
			return p1.Name < p2.Name
		end

		return p1.Cost < p2.Cost
	end)

	return table.freeze(t)
end

return {
	Catalog = buildCatalog(Gears.Directory),
	CatalogEntries = buildCatalogEntries(Gears.Directory)
}