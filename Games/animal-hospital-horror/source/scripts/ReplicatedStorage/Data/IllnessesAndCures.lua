local t = {}
local t2 = {}

t2.__index = t2

local t3 = {}
local t4 = {}
local t5 = {}

local function newCure(p1, p2, p3, p4) --[[ newCure | Line: 11 | Upvalues: t5 (copy) ]]
	local t = {
		Name = p1,
		Image = p2,
		Surgery = p3 or false
	}

	t.Attributes = if p4 then p4 else {}
	t5[p1] = t

	return t
end

function t2.new(p1, p2, p3) --[[ new | Line: 22 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
	local t = {}

	setmetatable(t, t2)
	t.Name = p1
	t.HealedWith = p3 or "Nothing"
	t.RoomType = p2
	t3[p1] = t
	t4[p2] = t4[p2] or {}
	table.insert(t4[p2], t)

	return t
end
function t2.TryCure(p1, p2) --[[ TryCure | Line: 38 ]]
	return p1.HealedWithv == p2
end
function t.GetIllnessByName(p1) --[[ GetIllnessByName | Line: 42 | Upvalues: t3 (copy) ]]
	return t3[p1]
end
t.GetIllness = t.GetIllnessByName

local t6 = {}

function t.GetRandomIllnessFromRoomType(p1, p2, p3) --[[ GetRandomIllnessFromRoomType | Line: 49 | Upvalues: t6 (ref), t4 (copy) ]]
	if p3 == 1 and #t6 > 0 then
		return {
			[table.remove(t6, 1)] = true
		}
	end

	local v1 = t4[p1] or t4.Medical
	local v2 = math.clamp(p2 or 1, 1, #v1)

	if not v1 or #v1 == 0 then
		return nil
	end

	local count, v3, v4 = 0, v2, {}

	while count < v3 do
		local v5 = v1[math.random(1, #v1)]

		if not (v4[v5] or v5.MinNight and p3 < v5.MinNight) then
			v4[v5] = true
			count = count + 1
		end
	end

	return v4
end
function t.GetCureForIllness(p1) --[[ GetCureForIllness | Line: 79 | Upvalues: t5 (copy) ]]
	return t5[p1.HealedWith]
end
function t.GetCures() --[[ GetCures | Line: 83 | Upvalues: t5 (copy) ]]
	return t5
end

local t7 = {
	Liquid = true,
	Stealable = true
}
local t8 = {
	Name = "IV Drops",
	Image = "rbxassetid://80921902713892",
	Surgery = true
}

t8.Attributes = if t7 then t7 else {}
t5["IV Drops"] = t8

local t9 = {
	GoodForEyes = true,
	Liquid = true,
	Stealable = true
}
local t10 = {
	Name = "Eye Drops",
	Image = "rbxassetid://111311966501039",
	Surgery = false
}

t10.Attributes = if t9 then t9 else {}
t5["Eye Drops"] = t10

local t11 = {
	Stealable = true
}
local t12 = {
	Name = "Medicine",
	Image = "rbxassetid://77371987968160",
	Surgery = true
}

t12.Attributes = if t11 then t11 else {}
t5.Medicine = t12

local t13 = {
	Stealable = true
}
local t14 = {
	Name = "Herbs",
	Image = "rbxassetid://75968336376122",
	Surgery = false
}

t14.Attributes = if t13 then t13 else {}
t5.Herbs = t14

local t15 = {
	Stealable = true
}
local t16 = {
	Name = "Antibiotics",
	Image = "rbxassetid://105921256950336",
	Surgery = true
}

t16.Attributes = if t15 then t15 else {}
t5.Antibiotics = t16

local t17 = {
	Stealable = true
}
local t18 = {
	Name = "Bandages",
	Image = "rbxassetid://114188173109669",
	Surgery = true
}

t18.Attributes = if t17 then t17 else {}
t5.Bandages = t18

local t19 = {
	Stealable = true
}
local t20 = {
	Name = "Ointment",
	Image = "rbxassetid://81516549429267",
	Surgery = false
}

t20.Attributes = if t19 then t19 else {}
t5.Ointment = t20

local t21 = {
	Stealable = true
}
local t22 = {
	Name = "Scissors",
	Image = "rbxassetid://99802820054944",
	Surgery = true
}

t22.Attributes = if t21 then t21 else {}
t5.Scissors = t22

local t23 = {
	Stealable = true
}
local t24 = {
	Name = "Scalpel",
	Image = "rbxassetid://126035532627391",
	Surgery = true
}

t24.Attributes = if t23 then t23 else {}
t5.Scalpel = t24

local t25 = {
	Stealable = true
}
local t26 = {
	Name = "Medkit",
	Image = "rbxassetid://130516067676328",
	Surgery = true
}

t26.Attributes = if t25 then t25 else {}
t5.Medkit = t26

local t27 = {
	Stealable = true
}
local t28 = {
	Name = "Thermo",
	Image = "rbxassetid://96487003723881",
	Surgery = false
}

t28.Attributes = if t27 then t27 else {}
t5.Thermo = t28

local t29 = {
	MonsterFood = true,
	Stealable = true
}
local t30 = {
	Name = "Transplant",
	Image = "rbxassetid://122764625848652",
	Surgery = true
}

t30.Attributes = if t29 then t29 else {}
t5.Transplant = t30

local t31 = {
	MonsterFood = true,
	Stealable = true
}
local t32 = {
	Name = "Organ",
	Image = "rbxassetid://98996052403892",
	Surgery = true
}

t32.Attributes = if t31 then t31 else {}
t5.Organ = t32

local t33 = {
	MonsterFood = true,
	Stealable = true
}
local t34 = {
	Name = "Maple Syrup",
	Image = "rbxassetid://94018869912090",
	Surgery = false
}

t34.Attributes = if t33 then t33 else {}
t5["Maple Syrup"] = t34

local t35 = {
	Stealable = true
}
local t36 = {
	Name = "Cough Syrup",
	Image = "rbxassetid://138919987897405",
	Surgery = false
}

t36.Attributes = if t35 then t35 else {}
t5["Cough Syrup"] = t36

local t37 = {
	Liquid = true,
	Stealable = true
}
local t38 = {
	Name = "Coffee",
	Image = "rbxassetid://118223977489343",
	Surgery = false
}

t38.Attributes = if t37 then t37 else {}
t5.Coffee = t38

local t39 = {
	Liquid = true,
	Stealable = true
}
local t40 = {
	Name = "RunCola",
	Image = "rbxassetid://118818101858676",
	Surgery = false
}

t40.Attributes = if t39 then t39 else {}
t5.RunCola = t40
t2.new("Dehydration", "Medical", t8.Name).MinNight = 2

local v18 = t2.new("Stomach Ache", "Medical", t14.Name)

t2.new("Head Ache", "Medical", t12.Name)
t2.new("Bleeding", "Medical", t18.Name)
t2.new("Fever", "Medical", t28.Name)
t2.new("Low Sugar", "Medical", t34.Name)
t2.new("Canadian", "Medical", t34.Name)
t2.new("Flu", "Medical", t36.Name)
t2.new("Rash", "Medical", t20.Name)

local v19 = t2.new("Dried Eyes", "Medical", t10.Name)

t2.new("Bruises", "Medical", t26.Name)
t6 = { v18, v19 }
t.MAX = 3

-- Getter aditivo (server): lista de enfermedades de un tipo de sala, para poder
-- filtrar por las curas que el jugador realmente posee (PatientCareService).
function t.GetIllnessesByRoomType(roomType)
	return t4[roomType] or {}
end

return t