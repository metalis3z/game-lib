function onDamage(Part)
	if Part.Parent:FindFirstChild("Humanoid") ~= nil then
		script.Disabled = true
		x = script.Parent
		x:remove()
		boom = Instance.new("Explosion")
		boom.Parent = game.Workspace
		boom.BlastRadius = math.huge
		boom.BlastPressure = 0
		boom.Position = x.Position
		for i = 1, 10 do
			Part.Parent.Humanoid.Health = Part.Parent.Humanoid.Health - math.random(5, 10)
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