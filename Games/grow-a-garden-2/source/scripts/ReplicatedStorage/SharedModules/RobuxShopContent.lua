--credit to quartz games studio
local function generateFullPalette(p1) --[[ generateFullPalette | Line: 1 ]]
	local v1, v2, v3 = p1:ToHSV()
	local v4 = v3 * (1 - v2 / 2)
	local v5 = if v4 == 0 or v4 == 1 then 0 else (v3 - v4) / math.min(v4, 1 - v4)

	local function fromHSL(p1, p2, p3) --[[ fromHSL | Line: 6 ]]
		local v1 = p3 + p2 * math.min(p3, 1 - p3)

		return Color3.fromHSV(p1, if v1 == 0 then 0 else 2 * (1 - p3 / v1), v1)
	end

	local t = {}
	local v7 = 0.6 + v2 * 0.4
	local v9 = Color3.fromHSV(v1 + 0.03333333333333333, if v7 == 0 then 0 else 2 * (1 - 0.6 / v7), v7)
	local v10 = 0.15 + v5 * 0.35 * 0.15
	local v12 = Color3.fromHSV(v1, if v10 == 0 then 0 else 2 * (1 - 0.15 / v10), v10)
	local v13 = 0.17 + v5 * 0.7 * 0.17
	local v14, v15

	if v13 == 0 then
		v14 = 0
		v15 = v9
	else
		v14 = 2 * (1 - 0.17 / v13)
		v15 = v9
	end

	t[1] = v15
	t[2] = v12
	t[3] = Color3.fromHSV(v1, v14, v13)
	t[4] = fromHSL(v1 + 0.013888888888888888, v5 * 0.9, 0.85)
	table.insert(t, 1, p1)

	return t
end

return {
	SeedPacks = {
		{
			Name = "Ghost Pepper Pack",
			DisplayName = "Ghost Pepper Pack",
			Colors = generateFullPalette(Color3.fromRGB(255, 0, 0))
		}
	},
	StarterPack = {
		DisplayName = "Starter Pack",
		Items = {
			{
				Type = "SeedPack",
				Name = "Legendary Seed Pack",
				Count = 1
			},
			{
				Type = "Gear",
				Name = "Common Watering Can",
				Count = 5
			},
			{
				Type = "SeedPack",
				Name = "Rare Seed Pack",
				Count = 3
			}
		}
	},
	Gears = {
		{
			Name = "Vine Wrapper",
			Description = "Wrap people in vines!",
			GamepassKey = "Gamepass:VineWrapper:1",
			Colors = generateFullPalette(Color3.fromRGB(0, 170, 0))
		},
		{
			Name = "Power Hose",
			Description = "Spray people from distance!",
			GamepassKey = "Gamepass:PowerHose:1",
			Colors = generateFullPalette(Color3.fromRGB(56, 168, 255))
		},
		{
			Name = "Freeze Ray",
			Description = "Freeze people!",
			GamepassKey = "Gamepass:FreezeRay:1",
			Colors = generateFullPalette(Color3.fromRGB(120, 220, 255))
		},
		{
			Name = "Rainbow Carpet",
			Description = "Fly anywhere!",
			GamepassKey = "Gamepass:RainbowCarpet:1",
			Colors = generateFullPalette(Color3.fromRGB(255, 100, 200))
		}
	},
	Sheckles = {
		{
			Amount = 5000,
			Price = 10,
			Image = "rbxassetid://88931175983845"
		},
		{
			Amount = 10000,
			Price = 20,
			Image = "rbxassetid://132134544257550"
		},
		{
			Amount = 25000,
			Price = 50,
			Image = "rbxassetid://72067131155642"
		},
		{
			Amount = 50000,
			Price = 100,
			Image = "rbxassetid://93115005224214"
		},
		{
			Amount = 100000,
			Price = 200,
			Image = "rbxassetid://99416757982094"
		}
	}
}