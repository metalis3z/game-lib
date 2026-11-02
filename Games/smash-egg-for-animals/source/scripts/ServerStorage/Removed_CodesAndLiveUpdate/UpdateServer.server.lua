-- UpdateServer : commande admin "Live Update" (panneau F2, onglet Update) : met à jour les builds ET les scripts
-- dans TOUS les serveurs en direct, SANS redémarrage et sans que les joueurs changent de serveur.
--
-- Comment ça marche :
--   * Dans Studio, tu mets ce que tu veux mettre à jour dans ServerStorage.LiveUpdate, dans le dossier du service visé :
--       Workspace, ReplicatedStorage, ServerStorage, Lighting, ServerScriptService, StarterGui, StarterPlayerScripts
--     Chaque objet REMPLACE l'objet du même nom dans ce service (ou est ajouté s'il n'existe pas).
--     Attribut "Path" (texte) sur un objet pour viser un dossier précis, ex : "Workspace.MapDecor".
--     Dossier "Remove" : des StringValue dont la valeur est le chemin d'un objet à supprimer, ex : "Workspace.VieuxBuild".
--   * Clic droit sur ServerStorage.LiveUpdate > "Save to Roblox" (la 1re fois : nouveau modèle, ensuite : écraser le même).
--   * Dans le jeu : F2 > Update > colle l'ID du modèle > "Push Live Update". Chaque serveur charge la dernière version
--     du modèle (InsertService) et l'applique tout de suite.
-- Les scripts remplacés s'arrêtent et la nouvelle version démarre ; les LocalScripts des joueurs déjà connectés sont
-- remplacés aussi (StarterPlayerScripts et StarterGui).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local MessagingService = game:GetService("MessagingService")
local InsertService = game:GetService("InsertService")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")

local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local postRemote = remotes:WaitForChild("PostUpdate")
local appliedRemote = remotes:WaitForChild("LiveUpdateApplied")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))

local TOPIC = "AdminLiveUpdate"
local store
pcall(function() store = DataStoreService:GetDataStore("LiveUpdate_v1") end)

-- dossier où le client récupère ses nouveaux LocalScripts
local clientFolder = ReplicatedStorage:FindFirstChild("LiveUpdateClient") or Instance.new("Folder")
clientFolder.Name = "LiveUpdateClient"
clientFolder.Parent = ReplicatedStorage

-- dernier ID utilisé (pré-rempli dans le panneau admin)
task.spawn(function()
	if not store then return end
	local ok, id = pcall(function() return store:GetAsync("assetId") end)
	if ok and tonumber(id) then ReplicatedStorage:SetAttribute("LiveUpdateAssetId", tonumber(id)) end
end)

local function isAdmin(player)
	return table.find(AdminConfig.AdminIds, player.UserId) ~= nil
end

-- "Workspace.MapDecor" -> l'objet
local function resolve(path)
	if type(path) ~= "string" or path == "" then return nil end
	local current = game
	for name in string.gmatch(path, "[^%.]+") do
		local nextObj = current == game and (game:FindFirstChild(name) or select(2, pcall(game.GetService, game, name))) or current:FindFirstChild(name)
		if typeof(nextObj) ~= "Instance" then return nil end
		current = nextObj
	end
	return current
end

local function replaceIn(parent, item)
	local old = parent:FindFirstChild(item.Name)
	if old then old:Destroy() end
	local copy = item:Clone()
	copy.Parent = parent
	return copy
end

local ORDER = {
	{Folder = "ReplicatedStorage", Target = ReplicatedStorage},
	{Folder = "ServerStorage", Target = ServerStorage},
	{Folder = "Lighting", Target = game:GetService("Lighting")},
	{Folder = "Workspace", Target = workspace},
}

