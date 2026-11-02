local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(ReplicatedStorage:WaitForChild("Config"))
local DataHandler = require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")

return function(context, target)
	if not target then
		return "Joueur introuvable."
	end

	-- Creer une copie fraiche des donnees par defaut
	local freshData = table.clone(Config.DEFAULT_DATA)
	freshData.OwnedTrails = {}
	freshData.PurchaseHistory = {}
	freshData.TikfinityBinds = {}
	freshData.EventRsvpClaimed = {}
	freshData.CheatHistory = {}
	freshData.CheatHistory2 = {}

	-- Recalculer le niveau a partir de TotalXP (0 = niveau 1)
	freshData.Level = 1
	freshData.XP = 0
	freshData.StepBonus = Config.GetBestStepBonus(freshData.Wins)

	-- Appliquer les nouvelles donnees en memoire
	DataHandler.Update(target, "TotalXP", freshData.TotalXP)
	local data = DataHandler.Get(target)
	if not data then
		return "Impossible de recuperer les donnees du joueur."
	end

	-- Remplacer toutes les valeurs
	for k, v in pairs(freshData) do
		data[k] = v
	end

	-- Sauvegarder dans le DataStore
	DataHandler.SaveData(target)

	-- Mettre a jour l'UI du joueur
	UpdateUI:FireClient(target, data)

	-- Reset la vitesse du personnage si en vie
	local char = target.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = Config.CalculateMaxSpeed(data.Level, data.Multiplier)
	end

	-- Reset l'attribut de trail equipe
	if char then
		char:SetAttribute("EquippedTrail", "None")
	end

	return string.format("Stats de %s resetees avec succes. (TotalXP=0, Wins=0, Rebirths=0, Level=1)", target.Name)
end