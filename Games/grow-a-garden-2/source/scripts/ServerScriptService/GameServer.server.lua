--credit to leon games studio
--[[
	GameServer
	Reconstrucción del lado servidor de gameplay:

	1. ReplicaServer mínimo — compatible con ReplicatedStorage.ClientModules.ReplicaClient
	2. Persistencia con ProfileStore (ServerPackages.ProfileStore del usuario)
	3. Réplica "PlayerState" por jugador + leaderstats
	4. Plots: asignación, spawn, IsInOwnGarden, expansión (ExpandGarden)
	5. Handlers de Networking (Packet) usados al arrancar
	6. ABTests/FastFlags: desbloqueo de los clientes (sin servidor original)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local STARTING_SHECKLES = 60000 -- MODDED: arranque con 60k sheckles
local STARTING_FAKE_ROBUX = 847823 -- MODDED: saldo inicial de la moneda interna "Fake Robux"
local STARTERPACK_DURATION = 3 * 86400 -- 3 días de oferta del Starter Pack

----------------------------------------------------------------------
-- 1) ReplicaServer mínimo
----------------------------------------------------------------------
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local ReplicaRequestData = RemoteEvents:WaitForChild("ReplicaRequestData")
local ReplicaSet = RemoteEvents:WaitForChild("ReplicaSet")
local ReplicaCreate = RemoteEvents:WaitForChild("ReplicaCreate")
local ReplicaDestroy = RemoteEvents:WaitForChild("ReplicaDestroy")
local ReplicaSignal = RemoteEvents:WaitForChild("ReplicaSignal")
local ReplicaSignalUnreliable = RemoteEvents:WaitForChild("ReplicaSignalUnreliable")

local nextReplicaId = 1
local replicas = {}
local readyPlayers = {}

local Replica = {}
Replica.__index = Replica

local function creationPacket(replica)
	return { [tostring(replica.Id)] = { replica.Token, replica.Tags, replica.Data, 0 } }
end

local function newReplica(token: string, tags, data)
	local self = setmetatable({
		Id = nextReplicaId,
		Token = token,
		Tags = tags or {},
		Data = data or {},
	}, Replica)
	nextReplicaId += 1
	replicas[self.Id] = self
	for player in readyPlayers do
		ReplicaCreate:FireClient(player, creationPacket(self), self.Id)
	end
	return self
end

function Replica:Set(path: { string }, value)
	local node = self.Data
	for i = 1, #path - 1 do
		node = node[path[i]]
	end
	node[path[#path]] = value
	for player in readyPlayers do
		ReplicaSet:FireClient(player, self.Id, path, value)
	end
end

function Replica:Destroy()
	replicas[self.Id] = nil
	for player in readyPlayers do
		ReplicaDestroy:FireClient(player, self.Id)
	end
end

ReplicaRequestData.OnServerEvent:Connect(function(player)
	if not readyPlayers[player] then
		readyPlayers[player] = true
		for _, replica in replicas do
			ReplicaCreate:FireClient(player, creationPacket(replica), replica.Id)
		end
	end
	ReplicaRequestData:FireClient(player)
end)

ReplicaSignal.OnServerEvent:Connect(function() end)
ReplicaSignalUnreliable.OnServerEvent:Connect(function() end)

----------------------------------------------------------------------
-- 2) ProfileStore (persistencia)
----------------------------------------------------------------------
local ProfileStore = require(script.Parent.ServerPackages.ProfileStore)

local PROFILE_TEMPLATE = {
	Sheckles = STARTING_SHECKLES,
	FakeRobux = STARTING_FAKE_ROBUX, -- MODDED: moneda interna para comprar gamepasses/devproducts
	OwnedExpansions = 0,
	Pets = {}, -- [petName] = count
	HugePets = {}, -- MODDED: [petName] = cuántas de esa pet son Huge (persiste el tamaño)
	Plants = {}, -- [plantId] = plantData (sin frutas)
	LastLogout = 0, -- epoch del ultimo cierre de sesion (cutscene offline)
	EquippedPets = {}, -- lista de nombres de pets equipadas (re-equipar al volver)
	MaxEquippedPets = 3, -- slots de pets activas comprados (PetSlotPrices.BaseMax)
	Gears = {}, -- [gearName] = cantidad (gear apilable de la GearShop)
	OwnedEquippableGears = {}, -- [gearName] = true (Sign/Lantern/Wheelbarrow comprados)
	EquippedGear = false, -- nombre del equipable puesto (re-equipar al volver)
	SignText = "", -- texto del cartel (Sign) del jugador
	OwnedFenceSkins = "", -- CSV de skins de cerca poseídas; la equipada lleva "+"
	OwnedGamepasses = "", -- CSV de nombres de gamepass poseídos (RobuxShop)
	OwnsAdminPanel = false, -- MODDED: admin panel PERMANENTE comprado (RobuxShop Set4)
	SheckleMultiplier = 1, -- MODDED: multiplicador de sheckles (P2W x2/x4/...)
	StarterPackExpiresAt = 0, -- epoch fin de la oferta del Starter Pack (0 = sin setear)
	StarterPackBought = false, -- compra única del Starter Pack
	TutorialCompleted = false, -- MODDED: el tutorial ya se corrió una vez (no repetir)
	FavoritedGame = false, -- MODDED: el jugador ya marcó "favorito" en el popup social
}

local PlayerStore = ProfileStore.New("PlayerData_v1", PROFILE_TEMPLATE)

-- En Studio sin acceso a DataStores, usar el Mock (sesión en memoria)
do
	local ok = pcall(function()
		game:GetService("DataStoreService"):GetDataStore("__probe__"):GetAsync("__probe__")
	end)
	if not ok then
		warn("[GameServer] DataStores no disponibles — usando ProfileStore.Mock (sin guardado real)")
		PlayerStore = PlayerStore.Mock
	end
end

local profilesByPlayer: { [Player]: any } = {}

----------------------------------------------------------------------
-- 3-4) PlayerState + leaderstats + plots
----------------------------------------------------------------------
local Gardens = workspace:WaitForChild("Gardens")
local ExpansionPrices = require(ReplicatedStorage.SharedData.ExpansionPrices)
local PetData = require(ReplicatedStorage.SharedData.PetData)
local HttpService = game:GetService("HttpService")

-- Expansion del jardin por nivel. Deltas medidos comparando el plot base (Plot6)
-- con el plot expandido a mano (Workspace.Plot = base +1 nivel):
--   PlotSizeReference      : Z +17/nivel (el controller genera beds/cercas de aca)
--   PlantAreaColumn1/2      : Z +17/nivel (zonas plantables, tag PlantArea)
--   GardenTotalArea         : Z +18/nivel (validacion de plantado en el server)
--   PlotSizeReferenceVisual : Z +18/nivel (marcador visual)
-- CLAVE: el jardin NO crece simetrico. La cara FRONTAL (por donde entra el
-- jugador) queda FIJA y se extiende hacia ATRAS. Verificado: el centro del
-- PlotSizeReference se movio 8.5 studs (= grow/2) entre Plot6 y el plot a mano,
-- dejando la cara frontal en el mismo punto. Por eso, ademas del Size, corremos
-- el CFrame -grow/2 sobre el eje Z local. Todas las partes comparten la
-- orientacion del plot, asi que el mismo corrimiento sirve para todas.
local function expandPart(part, stepZ, level)
	if not (part and part:IsA("BasePart")) then
		return
	end
	-- Capturar la base una sola vez (los plots arrancan en nivel 0 en el Studio).
	-- Asi el calculo es absoluto y no se acumula al re-aplicar.
	if part:GetAttribute("ExpBaseSizeZ") == nil then
		part:SetAttribute("ExpBaseSizeZ", part.Size.Z)
		part:SetAttribute("ExpBaseCFrame", part.CFrame)
	end
	local baseZ = part:GetAttribute("ExpBaseSizeZ")
	local baseCF = part:GetAttribute("ExpBaseCFrame")
	local grow = stepZ * (level or 0)
	part.Size = Vector3.new(part.Size.X, part.Size.Y, baseZ + grow)
	part.CFrame = baseCF * CFrame.new(0, 0, -grow / 2)
end
local function applyExpansionSize(plot, level)
	level = level or 0
	if not plot then
		return
	end
	expandPart(plot:FindFirstChild("PlotSizeReference"), 17, level)
	local visual = plot:FindFirstChild("Visual")
	if visual then
		expandPart(visual:FindFirstChild("PlantAreaColumn1"), 17, level)
		expandPart(visual:FindFirstChild("PlantAreaColumn2"), 17, level)
		expandPart(visual:FindFirstChild("GardenTotalArea"), 18, level)
		expandPart(visual:FindFirstChild("PlotSizeReferenceVisual"), 18, level)
	end
end
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local ABTestsUpdate = ReplicatedStorage.UserGenerated.ABTests.SharedABTests:WaitForChild("Update")

-- arranca el ServerFastFlags reconstruido (manda "flags cargados" a los clientes)
require(script.Parent.UserGenerated.Server.ServerFastFlags)

local stateByPlayer: { [Player]: any } = {}

----------------------------------------------------------------------
-- Skins de cerca (FenceThemes). El cliente (GardenVisualController) lee el atributo
-- "FenceSkin" del Plot y reemplaza FencePole/FenceConnectors con FenceThemes[skin].
-- La UI (CustomiseFenceTheme) lista las skins, marca las poseídas/equipada desde la
-- réplica Data.OwnedFenceSkins (CSV; la equipada lleva sufijo "+") y dispara
-- Actions.ChangeFenceTheme(name). Sin sistema de crates aquí, el jugador posee TODAS.
----------------------------------------------------------------------
local FenceThemesFolder = ReplicatedStorage.Assets.PlotAssets:FindFirstChild("FenceThemes")
local function defaultOwnedFenceSkins(): string
	local names = {}
	if FenceThemesFolder then
		for _, theme in FenceThemesFolder:GetChildren() do
			table.insert(names, theme.Name == "Default" and "Default+" or theme.Name)
		end
	end
	if not table.find(names, "Default+") then
		table.insert(names, 1, "Default+")
	end
	return table.concat(names, ",")
end
local function eachFenceEntry(csv: string)
	return tostring(csv):gmatch("[^,]+")
end
local function stripPlus(s: string): string
	s = s:match("^%s*(.-)%s*$") or s
	if s:sub(-1) == "+" then
		s = s:sub(1, -2)
	end
	return s
end
local function fenceOwns(csv: string, skin: string): boolean
	for entry in eachFenceEntry(csv) do
		if stripPlus(entry) == skin then
			return true
		end
	end
	return false
end
local function fenceEquipped(csv: string): string
	for entry in eachFenceEntry(csv) do
		local e = entry:match("^%s*(.-)%s*$") or entry
		if e:sub(-1) == "+" then
			return e:sub(1, -2)
		end
	end
	return "Default"
end
local function fenceSetEquipped(csv: string, skin: string): string
	local out, found = {}, false
	for entry in eachFenceEntry(csv) do
		local e = stripPlus(entry)
		if e ~= "" then
			if e == skin then
				e = e .. "+"
				found = true
			end
			table.insert(out, e)
		end
	end
	if not found then
		table.insert(out, skin .. "+")
	end
	return table.concat(out, ",")
end

local function findFreePlot()
	local list = Gardens:GetChildren()
	table.sort(list, function(a, b)
		return (tonumber(a.Name:match("%d+")) or 0) < (tonumber(b.Name:match("%d+")) or 0)
	end)
	for _, plot in list do
		if plot:GetAttribute("OwnerUserId") == nil then
			return plot
		end
	end
	return nil
end

local function placeCharacterAtPlot(character: Model, plot: Model)
	local spawnPoint = plot:FindFirstChild("SpawnPoint")
	if spawnPoint and spawnPoint:IsA("BasePart") then
		character:PivotTo(spawnPoint.CFrame + Vector3.new(0, 4, 0))
	end
end

local function syncProfileFromState(player: Player)
	local profile = profilesByPlayer[player]
	local state = stateByPlayer[player]
	if not (profile and state) then
		return
	end
	profile.Data.Sheckles = state.Sheckles.Value
	if state.FakeRobux then -- MODDED: persistir saldo de Fake Robux
		profile.Data.FakeRobux = state.FakeRobux.Value
	end
	profile.Data.OwnedExpansions = state.Replica.Data.OwnedExpansions or 0
	local api = require(script.Parent.GameServerAPI)
	local getGardenSave = api.GetGardenSave
	if getGardenSave then
		local save = getGardenSave(player.UserId)
		if save ~= nil then
			profile.Data.Plants = save
		end
	end
	-- MODDED: semillas persistidas (PlantService es el dueño; mismo patrón que el jardín)
	local getSeedSave = api.GetSeedSave
	if getSeedSave then
		local seeds = getSeedSave(player.UserId)
		if seeds ~= nil then
			profile.Data.Seeds = seeds
		end
	end
	-- Gear de la GearShop (GearService es el dueño del estado; lo jala aquí al
	-- guardar, mismo patrón que el jardín → sin carrera con EndSession).
	local getGearSave = api.GetGearSave
	if getGearSave then
		local g = getGearSave(player)
		if g then
			profile.Data.Gears = g.Gears or {}
			profile.Data.OwnedEquippableGears = g.Owned or {}
			profile.Data.EquippedGear = g.Equipped or false
			profile.Data.SignText = g.SignText or ""
		end
	end
	-- skin de cerca equipada/poseídas (vive en la réplica)
	profile.Data.OwnedFenceSkins = state.Replica.Data.OwnedFenceSkins or ""
	-- gamepasses poseídos (viven en el atributo del Player)
	profile.Data.OwnedGamepasses = player:GetAttribute("OwnedGamepasses") or ""
	profile.Data.OwnsAdminPanel = player:GetAttribute("OwnsAdminPanel") == true
	profile.Data.SheckleMultiplier = player:GetAttribute("SheckleMultiplier") or 1
	-- MODDED: buff de tamaño de fruta de los OP Sprinklers (atributo del Player)
	profile.Data.FruitSizeBuff = player:GetAttribute("FruitSizeBuff") or 1
	-- MODDED: estado del tutorial (vive en el atributo del Player; lo marca TutorialService)
	profile.Data.TutorialCompleted = player:GetAttribute("TutorialCompleted") == true
	-- MODDED: favorito marcado en el popup social (lo marca SocialPopupService)
	profile.Data.FavoritedGame = player:GetAttribute("FavoritedGame") == true
end

local function onPlayerAdded(player: Player)
	-- ABTests: sin esto, ClientABTests.GetAttributeAsync yielde para siempre
	ABTestsUpdate:FireClient(player, {}, {})

	-- Perfil persistente (yield)
	local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})
	if profile then
		profile:AddUserId(player.UserId)
		profile:Reconcile()
		profile.OnSessionEnd:Connect(function()
			profilesByPlayer[player] = nil
			player:Kick("Sesión de datos cerrada — vuelve a entrar")
		end)
		if player.Parent ~= Players then
			profile:EndSession()
			return
		end
		profilesByPlayer[player] = profile
	else
		warn(("[GameServer] No se pudo cargar el perfil de %s — datos temporales"):format(player.Name))
	end

	local savedData = profile and profile.Data or PROFILE_TEMPLATE
	local savedPets = {}
	local savedHugePets = {} -- MODDED
	if profile then
		for petName, count in savedData.Pets do
			savedPets[petName] = count
		end
		if type(savedData.HugePets) == "table" then
			for petName, count in savedData.HugePets do
				savedHugePets[petName] = count
			end
		end
	end

	-- Réplica PlayerState con datos persistidos
	local replica = newReplica("PlayerState", { UserId = player.UserId }, {
		Sheckles = savedData.Sheckles,
		Tokens = 0,
		OwnedExpansions = savedData.OwnedExpansions or 0,
		HasShoveledPlant = false,
		HasWateredPlants = false,
		Inventory = { Pets = savedPets, HugePets = savedHugePets },
		-- Compras por restock: el cliente (RestockStoreController) calcula el
		-- stock restante como maxStock - PurchasedThisRestock[key][item]. La
		-- subtabla Seeds debe existir desde la creación para que el Set anidado
		-- se aplique en el cliente.
		PurchasedThisRestock = { Seeds = {}, Gears = {} },
		-- skins de cerca poseídas (la equipada lleva "+"); sin crates = todas
		OwnedFenceSkins = (savedData.OwnedFenceSkins ~= nil and savedData.OwnedFenceSkins ~= "")
			and savedData.OwnedFenceSkins
			or defaultOwnedFenceSkins(),
	})

	-- leaderstats
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	local sheckles = Instance.new("NumberValue")
	sheckles.Name = "Sheckles"
	sheckles.Value = savedData.Sheckles
	sheckles.Parent = leaderstats
	leaderstats.Parent = player

	-- MODDED: moneda Fake Robux (economía interna). Va directo bajo el jugador
	-- (no en leaderstats) para no ensuciar el leaderboard de Roblox. Replica al
	-- cliente como cualquier hijo del Player. `or` cubre perfiles viejos sin la key.
	local fakeRobux = Instance.new("NumberValue")
	fakeRobux.Name = "FakeRobux"
	fakeRobux.Value = savedData.FakeRobux or STARTING_FAKE_ROBUX
	fakeRobux.Parent = player

	-- Plot
	local plot = findFreePlot()
	local plotBoundsCFrame, plotBoundsSize
	if plot then
		plot:SetAttribute("Owner", player.Name)
		plot:SetAttribute("OwnerUserId", player.UserId)
		plot:SetAttribute("GardenExpansion", savedData.OwnedExpansions or 0)
		applyExpansionSize(plot, savedData.OwnedExpansions or 0)
		plot:SetAttribute("FenceSkin", fenceEquipped(replica.Data.OwnedFenceSkins or "Default"))
		player:SetAttribute("PlotId", tonumber(plot.Name:match("%d+")))
		plotBoundsCFrame, plotBoundsSize = plot:GetBoundingBox()
	else
		warn(("[GameServer] No hay plots libres para %s"):format(player.Name))
	end

	stateByPlayer[player] = {
		Replica = replica,
		Plot = plot,
		Sheckles = sheckles,
		FakeRobux = fakeRobux, -- MODDED
		BoundsCFrame = plotBoundsCFrame,
		BoundsSize = plotBoundsSize,
		-- epoch del cierre de sesion ANTERIOR (para la cutscene de crecimiento
		-- offline). Se captura aqui antes de que el guardado de salida lo pise.
		LastLogout = tonumber(savedData.LastLogout) or 0,
		-- pets que estaban equipadas la sesion anterior (PetEquipService re-equipa)
		SavedEquippedPets = (typeof(savedData.EquippedPets) == "table") and savedData.EquippedPets or {},
		SavedMaxEquippedPets = tonumber(savedData.MaxEquippedPets) or 3,
	}

	player:AddTag("DataLoaded")
	player:SetAttribute("OfflineGrowthProcessed", true)

	-- Starter Pack: oferta por tiempo (persistida). El RobuxShop lo muestra mientras
	-- StarterPackExpiresAt esté en el futuro y no se haya comprado.
	if not savedData.StarterPackBought then
		local exp = tonumber(savedData.StarterPackExpiresAt) or 0
		if exp == 0 then
			exp = os.time() + STARTERPACK_DURATION
			if profile then
				profile.Data.StarterPackExpiresAt = exp
			end
		end
		player:SetAttribute("StarterPackExpiresAt", exp)
	end

	-- Gamepasses poseídos (persistidos): el RobuxShop los lee del atributo.
	local savedGamepasses = (type(savedData.OwnedGamepasses) == "string") and savedData.OwnedGamepasses or ""
	if savedGamepasses ~= "" then
		player:SetAttribute("OwnedGamepasses", savedGamepasses)
	end
	-- MODDED: admin panel permanente persistido
	if savedData.OwnsAdminPanel == true then
		player:SetAttribute("OwnsAdminPanel", true)
	end
	-- MODDED: tutorial ya completado (persistido) → TutorialService no lo repite
	player:SetAttribute("TutorialCompleted", savedData.TutorialCompleted == true)
	-- MODDED: favorito marcado (persistido) → el popup social no vuelve a pedirlo
	player:SetAttribute("FavoritedGame", savedData.FavoritedGame == true)
	-- MODDED: multiplicador de sheckles persistido (default 1)
	player:SetAttribute("SheckleMultiplier",
		(type(savedData.SheckleMultiplier) == "number" and savedData.SheckleMultiplier > 0) and savedData.SheckleMultiplier or 1)
	-- MODDED: buff de tamaño de fruta de los OP Sprinklers (persistido, default 1)
	player:SetAttribute("FruitSizeBuff",
		(type(savedData.FruitSizeBuff) == "number" and savedData.FruitSizeBuff > 1) and savedData.FruitSizeBuff or 1)

	player.CharacterAdded:Connect(function(character)
		if plot then
			task.defer(placeCharacterAtPlot, character, plot)
		end
	end)
	if player.Character and plot then
		placeCharacterAtPlot(player.Character, plot)
	end
