--credit to quartz games studio
local ScrollingFrame = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GearShop"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GearShopData = require(ReplicatedStorage.SharedModules.GearShopData)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local RestockStoreController = require(ReplicatedStorage.ClientModules.RestockStoreController)

require(ReplicatedStorage.ClientModules.PlayerStateClient)

local GearShopFlags = require(ReplicatedStorage.SharedModules.Flags.GearShopFlags)
local t = {}
local v1 = Networking.GearShop.RequestEquippableState:Fire()
local v2

if v1 then
	local v3 = pairs

	for v5 in v3(v1.OwnedEquippableGears or {}) do
		t[v5] = true
	end

	v2 = v1.EquippedGear
else
	v2 = nil
end

local t2 = {}
local t3 = {
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	Epic = 4,
	Legendary = 5,
	Mythic = 6,
	Super = 7
}

for i, v in ipairs(GearShopData.Data) do
	if not v.RobuxOnly and (v.RestockChance or v.EquippableGear) then
		table.insert(t2, v)
	end
end

table.sort(t2, function(p1, p2) --[[ Line: 42 | Upvalues: t3 (copy) ]]
	local v1 = t3[p1.Rarity] or 0
	local v2 = t3[p2.Rarity] or 0

	if v1 == v2 then
		local v3 = p1.SortPriority or 0
		local v4 = p2.SortPriority or 0

		if v3 == v4 then
			if p1.EquippableGear and not p2.EquippableGear then
				return false
			end

			if p2.EquippableGear and not p1.EquippableGear then
				return true
			end

			if p1.EquippableGear and p2.EquippableGear then
				return p1.Cost < p2.Cost
			end

			return (p1.RestockChance or 0) > (p2.RestockChance or 0)
		end

		return v3 < v4
	end

	return v1 < v2
end)
RestockStoreController.Init({
	shopName = "GearShop",
	purchasedRestockKey = "Gears",
	devProductPrefix = "Gear",
	scrollingFrame = ScrollingFrame,
	stockItems = ReplicatedStorage.StockValues.GearShop.Items,
	purchaseEvent = Networking.GearShop.PurchaseGear,
	personalRestockEvent = Networking.GearShop.PersonalRestock,
	equipGearEvent = Networking.GearShop.EquipGear,
	unequipGearEvent = Networking.GearShop.UnequipGear,
	gearEquipStateEvent = Networking.GearShop.GearEquipState,
	items = t2,
	priceOverrides = GearShopFlags.PriceOverrides,
	getItemName = function(p1) --[[ getItemName | Line: 84 ]]
		return p1.ItemName
	end,
	getDisplayName = function(p1) --[[ getDisplayName | Line: 85 ]]
		if p1.ItemName == "Crowbar" then
			return "Door Crowbar"
		end

		return p1.ItemName
	end,
	getItemImage = function(p1) --[[ getItemImage | Line: 89 ]]
		return p1.IMG
	end,
	getItemCost = function(p1) --[[ getItemCost | Line: 90 ]]
		return p1.Cost or 0
	end,
	getItemRarity = function(p1) --[[ getItemRarity | Line: 91 ]]
		return p1.Rarity
	end,
	isEquippableGear = function(p1) --[[ isEquippableGear | Line: 92 ]]
		return p1.EquippableGear == true
	end,
	getRequiredGroupId = function(p1) --[[ getRequiredGroupId | Line: 93 ]]
		return p1.RequiresGroupId
	end,
	ownsEquippableGear = function(p1) --[[ ownsEquippableGear | Line: 94 | Upvalues: t (copy) ]]
		return t[p1] == true
	end,
	isGearEquipped = function(p1) --[[ isGearEquipped | Line: 97 | Upvalues: v2 (ref) ]]
		return v2 == p1
	end,
	onGearEquipStateChanged = function(p1, p2) --[[ onGearEquipStateChanged | Line: 100 | Upvalues: v2 (ref), t (copy) ]]
		if p2 then
			v2 = p1
			t[p1] = true

			return
		end

		if v2 ~= p1 then
			return
		end

		v2 = nil
	end
})