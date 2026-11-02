--credit to quartz games studio
local GearImages = script.Parent.GearImages

local function getGearImage(p1) --[[ getGearImage | Line: 3 | Upvalues: GearImages (copy) ]]
	local v1 = GearImages:FindFirstChild(p1)

	return if v1 then v1.Value or "" else ""
end

local t = {}
local t2 = {}
local t3 = {
	ItemName = "Common Watering Can",
	ItemType = "Watering Can",
	RestockChance = 90,
	Cost = 2000,
	Rarity = "Common",
	RestockValues = NumberRange.new(2, 5)
}
local v1 = GearImages:FindFirstChild("Common Watering Can")

t3.IMG = if v1 then v1.Value or "" else ""

local t4 = {
	ItemName = "Common Sprinkler",
	ItemType = "Common Sprinkler",
	RestockChance = 50,
	Cost = 3000,
	Rarity = "Common",
	RestockValues = NumberRange.new(1, 2)
}
local v3 = GearImages:FindFirstChild("Common Sprinkler")

t4.IMG = v3 and v3.Value or ""

local t5 = {
	ItemName = "Sign",
	ItemType = "Sign",
	Cost = 4000,
	PriceInRobux = 49,
	EquippableGear = true,
	Rarity = "Common"
}
local Sign = GearImages:FindFirstChild("Sign")

t5.IMG = Sign and Sign.Value or ""

local t6 = {
	ItemName = "Lantern",
	ItemType = "Lantern",
	Cost = 12000,
	PriceInRobux = 99,
	EquippableGear = true,
	Rarity = "Rare"
}
local Lantern = GearImages:FindFirstChild("Lantern")

t6.IMG = Lantern and Lantern.Value or ""

local t8 = {
	ItemName = "Uncommon Sprinkler",
	ItemType = "Uncommon Sprinkler",
	RestockChance = 35,
	Cost = 10000,
	Rarity = "Uncommon",
	RestockValues = NumberRange.new(1, 2)
}
local v7 = GearImages:FindFirstChild("Uncommon Sprinkler")

t8.IMG = v7 and v7.Value or ""

local t9 = {
	ItemName = "Rare Sprinkler",
	ItemType = "Rare Sprinkler",
	RestockChance = 25,
	Cost = 50000,
	Rarity = "Rare",
	RestockValues = NumberRange.new(1, 2)
}
local v9 = GearImages:FindFirstChild("Rare Sprinkler")

t9.IMG = v9 and v9.Value or ""

local t10 = {
	ItemName = "Legendary Sprinkler",
	ItemType = "Legendary Sprinkler",
	RestockChance = 4,
	Cost = 100000,
	Rarity = "Legendary",
	RestockValues = NumberRange.new(1, 2)
}
local v11 = GearImages:FindFirstChild("Legendary Sprinkler")

t10.IMG = v11 and v11.Value or ""

local t11 = {
	ItemName = "Super Sprinkler",
	ItemType = "Super Sprinkler",
	RestockChance = 1.2,
	Cost = 300000,
	Rarity = "Super",
	RestockValues = NumberRange.new(1, 2)
}
local v13 = GearImages:FindFirstChild("Super Sprinkler")

t11.IMG = v13 and v13.Value or ""

local t12 = {
	ItemName = "Trowel",
	ItemType = "Trowel",
	RestockChance = 28,
	Cost = 1000,
	Rarity = "Rare",
	RestockValues = NumberRange.new(2, 3)
}
local Trowel = GearImages:FindFirstChild("Trowel")

t12.IMG = Trowel and Trowel.Value or ""

local t13 = {
	ItemName = "Speed Mushroom",
	ItemType = "Mushroom",
	RestockChance = 22,
	Cost = 1500,
	Rarity = "Rare",
	RestockValues = NumberRange.new(1, 5)
}
local v16 = GearImages:FindFirstChild("Speed Mushroom")

