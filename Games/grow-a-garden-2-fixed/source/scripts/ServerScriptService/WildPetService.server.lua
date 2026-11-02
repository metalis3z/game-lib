--credit to prince games studio
--[[
	WildPetService (REESCRITO — arquitectura client-driven)

	Ahora el cliente StarterPlayerScripts.Controllers.SpawnPetController SÍ existe
	(módulo completo, 1477 líneas) y se encarga de TODO lo visual de los wild pets:
	clona el modelo, lo anima, lo apoya en el suelo (raycast propio), lo orienta,
	muestra el ProximityPrompt "Buy", el precio (CostGui) y el contador de "leave"
	(TimerGui, calculado desde SpawnedAt+Lifetime). Lee cada frame refPart.Position.

	Por eso este servicio es AHORA mínimo: solo crea/mueve un Part "ref" invisible en
	workspace.Map.WildPetRef con los atributos que el cliente espera, y maneja el
	remote de domesticación. Ya NO crea modelos, ni animaciones, ni billboards
	(PetCostTimer / PetLeaveTimer quedaron eliminados — el cliente hace su propio HUD).

	Atributos del ref-part (contrato con SpawnPetController):
	  PetName   (string, clave en PetModules)
	  Rarity    (string)
	  Price     (number)
	  State     ("idle" | "wandering_walking" | "walking_to_garden")
	  SpawnedAt (number, os.time)   -- el cliente muestra el timer con esto
	  Lifetime  (number, segundos)  --   y con esto
	  PetSize   (string, opcional: "Big"/"Huge")
	  PetType   (opcional: PetTypes.Rainbow)
	  OwnerUserId -> SE DEJA nil mientras es salvaje (el cliente activa el prompt
	                 de compra y muestra precio/timer SOLO si OwnerUserId == nil).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local PetData = require(ReplicatedStorage.SharedData.PetData)
local PetTypes = require(ReplicatedStorage.SharedData.PetTypes)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local GameServerAPI = require(script.Parent.GameServerAPI)
local PetModules = require(ReplicatedStorage.SharedModules.PetModules)

local PetModels = ReplicatedStorage.Assets.Pets
local Map = workspace:WaitForChild("Map")

local function ensureFolder(name: string): Folder
	local f = Map:FindFirstChild(name)
	if not (f and f:IsA("Folder")) then
		f = Instance.new("Folder")
		f.Name = name
		f.Parent = Map
	end
	return f
end

local WildPetRef = ensureFolder("WildPetRef")
local WildPetSpawns = ensureFolder("WildPetSpawns")
local PlayerPetReferences = workspace:WaitForChild("PlayerPetReferences")

----------------------------------------------------------------------
-- Config
----------------------------------------------------------------------
local MAX_WILD_PETS = 4
local SPAWN_INTERVAL = 45
local WANDER_INTERVAL = 6
local WANDER_DISTANCE = 14
local WANDER_SPEED = 7      -- studs/s al deambular
local TRAVEL_SPEED = 8      -- studs/s al caminar al plot tras domar
local STEP = 0.08           -- cadencia del paso del servidor (el cliente interpola)
local RAINBOW_CHANCE = 0.02 -- 2% de que una wild pet natural salga Rainbow

local AREA_CENTER = Vector3.new(247, 143.25, -150)
local AREA_HALF = Vector2.new(80, 50)

local LIFETIME_BY_RARITY = {
	Common = 420,
	Uncommon = 360,
	Rare = 300,
	Epic = 240,
	Legendary = 90,
	Mythic = 60,
}

----------------------------------------------------------------------
-- Limpieza de residuos del dump / arranque
----------------------------------------------------------------------
WildPetRef:ClearAllChildren()
WildPetSpawns:ClearAllChildren()
for _, folder in PlayerPetReferences:GetChildren() do
	folder:Destroy()
end
local petVisualClient = workspace:FindFirstChild("_PetVisualClient")
if petVisualClient then
	for _, folder in petVisualClient:GetChildren() do
		folder:ClearAllChildren()
	end
end

-- Pool de refs por jugador (sistema de pets EQUIPADAS, ajeno a los wild — se conserva)
local function setupPlayerPetFolder(player: Player)
	if PlayerPetReferences:FindFirstChild(player.Name) then
		return
	end
	local folder = Instance.new("Folder")
	folder.Name = player.Name
	for i = 1, 30 do
		local part = Instance.new("Part")
		part.Name = "PetPart" .. i
		part.Size = Vector3.one
		part.Transparency = 1
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.Anchored = true
		part.Parent = folder
	end
	folder.Parent = PlayerPetReferences
end

Players.PlayerAdded:Connect(setupPlayerPetFolder)
for _, player in Players:GetPlayers() do
	setupPlayerPetFolder(player)
end
Players.PlayerRemoving:Connect(function(player)
	local folder = PlayerPetReferences:FindFirstChild(player.Name)
	if folder then
		folder:Destroy()
	end
end)

----------------------------------------------------------------------
-- Catálogo de pets spawneables: el cliente clona Pets[PetModules[name].AssetName],
-- así que solo aceptamos especies con entrada válida en PetModules + modelo presente.
----------------------------------------------------------------------
local spawnable = {}
for petName, data in PetData do
	if typeof(petName) == "string" then
		local m = PetModules[petName]
		local assetName = m and m.AssetName
		if assetName and PetModels:FindFirstChild(assetName) then
			table.insert(spawnable, {
				Name = petName,
				Chance = tonumber(data.SpawnChance) or 0.5,
				Price = tonumber(data.BasePrice) or 20000,
				Rarity = tostring(data.Rarity or "Common"),
			})
		end
	end
end

-- MODDED: 70% de probabilidad de que salga una de las MEJORES pets (OP)
local BEST_PETS = { BlackDragon = true, IceSerpent = true, GoldenDragonfly = true, Unicorn = true }

local function pickPet()
	if math.random() < 0.70 then
		local best = {}
		for _, pet in spawnable do
			if BEST_PETS[pet.Name] then
				table.insert(best, pet)
			end
		end
		if #best > 0 then
			return best[math.random(#best)]
		end
	end
	local total = 0
	for _, pet in spawnable do
		total += pet.Chance
	end
	if total <= 0 then
		return nil
	end
	local roll = math.random() * total
	for _, pet in spawnable do
		roll -= pet.Chance
		if roll <= 0 then
			return pet
		end
	end
	return spawnable[#spawnable]
end

----------------------------------------------------------------------
-- Estado + helpers de movimiento (solo movemos el ref-part; el cliente sigue)
----------------------------------------------------------------------
local activePets = {} -- [refPart] = {Ref, Info, Size, SpawnedAt, Lifetime, Claimed, ClaimedBy, MoveToken}

local function randomAreaPosition(): Vector3
	return AREA_CENTER + Vector3.new(
		(math.random() * 2 - 1) * AREA_HALF.X,
		0,
		(math.random() * 2 - 1) * AREA_HALF.Y
	)
end

local function despawnPet(ref: BasePart)
	if not activePets[ref] then
		return
	end
	activePets[ref] = nil
	if ref.Parent then
		ref:Destroy() -- el cliente limpia su modelo al ver ChildRemoved
	end
end

-- Mueve el ref de forma gradual a `target`. Un token nuevo cancela el anterior.
-- `onArrive` (opcional) corre al llegar si el token sigue vigente.
local function moveRef(pet, target: Vector3, speed: number, movingState: string, onArrive)
	pet.MoveToken = (pet.MoveToken or 0) + 1
	local token = pet.MoveToken
	local ref = pet.Ref
	task.spawn(function()
		if not (ref and ref.Parent) then
			return
		end
		local startPos = ref.Position
		local duration = math.clamp((target - startPos).Magnitude / speed, 0.4, 14)
		ref:SetAttribute("State", movingState)
		local t0 = os.clock()
		while os.clock() - t0 < duration do
			if pet.MoveToken ~= token or not ref.Parent then
				return
			end
			ref.Position = startPos:Lerp(target, (os.clock() - t0) / duration)
			task.wait(STEP)
		end
		if pet.MoveToken ~= token or not ref.Parent then
			return
		end
		ref.Position = target
		if onArrive then
			onArrive()
		elseif not pet.Claimed then
			ref:SetAttribute("State", "idle")
		end
	end)
end

----------------------------------------------------------------------
-- Spawning
----------------------------------------------------------------------
local function spawnWildPet(forcedInfo)
	local info = forcedInfo or pickPet()
	if not info then
		return
	end
	local guid = HttpService:GenerateGUID(false)
	local rarity = info.Rarity or "Common"
	local lifetime = LIFETIME_BY_RARITY[rarity] or 300
	local position = randomAreaPosition()

	-- Tipo: forzado lo respeta; natural tiene 2% de salir Rainbow.
	local petType = info.Type
	if not petType and not forcedInfo and math.random() < RAINBOW_CHANCE then
		petType = PetTypes.Rainbow
	end

	local ref = Instance.new("Part")
	ref.Name = "WildPet_" .. guid
	ref.Size = Vector3.one
	ref.Transparency = 1
	ref.CanCollide = false
	ref.CanQuery = false
	ref.CanTouch = false
	ref.Anchored = true
	ref.Position = position
	ref:SetAttribute("PetName", info.Name)
	ref:SetAttribute("Rarity", rarity)
	ref:SetAttribute("Price", info.Price)
	ref:SetAttribute("State", "idle")
	ref:SetAttribute("SpawnedAt", os.time())
	ref:SetAttribute("Lifetime", lifetime)
	if info.Size and info.Size ~= "" then
		ref:SetAttribute("PetSize", info.Size)
	end
	if petType and petType ~= "" then
		ref:SetAttribute("PetType", petType)
	end
	-- OwnerUserId se deja SIN setear (nil) → el cliente habilita el prompt de compra.
	ref.Parent = WildPetRef

	activePets[ref] = {
		Ref = ref,
		Info = info,
		Size = info.Size,
		SpawnedAt = os.time(),
		Lifetime = lifetime,
		Claimed = false,
	}
end

-- MODDED: spawn forzado de una wild pet específica (P2W "Spawn Random Huge OP Pet").
-- Lo usa DevProductService vía GameServerAPI.WaitFor("SpawnWildPet").
GameServerAPI.SpawnWildPet = function(petName: string, size: string?, price: number?, rarity: string?)
	local data = PetData[petName]
	local m = PetModules[petName]
	if not (data and m and m.AssetName and PetModels:FindFirstChild(m.AssetName)) then
		return false
	end
	spawnWildPet({
		Name = petName,
		Price = price or tonumber(data.BasePrice) or 1000000,
		Rarity = rarity or tostring(data.Rarity or "Mythic"),
		Size = size,
	})
	return true
end

----------------------------------------------------------------------
-- Domesticación (vía remote WildPetTame, no ProximityPrompt server-side)
----------------------------------------------------------------------
-- Destino del viaje al domar: el plot del jugador (SpawnPoint), o su HRP.
local function getPlotTarget(player: Player): Vector3?
	local plot = GameServerAPI.GetPlot and GameServerAPI.GetPlot(player)
	if not plot then
		local gardens = workspace:FindFirstChild("Gardens")
		if gardens then
			for _, p in ipairs(gardens:GetChildren()) do
				if p:GetAttribute("OwnerUserId") == player.UserId or p:GetAttribute("Owner") == player.Name then
					plot = p
					break
				end
			end
		end
	end
	if plot then
		local sp = plot:FindFirstChild("SpawnPoint", true)
		if sp and sp:IsA("BasePart") then
			return sp.Position + Vector3.new(0, 2, 0)
		end
		local ok, pivot = pcall(function()
			return plot:GetPivot()
		end)
		if ok then
			return pivot.Position + Vector3.new(0, 2, 0)
		end
	end
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if hrp and hrp:IsA("BasePart") then
		return hrp.Position
	end
	return nil
end

Networking.Pets.WildPetTame.OnServerEvent:Connect(function(player: Player, refPart)
	if typeof(refPart) ~= "Instance" or not refPart:IsA("BasePart") then
		return
	end
	local pet = activePets[refPart]
	if not pet or pet.Claimed or refPart.Parent ~= WildPetRef then
		return
	end

	local price = pet.Info.Price or 0
	local getSheckles = GameServerAPI.WaitFor("GetSheckles")
	if getSheckles(player) < price then
		return -- no le alcanza
	end
	GameServerAPI.AddSheckles(player, -price)

	pet.Claimed = true
	pet.ClaimedBy = player
	refPart:SetAttribute("OwnerUserId", player.UserId) -- el cliente apaga prompt/precio/timer
	refPart:SetAttribute("State", "walking_to_garden")

	-- Burst de domado en TODOS los clientes (p1=refPart, p2=UserId del que domó).
	for _, other in Players:GetPlayers() do
		Networking.Pets.WildPetTameResult:FireClient(other, refPart, player.UserId)
	end

	-- Camina al plot del dueño y, al llegar, entra a su inventario.
	local target = getPlotTarget(player) or refPart.Position
	moveRef(pet, target, TRAVEL_SPEED, "walking_to_garden", function()
		activePets[refPart] = nil
		if player.Parent and GameServerAPI.AddPet then
			GameServerAPI.AddPet(player, pet.Info.Name, pet.Size) -- conserva el tamaño (Huge)
		end
		for _, other in Players:GetPlayers() do
			Networking.Pets.WildPetCollected:FireClient(other, player, pet.Info.Name)
		end
		task.wait(0.05)
		if refPart.Parent then
			refPart:Destroy()
		end
	end)
end)

----------------------------------------------------------------------
-- Loops: wander, lifetime/despawn, spawner
----------------------------------------------------------------------
task.spawn(function()
	while true do
		task.wait(WANDER_INTERVAL)
		for ref, pet in activePets do
			if not (ref.Parent) then
				activePets[ref] = nil
			elseif not pet.Claimed then
				local current = ref.Position
				local target = current + Vector3.new(
					(math.random() * 2 - 1) * WANDER_DISTANCE,
					0,
					(math.random() * 2 - 1) * WANDER_DISTANCE
				)
				target = Vector3.new(
					math.clamp(target.X, AREA_CENTER.X - AREA_HALF.X, AREA_CENTER.X + AREA_HALF.X),
					AREA_CENTER.Y,
					math.clamp(target.Z, AREA_CENTER.Z - AREA_HALF.Y, AREA_CENTER.Z + AREA_HALF.Y)
				)
				moveRef(pet, target, WANDER_SPEED, "wandering_walking")
			end
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(1)
		local now = os.time()
		for ref, pet in activePets do
			if not pet.Claimed and (now - pet.SpawnedAt) >= (pet.Lifetime or 300) then
				despawnPet(ref)
			end
		end
	end
end)

task.spawn(function()
	task.wait(5)
	while true do
		local count = 0
		for _ in activePets do
			count += 1
		end
		if count < MAX_WILD_PETS then
			spawnWildPet()
		end
		task.wait(SPAWN_INTERVAL)
	end
end)

print(("[WildPetService] listo (client-driven) — %d tipos de pets spawneables"):format(#spawnable))
