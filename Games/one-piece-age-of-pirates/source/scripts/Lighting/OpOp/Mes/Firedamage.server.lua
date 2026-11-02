script.Parent.Touched:connect(function(Part)
	f = script.Parent.Owner
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value then
		script.Disabled = true
		wait(0.5)
		x = game.Players:FindFirstChild(f.Value)
		heart = game.Lighting.OpOp.Heart:Clone()
		heart.Parent = x.Backpack
		heart.Value.Value = Part.Parent.Name
		heart.Name = Part.Parent.Name
		script.Parent:remove()
		script:remove()
	end
	
	wait(8)
	script.Parent:remove()
end)