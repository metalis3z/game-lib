local all,last = {}
function scan(p)
	for _,v in pairs(p:GetChildren()) do
		if (v:IsA("BasePart")) then
			if (last) then
				local w = Instance.new("Weld")
				w.Part0,w.Part1 = last,v
				w.C0 = v.CFrame:toObjectSpace(last.CFrame):inverse()
				w.Parent = last
			end
			table.insert(all,v)
			last = v
		end
		scan(v)
	end
end
scan(script.Parent)
for _,v in pairs(all) do v.Anchored = false end 