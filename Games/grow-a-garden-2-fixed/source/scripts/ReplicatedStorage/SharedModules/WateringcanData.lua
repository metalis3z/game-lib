--credit to prince games studio
local GearImages = script.Parent.GearImages

local function getGearImage(p1) --[[ getGearImage | Line: 3 | Upvalues: GearImages (copy) ]]
	local v1 = GearImages:FindFirstChild(p1)

	return if v1 then v1.Value or "" else ""
end

local t = {}
local t2 = {
	Name = "Common Watering Can",
	GrowthSpeedMultiplier = 3,
	EffectTime = 10,
	SplashRadius = 5
}
local v1 = GearImages:FindFirstChild("Common Watering Can")

t2.Image = if v1 then v1.Value or "" else ""

local t3 = {
	Name = "Super Watering Can",
	GrowthSpeedMultiplier = 300,
	EffectTime = 15,
	SplashRadius = 8
}
local v3 = GearImages:FindFirstChild("Super Watering Can")

t3.Image = v3 and v3.Value or ""
t[1] = t2
t[2] = t3

return t