end

Players.PlayerAdded:Connect(function(player)
	task.spawn(onPlayerAdded, player)
end)
for _, player in Players:GetPlayers() do
	task.spawn(onPlayerAdded, player)
end

Players.PlayerRemoving:Connect(function(player)
	readyPlayers[player] = nil
	syncProfileFromState(player)
	local profile = profilesByPlayer[player]
	profilesByPlayer[player] = nil
	if profile then
		profile.Data.LastLogout = os.time() -- para la cutscene de crecimiento offline
		profile:EndSession()
	end
	local state = stateByPlayer[player]
	stateByPlayer[player] = nil
	if not state then
		return
	end
	if state.Plot then
		state.Plot:SetAttribute("Owner", nil)
		state.Plot:SetAttribute("OwnerUserId", nil)
		state.Plot:SetAttribute("GardenExpansion", 0)
		state.Plot:SetAttribute("FenceSkin", "Default")
		applyExpansionSize(state.Plot, 0)
		local plants = state.Plot:FindFirstChild("Plants")
		if plants then
			plants:ClearAllChildren()
		end
	end
	if state.Replica then
		state.Replica:Destroy()
	end
end)

-- Autosave suave cada 60s (ProfileStore además autosavea por su cuenta)
task.spawn(function()
	while true do
		task.wait(60)
		for player in profilesByPlayer do
			syncProfileFromState(player)
		end
	end
end)

