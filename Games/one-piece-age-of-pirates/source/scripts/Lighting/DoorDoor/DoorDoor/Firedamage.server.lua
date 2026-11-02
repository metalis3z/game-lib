function onDamage(Part)
	f = script.Parent.Owner
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name == f.Value then
		script.Disabled = true
		x = script.Parent:Clone()
		x.Parent = game.Workspace
		x.CFrame = script.Parent.CFrame * CFrame.new(0, 0, -80)
		d = x.Decal
		d.Face = "Front"
		Part.Parent.Torso.CFrame = x.CFrame
		wait(0.5)
		script.Disabled = false
		
		game.Debris:AddItem(x, 3)
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
