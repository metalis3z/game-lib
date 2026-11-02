local check = {"Part","SpawnLocation","FlagStand","Seat"}

local function runCheck(class)
	for i = 1, #check do
		if check[i]:lower() == class:lower() then return true end
	end
	return false
end

function cleanUpSnaps(object)
	local c = object:GetChildren()
	for i = 1, #c do
		if runCheck(c[i].className) then
			if not c[i].Anchored then
				c[i]:MakeJoints()
			else
				c[i]:BreakJoints()
			end
		else
			cleanUpSnaps(c[i])
		end
	end
end

cleanUpSnaps(game.Workspace)
game.Workspace.DescendantAdded:connect(function(instance) 
	if runCheck(instance.className) then
		if not instance.Anchored then
			instance:MakeJoints()
		else
			instance:BreakJoints()
		end
	end
end)

workspace.ChildAdded:connect(function(item) 
	if item:IsA("Hat") or item:IsA("Tool") then --Hats and gear get cleaned up.
		wait(10) --Delay until the object gets removed. Allows time to be picked up.
		if item.Parent == workspace then --Only hats and gear directly in workspace are cleaned up.
			item:Destroy()
		end 
	end 
end) 