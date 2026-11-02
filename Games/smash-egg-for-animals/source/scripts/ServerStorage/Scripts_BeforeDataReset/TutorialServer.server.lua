-- Tutoriel des nouveaux joueurs : on retient (DataStore) qui l'a déjà terminé, pour ne jamais le montrer deux fois.
-- Le déroulé (flèches, textes) est géré côté client : StarterPlayerScripts.TutorialClient
-- Attribut du joueur "TutorialDone" : true = déjà fait (rien ne s'affiche), false = à faire.
-- Attribut du script "AlwaysShowInStudio" : mettre à true pour revoir le tutoriel à chaque test dans Studio (rien n'est enregistré). Par défaut : false.
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local completeRemote = ReplicatedStorage:WaitForChild("TutorialSystem"):WaitForChild("TutorialComplete")

if script:GetAttribute("AlwaysShowInStudio") == nil then script:SetAttribute("AlwaysShowInStudio", false) end
local studioTest = RunService:IsStudio() and script:GetAttribute("AlwaysShowInStudio") == true

local store, playerStore
pcall(function() store = DataStoreService:GetDataStore("Tutorial_v1") end)
pcall(function() playerStore = DataStoreService:GetDataStore("PlayerData_v2") end) -- sauvegarde de PetServer (lecture seule ici)

local function key(player) return "u_" .. player.UserId end

local function onPlayer(player)
	if studioTest then
		player:SetAttribute("TutorialDone", false)
		return
	end
	local done = false
	if store then
		local ok, value = pcall(function() return store:GetAsync(key(player)) end)
		if ok and value then
			done = true
		elseif not ok then
			done = true -- DataStore en panne : dans le doute on ne gêne pas le joueur
		end
	end
	-- anciens joueurs (déjà des animaux avant l'ajout du tutoriel) : on ne leur montre pas
	if not done and playerStore then
		local ok, saved = pcall(function() return playerStore:GetAsync(key(player)) end)
		if ok and type(saved) == "table" and type(saved.Pets) == "table" and #saved.Pets > 0 then
			done = true
			if store then pcall(function() store:SetAsync(key(player), true) end) end
		end
	end
	if player.Parent then player:SetAttribute("TutorialDone", done) end
end

Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do task.spawn(onPlayer, player) end

completeRemote.OnServerEvent:Connect(function(player)
	if player:GetAttribute("TutorialDone") == true then return end
	player:SetAttribute("TutorialDone", true)
	if studioTest or not store then return end
	local ok, err = pcall(function() store:SetAsync(key(player), true) end)
	if not ok then warn("[TutorialServer] sauvegarde ratée pour " .. player.Name .. " : " .. tostring(err)) end
end)
