-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local Products = require(ReplicatedStorage.Directory.Products)

return {
	GetProductId = function(p1) --[[ GetProductId | Line: 18 | Upvalues: AssetItem (copy), Assets (copy), Products (copy) ]]
		assert(AssetItem.AssetItemData(p1))

		local _id = Assets.Directory[p1.Category].Rarity._id

		for k, v in pairs(Products.Directory) do
			if v.StealRarity == _id then
				return v.ProductId
			end
		end

		return nil
	end
}