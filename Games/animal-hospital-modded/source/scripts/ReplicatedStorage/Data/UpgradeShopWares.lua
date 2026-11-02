local t = {
	Items = {},
	ItemsByName = {}
}
local v1 = Random.new()

local function newItem(p1, p2, p3, p4, p5, p6) --[[ newItem | Line: 15 | Upvalues: t (copy) ]]
	local t2 = {
		Name = p1,
		Type = p2,
		Description = p3,
		Cost = p4,
		Icon = p6,
		IconType = p5
	}

	t.ItemsByName[p1] = t2
	table.insert(t.Items, t2)

	return t2
end

local v2 = nil
local v3 = true

function t.GetUpTo3RandomItems(p1) --[[ GetUpTo3RandomItems | Line: 34 | Upvalues: t (copy), v3 (ref), v1 (copy), v2 (ref) ]]
	local v22, v32, v4, v5, count = if p1 then p1 else {}, {}, {}, {}, 0

	for i, v in ipairs(t.Items) do
		local v6

		if not v22[v.Name] and (not v.Reqs or (not v.Reqs[1] or v22[v.Reqs[1]])) then
			local v7 = v.Weight or (if v.Type == "Upgrade" then 2 else 1)

			v6 = if v3 and v.EarlyAccess then 3 else 0

			for i2 = 1, v7 + v6 do
				table.insert(v32, v)
			end
		end
	end

	local v8 = t.ItemsByName["Second Check-in"]

	if v8 and not v22["Second Check-in"] then
		table.insert(v4, v8)
		v5[v8.Type] = (v5[v8.Type] or 0) + 1
	end

	while #v4 < 3 and (#v32 > 0 and count < 100) do
		local v9 = v1:NextInteger(1, #v32)
		local v10 = v32[v9]
		local v11 = false

		count = count + 1

		for i, v in ipairs(v4) do
			if v.Name == v10.Name then
				table.remove(v32, v9)
				v11 = true

				break
			end
		end

		if not v11 then
			local v122 = v5[v10.Type] or 0

			if v122 >= 2 then
				for j = #v32, 1, -1 do
					if v32[j].Type == v10.Type then
						table.remove(v32, j)
					end
				end

				continue
			end

			table.insert(v4, v10)
			v5[v10.Type] = v122 + 1
		end
	end

	while #v4 < 3 do
		table.insert(v4, v2)
	end

	v3 = false

	return v4
end

local function newTool(p1, p2, p3, p4, p5, p6) --[[ newTool | Line: 111 | Upvalues: t (copy) ]]
	local t2 = {
		Type = "Tool",
		Name = p1,
		Description = p2,
		Cost = p3,
		Icon = p5,
		IconType = p4
	}

	t.ItemsByName[p1] = t2
	table.insert(t.Items, t2)
	t2.TypeColor = Color3.fromRGB(134, 120, 118)
	t2.EarlyAccess = p6

	return t2
end

local function newUpgrade(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ newUpgrade | Line: 118 | Upvalues: t (copy) ]]
	local t2 = {
		Type = "Upgrade",
		Name = p1,
		Description = p6,
		Cost = p7,
		Icon = p9,
		IconType = p8
	}

	t.ItemsByName[p1] = t2
	table.insert(t.Items, t2)
	t2.TypeColor = Color3.fromRGB(113, 141, 209)
	t2.Attribute = p2
	t2.AttributeValue = p3
	t2.Mult = p4
	t2.EarlyAccess = p10
	t2.Reqs = p5

	return t2
end

local function newExpansion(p1, p2, p3, p4, p5) --[[ newExpansion | Line: 130 | Upvalues: t (copy) ]]
	local t2 = {
		Type = "Upgrade",
		Name = p1,
		Description = p2,
		Cost = p3,
		Icon = p5,
		IconType = p4
	}

	t.ItemsByName[p1] = t2
	table.insert(t.Items, t2)
	t2.TypeColor = Color3.fromRGB(200, 50, 200)
	t2.Weight = 10
	t2.Attribute = false

	return t2
end

