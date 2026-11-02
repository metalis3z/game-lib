-- Update GALACTIC, côté serveur (voir ReplicatedStorage.GalacticUpdate).
-- Au démarrage, tout ce qui appartient à la zone Galaxy est rangé dans ServerStorage.GalacticHidden, et le fond de la carte est
-- remis comme avant la zone (plateau du fond, murs invisibles du couloir et forêt de l'intro reculés de 344 studs) : on ne la voit pas.
-- Un admin clique "GALACTIC UPDATE" (onglet Galactic du panneau admin) : la zone revient, l'attribut GalacticUpdate passe à true
-- (œufs, gardien, marteaux, Index et tapis Galactic se débloquent), dans TOUS les serveurs. Ça ne marche qu'une fois :
-- l'état est gardé dans le DataStore GalacticUpdate_v1, relu au démarrage de chaque serveur.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)
local HttpService = game:GetService("HttpService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local remote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("GalacticUpdate")
local broadcastRemote = ReplicatedStorage.AdminSystem.Remotes:WaitForChild("BroadcastAnnounce") -- annonce globale (GlobalAnnounceClient)
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local ZONE = "GALACTIC galaxy egg zone"
local SHIFT = Vector3.new(510.24, 0, 0) -- de combien la zone Galaxy a repoussé le fond de la carte (482,34 de zone + 27,9 de bande, carte x0,2)
local TOPIC = "GalacticUpdate"
local SHOWCASE_LENGTH = 31 -- durée du showcase (GalacticUpdateClient) : l'annonce globale tombe à la fin
local store
pcall(function() store = DataStoreService:GetDataStore("GalacticUpdate_v1") end)

local hiddenFolder = ServerStorage:FindFirstChild("GalacticHidden") or Instance.new("Folder")
hiddenFolder.Name = "GalacticHidden"
hiddenFolder.Parent = ServerStorage

local function xOf(o)
	if o:IsA("BasePart") then return o.Position.X end
	if o:IsA("Model") then return o:GetPivot().Position.X end
	return nil
end
local function move(o, offset)
	if o:IsA("BasePart") then o.CFrame += offset elseif o:IsA("Model") then o:PivotTo(o:GetPivot() + offset) end
end

-- ce qui disparaît (la zone, son décor, ses plateaux et le séparateur qui la précède) et ce qui recule (le fond de la carte)
local hidden, shifted = {}, {}
local function hide(o) if o then table.insert(hidden, {Object = o, Parent = o.Parent}) end end
hide(workspace:FindFirstChild(ZONE))
hide(workspace:FindFirstChild("ZoneDecor") and workspace.ZoneDecor:FindFirstChild("Galaxy"))
for _, folderName in {"ZoneLedges", "ZoneSeparators"} do
	local folder = workspace:FindFirstChild(folderName)
	for _, o in folder and folder:GetChildren() or {} do
		local x = xOf(o)
		if x and x > 3629 and x < 4100 then hide(o) elseif x and x >= 4100 then table.insert(shifted, o) end -- (zone Galaxy : 3652..4135)
	end
end
local corridor = workspace:FindFirstChild("Corridor")
for _, o in corridor and corridor:GetChildren() or {} do
	if string.sub(o.Name, 1, 3) == "End" and (xOf(o) or 0) > 4100 then table.insert(shifted, o) end
end
local forest = ReplicatedStorage:FindFirstChild("IntroForest")
if forest then table.insert(shifted, forest) end

-- les mesures des zones, lues par la cinématique d'arrivée (même calcul que IntroServer)
local function publishZones()
	local system = ReplicatedStorage:FindFirstChild("IntroSystem")
	if not system then return end
	local zones = {}
	for _, p in workspace:GetChildren() do
		if p:IsA("BasePart") and p.Name:lower():find("egg zone") then table.insert(zones, p) end
	end
	table.sort(zones, function(a, b) return a.Position.X < b.Position.X end)
	local list = {}
	for _, p in zones do
		table.insert(list, {X = p.Position.X, Z = p.Position.Z, Top = p.Position.Y + p.Size.Y / 2, SizeX = p.Size.X, SizeZ = p.Size.Z, Color = p.Color:ToHex()})
	end
	system:SetAttribute("Zones", HttpService:JSONEncode(list))
end

local released = ReplicatedStorage:GetAttribute("GalacticUpdate") == true -- (2026-10-24 : la zone Galactic est là de base)
if not ReplicatedStorage:GetAttribute("GalacticUpdate") then
	for _, entry in hidden do entry.Object.Parent = hiddenFolder end
	for _, o in shifted do move(o, -SHIFT) end
	ReplicatedStorage:SetAttribute("GalacticUpdate", false)
	publishZones()
	task.delay(2, function() if not released then publishZones() end end) -- (IntroServer publie aussi au démarrage)
end

-- at = heure (os.time) du clic : les joueurs déjà là voient l'annonce globale puis le showcase (GalacticUpdateClient).
-- byName / byId : l'admin qui a cliqué (affiché dans l'annonce).
local function release(at, byName, byId)
	if released then return end
	released = true
	for _, o in shifted do move(o, SHIFT) end
	for _, entry in hidden do entry.Object.Parent = entry.Parent end
	-- copie du tapis Galactic pour le showcase : chaque joueur en pose une chez lui le temps de la cinématique, puis elle disparaît
	local templates = ServerStorage:FindFirstChild("TreadmillModels")
	local showcase = templates and templates:FindFirstChild("Galactic")
	if showcase and not ReplicatedStorage:FindFirstChild("GalacticShowcaseTreadmill") then
		local copy = showcase:Clone()
		copy.Name = "GalacticShowcaseTreadmill"
		copy.Parent = ReplicatedStorage
	end
	if at then
		ReplicatedStorage:SetAttribute("GalacticUpdateAt", at)
		-- l'annonce globale arrive à la fin du showcase (la cinématique part tout de suite, GalacticUpdateClient)
		task.delay(SHOWCASE_LENGTH, function()
			broadcastRemote:FireAllClients(byName or "Galactic Update", "THE GALACTIC UPDATE IS OUT! New Galaxy Zone, new hammers & a new treadmill. Enjoy!", byId or 0)
		end)
	end
	ReplicatedStorage:SetAttribute("GalacticUpdate", true)
	publishZones()
	print("[GalacticUpdateServer] GALACTIC UPDATE released")
end

-- déjà sortie (un autre serveur, ou avant) : on la montre tout de suite
task.spawn(function()
	if not store then return end
	for _ = 1, 3 do
		local ok, value = pcall(function() return store:GetAsync("Released") end)
		if ok then
			if value then release(nil) end
			return
		end
		task.wait(5)
	end
end)
task.spawn(function()
	pcall(function()
		MessagingService:SubscribeAsync(TOPIC, function(message)
			local data = message.Data
			if type(data) == "table" then release(tonumber(data.at) or os.time(), data.name, tonumber(data.id)) else release(os.time()) end
		end)
	end)
end)

local function isAdmin(player)
	return player:GetAttribute("IsAdmin") == true or table.find(AdminConfig.AdminIds, player.UserId) ~= nil
end
local busy = false
remote.OnServerEvent:Connect(function(player)
	if not isAdmin(player) then return end
	if released then
		notifyRemote:FireClient(player, "The Galactic Update is already out!")
		return
	end
	if busy then return end
	busy = true
	local at = os.time()
	local saved = false
	if store then
		saved = pcall(function() store:UpdateAsync("Released", function() return at end) end)
	end
	pcall(function() MessagingService:PublishAsync(TOPIC, {at = at, name = player.DisplayName, id = player.UserId}) end)
	release(at, player.DisplayName, player.UserId)
	busy = false
	notifyRemote:FireClient(player, saved and "GALACTIC UPDATE released on every server!" or "GALACTIC UPDATE released (this server only: DataStore unavailable)")
end)