-- IsInOwnGarden via bounding box del plot completo
-- GardenZoneData[playerName] (NumberValue) = PlotId del jardín en el que el
-- jugador está parado (0 si en ninguno). ShovelController lo usa para detectar
-- jugadores dentro de tu jardín (steal): IsPlayerInMyGarden compara ese Value
-- con tu propio atributo PlotId.
local GardenZoneData = ReplicatedStorage:FindFirstChild("GardenZoneData")

local function pointInBounds(cf: CFrame, size: Vector3, pos: Vector3): boolean
	local rel = cf:PointToObjectSpace(pos)
	local half = size / 2
	return math.abs(rel.X) <= half.X + 6
		and math.abs(rel.Z) <= half.Z + 6
		and math.abs(rel.Y) <= half.Y + 50
end

task.spawn(function()
	while true do
		task.wait(0.3)
		-- snapshot de plots ocupados (PlotId + bounds)
		local plots = {}
		for p2, s2 in stateByPlayer do
			local pid = p2:GetAttribute("PlotId")
			if pid and s2.BoundsCFrame then
				table.insert(plots, { id = pid, cf = s2.BoundsCFrame, size = s2.BoundsSize })
			end
		end
		for player, state in stateByPlayer do
			local character = player.Character
			local root = character and character.PrimaryPart
			if state.BoundsCFrame and root then
				local inside = pointInBounds(state.BoundsCFrame, state.BoundsSize, root.Position)
				if player:GetAttribute("IsInOwnGarden") ~= inside then
					player:SetAttribute("IsInOwnGarden", inside)
				end
			end
			if GardenZoneData then
				local zone = 0
				if root then
					for _, plot in plots do
						if pointInBounds(plot.cf, plot.size, root.Position) then
							zone = plot.id
							break
						end
					end
				end
				local nv = GardenZoneData:FindFirstChild(player.Name)
				if not nv then
					nv = Instance.new("NumberValue")
					nv.Name = player.Name
					nv.Parent = GardenZoneData
				end
				nv.Value = zone
			end
		end
		-- limpiar entradas de jugadores que ya salieron
		if GardenZoneData then
			for _, nv in GardenZoneData:GetChildren() do
				if not Players:FindFirstChild(nv.Name) then
					nv:Destroy()
				end
			end
		end
	end
end)

