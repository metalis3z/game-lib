wait(3)

function onDamage(Part)
	f = script.Parent.Value
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value and Part.Parent:findFirstChild("Snow") == nil then
		script.Disabled = true
		x = script.Parent
		Part.Parent.Humanoid.Health = Part.Parent.Humanoid.Health - script.Parent.HealthValue.Value
		wait(0.5)
		script.Parent:remove()
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