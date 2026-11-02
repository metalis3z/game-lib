function onDamage(Part)
	f = script.Parent.Owner
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value and Part.Parent:findFirstChild("Snow") == nil then
		script.Disabled = true
		x2 = game.Lighting.PawPaw.FlyPaw:Clone()
		x2.Parent = game.Workspace
		x2.Anchored = false
		x2.CanCollide = false
		x2.CFrame = Part.Parent.Torso.CFrame * CFrame.new(0, 1, 0) * CFrame.Angles(0, 4.75, 0)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = Vector3.new(math.random(-20, 20), 100, math.random(-20, 20))
		y.Parent = Part.Parent.Torso
		Part.Parent.Humanoid.WalkSpeed = 0
		
		weld = Instance.new("Weld")
		weld.Part0 = x2
		weld.C0 = x2.CFrame:inverse()
		weld.Part1 = Part.Parent.Torso
		weld.C1 = Part.Parent.Torso.CFrame:inverse()
		weld.Parent = Part.Parent.Torso
		
		wait(30)
		
		y.velocity = Vector3.new(0, -100, 0)
		
		wait(28)
		
		y:remove()
		Part.Parent.Humanoid.WalkSpeed = 16
		x2:remove()
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