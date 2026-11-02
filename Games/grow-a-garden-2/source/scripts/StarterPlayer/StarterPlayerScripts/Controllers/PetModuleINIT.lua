--credit to leon games studio
return {
	Init = function(p1) --[[ Init | Line: 3 ]]
		for k, v in pairs(script.Parent.PetVisualController.ClientPetControllers:GetChildren()) do
			require(v):Init()
		end
	end
}