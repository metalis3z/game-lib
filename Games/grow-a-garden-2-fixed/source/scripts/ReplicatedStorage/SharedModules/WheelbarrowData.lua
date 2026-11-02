--credit to quartz games studio
local GearImages = script.Parent.GearImages

local function getGearImage(p1) --[[ getGearImage | Line: 3 | Upvalues: GearImages (copy) ]]
	local v1 = GearImages:FindFirstChild(p1)

	return if v1 then v1.Value or "" else ""
end

local t = {}
local t2 = {
	Name = "Wheelbarrow"
}
local Wheelbarrow = GearImages:FindFirstChild("Wheelbarrow")

t2.IMG = if Wheelbarrow then Wheelbarrow.Value or "" else ""
t.Data = t2

return t