----------------------------------------------------------------------
-- 5) Handlers de Networking
----------------------------------------------------------------------
Networking.Actions.ExpandGarden.OnServerInvoke = function(player)
	local state = stateByPlayer[player]
	if not (state and state.Plot) then
		return false
	end
	local owned = state.Replica.Data.OwnedExpansions or 0
	local nextExpansion = ExpansionPrices[owned + 1]
	if not nextExpansion then
		return false
	end
	if state.Sheckles.Value < nextExpansion.Price then
		return false
	end
	state.Sheckles.Value -= nextExpansion.Price
	state.Replica:Set({ "Sheckles" }, state.Sheckles.Value)
	state.Replica:Set({ "OwnedExpansions" }, owned + 1)
	state.Plot:SetAttribute("GardenExpansion", nextExpansion.Expansion)
	applyExpansionSize(state.Plot, nextExpansion.Expansion)
	syncProfileFromState(player)
	return true
end

-- Cambiar la skin de cerca del plot propio. La UI (CustomiseFenceTheme) ya valida
-- "poseída" en el cliente; aquí va la autoridad: comprobar dueño + propiedad, fijar
-- el atributo FenceSkin del Plot (GardenVisualController re-renderiza para todos) y
-- mover el "+" en OwnedFenceSkins (la réplica) para el checkmark de la UI.
Networking.Actions.ChangeFenceTheme.OnServerInvoke = function(player, skinName)
	if type(skinName) ~= "string" then
		return false
	end
	local state = stateByPlayer[player]
	if not (state and state.Plot) then
		return false
	end
	if not (FenceThemesFolder and FenceThemesFolder:FindFirstChild(skinName)) then
		return false
	end
	local csv = state.Replica.Data.OwnedFenceSkins or ""
	if not fenceOwns(csv, skinName) then
		return false
	end
	state.Replica:Set({ "OwnedFenceSkins" }, fenceSetEquipped(csv, skinName))
	state.Plot:SetAttribute("FenceSkin", skinName)
	syncProfileFromState(player)
	return true
