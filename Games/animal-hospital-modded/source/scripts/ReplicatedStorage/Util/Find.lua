local t = {}

function t.Parent(p1) --[[ Parent | Line: 3 | Upvalues: t (copy) ]]
	if not (p1 and p1.Parent) then
		return
	end

	local v1 = p1.Parent

	if v1 == workspace or v1:IsA("Folder") then
		return p1
	end

	return t.Parent(v1)
end
function t.ChildOfParent(p1, p2) --[[ ChildOfParent | Line: 13 | Upvalues: t (copy) ]]
	local v1 = p1.Parent

	if v1 == workspace then
		return false
	end

	if v1 == p2 then
		return p1
	end

	return t.ChildOfParent(v1, p2)
end
function t.Tool(p1, p2) --[[ Tool | Line: 23 ]]
	return p1.Backpack:FindFirstChild(p2) or p1.Character and p1.Character:FindFirstChild(p2)
end
function t.ClosestLight(p1) --[[ ClosestLight | Line: 27 ]]
	local v1 = (1 / 0)
	local v2 = nil

	for i, v in ipairs(workspace.Lights:GetChildren()) do
		local Magnitude = (v.Position - p1).Magnitude

		if Magnitude < v1 then
			v1 = Magnitude
			v2 = v
		end
	end

	return v2
end

return t