local function newCurrency(p1, p2, p3, p4, p5) --[[ newCurrency | Line: 139 | Upvalues: t (copy) ]]
	local t2 = {
		Type = "Currency",
		Name = p1,
		Description = p2,
		Cost = p3,
		Icon = p5,
		IconType = p4
	}

	t.ItemsByName[p1] = t2
	table.insert(t.Items, t2)
	t2.TypeColor = Color3.fromRGB(201, 171, 47)

	return t2
end

local t2 = {
	Name = "Animal Coins",
	Type = "Currency",
	Description = " 1-3 Animal Coins ",
	Cost = 100,
	Icon = "rbxassetid://116416447601441",
	IconType = "Image"
}

t.ItemsByName["Animal Coins"] = t2
table.insert(t.Items, t2)
t2.TypeColor = Color3.fromRGB(201, 171, 47)
v2 = t2

local t3 = {
	Name = "Second Check-in",
	Type = "Upgrade",
	Description = "Extra check in window",
	Cost = 190,
	Icon = "SecondCheckInBell",
	IconType = "Model"
}

t.ItemsByName["Second Check-in"] = t3
table.insert(t.Items, t3)
t3.TypeColor = Color3.fromRGB(200, 50, 200)
t3.Weight = 10
t3.Attribute = ({
	MULT = true,
	SUM = false
}).SUM

local t4 = {
	Name = "Faster Check-Ins",
	Type = "Upgrade",
	Description = "Visitors check in faster",
	Cost = 20,
	Icon = "CheckInSign",
	IconType = "Model"
}

t.ItemsByName["Faster Check-Ins"] = t4
table.insert(t.Items, t4)
t4.TypeColor = Color3.fromRGB(113, 141, 209)
t4.Attribute = "FasterCheckIns"
t4.AttributeValue = 1
t4.Mult = false
t4.EarlyAccess = true
t4.Reqs = {}

local t5 = {
	Name = "\"No Speaking\" Sign",
	Type = "Upgrade",
	Description = "Faster check in",
	Cost = 250,
	Icon = "NoSpeakingSign",
	IconType = "Model"
}

t.ItemsByName["\"No Speaking\" Sign"] = t5
table.insert(t.Items, t5)
t5.TypeColor = Color3.fromRGB(113, 141, 209)
t5.Attribute = "NoSpeaking"
t5.AttributeValue = 1
t5.Mult = false
t5.EarlyAccess = nil
t5.Reqs = { "Faster Check-Ins" }

local t6 = {
	Name = "Adv. DNA Synth",
	Type = "Upgrade",
	Description = "50% Faster DNA analysis",
	Cost = 110,
	Icon = "Analyzer",
	IconType = "Model"
}

t.ItemsByName["Adv. DNA Synth"] = t6
table.insert(t.Items, t6)
t6.TypeColor = Color3.fromRGB(113, 141, 209)
t6.Attribute = "BonusDNASpeed"
t6.AttributeValue = 0.5
t6.Mult = true
t6.EarlyAccess = true
t6.Reqs = {}

local t7 = {
	Name = "16GB RAM",
	Type = "Upgrade",
	Description = "33% Faster computers",
	Cost = 110,
	Icon = "Computer",
	IconType = "Model"
}

t.ItemsByName["16GB RAM"] = t7
table.insert(t.Items, t7)
t7.TypeColor = Color3.fromRGB(113, 141, 209)
t7.Attribute = "BonusComputerSpeed"
t7.AttributeValue = 0.6699999999999999
t7.Mult = true
t7.EarlyAccess = true
t7.Reqs = {}

local t8 = {
	Name = "Better Printers",
	Type = "Upgrade",
	Description = "25% Faster Printers",
	Cost = 100,
	Icon = "Printer",
	IconType = "Model"
}

t.ItemsByName["Better Printers"] = t8
table.insert(t.Items, t8)
t8.TypeColor = Color3.fromRGB(113, 141, 209)
t8.Attribute = "BonusPrinterSpeed"
t8.AttributeValue = 0.75
t8.Mult = true
t8.EarlyAccess = true
t8.Reqs = {}

local t9 = {
	Name = "Medicine Pockets",
	Type = "Upgrade",
	Description = "+1 Carry Capacity",
	Cost = 100,
	Icon = "MedicBag",
	IconType = "Model"
}

