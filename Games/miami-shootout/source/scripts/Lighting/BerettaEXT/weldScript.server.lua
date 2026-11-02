--- weld script by DuckXrec
local yes = script.Parent.Handle -- the handle (or the primary part)
local woh = script.Parent:GetChildren() -- getting children of the tool
for x = 1, #woh do  -- getting all the children
	if woh[x]:IsA('BasePart') then -- checking if children == parts
		local weld = Instance.new ("Weld")  -- making weld
		weld.Part0 = yes -- stuff
		weld.Part1 = woh[x] -- stuff
		weld.C0 = yes.CFrame:Inverse() -- stuff
		weld.C1 = woh[x].CFrame:Inverse() -- stuff
		weld.Parent = yes-- adding weld to the primary part aka  handle
	end
end