end

-- Reset de datos para TESTEO: escribir "/resetdata" (o "/wipedata") en el chat
-- resetea al que lo escribe -> sheckles a STARTING, expansiones a 0 (plot vuelve
-- a base) y limpia plantas + semillas. No hace falta rejoin. TextChatCommand.
-- Triggered dispara tambien en el server, con textSource del que escribio.
local function resetPlayerData(player: Player)
	local state = stateByPlayer[player]
	if not state then
		return
	end
	if state.Sheckles then
		state.Sheckles.Value = STARTING_SHECKLES
	end
	if state.Replica then
		state.Replica:Set({ "Sheckles" }, STARTING_SHECKLES)
		state.Replica:Set({ "OwnedExpansions" }, 0)
	end
	if state.Plot then
		applyExpansionSize(state.Plot, 0)
	end
	local resetGarden = require(script.Parent.GameServerAPI).ResetGarden
	if resetGarden then
		pcall(resetGarden, player)
	end
	local profile = profilesByPlayer[player]
	if profile then
		profile.Data.Sheckles = STARTING_SHECKLES
		profile.Data.OwnedExpansions = 0
		profile.Data.Plants = {}
		profile.Data.Pets = {}
	end
	warn(("[GameServer] Datos reseteados para %s (/resetdata)"):format(player.Name))