t.ItemsByName["Medicine Pockets"] = t9
table.insert(t.Items, t9)
t9.TypeColor = Color3.fromRGB(113, 141, 209)
t9.Attribute = "BonusCarryItems"
t9.AttributeValue = 1
t9.Mult = false
t9.EarlyAccess = true
t9.Reqs = {}

local t10 = {
	Name = "Special Formula",
	Type = "Upgrade",
	Description = "Patients recover 25% faster",
	Cost = 110,
	Icon = "Vial",
	IconType = "Model"
}

t.ItemsByName["Special Formula"] = t10
table.insert(t.Items, t10)
t10.TypeColor = Color3.fromRGB(113, 141, 209)
t10.Attribute = "BonusHealingSpeed"
t10.AttributeValue = 0.75
t10.Mult = true
t10.EarlyAccess = true
t10.Reqs = {}

local t11 = {
	Name = "Hospital Shoes",
	Type = "Upgrade",
	Description = "+10% NPC Speed",
	Cost = 150,
	Icon = "Shoes",
	IconType = "Model"
}

t.ItemsByName["Hospital Shoes"] = t11
table.insert(t.Items, t11)
t11.TypeColor = Color3.fromRGB(113, 141, 209)
t11.Attribute = "BonusNPCSpeed"
t11.AttributeValue = 1.1
t11.Mult = true
t11.EarlyAccess = true
t11.Reqs = {}

local t12 = {
	Name = "Special Technique",
	Type = "Upgrade",
	Description = "Give medicine from inventory",
	Cost = 450,
	Icon = "Vial 2",
	IconType = "Model"
}

t.ItemsByName["Special Technique"] = t12
table.insert(t.Items, t12)
t12.TypeColor = Color3.fromRGB(113, 141, 209)
t12.Attribute = "GiveAllItems"
t12.AttributeValue = 1
t12.Mult = false
t12.EarlyAccess = nil
t12.Reqs = { "Special Formula" }

local t13 = {
	Name = "Medical Backpack",
	Type = "Upgrade",
	Description = "+1 Carry Capacity",
	Cost = 250,
	Icon = "MedicBag",
	IconType = "Model"
}

t.ItemsByName["Medical Backpack"] = t13
table.insert(t.Items, t13)
t13.TypeColor = Color3.fromRGB(113, 141, 209)
t13.Attribute = "BonusCarryItems"
t13.AttributeValue = 1
t13.Mult = false
t13.EarlyAccess = nil
t13.Reqs = { "Medicine Pockets" }

local t14 = {
	Name = "Max Printers",
	Type = "Upgrade",
	Description = "20% Faster Printers",
	Cost = 250,
	Icon = "Printer",
	IconType = "Model"
}

t.ItemsByName["Max Printers"] = t14
table.insert(t.Items, t14)
t14.TypeColor = Color3.fromRGB(113, 141, 209)
t14.Attribute = "BonusPrinterSpeed"
t14.AttributeValue = 0.8
t14.Mult = true
t14.EarlyAccess = nil
t14.Reqs = { "Better Printers" }

local t15 = {
	Name = "32GB RAM",
	Type = "Upgrade",
	Description = "25% Faster computers",
	Cost = 350,
	Icon = "Computer",
	IconType = "Model"
}

t.ItemsByName["32GB RAM"] = t15
table.insert(t.Items, t15)
t15.TypeColor = Color3.fromRGB(113, 141, 209)
t15.Attribute = "BonusComputerSpeed"
t15.AttributeValue = 0.75
t15.Mult = true
t15.EarlyAccess = nil
t15.Reqs = { "16GB RAM" }

local t16 = {
	Name = "Expert DNA Synth",
	Type = "Upgrade",
	Description = "25% Faster DNA analysis",
	Cost = 250,
	Icon = "Analyzer",
	IconType = "Model"
}

t.ItemsByName["Expert DNA Synth"] = t16
table.insert(t.Items, t16)
t16.TypeColor = Color3.fromRGB(113, 141, 209)
t16.Attribute = "BonusDNASpeed"
t16.AttributeValue = 0.75
t16.Mult = true
t16.EarlyAccess = nil
t16.Reqs = { "Adv. DNA Synth" }

