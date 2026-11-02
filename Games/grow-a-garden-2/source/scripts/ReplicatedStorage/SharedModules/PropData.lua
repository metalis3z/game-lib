--credit to leon games studio
local PropImages = script.Parent.PropImages
local Props = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Props")

local function getPropImage(p1) --[[ getPropImage | Line: 4 | Upvalues: PropImages (copy) ]]
	local v1 = PropImages:FindFirstChild(p1)

	return if v1 then v1.Value or "" else ""
end

local t = {
	Data = {}
}

for v1, v2 in Props:GetChildren() do
	local t2 = {
		PropName = v2.Name
	}
	local v3 = PropImages:FindFirstChild(v2.Name)

	t2.IMG = if v3 then v3.Value or "" else ""
	t2.ExtraDataFilter = if v2:GetAttribute("ExtraDataFilter") == true then true else false
	table.insert(t.Data, t2)
end

return t