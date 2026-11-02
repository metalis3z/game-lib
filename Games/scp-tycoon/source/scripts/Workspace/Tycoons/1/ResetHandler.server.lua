for i,v in pairs(script.Parent.Droppers:GetChildren()) do
	for i,Part in pairs(v.Parts:GetChildren()) do
		Part.Transparency = 1
		Part.CanCollide = false
	end
end
for i,v in pairs(script.Parent.Upgrades:GetChildren()) do
	for i,Part in pairs(v.Parts:GetChildren()) do
		Part.Transparency = 1
		Part.CanCollide = false
	end
	v.UpgradePart.Transparency = 1
end

for i,v in pairs(script.Parent.Walls:GetChildren()) do
	
		v.Transparency = 1
		v.CanCollide = false
end

script.Parent.Extras.DoorLazer.Btn.Transparency = 1
script.Parent.Extras.DoorLazer.Btn.CanCollide = false

for i,Stair in pairs(script.Parent.Stairs1:GetChildren()) do
	Stair.CanCollide = false
	Stair.Transparency = 1
end

for i,floor in pairs(script.Parent.Floors:GetChildren()) do
	floor.CanCollide = false
	floor.Transparency = 1
	for i,v in pairs(floor:GetChildren()) do
		if v.Name == "Texture" then
			v.Transparency = 1
		end
	end
end