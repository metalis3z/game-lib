return function(Knife)
	local clone1 = workspace.Smoke:Clone()
	clone1.Parent = Knife.Handle
	
	local clone2 = workspace.Gear:Clone()
	clone2.Parent = Knife.Handle
	
	local clone1 = workspace.Bolt:Clone()
	clone1.Parent = Knife.Handle

	local clone2 = workspace.Screw:Clone()
	clone2.Parent = Knife.Handle
	
end