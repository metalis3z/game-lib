-- zBug3 Fix: Cache l'animal volé pour tous les joueurs SAUF le voleur
-- Le serveur fire ce RemoteEvent uniquement vers les autres joueurs

local Net = require(game:GetService("ReplicatedStorage").Packages.Net)
local HideAnimalEvent = Net:RemoteEvent("StealService/HideAnimalForOthers")

HideAnimalEvent.OnClientEvent:Connect(function(animalModel: Model)
	if not animalModel or not animalModel.Parent then return end

	-- Cacher le modèle pour ce client (il n'est pas le voleur)
	for _, part in ipairs(animalModel:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = 1
		end
	end

	-- Si le modèle est retiré (vol annulé/complété), rien à faire (il est destroy côté serveur)
end)