end

do
	local cmd = Instance.new("TextChatCommand")
	cmd.Name = "ResetDataCommand"
	cmd.PrimaryAlias = "/resetdata"
	cmd.SecondaryAlias = "/wipedata"
	cmd.Parent = game:GetService("TextChatService")
	cmd.Triggered:Connect(function(textSource)
		local player = Players:GetPlayerByUserId(textSource.UserId)
		if player then
			resetPlayerData(player)
		end
	end)
end

local function clamp01(value)
	return typeof(value) == "number" and math.clamp(value, 0, 1) or nil
end
Networking.Settings.UpdateMusic.OnServerEvent:Connect(function(player, value)
	local v = clamp01(value)
	local settings = player:FindFirstChild("Settings")
	local musicVolume = settings and settings:FindFirstChild("Music_Volume")
	if v and musicVolume then
		musicVolume.Value = v
	end
end)
Networking.Settings.UpdateSFX.OnServerEvent:Connect(function(player, value)
	local v = clamp01(value)
	local settings = player:FindFirstChild("Settings")
	local sfxVolume = settings and settings:FindFirstChild("SFX_Volume")
	if v and sfxVolume then
		sfxVolume.Value = v
	end
end)

-- GetEquippedPets lo maneja PetEquipService (equip/follow server-side).
Networking.SkillPoints.RequestSkillData.OnServerInvoke = function()
	return nil
end
Networking.Settings.SubmitCode.OnServerInvoke = function()
	return false
end
Networking.ReturnNearestFruit.ReturnNearestFruit.OnServerInvoke = function()
	return nil
end

----------------------------------------------------------------------
-- API compartida para otros scripts del servidor
----------------------------------------------------------------------
local GameServerAPI = require(script.Parent.GameServerAPI)

GameServerAPI.GetSheckles = function(player: Player): number
	local state = stateByPlayer[player]
	return state and state.Sheckles.Value or 0
end

GameServerAPI.AddSheckles = function(player: Player, amount: number)
	local state = stateByPlayer[player]
	if not state then
		return
	end
	state.Sheckles.Value = math.max(0, state.Sheckles.Value + amount)
	state.Replica:Set({ "Sheckles" }, state.Sheckles.Value)
end

----------------------------------------------------------------------
-- MODDED: API de la moneda interna "Fake Robux"
----------------------------------------------------------------------
GameServerAPI.GetFakeRobux = function(player: Player): number
	local state = stateByPlayer[player]
	return state and state.FakeRobux and state.FakeRobux.Value or 0
end

GameServerAPI.AddFakeRobux = function(player: Player, amount: number)
	local state = stateByPlayer[player]
	if not (state and state.FakeRobux) then
		return
	end
	state.FakeRobux.Value = math.max(0, state.FakeRobux.Value + amount)
end

-- Cobra `cost` Fake Robux si el jugador puede pagarlo. Devuelve true si cobró.
GameServerAPI.SpendFakeRobux = function(player: Player, cost: number): boolean
	local state = stateByPlayer[player]
	if not (state and state.FakeRobux) then
		return false
	end
	cost = math.max(0, math.floor(tonumber(cost) or 0))
	if state.FakeRobux.Value < cost then
		return false
	end
	state.FakeRobux.Value -= cost
	return true
end

----------------------------------------------------------------------
-- MODDED: refleja el conteo de una semilla en la réplica (Inventory.Seeds)
-- para que el Mailbox la pueda listar como regalable. Lo llama PlantService
-- desde syncSeedTool (el punto único por donde pasan todos los cambios).
----------------------------------------------------------------------
GameServerAPI.SetInventorySeed = function(player: Player, seedName: string, count: number)
	local state = stateByPlayer[player]
	if not (state and state.Replica) then
		return
	end
	local inv = state.Replica.Data.Inventory or {}
	inv.Seeds = inv.Seeds or {}
	count = math.floor(tonumber(count) or 0)
	if count > 0 then
		inv.Seeds[seedName] = count
	else
		inv.Seeds[seedName] = nil
	end
	state.Replica:Set({ "Inventory" }, inv)
end

-- MODDED: multiplicador de sheckles (P2W x2/x4/...). Aplica a las VENTAS (PlantService).
GameServerAPI.GetSheckleMultiplier = function(player: Player): number
	local m = player:GetAttribute("SheckleMultiplier")
	return (type(m) == "number" and m > 0) and m or 1
end
GameServerAPI.SetSheckleMultiplier = function(player: Player, mult: number)
	if type(mult) == "number" and mult > 0 then
		player:SetAttribute("SheckleMultiplier", mult)
	end
end

GameServerAPI.GetPlot = function(player: Player): Model?
	local state = stateByPlayer[player]
	return state and state.Plot or nil
end

----------------------------------------------------------------------
-- Pets en el inventario (Backpack). El inventario del cliente
-- (InventoryController.Main, pestana "Pets") lista Tools con atributo "Pet".
-- AddPet solo subia el conteo de la replica -> las pets NO aparecian en la
-- mochila. Aqui las materializamos como Tools.
----------------------------------------------------------------------
local function givePetTool(player: Player, petName: string, petSize: string?, petType: string?)
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then
		return
	end
	local size = petSize or "Normal"
	local kind = petType or "Normal"
	local tool = Instance.new("Tool")
	tool.Name = petName
	tool.RequiresHandle = false
	tool.CanBeDropped = false
	tool:SetAttribute("Pet", petName)
	tool:SetAttribute("PetId", HttpService:GenerateGUID(false))
	tool:SetAttribute("PetSize", size)
	tool:SetAttribute("PetType", kind)
	tool:SetAttribute("MainCategory", "Pet")
	local ok, img = pcall(PetData.GetImage, petName, size)
	if ok and type(img) == "string" and img ~= "" then
		tool.TextureId = img
	end
	tool.Parent = backpack
