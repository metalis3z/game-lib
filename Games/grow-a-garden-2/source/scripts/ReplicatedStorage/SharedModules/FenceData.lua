--credit to quartz games studio
local FenceImages = script.Parent.FenceImages

local function getFenceImage(p1) --[[ getFenceImage | Line: 3 | Upvalues: FenceImages (copy) ]]
	local v1 = FenceImages:FindFirstChild(p1)

	return if v1 then v1.Value or "" else ""
end

local t = {}
local t2 = {}
local t3 = {
	PropName = "Default"
}
local Default = FenceImages:FindFirstChild("Default")

t3.IMG = if Default then Default.Value or "" else ""

local t4 = {
	PropName = "Rainbow"
}
local Rainbow = FenceImages:FindFirstChild("Rainbow")

t4.IMG = Rainbow and Rainbow.Value or ""

local t5 = {
	PropName = "Cupid"
}
local Cupid = FenceImages:FindFirstChild("Cupid")

t5.IMG = Cupid and Cupid.Value or ""

local t6 = {
	PropName = "Wood"
}
local Wood = FenceImages:FindFirstChild("Wood")

t6.IMG = Wood and Wood.Value or ""

local t7 = {
	PropName = "Bamboo"
}
local Bamboo = FenceImages:FindFirstChild("Bamboo")

t7.IMG = Bamboo and Bamboo.Value or ""

local t8 = {
	PropName = "Lantern"
}
local Lantern = FenceImages:FindFirstChild("Lantern")

t8.IMG = Lantern and Lantern.Value or ""

local t9 = {
	PropName = "Stone"
}
local Stone = FenceImages:FindFirstChild("Stone")

t9.IMG = Stone and Stone.Value or ""

local t10 = {
	PropName = "Light"
}
local Light = FenceImages:FindFirstChild("Light")

t10.IMG = Light and Light.Value or ""

local t11 = {
	PropName = "Futuristic"
}
local Futuristic = FenceImages:FindFirstChild("Futuristic")

t11.IMG = Futuristic and Futuristic.Value or ""

local t12 = {
	PropName = "Spike"
}
local Spike = FenceImages:FindFirstChild("Spike")

t12.IMG = Spike and Spike.Value or ""

local t13 = {
	PropName = "Flower"
}
local Flower = FenceImages:FindFirstChild("Flower")

t13.IMG = Flower and Flower.Value or ""

local t14 = {
	PropName = "Star"
}
local Star = FenceImages:FindFirstChild("Star")

t14.IMG = Star and Star.Value or ""

local t15 = {
	PropName = "White"
}
local White = FenceImages:FindFirstChild("White")

t15.IMG = White and White.Value or ""

local t16 = {
	PropName = "Stick"
}
local Stick = FenceImages:FindFirstChild("Stick")

t16.IMG = Stick and Stick.Value or ""

local t17 = {
	PropName = "Pole"
}
local Pole = FenceImages:FindFirstChild("Pole")

t17.IMG = Pole and Pole.Value or ""
t2[1] = t3
t2[2] = t4
t2[3] = t5
t2[4] = t6
t2[5] = t7
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
t.Data = t2

return t