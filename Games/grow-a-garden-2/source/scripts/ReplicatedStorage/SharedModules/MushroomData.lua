--credit to leon games studio
local GearImages = script.Parent.GearImages

local function getGearImage(p1) --[[ getGearImage | Line: 3 | Upvalues: GearImages (copy) ]]
	local v1 = GearImages:FindFirstChild(p1)

	return if v1 then v1.Value or "" else ""
end

local t = {}
local t2 = {}
local t3 = {
	Name = "Invisibility Mushroom",
	LastTime = 30,
	Description = "Go Invisible"
}
local v1 = GearImages:FindFirstChild("Invisibility Mushroom")

t3.IMG = if v1 then v1.Value or "" else ""
t3.Color = Color3.new(0.666667, 0.666667, 0.666667)

local t4 = {
	Name = "Jump Mushroom",
	LastTime = 60,
	Description = "+5 Jump Power"
}
local v3 = GearImages:FindFirstChild("Jump Mushroom")

t4.IMG = v3 and v3.Value or ""
t4.Color = Color3.new(0, 0.666667, 1)

local t5 = {
	Name = "Shrink Mushroom",
	LastTime = 45,
	Description = "X0.75 Size"
}
local v5 = GearImages:FindFirstChild("Shrink Mushroom")

t5.IMG = v5 and v5.Value or ""
t5.Color = Color3.new(255/255, 102/255, 204/255)

local t6 = {
	Name = "Speed Mushroom",
	LastTime = 60,
	Description = "+5 Speed"
}
local v7 = GearImages:FindFirstChild("Speed Mushroom")

t6.IMG = v7 and v7.Value or ""
t6.Color = Color3.new(0.811765, 0.12549, 0.14902)

local t7 = {
	Name = "Supersize Mushroom",
	LastTime = 45,
	Description = "X1.25 Size"
}
local v9 = GearImages:FindFirstChild("Supersize Mushroom")

t7.IMG = v9 and v9.Value or ""
t7.Color = Color3.new(0.419608, 0.196078, 0.486275)
t2[1] = t3
t2[2] = t4
t2[3] = t5
t2[4] = t6
t2[5] = t7
t.Data = t2

return t