end

-- Reconstruye los Tools de pet en la mochila a partir de los conteos de la
-- replica (Inventory.Pets). Idempotente: borra los previos y recrea. Se usa al
-- unirse (pets guardadas) y al respawnear.
local function rebuildPetTools(player: Player)
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then
		return
	end
	for _, child in backpack:GetChildren() do
		if child:IsA("Tool") and child:GetAttribute("Pet") ~= nil then
			child:Destroy()
		end
	end
	local state = stateByPlayer[player]
	local inventory = state and state.Replica and state.Replica.Data.Inventory
	local pets = inventory and inventory.Pets
	if type(pets) ~= "table" then
		return
	end
	-- Las pets EQUIPADAS no van en la mochila (su Tool desaparece al equipar). Resta
	-- el conteo de equipadas por nombre para no recrear sus Tools al respawnear.
	local equippedByName = {}
	if GameServerAPI.GetEquippedPets then
		for _, e in GameServerAPI.GetEquippedPets(player) do
			if type(e.Name) == "string" then
				equippedByName[e.Name] = (equippedByName[e.Name] or 0) + 1
			end
		end
	end
	local hugePets = inventory.HugePets or {}
	for petName, count in pets do
		local n = (tonumber(count) or 0) - (equippedByName[petName] or 0)
		local hugeLeft = tonumber(hugePets[petName]) or 0
		for _ = 1, n do
			if hugeLeft > 0 then
				givePetTool(player, petName, "Huge") -- MODDED: recrea como Huge (persistencia)
				hugeLeft -= 1
			else
				givePetTool(player, petName)
			end
		end
	end
end

-- Expuesto a PetEquipService: al DESEQUIPAR una pet, recrear su Tool en la mochila.
GameServerAPI.GivePetTool = function(player: Player, petName: string, size: string?, petType: string?)
	givePetTool(player, petName, size, petType)
end

GameServerAPI.AddPet = function(player: Player, petName: string, size: string?)
	local state = stateByPlayer[player]
	if not state then
		return
	end
	local inventory = state.Replica.Data.Inventory or {}
	local pets = inventory.Pets or {}
	pets[petName] = (pets[petName] or 0) + 1
	inventory.Pets = pets
	-- MODDED: contar cuántas de esta pet son Huge para que el tamaño persista al rejoin
	if size == "Huge" then
		local huge = inventory.HugePets or {}
		huge[petName] = (huge[petName] or 0) + 1
		inventory.HugePets = huge
	end
	state.Replica:Set({ "Inventory" }, inventory)
	local profile = profilesByPlayer[player]
	if profile then
		profile.Data.Pets[petName] = pets[petName]
		if size == "Huge" then
			profile.Data.HugePets = profile.Data.HugePets or {}
			profile.Data.HugePets[petName] = inventory.HugePets[petName]
		end
	end
	-- materializar la pet en la mochila (pestana "Pets" del inventario)
	givePetTool(player, petName, size) -- MODDED: tamaño opcional (p.ej. "Huge")
end

-- MODDED: quita 'amount' pets del conteo SOLO si las tiene (anti-duplicado).
-- Ajusta HugePets, réplica, perfil y reconstruye los Tools. Para regalos del Mailbox.
GameServerAPI.RemovePet = function(player: Player, petName: string, amount: number?): boolean
	amount = math.floor(tonumber(amount) or 0)
	if amount <= 0 then
		return false
	end
	local state = stateByPlayer[player]
	if not state then
		return false
	end
	local inventory = state.Replica.Data.Inventory or {}
	local pets = inventory.Pets or {}
	local have = tonumber(pets[petName]) or 0
	if have < amount then
		return false
	end
	local left = have - amount
	pets[petName] = (left > 0) and left or nil
	inventory.Pets = pets
	-- no dejar más Huge que el conteo restante
	if inventory.HugePets and inventory.HugePets[petName] then
		local huge = math.min(tonumber(inventory.HugePets[petName]) or 0, left)
		inventory.HugePets[petName] = (huge > 0) and huge or nil
	end
	state.Replica:Set({ "Inventory" }, inventory)
	local profile = profilesByPlayer[player]
	if profile then
		profile.Data.Pets[petName] = (left > 0) and left or nil
		if profile.Data.HugePets then
			profile.Data.HugePets[petName] = inventory.HugePets and inventory.HugePets[petName] or nil
		end
	end
	rebuildPetTools(player)
	return true
end

GameServerAPI.GetOwnedPetCount = function(player: Player, petName: string): number
	local state = stateByPlayer[player]
	if not state then
		return 0
	end
	local inventory = state.Replica.Data.Inventory
	local pets = inventory and inventory.Pets
	return (pets and tonumber(pets[petName])) or 0
end

-- Epoch del cierre de sesion anterior del jugador (0 si es su primera vez).
-- PlantService lo usa para la cutscene de crecimiento offline.
GameServerAPI.GetLastLogout = function(player: Player): number
	local state = stateByPlayer[player]
	return state and tonumber(state.LastLogout) or 0
end

-- Pets equipadas guardadas (PetEquipService las re-equipa al unirse).
GameServerAPI.GetSavedEquippedPets = function(player: Player)
	local state = stateByPlayer[player]
	return (state and state.SavedEquippedPets) or {}
end

