--!strict
-- LOCATION: ReplicatedStorage/Modules/ItemConfigurations

local ItemConfigurations = {}

ItemConfigurations.Items = {
	["Love"] = { Rarity = "Common", Income = 20, ImageId = "rbxassetid://79090027652300" },
	["Rubber Fruit"] = { Rarity = "Common", Income = 22, ImageId = "rbxassetid://131554490759014" },
	

	["Dough Fruit"] = { Rarity = "Uncommon", Income = 35, ImageId = "rbxassetid://126955368721375" },
	["spirit fruit"] = { Rarity = "Uncommon", Income = 40, ImageId = "rbxassetid://92237676577047" },
	

	["Yeti Fruit"] = { Rarity = "Rare", Income = 60, ImageId = "rbxassetid://109261438809226" },
	["Soul Fruit"] = { Rarity = "Rare", Income = 65, ImageId = "rbxassetid://125452082781010" },
	

	["Leopard Fruit"] = { Rarity = "Epic", Income = 105, ImageId = "rbxassetid://115274192379897" },
	["Gas Fruit"] = { Rarity = "Epic", Income = 115, ImageId = "rbxassetid://123207669322850" },
	["Kage"] = { Rarity = "Legendary", Income = 180, ImageId = "rbxassetid://103234531199510" },

	
	["Kitsune"] = { Rarity = "Legendary", Income = 180, ImageId = "rbxassetid://103234531199510" },
	["Goro"] = { Rarity = "Mythical", Income = 200, ImageId = "rbxassetid://103234531199510" },


	["Dragon Fruit"] = { Rarity = "Mythical", Income = 220, ImageId = "rbxassetid://112098475013592" },
	["Gura"] = { Rarity = "Mythical", Income = 250, ImageId = "rbxassetid://112098475013592" },
	
	
}

function ItemConfigurations.GetItemsByRarity(rarity: string): {string}
	local foundItems = {}
	for itemName, data in pairs(ItemConfigurations.Items) do
		if data.Rarity == rarity then
			table.insert(foundItems, itemName)
		end
	end
	return foundItems
end

function ItemConfigurations.GetItemData(itemName: string)
	return ItemConfigurations.Items[itemName]
end

return ItemConfigurations