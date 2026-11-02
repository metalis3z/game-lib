-- Fuse Machine : le joueur met 3 fois le MÊME animal de son inventaire dans la machine ; il reçoit tout de suite un œuf
-- fusionné de cet animal (poids = somme des trois). Posé dans le jardin, l'œuf éclot après 1 h (FuseConfig.EggHatchTime).
-- (les anciennes fusions avec timer dans la machine, déjà sauvegardées, se récupèrent toujours avec Claim)
-- La fusion en cours est sauvegardée avec le joueur (PetServer : d.Fuse), le timer continue même déconnecté.
-- Commande admin GLOBALSKIPFUSE : toutes les fusions lancées avant la commande sont terminées, dans TOUS les serveurs
-- (et aussi pour les joueurs hors ligne : l'heure de la commande est gardée dans un DataStore).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)
local DataStoreService = game:GetService("DataStoreService")

local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local fuseSystem = ReplicatedStorage:WaitForChild("FuseSystem")
local FuseConfig = require(fuseSystem:WaitForChild("FuseConfig"))
local remotes = fuseSystem:WaitForChild("Remotes")
local notifyRemote = ReplicatedStorage.EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local skipRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("GlobalSkipFuse")
local bridge = script.Parent:WaitForChild("TradeBridge") -- PetServer : retirer / donner des pets, lire / écrire la fusion

local SKIP_TOPIC = "AdminGlobalSkipFuse"
local SKIP_KEY = "SkipBefore"

local function notify(player, text) notifyRemote:FireClient(player, text) end

---------------------------------------------------------------- skip global (GLOBALSKIPFUSE)
local skipBefore = 0 -- toute fusion commencée à cette heure-là ou avant est terminée
local store
pcall(function() store = DataStoreService:GetDataStore("FuseGlobal_v1") end)
local function readSkip()
	if not store then return end
	local ok, value = pcall(function() return store:GetAsync(SKIP_KEY) end)
	if ok and tonumber(value) then skipBefore = math.max(skipBefore, tonumber(value)) end
end

local function isReady(fuse)
	return os.time() >= (tonumber(fuse.Ends) or 0) or (tonumber(fuse.Start) or math.huge) <= skipBefore
end

---------------------------------------------------------------- état envoyé à l'interface
local function stateOf(player)
	local fuse = bridge:Invoke("GetFuse", player)
	if type(fuse) ~= "table" then return {Active = false} end
	return {Active = true, Pets = fuse.Pets, Result = fuse.Result, Start = fuse.Start, Ends = fuse.Ends, Ready = isReady(fuse)}
end
local function push(player)
	if player.Parent then remotes.State:FireClient(player, stateOf(player)) end
end

-- la machine (pour l'invite et la vérification de distance)
local machine = workspace:WaitForChild("Fuse Machine", 30)
local promptPart
if machine then
	promptPart = machine:FindFirstChild("FusePrompt")
	if not promptPart then
		-- devant la machine (elle regarde vers -X), à hauteur de joueur, entre la console et le réservoir
		local cf, size = machine:GetBoundingBox()
		promptPart = Instance.new("Part")
		promptPart.Name = "FusePrompt"
		promptPart.Size = Vector3.new(1, 1, 1)
		promptPart.Transparency = 1
		promptPart.Anchored, promptPart.CanCollide, promptPart.CanQuery, promptPart.CanTouch = true, false, false, false
		promptPart.CFrame = CFrame.new(cf.Position.X - size.X / 2 + 3, cf.Position.Y - size.Y / 2 + 3.5, cf.Position.Z)
		promptPart.Parent = machine
	end
	local prompt = promptPart:FindFirstChildOfClass("ProximityPrompt") or Instance.new("ProximityPrompt")
	prompt.Name = "FusePrompt"
	prompt.ActionText = "Open"
	prompt.ObjectText = "Fuse Machine"
	prompt.HoldDuration = 0
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.MaxActivationDistance = FuseConfig.PromptDistance
	prompt.RequiresLineOfSight = false
	prompt.Parent = promptPart
	prompt.Triggered:Connect(function(player)
		remotes.Open:FireClient(player, stateOf(player))
	end)
else
	warn("[FuseServer] modèle \"Fuse Machine\" introuvable dans le Workspace")
end

local function nearMachine(player)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return false end
	if promptPart and (root.Position - promptPart.Position).Magnitude <= FuseConfig.CloseDistance + 8 then return true end
	-- Fuse Machine 2 : la fenêtre s'ouvre en marchant sur son cercle magique (FuseClient)
	local machine2 = workspace:FindFirstChild("Fuse Machine 2")
	local circle = machine2 and machine2:FindFirstChild("MagicCircle", true)
	return circle ~= nil and (root.Position - circle:GetPivot().Position).Magnitude <= 20
end

---------------------------------------------------------------- actions : State, Start (3 ids), Claim
local function handle(player, action, ids)
	if action == "State" then return true, stateOf(player) end
	if not bridge:Invoke("Loaded", player) then return false, "Your data is still loading, try again in a moment." end
	if not nearMachine(player) then return false, "Go to the Fuse Machine!" end

	if action == "Start" then
		if type(ids) ~= "table" or #ids ~= FuseConfig.Slots then return false, "Put " .. FuseConfig.Slots .. " pets in the machine!" end
		local seen, clean = {}, {}
		for _, id in ids do
			if type(id) ~= "number" or seen[id] then return false, "Choose " .. FuseConfig.Slots .. " different pets!" end
			seen[id] = true
			table.insert(clean, id)
		end
		if type(bridge:Invoke("GetFuse", player)) == "table" then return false, "Claim your old fusion first!" end
		-- les 3 pets doivent être le même animal
		local species = bridge:Invoke("PetSpecies", player, clean)
		if type(species) ~= "table" or #species ~= FuseConfig.Slots then return false, "One of these pets is not available (placed in your garden?)." end
		for _, name in species do
			if name ~= species[1] then return false, "Put 3 times the SAME animal in the machine!" end
		end
		if not bridge:Invoke("EggSpace", player) then return false, "Your egg inventory is full! Place or hatch some eggs first." end
		local records, err = bridge:Invoke("Take", player, clean) -- retire les 3 pets de l'inventaire (refusé si l'un est posé dans le jardin)
		if type(records) ~= "table" or #records ~= FuseConfig.Slots then
			if type(records) == "table" and #records > 0 then bridge:Invoke("Give", player, records) end -- par sécurité : on rend ce qui a été pris
			return false, err or "One of these pets is not available (placed in your garden?)."
		end
		local result = FuseConfig.Result(records, Config)
		-- pas de chance : le pet sort NORMAL, sans aucune modification (poids normal de l'animal, ni mutation, ni trait, ni niveau)
		-- (tiré ici, côté serveur seulement)
		local unlucky = result ~= nil and math.random() < (FuseConfig.BadLuckChance or 0)
		if unlucky then
			local base = Config.Pets[result.Pet]
			result.Kg = base and base.Kg or result.Kg
			result.Mutation, result.Trait, result.Level, result.Xp = nil, nil, nil, nil
		end
		if not result or not bridge:Invoke("GiveFusedEgg", player, result) then
			bridge:Invoke("Give", player, records) -- l'œuf n'a pas pu être donné : on rend les pets
			return false, "Something went wrong, your pets are back in your inventory."
		end
		task.spawn(function() bridge:Invoke("Save", player) end) -- sauvegardé tout de suite : rien ne peut être perdu
		local info = Config.Pets[result.Pet]
		if unlucky then
			notify(player, "Bad luck! The fusion failed... Your pet came out normal: Fused " .. (info and info.Name or "pet") .. " Egg (" .. Config.FormatKg(result.Kg) .. ").")
		else
			notify(player, "You got a Fused " .. (info and info.Name or "pet") .. " Egg (" .. Config.FormatKg(result.Kg) .. ")! Place it in your garden: it hatches after 1 hour.")
		end
		return true, stateOf(player), result
	end

	if action == "Claim" then
		local fuse = bridge:Invoke("GetFuse", player)
		if type(fuse) ~= "table" then return false, "Nothing to claim." end
		if not isReady(fuse) then return false, "The fusion is not finished yet!" end
		local count, max = bridge:Invoke("Count", player)
		if count and max and count >= max then return false, "Inventory full! Make some room first." end
		bridge:Invoke("SetFuse", player, nil)
		bridge:Invoke("Give", player, {fuse.Result})
		task.spawn(function() bridge:Invoke("Save", player) end)
		local info = Config.Pets[fuse.Result.Pet]
		notify(player, (info and info.Name or "Pet") .. " (" .. Config.FormatKg(fuse.Result.Kg) .. ") claimed! It's in your inventory.")
		return true, stateOf(player), fuse.Result
	end
	return false, "Unknown action."
end

local busy = {}
remotes.Action.OnServerInvoke = function(player, action, ids)
	if busy[player] then return false, "Please wait..." end
	busy[player] = true
	local ok, a, b, c = pcall(handle, player, action, ids)
	busy[player] = nil
	if not ok then
		warn("[FuseServer] " .. tostring(a))
		return false, "Something went wrong, try again."
	end
	return a, b, c
end

---------------------------------------------------------------- GLOBALSKIPFUSE
local function applySkip(time)
	time = tonumber(time)
	if not time then return end
	skipBefore = math.max(skipBefore, time)
	for _, player in Players:GetPlayers() do
		task.spawn(function()
			local fuse = bridge:Invoke("GetFuse", player)
			if type(fuse) == "table" then notify(player, "An admin skipped the Fuse timer! Your fused pet is ready to claim at the Fuse Machine!") end
			push(player)
		end)
	end
end

pcall(function()
	MessagingService:SubscribeAsync(SKIP_TOPIC, function(message)
		local data = message.Data
		applySkip(type(data) == "table" and data.time)
	end)
end)

local lastSkip = 0
skipRemote.OnServerEvent:Connect(function(player)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if os.clock() - lastSkip < 3 then return end
	lastSkip = os.clock()
	local now = os.time()
	-- gardé dans un DataStore : les joueurs hors ligne et les serveurs qui ouvrent plus tard en profitent aussi
	if store then
		pcall(function()
			store:UpdateAsync(SKIP_KEY, function(old) return math.max(tonumber(old) or 0, now) end)
		end)
	end
	applySkip(now)
	local ok = pcall(function() MessagingService:PublishAsync(SKIP_TOPIC, {time = now}) end)
	notify(player, ok and "GLOBALSKIPFUSE: every fusion is now ready to claim on ALL servers!" or "GLOBALSKIPFUSE: done on this server (MessagingService unavailable, other servers get it within a minute).")
end)

-- relecture régulière (au cas où un message serait perdu) et prévenir quand une fusion se termine
local announced = {} -- [player] = Start de la fusion déjà annoncée comme prête
task.spawn(function()
	readSkip()
	local lastRead = os.clock()
	while true do
		task.wait(5)
		if os.clock() - lastRead > 60 then
			lastRead = os.clock()
			readSkip()
		end
		for _, player in Players:GetPlayers() do
			local fuse = bridge:Invoke("GetFuse", player)
			if type(fuse) == "table" and isReady(fuse) and announced[player] ~= fuse.Start then
				announced[player] = fuse.Start
				notify(player, "Your fusion is finished! Claim your pet at the Fuse Machine.")
				push(player)
			end
		end
	end
end)
Players.PlayerRemoving:Connect(function(player) announced[player] = nil busy[player] = nil end)