t13.IMG = v16 and v16.Value or ""

local t14 = {
	ItemName = "Jump Mushroom",
	ItemType = "Mushroom",
	RestockChance = 24,
	Cost = 1800,
	Rarity = "Rare",
	RestockValues = NumberRange.new(1, 4)
}
local v18 = GearImages:FindFirstChild("Jump Mushroom")

t14.IMG = v18 and v18.Value or ""

local t15 = {
	ItemName = "Gnome",
	ItemType = "Gnome",
	RestockChance = 8,
	Cost = 50000,
	Rarity = "Epic",
	RestockValues = NumberRange.new(2, 5)
}
local Gnome = GearImages:FindFirstChild("Gnome")

t15.IMG = Gnome and Gnome.Value or ""

local t16 = {
	ItemName = "Shrink Mushroom",
	ItemType = "Mushroom",
	RestockChance = 10,
	Cost = 4500,
	Rarity = "Epic",
	RestockValues = NumberRange.new(1, 3)
}
local v21 = GearImages:FindFirstChild("Shrink Mushroom")

t16.IMG = v21 and v21.Value or ""

local t17 = {
	ItemName = "Supersize Mushroom",
	ItemType = "Mushroom",
	RestockChance = 10,
	Cost = 4500,
	Rarity = "Epic",
	RestockValues = NumberRange.new(1, 3)
}
local v23 = GearImages:FindFirstChild("Supersize Mushroom")

t17.IMG = v23 and v23.Value or ""

local t18 = {
	ItemName = "Invisibility Mushroom",
	ItemType = "Mushroom",
	RestockChance = 4,
	Cost = 18000,
	Rarity = "Legendary",
	RestockValues = NumberRange.new(1, 2)
}
local v25 = GearImages:FindFirstChild("Invisibility Mushroom")

t18.IMG = v25 and v25.Value or ""
t2[1] = t3
t2[2] = t4
t2[3] = t5
t2[4] = t6
t2[5] = {
	ItemName = "Wheelbarrow",
	ItemType = "Wheelbarrow",
	Cost = 500000,
	PriceInRobux = 129,
	EquippableGear = true,
	Rarity = "Legendary",
	IMG = "rbxassetid://125296794878681"
}
t2[6] = t8
t2[7] = t9
t2[8] = t10
t2[9] = t11
t2[10] = t12
t2[11] = t13
t2[12] = t14
t2[13] = t15
t2[14] = t16
t2[15] = t17
t2[16] = t18

local t19 = {
	ItemName = "Teleporter",
	ItemType = "Teleporter",
	RestockChance = 3,
	Cost = 18000,
	Rarity = "Legendary",
	RestockValues = NumberRange.new(1, 3)
}
local Teleporter = GearImages:FindFirstChild("Teleporter")

t19.IMG = Teleporter and Teleporter.Value or ""

local t20 = {
	ItemName = "Super Watering Can",
	ItemType = "Watering Can",
	RestockChance = 2,
	Cost = 250000,
	Rarity = "Super",
	RestockValues = NumberRange.new(1, 2)
}
local v28 = GearImages:FindFirstChild("Super Watering Can")

t20.IMG = v28 and v28.Value or ""

local t21 = {
	ItemName = "Basic Pot",
	ItemType = "EmptyPot",
	RestockChance = 7,
	Cost = 60000,
	Rarity = "Epic",
	RestockValues = NumberRange.new(1, 3)
}
local v30 = GearImages:FindFirstChild("Basic Pot")

t21.IMG = v30 and v30.Value or ""
t2[17] = t19
t2[18] = t20
t2[19] = t21
t2[20] = {
	ItemName = "Flashbang",
	ItemType = "Flashbang",
	RestockChance = 7,
	Cost = 8000,
	Rarity = "Epic",
	IMG = "rbxassetid://137760243645491",
	RestockValues = NumberRange.new(4, 7)
}
t.Data = t2

return t