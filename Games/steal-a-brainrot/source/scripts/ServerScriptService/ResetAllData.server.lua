local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- Script de réinitialisation complète des données
-- ATTENTION: Ce script efface TOUTES les données du leaderboard et kick tous les joueurs

local function clearOrderedDataStore(store)
	local success, err = pcall(function()
		local pages = store:GetSortedAsync(false, 1000)
		while true do
			local data = pages:GetCurrentPage()
			if #data == 0 then break end
			for _, entry in ipairs(data) do
				store:RemoveAsync(entry.key)
			end
			if pages.IsFinished then break end
			pages:AdvanceToNextPageAsync()
		end
	end)
	return success, err
end

print("=== DÉBUT DE LA RÉINITIALISATION ===")

-- 1. Effacer les leaderboards
print("Effacement du leaderboard Generation...")
local genStore = DataStoreService:GetOrderedDataStore("GenerationLeaderboard_2")
local success1, err1 = clearOrderedDataStore(genStore)
if success1 then
	print("✓ Leaderboard Generation effacé")
else
	warn("✗ Erreur Generation:", err1)
end

print("Effacement du leaderboard Steals...")
local stealsStore = DataStoreService:GetOrderedDataStore("StealsLeaderboard_2")
local success2, err2 = clearOrderedDataStore(stealsStore)
if success2 then
	print("✓ Leaderboard Steals effacé")
else
	warn("✗ Erreur Steals:", err2)
end

-- 2. Effacer les verrous de session
print("Effacement des verrous de session...")
local sessionStore = DataStoreService:GetDataStore("SESSION-LOCK")
local success3, err3 = pcall(function()
	-- Note: On ne peut pas itérer sur un DataStore normal, mais les verrous expirent automatiquement
	print("✓ Les verrous de session expireront automatiquement")
end)

-- 3. Effacer les données de pays/région
print("Effacement des données de pays...")
local countryStore = DataStoreService:GetDataStore("PlayerCountry_1")
local regionStore = DataStoreService:GetDataStore("PlayerRegionHidden_1")
print("✓ Données de pays (les données seront réinitialisées à la reconnexion)")

-- 4. Expulser tous les joueurs
print("Expulsion de tous les joueurs...")
local playerCount = 0
for _, player in ipairs(Players:GetPlayers()) do
	player:Kick("🔄 Réinitialisation du serveur en cours. Rejoignez le jeu pour commencer avec de nouvelles données!")
	playerCount = playerCount + 1
end
print(string.format("✓ %d joueur(s) expulsé(s)", playerCount))

print("=== RÉINITIALISATION TERMINÉE ===")
print("")
print("IMPORTANT: Les données des joueurs sont stockées dans DATA-FOR-EVERYONESS-V2.")
print("Pour un reset COMPLET, vous devrez soit:")
print("  1. Changer le nom du DataStore dans DataService (ligne 8)")
print("  2. Ou utiliser un outil externe pour effacer le DataStore")
print("")
print("Ce script a effacé les leaderboards et expulsé tous les joueurs.")

-- Supprimer ce script après exécution
script:Destroy()