-- Slots de pets activas comprados (persistido). PetEquipService lo lee al unirse.
GameServerAPI.GetSavedMaxEquippedPets = function(player: Player): number
	local state = stateByPlayer[player]
	return (state and tonumber(state.SavedMaxEquippedPets)) or 3
end

GameServerAPI.SetMaxEquippedPets = function(player: Player, n: number)
	local state = stateByPlayer[player]
	if state then
		state.SavedMaxEquippedPets = n
	end
	local profile = profilesByPlayer[player]
	if profile then
		profile.Data.MaxEquippedPets = n
	end
end

-- Persiste la lista de pets equipadas (nombres) para la proxima sesion.
GameServerAPI.SetEquippedPets = function(player: Player, list)
	local profile = profilesByPlayer[player]
	if not (profile and typeof(list) == "table") then
		return
	end
	local copy = {}
	for _, n in ipairs(list) do
		if type(n) == "string" then
			table.insert(copy, n)
		end
	end
	profile.Data.EquippedPets = copy
end

-- Compras por restock (modelo real del cliente: remaining = maxStock - comprado)
GameServerAPI.GetPurchaseCount = function(player: Player, key: string, item: string): number
	local state = stateByPlayer[player]
	if not state then
		return 0
	end
	local bucket = state.Replica.Data.PurchasedThisRestock
	bucket = bucket and bucket[key]
	return (bucket and bucket[item]) or 0
end

GameServerAPI.IncrementPurchase = function(player: Player, key: string, item: string)
	local state = stateByPlayer[player]
	if not state then
		return
	end
	local data = state.Replica.Data
	data.PurchasedThisRestock = data.PurchasedThisRestock or {}
	local bucket = data.PurchasedThisRestock[key]
	if not bucket then
		bucket = {}
		data.PurchasedThisRestock[key] = bucket
		state.Replica:Set({ "PurchasedThisRestock", key }, bucket)
	end
	bucket[item] = (bucket[item] or 0) + 1
	state.Replica:Set({ "PurchasedThisRestock", key, item }, bucket[item])
end

GameServerAPI.ResetPurchases = function(player: Player, key: string)
	local state = stateByPlayer[player]
	if not state then
		return
	end
	local data = state.Replica.Data
	data.PurchasedThisRestock = data.PurchasedThisRestock or {}
	data.PurchasedThisRestock[key] = {}
	state.Replica:Set({ "PurchasedThisRestock", key }, {})
end

-- PlantService compromete su snapshot al salir el jugador (orden seguro)
GameServerAPI.CommitGardenSave = function(player: Player, save)
	local profile = profilesByPlayer[player]
	if profile and typeof(save) == "table" then
		profile.Data.Plants = save
	end
end

-- Plantas guardadas (PlantService las restaura; espera a que el perfil cargue)
GameServerAPI.GetSavedPlants = function(player: Player)
	local startTime = os.clock()
	while not profilesByPlayer[player] and player.Parent == Players and os.clock() - startTime < 15 do
		task.wait(0.1)
	end
	local profile = profilesByPlayer[player]
	return profile and profile.Data.Plants or {}
end

-- Gear guardado de la GearShop (GearService lo restaura al unirse; espera al perfil)
GameServerAPI.GetSavedGear = function(player: Player)
	local startTime = os.clock()
	while not profilesByPlayer[player] and player.Parent == Players and os.clock() - startTime < 15 do
		task.wait(0.1)
	end
	local profile = profilesByPlayer[player]
	if not profile then
		return nil
	end
	return {
		Gears = profile.Data.Gears or {},
		Owned = profile.Data.OwnedEquippableGears or {},
		Equipped = profile.Data.EquippedGear,
		SignText = profile.Data.SignText or "",
	}
end

-- MODDED: semillas guardadas (PlantService las restaura; espera al perfil).
GameServerAPI.GetSavedSeeds = function(player: Player)
	local startTime = os.clock()
	while not profilesByPlayer[player] and player.Parent == Players and os.clock() - startTime < 15 do
		task.wait(0.1)
	end
	local profile = profilesByPlayer[player]
	return profile and profile.Data.Seeds or {}
end

-- MODDED: PlantService compromete las semillas al instante (anti-carrera de salida).
GameServerAPI.CommitSeedSave = function(player: Player, save)
	local profile = profilesByPlayer[player]
	if profile and typeof(save) == "table" then
		profile.Data.Seeds = save
	end
end

-- Starter Pack: compra única (DevProductService la consulta/marca al entregar).
GameServerAPI.IsStarterPackBought = function(player: Player): boolean
	local profile = profilesByPlayer[player]
	return profile and profile.Data.StarterPackBought == true or false
end
GameServerAPI.MarkStarterPackBought = function(player: Player)
	local profile = profilesByPlayer[player]
	if profile then
		profile.Data.StarterPackBought = true
	end
	player:SetAttribute("StarterPackExpiresAt", 0) -- ocultarlo en el RobuxShop
end

----------------------------------------------------------------------
-- Materializar pets en la mochila al unirse (pets guardadas) y al respawnear.
----------------------------------------------------------------------
local function hookPetInventory(player: Player)
	task.spawn(function()
		local deadline = os.clock() + 30
		while not (stateByPlayer[player] and stateByPlayer[player].Replica) and player.Parent == Players and os.clock() < deadline do
			task.wait(0.1)
		end
		rebuildPetTools(player)
	end)
	player.CharacterAdded:Connect(function()
		task.defer(rebuildPetTools, player)
	end)
end
Players.PlayerAdded:Connect(hookPetInventory)
for _, player in Players:GetPlayers() do
	hookPetInventory(player)
end

print("[GameServer] Replica + plots + networking + ProfileStore listos")