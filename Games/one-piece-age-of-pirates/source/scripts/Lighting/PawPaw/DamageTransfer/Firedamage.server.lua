function onDamage(Part)
	f = script.Parent.Owner
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value and Part.Parent:findFirstChild("Snow") == nil then
		script.Disabled = true
		x = script.Parent
		thehealth = Part.Parent.Humanoid.MaxHealth - Part.Parent.Humanoid.Health
		for i = 1, 10 do
			Part.Parent.Humanoid.Health = Part.Parent.Humanoid.Health + thehealth
			wait(0.05)
		end
		x2 = game.Lighting.PawPaw.DamagePaw:Clone()
		x2.Parent = game.Workspace
		x2.CFrame = Part.Parent.Torso.CFrame * CFrame.new(0, 2, 0)
		x2.Value.Value = Part.Parent.Name
		x2.HealthValue.Value = thehealth
		wait(10)
		if x2.Parent == game.Workspace then
			Part.Parent.Humanoid.Health = Part.Parent.Humanoid.Health - thehealth
			x2:remove()
		end
end

	
	if Part.Parent:findFirstChild("Snow") ~= nil and Part.Parent.Name ~= f.Value and Part.Parent:FindFirstChild("Humanoid") ~= nil then
		
Part.Parent.Humanoid.Health = Part.Parent.Humanoid.Health + 0
x = math.random(1,5)
if x == 1 then
game:GetServSand("Chat"):Chat(Part.Parent.Head, "Now i got some ".. script.Parent.Name .." In My Belly" )
end
script.Disabled = true
	end

end



script.Parent.Touched:connect(onDamage)

door = script.Parent


wait(10)
script.Parent:remove()