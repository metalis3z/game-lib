function onDamage(Part)
	f = script.Parent.Owner
	if Part.Parent:FindFirstChild("Humanoid") ~= nil then
		script.Disabled = true
		OriginalCF = Instance.new("Vector3Value")
		OriginalCF.Parent = Part.Parent.Torso
		OriginalCF.Value = Part.Parent.Torso.Position
		wait(0.5)
		Part.Parent.Torso.CFrame = game.Workspace.Door.Enter.CFrame
		wait(0.5)
		script.Disabled = false
end

	
	if Part.Parent:findFirstChild("Crash") ~= nil and Part.Parent.Name ~= f.Value and Part.Parent:FindFirstChild("Humanoid") ~= nil then
		
Part.Parent.Humanoid.Health = Part.Parent.Humanoid.Health + 15
x = math.random(1,5)
if x == 1 then
game:GetServCrash("Chat"):Chat(Part.Parent.Head, "Now i got some ".. script.Parent.Name .." In My Belly" )
end
script.Disabled = true
	end

end



script.Parent.Touched:connect(onDamage)

door = script.Parent
