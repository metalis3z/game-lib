local ParkSpots = workspace:WaitForChild('parkspots')

script.Parent.ChildAdded:Connect(function(Child)
	if string.find(string.lower(Child.Name), 'interface') then
		for _,v in next, ParkSpots:GetChildren() do
			if v:IsA('Part') and string.lower(v.Name) == 'parked' then
				v.Transparency = .9
			end
		end
	end
end)

script.Parent.ChildRemoved:Connect(function(Child)
	if string.find(string.lower(Child.Name), 'interface') then
		for _,v in next, ParkSpots:GetChildren() do
			if v:IsA('Part') and string.lower(v.Name) == 'parked' then
				v.Transparency = 1
			end
		end
	end
end)

for _,v in next, ParkSpots:GetChildren() do
	if v:IsA('Part') and string.lower(v.Name) == 'parked' then
		v.Transparency = 1
	end
end