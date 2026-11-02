--credit to prince games studio
local ScrollingFrame = script.Parent:WaitForChild("ScrollingFrame")
local Empty = script.Parent:WaitForChild("Empty")

function UPD() --[[ UPD | Line: 5 | Upvalues: ScrollingFrame (copy), Empty (copy) ]]
	if #ScrollingFrame:GetChildren() > 3 then
		Empty.Visible = false
	else
		Empty.Visible = true
	end
end
UPD()
ScrollingFrame.ChildAdded:Connect(function() --[[ Line: 15 ]]
	UPD()
end)
ScrollingFrame.ChildRemoved:Connect(function() --[[ Line: 19 ]]
	UPD()
end)