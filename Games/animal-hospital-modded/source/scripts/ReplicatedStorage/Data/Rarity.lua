local t = {}
local v1 = 1

local function RarityNew(p1, p2, p3) --[[ RarityNew | Line: 4 | Upvalues: v1 (ref), t (copy) ]]
	v1 = math.max(v1, p2)
	t[p1] = {
		Name = p1,
		Value = p2,
		Color = p3
	}
end

local t2 = {
	Name = "Common",
	Value = 0.5,
	Color = Color3.fromRGB(230, 230, 245)
}
local v2 = v1

v1 = math.max(v2, 0.5)
t.Common = t2

local t3 = {
	Name = "Uncommon",
	Value = 0.9,
	Color = Color3.fromRGB(13, 170, 255)
}
local v3 = v1

v1 = math.max(v3, 0.9)
t.Uncommon = t3

local t4 = {
	Name = "Rare",
	Value = 1.8,
	Color = Color3.fromRGB(9, 207, 128)
}
local v4 = v1

v1 = math.max(v4, 1.8)
t.Rare = t4

local t5 = {
	Name = "Epic",
	Value = 2.5,
	Color = Color3.fromRGB(239, 184, 56)
}
local v5 = v1

v1 = math.max(v5, 2.5)
t.Epic = t5

local t6 = {
	Name = "Legendary",
	Value = 5,
	Color = Color3.fromRGB(222, 76, 125)
}
local v6 = v1

v1 = math.max(v6, 5)
t.Legendary = t6

return t