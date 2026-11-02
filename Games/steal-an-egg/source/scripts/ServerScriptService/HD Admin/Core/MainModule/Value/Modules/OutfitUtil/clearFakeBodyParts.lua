return function (character)
	if not character then return end
	for _, descendant in character:GetDescendants() do
		if descendant:IsA("BasePart") then
			if string.sub(descendant.Name, 1, 4) == "Fake" then
				descendant:SetAttribute("DisableMorphPart", true)
				descendant:Destroy()
			elseif descendant.Name ~= "HumanoidRootPart" then
				descendant.Transparency = 0
			end
		end
	end
end