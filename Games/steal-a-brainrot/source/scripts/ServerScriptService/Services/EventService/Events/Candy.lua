local Candy = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Sécurité : s'assurer que l'event est bien désactivé au chargement du module
ReplicatedStorage:SetAttribute("CandyEvent", nil)

function Candy.OnStart()
	ReplicatedStorage:SetAttribute("CandyEvent", true)
end

function Candy.OnStop()
	-- On remet uniquement à nil (false est inutile car AnimalService vérifie == true)
	ReplicatedStorage:SetAttribute("CandyEvent", nil)
end

return Candy