local function apply(root)
	local count = 0
	-- suppressions
	local remove = root:FindFirstChild("Remove")
	for _, v in remove and remove:GetChildren() or {} do
		if v:IsA("StringValue") then
			local target = resolve(v.Value)
			if target and target ~= game and target.Parent ~= game then target:Destroy() count += 1 end
		end
	end
	-- contenu (avant les scripts, pour qu'ils trouvent ce dont ils ont besoin)
	for _, entry in ORDER do
		local folder = root:FindFirstChild(entry.Folder)
		for _, item in folder and folder:GetChildren() or {} do
			replaceIn(resolve(item:GetAttribute("Path")) or entry.Target, item)
			count += 1
		end
	end
	-- interface : pour les prochains joueurs + tout de suite pour les joueurs connectés
	local guiFolder = root:FindFirstChild("StarterGui")
	for _, item in guiFolder and guiFolder:GetChildren() or {} do
		replaceIn(game:GetService("StarterGui"), item)
		for _, player in Players:GetPlayers() do
			local pg = player:FindFirstChild("PlayerGui")
			if pg then replaceIn(pg, item) end
		end
		count += 1
	end
	-- scripts des joueurs : pour les prochains joueurs + envoyés aux joueurs connectés (UpdateClient les remplace)
	local psFolder = root:FindFirstChild("StarterPlayerScripts")
	local clientNames = {}
	for _, item in psFolder and psFolder:GetChildren() or {} do
		replaceIn(StarterPlayer.StarterPlayerScripts, item)
		replaceIn(clientFolder, item)
		table.insert(clientNames, item.Name)
		count += 1
	end
	-- scripts serveur en dernier : l'ancienne version s'arrête, la nouvelle démarre
	local sssFolder = root:FindFirstChild("ServerScriptService")
	for _, item in sssFolder and sssFolder:GetChildren() or {} do
		if item.Name ~= script.Name then -- ce script-ci ne se remplace pas lui-même
			replaceIn(resolve(item:GetAttribute("Path")) or game:GetService("ServerScriptService"), item)
			count += 1
		end
	end
	return count, clientNames
end

local busy = false
local function liveUpdate(assetId, adminPlayer)
	if busy then return end
	busy = true
	local root, err
	if RunService:IsStudio() and (tonumber(assetId) or 0) == 0 then
		-- test dans Studio sans ID : on applique directement ServerStorage.LiveUpdate
		root = ServerStorage:FindFirstChild("LiveUpdate")
		root = root and root:Clone()
	else
		local ok, result = pcall(function()
			local version = InsertService:GetLatestAssetVersionAsync(assetId)
			return InsertService:LoadAssetVersion(version)
		end)
		if ok then
			root = result:FindFirstChild("LiveUpdate") or result
		else
			err = tostring(result)
		end
	end
	if not root then
		warn("[UpdateServer] impossible de charger la mise à jour : " .. tostring(err))
		if adminPlayer then notifyRemote:FireClient(adminPlayer, "Live update failed: " .. tostring(err)) end
		busy = false
		return
	end
	local ok, count, clientNames = pcall(apply, root)
	root:Destroy()
	if not ok then
		warn("[UpdateServer] erreur pendant la mise à jour : " .. tostring(count))
		if adminPlayer then notifyRemote:FireClient(adminPlayer, "Live update error: " .. tostring(count)) end
	else
		print("[UpdateServer] mise à jour en direct appliquée : " .. count .. " objet(s)")
		appliedRemote:FireAllClients(clientNames, count)
		if adminPlayer then notifyRemote:FireClient(adminPlayer, "Live update applied on this server (" .. count .. " objects)") end
	end
	busy = false
end

postRemote.OnServerEvent:Connect(function(player, assetId)
	if not isAdmin(player) then return end
	assetId = math.floor(tonumber(assetId) or 0)
	if assetId < 0 then return end
	if assetId > 0 then
		ReplicatedStorage:SetAttribute("LiveUpdateAssetId", assetId)
		if store then task.spawn(pcall, function() store:SetAsync("assetId", assetId) end) end
	end
	pcall(function() MessagingService:PublishAsync(TOPIC, {AssetId = assetId, JobId = game.JobId}) end)
	task.spawn(liveUpdate, assetId, player)
end)

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) ~= "table" or data.JobId == game.JobId then return end
		task.spawn(liveUpdate, data.AssetId)
	end)
end)
