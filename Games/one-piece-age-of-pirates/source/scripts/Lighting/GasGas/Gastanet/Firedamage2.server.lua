function onDamage(Part)
	f = script.Parent.Owner
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value and Part.Parent:findFirstChild("Snow") == nil then
		script.Disabled = true
		x = script.Parent
		z = x["Mesh"]
		z.MeshType = "Brick"
		x.Anchored = true
		st = math.random(1,10)
		if st == 1 then
		Part.Parent.Humanoid.Sit = false
		end
		for i = 1,10 do
			Part.Parent.Humanoid.Health = Part.Parent.Humanoid.Health - 0.01
			z.Scale = z.Scale + Vector3.new(0.1, 0.1, 0.1)
			script.Parent.PointLight.Brightness = script.Parent.PointLight.Brightness + 0.5
			script.Parent.PointLight.Range = script.Parent.PointLight.Range + 0.5
			wait(0.05)
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


wait(5)
script.Parent:remove()