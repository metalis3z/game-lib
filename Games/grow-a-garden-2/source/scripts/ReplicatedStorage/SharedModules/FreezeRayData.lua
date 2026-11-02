--credit to leon games studio
local GearImages = script.Parent.GearImages

local function getGearImage(p1) --[[ getGearImage | Line: 3 | Upvalues: GearImages (copy) ]]
	local v1 = GearImages:FindFirstChild(p1)

	return if v1 then v1.Value or "" else ""
end

local t = {}
local t2 = {}
local t3 = {
	Name = "Freeze Ray",
	Description = "Freeze people in a cube!"
}
local v1 = GearImages:FindFirstChild("Freeze Ray")

t3.IMG = if v1 then v1.Value or "" else ""
t2[1] = t3
t.Data = t2

return t