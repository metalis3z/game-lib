--credit to quartz games studio
local GearImages = script.Parent.GearImages

local function getGearImage(p1) --[[ getGearImage | Line: 3 | Upvalues: GearImages (copy) ]]
	local v1 = GearImages:FindFirstChild(p1)

	return if v1 then v1.Value or "" else ""
end

local t = {}
local t2 = {
	RakeName = "Rake",
	Lifetime = 600,
	Cooldown = 3,
	Radius = 7
}
local Rake = GearImages:FindFirstChild("Rake")

t2.Image = if Rake then Rake.Value or "" else ""
t[1] = t2

return t