local t17 = {
	Name = "Hospital Shoes 2",
	Type = "Upgrade",
	Description = "+10% NPC Speed",
	Cost = 280,
	Icon = "Shoes",
	IconType = "Model"
}

t.ItemsByName["Hospital Shoes 2"] = t17
table.insert(t.Items, t17)
t17.TypeColor = Color3.fromRGB(113, 141, 209)
t17.Attribute = "BonusNPCSpeed"
t17.AttributeValue = 1.1
t17.Mult = true
t17.EarlyAccess = nil
t17.Reqs = { "Hospital Shoes" }

local t18 = {
	Name = "Hospital Shoes 3",
	Type = "Upgrade",
	Description = "+12% NPC Speed",
	Cost = 500,
	Icon = "Shoes",
	IconType = "Model"
}

t.ItemsByName["Hospital Shoes 3"] = t18
table.insert(t.Items, t18)
t18.TypeColor = Color3.fromRGB(113, 141, 209)
t18.Attribute = "BonusNPCSpeed"
t18.AttributeValue = 1.12
t18.Mult = true
t18.EarlyAccess = nil
t18.Reqs = { "Hospital Shoes 2" }

local t19 = {
	Name = "Choco",
	Type = "Tool",
	Description = "Recover 60% Sanity",
	Cost = 120,
	Icon = "rbxassetid://135315375567218",
	IconType = "Image"
}

t.ItemsByName.Choco = t19
table.insert(t.Items, t19)
t19.TypeColor = Color3.fromRGB(134, 120, 118)
t19.EarlyAccess = true

local t20 = {
	Name = "RunCola",
	Type = "Tool",
	Description = "Speed Boost (30s)",
	Cost = 75,
	Icon = "rbxassetid://118818101858676",
	IconType = "Image"
}

t.ItemsByName.RunCola = t20
table.insert(t.Items, t20)
t20.TypeColor = Color3.fromRGB(134, 120, 118)
t20.EarlyAccess = true

local t21 = {
	Name = "Coffee",
	Type = "Tool",
	Description = "Recover 15% Sanity",
	Cost = 50,
	Icon = "rbxassetid://118223977489343",
	IconType = "Image"
}

t.ItemsByName.Coffee = t21
table.insert(t.Items, t21)
t21.TypeColor = Color3.fromRGB(134, 120, 118)
t21.EarlyAccess = nil

local t22 = {
	Name = "Taser",
	Type = "Tool",
	Description = "Shock people (1 use)",
	Cost = 150,
	Icon = "rbxassetid://117281306399004",
	IconType = "Image"
}

t.ItemsByName.Taser = t22
table.insert(t.Items, t22)
t22.TypeColor = Color3.fromRGB(134, 120, 118)
t22.EarlyAccess = true

local t23 = {
	Name = "X-Taser",
	Type = "Tool",
	Description = "Shock people (3 uses)",
	Cost = 250,
	Icon = "rbxassetid://84135156232745",
	IconType = "Image"
}

t.ItemsByName["X-Taser"] = t23
table.insert(t.Items, t23)
t23.TypeColor = Color3.fromRGB(134, 120, 118)
t23.EarlyAccess = nil

local t24 = {
	Name = "Gun",
	Type = "Tool",
	Description = "Shoot people (20 bullets)",
	Cost = 400,
	Icon = "Gun",
	IconType = "Model"
}

t.ItemsByName.Gun = t24
table.insert(t.Items, t24)
t24.TypeColor = Color3.fromRGB(134, 120, 118)
t24.EarlyAccess = nil

local t25 = {
	Name = "Teddy",
	Type = "Tool",
	Description = "Use to revive 1 dead player (cant use on self)",
	Cost = 1000,
	Icon = "Teddy",
	IconType = "Model"
}

t.ItemsByName.Teddy = t25
table.insert(t.Items, t25)
t25.TypeColor = Color3.fromRGB(134, 120, 118)
t25.EarlyAccess = nil

return t