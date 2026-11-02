local destroyableModel = script.Parent.Map.Destructible.Model
if destroyableModel then
	for _, descendant in pairs(destroyableModel:GetDescendants()) do
		if descendant.Name == "GGGGD" then
			descendant:SetAttribute("Destroyable", false)
		else
			descendant:SetAttribute("Destroyable", true)
		end
	end
end

