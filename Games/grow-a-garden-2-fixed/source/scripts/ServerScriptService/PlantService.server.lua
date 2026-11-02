--credit to leon games studio
--[[
	PlantService
	Sistema de semillas/plantas reconstruido sobre el contrato de
	GardenSyncController (Networking.Garden) y RestockStoreController:

	- Tienda de semillas: SeedShop.PurchaseSeed + PersonalRestock (stock por jugador).
	- Plantar: Plant.PlantSeed(worldPos, seedName, tool) → PlantAdded broadcast.
	  Posiciones LOCALES al Plot.SpawnPoint (así las convierte el cliente).
	- Crecimiento: edad real (os.time - PlantedAt); PlantAgeSync/FruitAgeSync periódicos.
	- Frutas: plantas multi-cosecha spawnean frutas en FruitSpawnLocations.
	- Cosecha: Garden.CollectFruit(plantId, fruitId|"") → Tool de fruta.
	- Venta (Steven): NPCS.SellFruit/SellAll/PreviewSellAll con FruitValueCalc.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Networking = require(ReplicatedStorage.SharedModules.Networking)
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local FruitValueCalc = require(ReplicatedStorage.SharedModules.FruitValueCalc)
local MutationData = require(ReplicatedStorage.SharedModules.MutationData)
local GameServerAPI = require(script.Parent.GameServerAPI)

local RESTOCK_INTERVAL = 60 -- MODDED: restock cada 1 minuto
local MODDED_STOCK_COMMON = 14 -- MODDED: stock fijo de seeds comunes (siempre en stock)
local MODDED_STOCK_OTHER = 5   -- MODDED: stock fijo del resto de seeds (siempre en stock)
local FRUIT_GROW_SECONDS = 30 -- tiempo de maduración de una fruta
local FRUIT_SPAWN_INTERVAL = 10 -- segundos entre frutas nuevas por planta
local AGE_SYNC_INTERVAL = 5

-- Módulos de generación de plantas (mismos que usa el cliente). El template de
-- cada planta trae FruitSpawnLocations VACÍO: los slots los crea InitPlant en
-- runtime a partir del Seed. El server corre el mismo módulo para saber cuántas
-- frutas caben y en qué índices, de modo que coincida con el cliente.
local PlantGenModules = ReplicatedStorage:FindFirstChild("PlantGenerationModules")
local PlantGenPlants = PlantGenModules and PlantGenModules:FindFirstChild("Plants")

-- SeedData es un array; índice por nombre
local seedByName: { [string]: any } = {}
for _, entry in SeedData do
	if entry.SeedName then
		seedByName[entry.SeedName] = entry
	end
end

----------------------------------------------------------------------
-- Estado
----------------------------------------------------------------------
-- gardens[userId] = { Plants = { [plantId] = plantData } } (formato de SyncAllGardens)
local gardens: { [number]: any } = {}
-- runtime[userId][plantId] = { seed = SeedData entry, lastFruitAt = number }
local runtime: { [number]: any } = {}
-- seedCounts[userId][seedName] = cantidad. FUENTE DE VERDAD de las semillas: el
-- Backpack se reinicia en cada respawn (Roblox), así que re-creamos los Tools
-- desde aquí en CharacterAdded en vez de perderlos.
local seedCounts: { [number]: { [string]: number } } = {}
-- MODDED: atributos OP por semilla (SizeMultiplier/ForcedMutation/Height/Width).
-- Se reaplican al Tool en cada respawn y se persisten (OP/Rainbow/SeedSize seeds).
local seedMeta: { [number]: { [string]: any } } = {}
-- forward: definido más abajo (tras GetSeedSave). Persiste jardín+semillas al instante.
local persistInventory
-- MODDED: buff de tamaño de fruta de los OP Sprinklers (atributo del Player dueño).
local function fruitSizeBuffFor(userId: number): number
	local p = Players:GetPlayerByUserId(userId)
	local b = p and p:GetAttribute("FruitSizeBuff")
	return (type(b) == "number" and b > 1) and b or 1
end

local function newId(): string
	return HttpService:GenerateGUID(false)
end

local function broadcast(packet, ...)
	for _, player in Players:GetPlayers() do
		packet:FireClient(player, ...)
	end
end

local function getPlotReference(player: Player): (Model?, BasePart?)
	local plot = GameServerAPI.WaitFor("GetPlot")(player)
	if not plot then
		return nil, nil
	end
	local spawnPoint = plot:FindFirstChild("SpawnPoint")
	return plot, spawnPoint :: BasePart?
end

----------------------------------------------------------------------
-- Tienda de semillas
----------------------------------------------------------------------
-- Modelo de stock GAG real: StockValues.SeedShop.Items[seed].Value = TOPE rodado
-- (RestockValues), igual para todos, fijado al restock. Cada jugador cuenta sus
-- compras en la réplica PlayerState.Data.PurchasedThisRestock.Seeds[seed]; el
-- cliente muestra remaining = tope - comprado y baja "x N in Stock" por compra.
-- Al restock se rolea el tope y se resetean las compras. Seeds raros
-- (RestockChance < 100) pueden no aparecer. Timer: UnixNextRestock/UnixLastRestock.
local StockValues = ReplicatedStorage:FindFirstChild("StockValues")
local SeedShopStock = StockValues and StockValues:FindFirstChild("SeedShop")
local SeedItems = SeedShopStock and SeedShopStock:FindFirstChild("Items")

local function rollAmount(entry): number
	-- MODDED: stock fijo por rareza, SIEMPRE en stock. Common=14, el resto=5.
	if entry.Rarity == "Common" then
		return MODDED_STOCK_COMMON
	end
	return MODDED_STOCK_OTHER
end

local function restockShop()
	if SeedItems then
		for name, entry in seedByName do
			if entry.RestockShop then
				local nv = SeedItems:FindFirstChild(name)
				if nv and nv:IsA("NumberValue") then
					nv.Value = rollAmount(entry)
				end
			end
		end
	end
	if SeedShopStock then
		local now = os.time()
		local last = SeedShopStock:FindFirstChild("UnixLastRestock")
		local next_ = SeedShopStock:FindFirstChild("UnixNextRestock")
		if last then last.Value = now end
		if next_ then next_.Value = now + RESTOCK_INTERVAL end
	end
	-- Nuevo restock: cada jugador vuelve a poder comprar hasta el tope.
	for _, player in Players:GetPlayers() do
		GameServerAPI.ResetPurchases(player, "Seeds")
	end
end

-- El Handle visual de la semilla lo arma SeedHandleController (cliente) al
-- EQUIPAR y lo quita al guardar (igual que las frutas con
-- HarvestedFruitHandleController). Por eso el server crea el Tool SIN Handle.
-- (Antes el server le ponía Handle + RequiresHandle=true; el controller hacía
-- ClearHandle estando en la mochila y al equipar Roblox la desequipaba -> la
-- semilla "desaparecía al tenerla en la mano".)

local function findSeedTool(player: Player, seedName: string): Tool?
	for _, container in { player:FindFirstChild("Backpack"), player.Character } do
		if container then
			for _, t in container:GetChildren() do
				if t:IsA("Tool") and t:GetAttribute("SeedTool") == seedName then
					return t
				end
			end
		end
	end
	return nil
end

-- Crea el Tool de semilla en el Backpack (no toca el conteo). SIN Handle y con
-- RequiresHandle=false: el visual lo arma SeedHandleController al equipar. El
-- inventario (InventoryController.Main) renderiza la semilla por los atributos
-- SeedTool + Count (no necesita Handle); el icono sale de SeedImages[seedName].
local function spawnSeedTool(player: Player, seedName: string, count: number): Tool
	local tool = Instance.new("Tool")
	tool.Name = seedName .. " Seed"
	tool.CanBeDropped = false
	tool.RequiresHandle = false
	tool:SetAttribute("SeedTool", seedName)
	tool:SetAttribute("MainCategory", "Seed")
	tool:SetAttribute("Count", count)
	tool.Parent = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack")
	return tool
end

-- Sincroniza el Tool con el conteo: crea si falta, ajusta Count, o destruye si 0.
-- MODDED: aplica (o limpia) al Tool los atributos OP guardados en seedMeta.
local function applySeedMeta(player: Player, seedName: string)
	local tool = findSeedTool(player, seedName)
	if not tool then
		return
	end
	local meta = seedMeta[player.UserId] and seedMeta[player.UserId][seedName]
	tool:SetAttribute("SizeMultiplier", meta and meta.SizeMultiplier or nil)
	tool:SetAttribute("ForcedMutation", meta and meta.ForcedMutation or nil)
	tool:SetAttribute("HeightMultiplier", meta and meta.HeightMultiplier or nil)
	tool:SetAttribute("WidthMultiplier", meta and meta.WidthMultiplier or nil)
end

local function syncSeedTool(player: Player, seedName: string, count: number)
	-- MODDED: refleja el conteo en la réplica (Inventory.Seeds) para el Mailbox.
	if GameServerAPI.SetInventorySeed then
		GameServerAPI.SetInventorySeed(player, seedName, count)
	end
	local tool = findSeedTool(player, seedName)
	if count <= 0 then
		if tool then
			tool:Destroy()
		end
		if seedMeta[player.UserId] then
			seedMeta[player.UserId][seedName] = nil
		end
		return
	end
	if not tool then
		spawnSeedTool(player, seedName, count)
	else
		tool:SetAttribute("Count", count)
	end
	applySeedMeta(player, seedName)
end

-- Las semillas se APILAN en un único Tool con atributo Count. seedCounts es la
-- fuente de verdad; el Tool es solo su reflejo en el Backpack.
local function giveSeedTool(player: Player, seedName: string, amount: number?)
	local uid = player.UserId
	seedCounts[uid] = seedCounts[uid] or {}
	seedCounts[uid][seedName] = (seedCounts[uid][seedName] or 0) + (amount or 1)
	syncSeedTool(player, seedName, seedCounts[uid][seedName])
	if persistInventory then
		persistInventory(player)
	end
end

-- Re-crea los Tools de semilla tras un respawn (el Backpack nuevo está vacío).
local function respawnSeedTools(player: Player)
	local counts = seedCounts[player.UserId]
	if not counts then
		return
	end
	for seedName, count in counts do
		if count > 0 then
			syncSeedTool(player, seedName, count)
		end
	end
end

-- MODDED: helper para reproducir un SFX en el cliente. El server reconstruido
-- NUNCA disparaba Networking.SFX (por eso no sonaban compra/venta/etc.); el
-- SfxController del cliente ya escucha PlaySound y reproduce SoundService.SFX[name].
GameServerAPI.PlaySFX = function(player: Player, name: string)
	if player and name then
		Networking.SFX.PlaySound:FireClient(player, name)
	end
end

local function purchaseSeed(player, seedName)
	local entry = seedByName[seedName]
	if not entry then
		return false, "no-entry"
	end
	local nv = SeedItems and SeedItems:FindFirstChild(seedName)
	local maxStock = (nv and nv:IsA("NumberValue")) and nv.Value or 0
	-- stock restante de ESTE jugador este restock = tope - comprado
	local purchased = GameServerAPI.GetPurchaseCount(player, "Seeds", seedName)
	if maxStock - purchased <= 0 then
		return false, "no-stock"
	end
	local price = entry.PurchasePrice or 0
	if GameServerAPI.WaitFor("GetSheckles")(player) < price then
		return false, "no-sheckles"
	end
	GameServerAPI.AddSheckles(player, -price)
	-- Cuenta la compra → el cliente baja "x N in Stock" (remaining = tope - comprado)
	GameServerAPI.IncrementPurchase(player, "Seeds", seedName)
	giveSeedTool(player, seedName)
	GameServerAPI.PlaySFX(player, "Purchase")
	return true
end
Networking.SeedShop.PurchaseSeed.OnServerEvent:Connect(purchaseSeed)

-- Expuesto para otros servicios (p.ej. DevProductService al comprar semillas).
-- Apila 'amount' semillas de 'seedName' en el Backpack vía seedCounts.
GameServerAPI.GiveSeed = function(player: Player, seedName: string, amount: number?): boolean
	if not seedByName[seedName] then
		return false
	end
	giveSeedTool(player, seedName, amount or 1)
	return true
end

-- MODDED: conteo actual de una semilla (para validar envíos del Mailbox).
GameServerAPI.GetSeedCount = function(player: Player, seedName: string): number
	local c = seedCounts[player.UserId]
	return (c and tonumber(c[seedName])) or 0
end

-- MODDED: quita 'amount' semillas SOLO si el jugador las tiene (anti-duplicado).
-- Devuelve true si las quitó. Usa el mismo seedCounts + syncSeedTool + persist.
GameServerAPI.RemoveSeed = function(player: Player, seedName: string, amount: number?): boolean
	amount = math.floor(tonumber(amount) or 0)
	if amount <= 0 then
		return false
	end
	local uid = player.UserId
	local have = (seedCounts[uid] and seedCounts[uid][seedName]) or 0
	if have < amount then
		return false
	end
	seedCounts[uid][seedName] = have - amount
	syncSeedTool(player, seedName, seedCounts[uid][seedName])
	if persistInventory then
		persistInventory(player)
	end
	return true
end

-- MODDED: da una semilla marcada con un SizeMultiplier grande (P2W OpSizeRandomSeed).
-- Al plantarla, la planta crece extremadamente grande (PlantSeed lee el atributo).
GameServerAPI.GiveOpSizeSeed = function(player: Player, seedName: string, size: number?, height: number?, width: number?): boolean
	if not seedByName[seedName] then
		return false
	end
	-- MODDED: guarda los atributos OP en seedMeta (sobreviven respawn y rejoin);
	-- syncSeedTool los reaplica al Tool. alto/ancho = comando /opseed.
	local uid = player.UserId
	seedMeta[uid] = seedMeta[uid] or {}
	seedMeta[uid][seedName] = {
		SizeMultiplier = size or 20,
		HeightMultiplier = height,
		WidthMultiplier = width,
	}
	giveSeedTool(player, seedName, 1)
	return true
end

-- MODDED: semilla con tamaño OP + mutacion forzada (RAINBOWSEEDOPSIZE del merchant).
GameServerAPI.GiveMutatedOpSeed = function(player: Player, seedName: string, size: number?, mutation: string?): boolean
	if not seedByName[seedName] then
		return false
	end
	local uid = player.UserId
	seedMeta[uid] = seedMeta[uid] or {}
	seedMeta[uid][seedName] = {
		SizeMultiplier = size or 10,
		ForcedMutation = mutation,
	}
	giveSeedTool(player, seedName, 1)
	return true
end

----------------------------------------------------------------------
-- Sync de jardines
----------------------------------------------------------------------
Networking.Garden.RequestGardens.OnServerEvent:Connect(function(player)
	-- Asegura que el userId del que pide exista (aunque esté vacío) para
	-- que IsLocalGardenLoaded del cliente pase.
	if not gardens[player.UserId] then
		gardens[player.UserId] = { Plants = {} }
	end
	Networking.Garden.SyncAllGardens:FireClient(player, gardens)
end)

-- Crecimiento offline: el cliente (PlantVisualizerController.runOfflineLoginCutscene)
-- pide estos datos y, si trae oldPlants/newPlants con cambios reales y
-- actualOfflineTime>=300 (5 min), corre la cutscene (OfflineGrowthAnimationController)
-- animando cada planta/fruta de su edad AL SALIR a su edad AHORA. Como nuestras
-- plantas crecen por epoch (Age = now - PlantedAt), el "offline" es la diferencia
-- entre lastLogout y ahora. Devolver { processed=true } = "nada que animar".
Networking.Garden.RequestOfflineGrowthData.OnServerInvoke = function(player)
	local userId = player.UserId
	local lastLogout = tonumber(GameServerAPI.GetLastLogout and GameServerAPI.GetLastLogout(player)) or 0
	local now = os.time()
	local offline = now - lastLogout
	if lastLogout <= 0 or offline < 30 then
		return { processed = true }
	end

	-- esperar un poco a que PlantService restaure las plantas guardadas (carrera
	-- con el join), si aun no estan.
	local garden = gardens[userId]
	local deadline = os.clock() + 5
	while (not garden or next(garden.Plants) == nil) and os.clock() < deadline do
		task.wait(0.2)
		garden = gardens[userId]
	end
	if not garden or next(garden.Plants) == nil then
		return { processed = true }
	end

	local function clampAge(spawnEpoch, maxAge, atEpoch)
		local age = atEpoch - spawnEpoch
		if age < 0 then
			age = 0
		end
		if maxAge and maxAge > 0 and age > maxAge then
			age = maxAge
		end
		return age
	end

	local oldPlants, newPlants = {}, {}
	for plantId, plantData in garden.Plants do
		local plantedAt = tonumber(plantData.PlantedAt) or now
		local maxAge = plantData.MaxAge or 0
		local oldFruits, newFruits = {}, {}
		if plantData.Fruits then
			for fruitId, fruitData in plantData.Fruits do
				local spawnedAt = tonumber(fruitData.SpawnedAt) or now
				local fMax = fruitData.MaxAge or FRUIT_GROW_SECONDS
				local overtime = fruitData.OvertimeGrowth or 1
				newFruits[fruitId] = { Age = clampAge(spawnedAt, fMax, now), MaxAge = fMax, OvertimeGrowth = overtime }
				oldFruits[fruitId] = { Age = clampAge(spawnedAt, fMax, lastLogout), MaxAge = fMax, OvertimeGrowth = overtime }
			end
		end
		newPlants[plantId] = {
			Age = clampAge(plantedAt, maxAge, now),
			MaxAge = maxAge,
			PlantName = plantData.PlantName,
			Fruits = newFruits,
		}
		oldPlants[plantId] = {
			Age = clampAge(plantedAt, maxAge, lastLogout),
			MaxAge = maxAge,
			PlantName = plantData.PlantName,
			Fruits = oldFruits,
		}
	end

	return {
		oldPlants = oldPlants,
		newPlants = newPlants,
		effectiveGrowthTime = offline,
		actualOfflineTime = offline,
	}
end
Networking.Garden.RequestGrowAllData.OnServerInvoke = function()
	return nil
end
Networking.Backpack.GetLayout.OnServerInvoke = function()
	return nil
end

----------------------------------------------------------------------
-- Plantar
----------------------------------------------------------------------
Networking.Plant.PlantSeed.OnServerEvent:Connect(function(player, worldPos, seedName, tool)
	local entry = seedByName[seedName]
	if not entry then
		return
	end
	-- validar el tool (debe ser una semilla de ese tipo en manos del jugador)
	if typeof(tool) ~= "Instance" or not tool:IsA("Tool") or tool:GetAttribute("SeedTool") ~= seedName then
		return
	end
	local character = player.Character
	if tool.Parent ~= character and tool.Parent ~= player:FindFirstChild("Backpack") then
		return
	end
	local plot, spawnPoint = getPlotReference(player)
	if not (plot and spawnPoint) then
		return
	end
	-- validar que la posición esté dentro del área total del jardín
	local zone = plot:FindFirstChild("Visual") and plot.Visual:FindFirstChild("GardenTotalArea")
	if zone then
		local rel = zone.CFrame:PointToObjectSpace(worldPos)
		local half = zone.Size / 2
		if math.abs(rel.X) > half.X + 2 or math.abs(rel.Z) > half.Z + 2 then
			return
		end
	end

	local localPos = spawnPoint.CFrame:PointToObjectSpace(worldPos)
	local plantId = newId()
	local plantData = {
		PlantName = seedName,
		Positions = {
			PosX = localPos.X,
			PosY = localPos.Y,
			PosZ = localPos.Z,
			Rotation = math.random(0, 359),
		},
		PlantedAt = os.time(),
		Age = 0,
		MaxAge = (seedByName[seedName] and seedByName[seedName].Rarity == "Common") and 10 or 60, -- MODDED: Common 10s, resto 60s
		Seed = math.random(1, 2 ^ 30),
		SizeMultiplier = tool:GetAttribute("SizeMultiplier") or 1, -- MODDED: OpSize Random Seed
		HeightMultiplier = tool:GetAttribute("HeightMultiplier") or 1, -- MODDED: comando admin /opseed (alto)
		WidthMultiplier = tool:GetAttribute("WidthMultiplier") or 1, -- MODDED: comando admin /opseed (ancho)
		Mutation = tool:GetAttribute("ForcedMutation"), -- MODDED: mutacion forzada (RAINBOWSEEDOPSIZE merchant)
		Fruits = {},
	}

	local userId = player.UserId
	if not gardens[userId] then
		gardens[userId] = { Plants = {} }
	end
	gardens[userId].Plants[plantId] = plantData
	if not runtime[userId] then
		runtime[userId] = {}
	end
	runtime[userId][plantId] = { seed = entry, lastFruitAt = 0 }

	-- consumir UNA semilla del stack desde la fuente de verdad (seedCounts).
	-- Fallback al atributo Count por si la semilla viene de antes de seedCounts.
	local uid = player.UserId
	local counts = seedCounts[uid]
	local remaining = (((counts and counts[seedName]) or tool:GetAttribute("Count") or 1)) - 1
	if counts then
		counts[seedName] = remaining
	end
	syncSeedTool(player, seedName, remaining)
	broadcast(Networking.Garden.PlantAdded, userId, plantId, plantData)
	-- FX de plantado (la semilla cayendo + decal de tierra + anillo). El cliente
	-- lo renderiza en PlantController:PlayPlantFx(worldPos, seedName). Sin esto la
	-- planta aparecia sin el "golpe" visual al plantar.
	broadcast(Networking.Plant.PlantFx, worldPos, seedName)
	-- MODDED: persistir de inmediato (planta nueva + semilla consumida) para que
	-- no se pierda si la carrera de PlayerRemoving limpia gardens antes de guardar.
	if persistInventory then
		persistInventory(player)
	end
end)

----------------------------------------------------------------------
-- Frutas y cosecha
----------------------------------------------------------------------
-- Conteo de slots de fruta para un Seed concreto: clona el PlantModel, corre el
-- módulo de generación con el mismo Seed/SizeMultiplier que verá el cliente y
-- cuenta los FruitSpawnLocations resultantes. Determinista (Random.new(Seed)),
-- así el índice de cada fruta apunta al mismo slot en ambos lados.
local function computeFruitSlots(entry, plantData): number
	local model = entry.PlantModel
	if not model then
		return 0
	end
	local genModule = PlantGenPlants and PlantGenPlants:FindFirstChild(plantData.PlantName)
	if not genModule or not genModule:IsA("ModuleScript") then
		local locations = model:FindFirstChild("FruitSpawnLocations")
		return locations and #locations:GetChildren() or 0
	end
	local ok, count = pcall(function()
		local gen = require(genModule)
		if type(gen) ~= "table" or type(gen.InitPlant) ~= "function" then
			return 0
		end
		local clone = model:Clone()
		-- IMPORTANTE: algunos InitPlant (p.ej. Blueberry) colocan los FruitSpawn
		-- con workspace:Raycast, que SÓLO funciona si el modelo está en el
		-- workspace. Sin parentar daba 0 slots → esa fruta nunca spawneaba.
		-- Lo mandamos lejos y oculto; el conteo es relativo a la geometría
		-- (mismo resultado que verá el cliente) y se destruye en el acto.
		for _, d in clone:GetDescendants() do
			if d:IsA("BasePart") then
				d.Anchored = true
			end
		end
		clone:PivotTo(CFrame.new(0, 100000, 0))
		clone.Parent = workspace
		gen.InitPlant(clone, plantData.Seed or 0, plantData.SizeMultiplier or 1)
		local locations = clone:FindFirstChild("FruitSpawnLocations")
		local n = locations and #locations:GetChildren() or 0
		clone:Destroy()
		return n
	end)
	if ok and type(count) == "number" and count > 0 then
		return count
	end
	return 0
end

local function giveFruitTool(player: Player, fruitName: string, sizeMultiplier: number?, mutation: string?)
	local tool = Instance.new("Tool")
	tool.Name = fruitName
	tool.RequiresHandle = false
	tool.CanBeDropped = false
	tool:SetAttribute("Fruit", fruitName)
	tool:SetAttribute("FruitName", fruitName)
	tool:SetAttribute("Id", newId())
	tool:SetAttribute("SizeMultiplier", sizeMultiplier or 1)
	tool:SetAttribute("Weight", sizeMultiplier or 1) -- kg que muestra el inventario
	tool:SetAttribute("MainCategory", "Fruit")
	-- HarvestedFruitHandleController exige estos dos para construir el handle visual
	tool:SetAttribute("HarvestedFruit", true)
	tool:SetAttribute("Seed", math.random(1, 2 ^ 30))
	if mutation then
		tool:SetAttribute("Mutation", mutation)
	end
	tool.Parent = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack")
end

Networking.Garden.CollectFruit.OnServerEvent:Connect(function(player, plantId, fruitId)
	local userId = player.UserId
	local garden = gardens[userId]
	local plantData = garden and garden.Plants[plantId]
	if not plantData then
		return
	end
	local plantRuntime = runtime[userId] and runtime[userId][plantId]
	local entry = plantRuntime and plantRuntime.seed
	if not entry then
		return
	end

	if fruitId == nil or fruitId == "" or entry.IsSingleHarvest then
		-- cosecha única: la planta entera se recoge
		if (plantData.Age or 0) < (plantData.MaxAge or 0) then
			return
		end
		garden.Plants[plantId] = nil
		runtime[userId][plantId] = nil
		broadcast(Networking.Garden.PlantRemoved, userId, plantId)
		giveFruitTool(player, plantData.PlantName, plantData.SizeMultiplier)
	else
		local fruitData = plantData.Fruits and plantData.Fruits[fruitId]
		if not fruitData then
			return
		end
		if (fruitData.Age or 0) < (fruitData.MaxAge or 0) then
			return -- aún no madura
		end
		plantData.Fruits[fruitId] = nil
		broadcast(Networking.Garden.FruitRemoved, userId, plantId, fruitId)
		giveFruitTool(player, plantData.PlantName, fruitData.SizeMultiplier, fruitData.Mutation)
	end
end)

----------------------------------------------------------------------
-- Pala (Shovel): elimina una planta entera del jardín del jugador.
-- Cliente: ShovelController dispara UseShovel(plantId, fruitId, shovelAttr, tool)
-- al cavar. El server solo borra plantas del PROPIO jardín (autoridad por UserId).
-- Reusa el mismo borrado/broadcast que la cosecha (PlantRemoved) para que el
-- cliente quite el modelo. No devuelve fruta (la pala destruye, no cosecha).
----------------------------------------------------------------------
Networking.Shovel.UseShovel.OnServerEvent:Connect(function(player, plantId, fruitId, shovelAttr, tool)
	print("[DIG][normal] RECIBIDO de", player.Name, "| plantId=", plantId, "| fruitId=", fruitId, "| shovelAttr=", shovelAttr) -- [TEMP DEBUG plotdebug]
	if typeof(plantId) ~= "string" or plantId == "" then
		print("[DIG][normal] RECHAZADO: plantId inválido, type=", typeof(plantId)) -- [TEMP DEBUG plotdebug]
		return
	end
	local userId = player.UserId
	local garden = gardens[userId]
	local plantData = garden and garden.Plants[plantId]
	-- FIX: el ShovelController manda el NOMBRE del modelo = "userId_plantId"
	-- (compuesto), no el plantId puro con el que el server indexa gardens. Quitar
	-- el prefijo "<userId>_" para encontrar la planta.
	if not plantData and garden then
		local stripped = tostring(plantId):match("^%d+_(.+)$")
		if stripped and garden.Plants[stripped] then
			plantId = stripped
			plantData = garden.Plants[stripped]
		end
	end
	if not plantData then
		local ids = {}
		if garden then for k in pairs(garden.Plants) do ids[#ids + 1] = k end end
		print("[DIG][normal] RECHAZADO: plantId", plantId, "NO está en gardens[", userId, "] | vivas:", table.concat(ids, ", ")) -- [TEMP DEBUG plotdebug]
		return
	end
	garden.Plants[plantId] = nil
	if runtime[userId] then
		runtime[userId][plantId] = nil
	end
	broadcast(Networking.Garden.PlantRemoved, userId, plantId)
	-- a partir de la primera vez el cliente salta el prompt de confirmación
	player:SetAttribute("HasShoveledPlant", true)
	-- MODDED: persistir el borrado YA (si no, la carrera de PlayerRemoving puede
	-- dejar el save viejo y la planta "vuelve" al rejoin).
	if persistInventory then
		persistInventory(player)
	end
	-- [TEMP DEBUG plotdebug] verificar persistencia tras dig (quitar cuando termine)
	do
		local saved = GameServerAPI.GetSavedPlants(player)
		local n = 0
		for _ in pairs(saved or {}) do n += 1 end
		print(("[DIG][normal] %s borró %s | SAVED=%d plantas | ¿sigue en DB? %s"):format(player.Name, tostring(plantId), n, tostring((saved or {})[plantId] ~= nil)))
	end
end)

----------------------------------------------------------------------
-- MODDED: Rainbow Shovel (super-pala con gamepass). Borra CUALQUIER planta de
-- CUALQUIER plot. Valida gamepass + cooldown 30s server-side y persiste el
-- borrado para el DUEÑO de la planta (no para quien la borra).
----------------------------------------------------------------------
do
	local MarketplaceService = game:GetService("MarketplaceService")
	local RAINBOW_GAMEPASS = 1875843847
	local RAINBOW_COOLDOWN = 30
	local RAINBOW_MONEY_COST = 50000000 -- MODDED: 50M sheckles; compra NO persistente (se pierde al salir del server)
	local lastUse: { [Player]: number } = {}
	local ownsCache: { [number]: boolean } = {}
	local moneyGranted: { [Player]: boolean } = {} -- acceso comprado con sheckles (solo esta sesión)

	local function setAccessAttr(player: Player)
		if player and player.Parent then
			player:SetAttribute("RainbowShovelAccess", true)
		end
	end

	-- Solo cachea POSITIVOS (sticky); si da false re-consulta la próxima vez. Así
	-- una compra (PromptGamePassPurchaseFinished) o un check positivo lo deja
	-- habilitado para siempre, y un false transitorio no lo bloquea.
	local function ownsGamepass(player: Player): boolean
		if game:GetService("RunService"):IsStudio() then
			return true -- en Studio no se puede verificar gamepass; permitir test (en producción IsStudio=false)
		end
		local uid = player.UserId
		if ownsCache[uid] then
			return true
		end
		local ok, res = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(uid, RAINBOW_GAMEPASS)
		end)
		if ok and res then
			ownsCache[uid] = true
			setAccessAttr(player)
			return true
		end
		return false
	end

	-- Acceso = gamepass (permanente) o compra con sheckles (solo esta sesión)
	local function hasAccess(player: Player): boolean
		return moneyGranted[player] == true or ownsGamepass(player)
	end

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, id, purchased)
		if id == RAINBOW_GAMEPASS and purchased then
			ownsCache[player.UserId] = true
			setAccessAttr(player)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		lastUse[player] = nil
		ownsCache[player.UserId] = nil
		moneyGranted[player] = nil
	end)

	local remote = ReplicatedStorage:FindFirstChild("RainbowShovelDelete")
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = "RainbowShovelDelete"
		remote.Parent = ReplicatedStorage
	end

	-- Compra con sheckles (50M): da acceso de SESIÓN (no se persiste; se pierde al salir).
	local buyMoney = ReplicatedStorage:FindFirstChild("RainbowShovelBuyMoney")
	if not buyMoney then
		buyMoney = Instance.new("RemoteEvent")
		buyMoney.Name = "RainbowShovelBuyMoney"
		buyMoney.Parent = ReplicatedStorage
	end
	buyMoney.OnServerEvent:Connect(function(player)
		if hasAccess(player) then
			buyMoney:FireClient(player, "granted") -- ya tiene acceso (gamepass o compra previa)
			return
		end
		local getSheckles = GameServerAPI.WaitFor("GetSheckles")
		if getSheckles(player) < RAINBOW_MONEY_COST then
			buyMoney:FireClient(player, "no-sheckles")
			return
		end
		GameServerAPI.AddSheckles(player, -RAINBOW_MONEY_COST)
		moneyGranted[player] = true
		setAccessAttr(player)
		if GameServerAPI.PlaySFX then
			GameServerAPI.PlaySFX(player, "Purchase")
		end
		buyMoney:FireClient(player, "granted")
	end)

	remote.OnServerEvent:Connect(function(player, targetUserId, plantId)
		print("[DIG][rainbow] recibido de", player.Name, "uid=", targetUserId, "plantId=", plantId) -- [TEMP DEBUG plotdebug]
		targetUserId = tonumber(targetUserId)
		if not targetUserId or typeof(plantId) ~= "string" or plantId == "" then
			print("[DIG][rainbow] RECHAZADO: args inválidos") -- [TEMP DEBUG plotdebug]
			return
		end
		if not hasAccess(player) then
			return
		end
		local now = os.clock()
		if now - (lastUse[player] or -math.huge) < RAINBOW_COOLDOWN then
			print("[DIG][rainbow] RECHAZADO: cooldown") -- [TEMP DEBUG plotdebug]
			return
		end
		local garden = gardens[targetUserId]
		local plantData = garden and garden.Plants[plantId]
		if not plantData then
			print("[DIG][rainbow] RECHAZADO: planta no existe en gardens[", targetUserId, "]") -- [TEMP DEBUG plotdebug]
			return
		end
		garden.Plants[plantId] = nil
		if runtime[targetUserId] then
			runtime[targetUserId][plantId] = nil
		end
		lastUse[player] = now
		broadcast(Networking.Garden.PlantRemoved, targetUserId, plantId)
		-- persistir el borrado para el DUEÑO de la planta (su jardín cambió)
		local owner = Players:GetPlayerByUserId(targetUserId)
		if owner and persistInventory then
			persistInventory(owner)
		end
		-- [TEMP DEBUG plotdebug] verificar persistencia tras dig (quitar cuando termine)
		do
			local saved = owner and GameServerAPI.GetSavedPlants(owner) or {}
			local n = 0
			for _ in pairs(saved or {}) do n += 1 end
			print(("[DIG][rainbow] %s borró %s del plot uid %d | SAVED dueño=%d | ¿sigue en DB? %s"):format(player.Name, tostring(plantId), targetUserId, n, tostring((saved or {})[plantId] ~= nil)))
		end
		remote:FireClient(player, "cooldown", RAINBOW_COOLDOWN)
	end)
end

----------------------------------------------------------------------
-- Venta (Steven)
----------------------------------------------------------------------
local function collectFruitTools(player: Player): { Tool }
	local tools = {}
	local character = player.Character
	if character then
		for _, child in character:GetChildren() do
			if child:IsA("Tool") and child:GetAttribute("FruitName") then
				table.insert(tools, child)
			end
		end
	end
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		for _, child in backpack:GetChildren() do
			if child:IsA("Tool") and child:GetAttribute("FruitName") then
				table.insert(tools, child)
			end
		end
	end
	return tools
end

local SELL_MULTIPLIER = 30 -- MODDED: x30 al valor de cada planta/fruta que venda el jugador

local function toolValue(player: Player, tool: Tool): number
	local ok, value = pcall(
		FruitValueCalc,
		tool:GetAttribute("FruitName"),
		tool:GetAttribute("SizeMultiplier"),
		tool:GetAttribute("Mutation"),
		player,
		tool:GetAttribute("DecayAlpha")
	)
	if ok and typeof(value) == "number" then
		return math.max(0, math.floor(value * SELL_MULTIPLIER))
	end
	return 1
end

Networking.NPCS.SellFruit.OnServerInvoke = function(player, fruitId)
	for _, tool in collectFruitTools(player) do
		if tool:GetAttribute("Id") == fruitId then
			local value = toolValue(player, tool)
			tool:Destroy()
			value = value * ((GameServerAPI.GetSheckleMultiplier and GameServerAPI.GetSheckleMultiplier(player)) or 1) -- MODDED
			GameServerAPI.WaitFor("AddSheckles")(player, value)
			GameServerAPI.PlaySFX(player, "RecordSale")
			return { Success = true, SellPrice = value }
		end
	end
	return { Success = false }
end

Networking.NPCS.PreviewSellAll.OnServerInvoke = function(player)
	local total, count = 0, 0
	for _, tool in collectFruitTools(player) do
		total += toolValue(player, tool)
		count += 1
	end
	return { FruitCount = count, TotalValue = total }
end

Networking.NPCS.SellAll.OnServerInvoke = function(player)
	local total, count = 0, 0
	for _, tool in collectFruitTools(player) do
		total += toolValue(player, tool)
		count += 1
		tool:Destroy()
	end
	if count > 0 then
		total = total * ((GameServerAPI.GetSheckleMultiplier and GameServerAPI.GetSheckleMultiplier(player)) or 1) -- MODDED
		GameServerAPI.WaitFor("AddSheckles")(player, total)
		GameServerAPI.PlaySFX(player, "RecordSale")
	end
	return { Success = true, SellPrice = total, SoldCount = count }
end

Networking.NPCS.CheckDailyDeal.OnServerInvoke = function()
	return { Available = false }
end
Networking.NPCS.GetFruitBid.OnServerInvoke = function()
	return { BidPrice = 0 }
end
Networking.NPCS.AskBid.OnServerInvoke = function()
	return { Success = false }
end
Networking.NPCS.AskBidAll.OnServerInvoke = function()
	return { Success = false }
end
Networking.NPCS.SellPet.OnServerInvoke = function()
	return { Success = false }
end

----------------------------------------------------------------------
-- Loop de crecimiento
----------------------------------------------------------------------
task.spawn(function()
	while true do
		task.wait(AGE_SYNC_INTERVAL)
		local now = os.time()
		for userId, garden in gardens do
			-- MODDED: buffs de pets del dueño — Deer (crecimiento) + Unicorn/Golden Dragonfly (mutación).
			-- Los setea PetBehaviorService como atributos del jugador.
			local petOwner = Players:GetPlayerByUserId(userId)
			local growthMult = tonumber(petOwner and petOwner:GetAttribute("PetGrowthMult")) or 1
			if growthMult < 1 then growthMult = 1 end
			local rainbowMult = tonumber(petOwner and petOwner:GetAttribute("PetRainbowMult")) or 1
			local goldMult = tonumber(petOwner and petOwner:GetAttribute("PetGoldMult")) or 1
			local petMutMults = (rainbowMult > 1 or goldMult > 1)
				and { Rainbow = rainbowMult, Gold = goldMult }
				or nil
			local plantAges = {}
			local hasPlants = false
			for plantId, plantData in garden.Plants do
				hasPlants = true
				local age = math.min(plantData.MaxAge or 60, (now - (plantData.PlantedAt or now)) * growthMult)
				plantData.Age = age
				plantAges[plantId] = age

				local plantRuntime = runtime[userId] and runtime[userId][plantId]
				local entry = plantRuntime and plantRuntime.seed
				-- plantas multi-cosecha maduras: spawnear frutas
				if entry and not entry.IsSingleHarvest and age >= (plantData.MaxAge or 60) then
					if plantRuntime.slots == nil then
						plantRuntime.slots = computeFruitSlots(entry, plantData)
					end
					local slots = plantRuntime.slots
					local current = 0
					local usedSlots = {}
					for _, fruitData in plantData.Fruits do
						current += 1
						usedSlots[fruitData.SpawnLocationIndex] = true
					end
					if slots > 0 and current < slots and now - (plantRuntime.lastFruitAt or 0) >= FRUIT_SPAWN_INTERVAL then
						local slotIndex
						for i = 1, slots do
							if not usedSlots[i] then
								slotIndex = i
								break
							end
						end
						if slotIndex then
							plantRuntime.lastFruitAt = now
							local fruitId = newId()
							local fruitData = {
								SpawnLocationIndex = slotIndex,
								Age = 0,
								MaxAge = FRUIT_GROW_SECONDS,
								GrowRate = 1,
								OvertimeGrowth = 1,
								Seed = math.random(1, 2 ^ 30),
								SizeMultiplier = fruitSizeBuffFor(userId), -- MODDED: buff OP Sprinkler del dueño
								SpawnedAt = now,
							}
							plantData.Fruits[fruitId] = fruitData
							broadcast(Networking.Garden.FruitAdded, userId, plantId, fruitId, fruitData)
							-- mutacion al crecer (solo las CanGetOnGrowth: Gold/Rainbow);
							-- las de clima (Frozen/Electric/Starstruck/Bloodlit) se aplican
							-- en el loop de clima de mas abajo.
							local mut = (plantData.Mutation and plantData.Mutation ~= "" and plantData.Mutation) or MutationData.ReturnFruitMutation(fruitData.Seed, petMutMults)
							if mut then
								fruitData.Mutation = mut
								broadcast(Networking.Garden.FruitMutationUpdated, userId, plantId, fruitId, mut)
							end
						end
					end
				end

				-- edades de frutas
				local fruitAges = {}
				local hasFruits = false
				for fruitId, fruitData in plantData.Fruits do
					hasFruits = true
					local fruitAge = math.min(fruitData.MaxAge or FRUIT_GROW_SECONDS, (now - (fruitData.SpawnedAt or now)) * growthMult)
					fruitData.Age = fruitAge
					fruitAges[fruitId] = fruitAge
				end
				if hasFruits then
					broadcast(Networking.Garden.FruitAgeSync, userId, plantId, fruitAges)
				end
			end
			if hasPlants then
				broadcast(Networking.Garden.PlantAgeSync, userId, plantAges)
			end
		end
	end
end)

----------------------------------------------------------------------
-- Restock + jugadores
----------------------------------------------------------------------
restockShop() -- stock inicial (escribe los NumberValue replicados)
task.spawn(function()
	while true do
		local next_ = SeedShopStock and SeedShopStock:FindFirstChild("UnixNextRestock")
		local waitFor = (next_ and next_.Value or (os.time() + RESTOCK_INTERVAL)) - os.time()
		task.wait(math.max(1, waitFor))
		restockShop()
	end
end)

-- Guardado: snapshot serializable de las plantas (sin frutas, se regeneran)
-- Reset de jardin para el comando de testeo /resetdata (lo invoca GameServer).
-- Limpia el estado de plantas/semillas del jugador y avisa al cliente que quite
-- cada planta y destruye los Tools de semilla.
-- MODDED: forzar un restock de la SeedShop (botón RestockShop del Admin Panel).
GameServerAPI.RestockSeedShop = restockShop

-- MODDED: crecer al instante todas las plantas del jugador (botón GrowAll del Admin Panel).
GameServerAPI.GrowAllPlants = function(player: Player): number
	local userId = player.UserId
	local garden = gardens[userId]
	if not garden then
		return 0
	end
	local plantAges = {}
	local n = 0
	for plantId, plantData in garden.Plants do
		local maxAge = plantData.MaxAge or 60
		plantData.PlantedAt = os.time() - maxAge
		plantData.Age = maxAge
		plantAges[plantId] = maxAge
		n += 1
	end
	if next(plantAges) ~= nil then
		broadcast(Networking.Garden.PlantAgeSync, userId, plantAges)
	end
	return n
end

----------------------------------------------------------------------
-- MODDED: Grow de UNA planta (botón Grow del GrowingList / HarvestPrompt).
-- El cliente avisa QUÉ planta por Networking.GrowPlant ANTES de comprar el
-- DevProduct; al entregarlo, DevProductService llama GrowOnePlant.
----------------------------------------------------------------------
local growPlantPending = {} -- [userId] = plantId

Networking.GrowPlant.OnServerEvent:Connect(function(player, plantId)
	if type(plantId) == "string" and plantId ~= "" then
		growPlantPending[player.UserId] = plantId
	end
end)

GameServerAPI.GrowOnePlant = function(player: Player): boolean
	local userId = player.UserId
	local garden = gardens[userId]
	local plantId = growPlantPending[userId]
	if not (garden and plantId) then
		return false
	end
	local plantData = garden.Plants[plantId]
	if not plantData then
		return false
	end
	local maxAge = plantData.MaxAge or 60
	plantData.PlantedAt = os.time() - maxAge
	plantData.Age = maxAge
	broadcast(Networking.Garden.PlantAgeSync, userId, { [plantId] = maxAge })
	growPlantPending[userId] = nil
	return true
end

GameServerAPI.ResetGarden = function(player: Player)
	local userId = player.UserId
	local garden = gardens[userId]
	if garden then
		for plantId in garden.Plants do
			broadcast(Networking.Garden.PlantRemoved, userId, plantId)
		end
	end
	gardens[userId] = nil
	runtime[userId] = nil
	seedCounts[userId] = nil
	for _, container in { player:FindFirstChild("Backpack"), player.Character } do
		if container then
			for _, t in container:GetChildren() do
				if t:IsA("Tool") and t:GetAttribute("SeedTool") then
					t:Destroy()
				end
			end
		end
	end
end

GameServerAPI.GetGardenSave = function(userId: number)
	local garden = gardens[userId]
	if not garden then
		return nil -- jugador ya limpiado: no sobrescribir el save comprometido
	end
	local save = {}
	for plantId, plantData in garden.Plants do
		save[plantId] = {
			PlantName = plantData.PlantName,
			Positions = plantData.Positions,
			PlantedAt = plantData.PlantedAt,
			MaxAge = plantData.MaxAge,
			Seed = plantData.Seed,
			SizeMultiplier = plantData.SizeMultiplier,
			HeightMultiplier = plantData.HeightMultiplier, -- MODDED: /opseed
			WidthMultiplier = plantData.WidthMultiplier,   -- MODDED: /opseed
		}
	end
	return save
end

-- MODDED: snapshot de semillas (conteo + atributos OP) para persistir en el perfil.
GameServerAPI.GetSeedSave = function(userId: number)
	local counts = seedCounts[userId]
	if not counts then
		return nil
	end
	local save = {}
	for seedName, count in counts do
		if count and count > 0 then
			local meta = seedMeta[userId] and seedMeta[userId][seedName]
			save[seedName] = {
				Count = count,
				SizeMultiplier = meta and meta.SizeMultiplier,
				ForcedMutation = meta and meta.ForcedMutation,
				HeightMultiplier = meta and meta.HeightMultiplier,
				WidthMultiplier = meta and meta.WidthMultiplier,
			}
		end
	end
	return save
end

-- MODDED: persiste jardín + semillas AL INSTANTE (no depende del orden de
-- PlayerRemoving). Llama a las APIs de GameServer (perfil activo durante el juego).
persistInventory = function(player: Player)
	if not player or not player.Parent then
		return
	end
	local userId = player.UserId
	local commitG = GameServerAPI.CommitGardenSave
	local g = GameServerAPI.GetGardenSave(userId)
	if commitG and g then
		commitG(player, g)
	end
	local commitS = GameServerAPI.CommitSeedSave
	local s = GameServerAPI.GetSeedSave(userId)
	if commitS and s then
		commitS(player, s)
	end
end

-- MODDED: restaura las semillas guardadas (incluye OP/Rainbow/SeedSize) al unirse.
local function restoreSavedSeeds(player: Player)
	local saved = GameServerAPI.WaitFor("GetSavedSeeds")(player)
	if player.Parent == nil then
		return
	end
	local uid = player.UserId
	seedCounts[uid] = seedCounts[uid] or {}
	seedMeta[uid] = seedMeta[uid] or {}
	if typeof(saved) == "table" then
		for seedName, rec in saved do
			if seedByName[seedName] and typeof(rec) == "table" and (tonumber(rec.Count) or 0) > 0 then
				seedCounts[uid][seedName] = rec.Count
				if rec.SizeMultiplier or rec.ForcedMutation or rec.HeightMultiplier or rec.WidthMultiplier then
					seedMeta[uid][seedName] = {
						SizeMultiplier = rec.SizeMultiplier,
						ForcedMutation = rec.ForcedMutation,
						HeightMultiplier = rec.HeightMultiplier,
						WidthMultiplier = rec.WidthMultiplier,
					}
				end
				syncSeedTool(player, seedName, rec.Count)
			end
		end
	end
end

local function restoreSavedPlants(player: Player)
	local saved = GameServerAPI.WaitFor("GetSavedPlants")(player)
	if not saved or next(saved) == nil or player.Parent == nil then
		return
	end
	local userId = player.UserId
	if not gardens[userId] then
		gardens[userId] = { Plants = {} }
	end
	if not runtime[userId] then
		runtime[userId] = {}
	end
	-- MODDED: escalonar el spawn para evitar el pico de lag al entrar con muchas plantas.
	local n = 0
	for plantId, plantData in saved do
		local entry = seedByName[plantData.PlantName]
		if entry then
			plantData.Age = math.min(plantData.MaxAge or 60, os.time() - (plantData.PlantedAt or os.time()))
			plantData.Fruits = {}
			gardens[userId].Plants[plantId] = plantData
			runtime[userId][plantId] = { seed = entry, lastFruitAt = 0 }
			broadcast(Networking.Garden.PlantAdded, userId, plantId, plantData)
			n += 1
			if n % 4 == 0 then
				task.wait() -- repartir el envío en varios frames
			end
		end
	end
end

local function onPlayerAdded(player: Player)
	-- restaurar el jardín guardado (espera al perfil)
	task.spawn(restoreSavedPlants, player)
	-- re-crear las semillas tras CADA respawn (Roblox reinicia el Backpack y
	-- borraría los Tools dados en runtime)
	player.CharacterAdded:Connect(function()
		task.defer(respawnSeedTools, player)
	end)
	-- MODDED: restaurar semillas guardadas (incluye OP/Rainbow/SeedSize). Si no
	-- había ninguna guardada, dar las de prueba (antes se daban SIEMPRE -> se
	-- apilaban en cada rejoin).
	task.spawn(function()
		restoreSavedSeeds(player)
		local counts = seedCounts[player.UserId]
		if not counts or next(counts) == nil then
			giveSeedTool(player, "Carrot")
			giveSeedTool(player, "Carrot")
			giveSeedTool(player, "Strawberry")
		end
	end)
end

-- MODDED: Dragon's Breath ataca de NOCHE — daña a los intrusos (no dueños)
-- que estén cerca de una Dragon's Breath madura en el jardín.
do
	local DRAGON_SEED = "Dragon's Breath"
	local DB_RADIUS = 18
	local DB_DPS = 12
	local DB_TICK = 1
	task.spawn(function()
		while true do
			task.wait(DB_TICK)
			-- solo de noche y solo si hay un posible intruso (2+ jugadores)
			if workspace:GetAttribute("ActivePhase") ~= "Night" then
				continue
			end
			local players = Players:GetPlayers()
			if #players < 2 then
				continue
			end
			for ownerId, garden in gardens do
				local owner = Players:GetPlayerByUserId(ownerId)
				if not owner then
					continue
				end
				local _, spawnPoint = getPlotReference(owner)
				if not spawnPoint then
					continue
				end
				for _, plantData in garden.Plants do
					if plantData.PlantName == DRAGON_SEED and plantData.Positions then
						local age = os.time() - (plantData.PlantedAt or os.time())
						if age >= (plantData.MaxAge or 60) then
							local p = plantData.Positions
							local wpos = spawnPoint.CFrame:PointToWorldSpace(Vector3.new(p.PosX, p.PosY, p.PosZ))
							for _, other in players do
								if other.UserId ~= ownerId then
									local char = other.Character
									local hrp = char and char:FindFirstChild("HumanoidRootPart")
									local hum = char and char:FindFirstChildOfClass("Humanoid")
									if hrp and hum and hum.Health > 0 and (hrp.Position - wpos).Magnitude <= DB_RADIUS then
										hum:TakeDamage(DB_DPS * DB_TICK)
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in Players:GetPlayers() do
	task.spawn(onPlayerAdded, player)
end

Players.PlayerRemoving:Connect(function(player)
	local userId = player.UserId
	-- comprometer el save ANTES de limpiar (evita carrera con GameServer)
	local commit = GameServerAPI.CommitGardenSave
	local save = GameServerAPI.GetGardenSave(userId)
	if commit and save then
		commit(player, save)
	end
	if gardens[userId] then
		for plantId in gardens[userId].Plants do
			broadcast(Networking.Garden.PlantRemoved, userId, plantId)
		end
	end
	gardens[userId] = nil
	runtime[userId] = nil
	seedCounts[userId] = nil
end)

----------------------------------------------------------------------
-- Robo (Steal) — solo de noche. El cliente (StealController) ya maneja
-- prompts, animaciones y el apilado visual de la fruta cargada; aquí va la
-- autoridad: validar el objetivo, quitárselo al dueño, marcar al ladrón como
-- "cargando" y depositar la fruta al volver a su propio jardín.
----------------------------------------------------------------------
do
	local Steal = Networking.Steal

	-- ReplicatedStorage.Night lo lee el cliente para permitir el robo, pero nadie
	-- lo mantenía (TimeCycleServer solo escribe workspace.ActivePhase). Lo
	-- derivamos de ahí: sin esto el robo NUNCA se permitía.
	local NightValue = ReplicatedStorage:FindFirstChild("Night")
	local function isNight(): boolean
		return workspace:GetAttribute("ActivePhase") == "Night"
	end
	local function syncNight()
		if NightValue then
			NightValue.Value = isNight()
		end
	end
	workspace:GetAttributeChangedSignal("ActivePhase"):Connect(syncNight)
	syncNight()

	-- activeSteal[player]   = { ownerUserId, plantId, fruitId, key } robo en curso
	-- lockedTargets[key]    = player que lo está robando (evita doble robo)
	-- carried[player]       = { { name, sizeMultiplier, mutation, seed }, ... }
	local activeSteal: { [Player]: any } = {}
	local lockedTargets: { [string]: Player } = {}
	local carried: { [Player]: { any } } = {}

	local function targetKey(ownerUserId, plantId, fruitId): string
		return ("%d|%s|%s"):format(ownerUserId, tostring(plantId), tostring(fruitId or ""))
	end

	-- Resuelve el objetivo robable y devuelve sus datos de display SIN mutar nada.
	-- fruitId vacío/"" = planta de cosecha única; si no, una fruta concreta.
	local function resolveTarget(ownerUserId, plantId, fruitId)
		local garden = gardens[ownerUserId]
		local plantData = garden and garden.Plants[plantId]
		if not plantData then
			return nil
		end
		if fruitId == nil or fruitId == "" then
			return {
				kind = "plant",
				plantData = plantData,
				name = plantData.PlantName,
				sizeMultiplier = plantData.SizeMultiplier or 1,
				mutation = plantData.Mutation,
				seed = plantData.Seed or 0,
			}
		end
		local fruitData = plantData.Fruits and plantData.Fruits[fruitId]
		if not fruitData then
			return nil
		end
		return {
			kind = "fruit",
			plantData = plantData,
			fruitData = fruitData,
			name = plantData.PlantName,
			sizeMultiplier = fruitData.SizeMultiplier or 1,
			mutation = fruitData.Mutation,
			seed = fruitData.Seed or 0,
		}
	end

	-- Candado del jardín: de noche un jardín solo es robable si su dueño NO está
	-- dentro (si está presente → "Garden Locked!", lo protege). PlotsController ya
	-- muestra el cartel; aquí va la regla real. Dueño offline = no robable (sus
	-- plantas ya desaparecen del mundo al salir).
	local function isGardenProtected(ownerUserId): boolean
		local owner = Players:GetPlayerByUserId(ownerUserId)
		return owner ~= nil and owner:GetAttribute("IsInOwnGarden") == true
	end

	-- Cancela el robo en curso del jugador y (opcionalmente) restaura el visual.
	local function clearSteal(player: Player, restore: boolean)
		local s = activeSteal[player]
		if not s then
			return
		end
		activeSteal[player] = nil
		if lockedTargets[s.key] == player then
			lockedTargets[s.key] = nil
		end
		broadcast(Steal.StealCancelled, player)
		if restore then
			broadcast(Steal.RestoreFruitAppearance, s.ownerUserId, s.plantId, s.fruitId)
		end
	end

	Steal.BeginSteal.OnServerEvent:Connect(function(player, ownerUserId, plantId, fruitId)
		fruitId = fruitId or ""
		if typeof(ownerUserId) ~= "number" or type(plantId) ~= "string" then
			return
		end
		if ownerUserId == player.UserId then
			return -- no tiene sentido robarte a ti mismo
		end
		if not isNight() then
			return
		end
		if isGardenProtected(ownerUserId) then
			return -- el dueño está en su jardín: "Garden Locked!"
		end
		if not resolveTarget(ownerUserId, plantId, fruitId) then
			return
		end
		local key = targetKey(ownerUserId, plantId, fruitId)
		local holder = lockedTargets[key]
		if holder and holder ~= player and holder.Parent then
			return -- otro jugador ya lo está robando
		end
		clearSteal(player, true) -- soltar cualquier robo previo de este jugador
		activeSteal[player] = { ownerUserId = ownerUserId, plantId = plantId, fruitId = fruitId, key = key }
		lockedTargets[key] = player
		broadcast(Steal.StealStarted, player)
		broadcast(Steal.MarkFruitStolen, ownerUserId, plantId, fruitId)
	end)

	Steal.CancelSteal.OnServerEvent:Connect(function(player)
		clearSteal(player, true)
	end)

	Steal.CompleteSteal.OnServerEvent:Connect(function(player)
		local s = activeSteal[player]
		if not s then
			return
		end
		activeSteal[player] = nil
		if lockedTargets[s.key] == player then
			lockedTargets[s.key] = nil
		end

		local target = resolveTarget(s.ownerUserId, s.plantId, s.fruitId)
		if not target then
			-- el dueño ya lo cosechó/vendió: solo limpiar el resaltado
			broadcast(Steal.StealCancelled, player)
			return
		end

		-- el dueño volvió a su jardín durante el hold → protegido, abortar
		if isGardenProtected(s.ownerUserId) then
			broadcast(Steal.StealCancelled, player)
			broadcast(Steal.RestoreFruitAppearance, s.ownerUserId, s.plantId, s.fruitId)
			return
		end

		-- quitarle el objetivo al dueño (autoritativo, igual que cosechar)
		if target.kind == "plant" then
			local garden = gardens[s.ownerUserId]
			if garden then
				garden.Plants[s.plantId] = nil
			end
			if runtime[s.ownerUserId] then
				runtime[s.ownerUserId][s.plantId] = nil
			end
			broadcast(Networking.Garden.PlantRemoved, s.ownerUserId, s.plantId)
		else
			target.plantData.Fruits[s.fruitId] = nil
			broadcast(Networking.Garden.FruitRemoved, s.ownerUserId, s.plantId, s.fruitId)
		end

		broadcast(Steal.StealCancelled, player) -- quitar el resaltado de "robando"

		-- registrar lo cargado y mostrar el visual apilado sobre el ladrón
		if not carried[player] then
			carried[player] = {}
		end
		table.insert(carried[player], {
			name = target.name,
			sizeMultiplier = target.sizeMultiplier,
			mutation = target.mutation,
			seed = target.seed,
		})
		broadcast(
			Steal.AddStolenFruitVisual,
			player.UserId,
			target.name,
			target.seed,
			target.sizeMultiplier,
			0,
			target.mutation or ""
		)

		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root then
			broadcast(Steal.PopVFX, root.Position, 1)
		end

		player:SetAttribute("CarryingStolenFruit", true)
	end)

	----------------------------------------------------------------------
	-- Depósito: al volver a TU propio jardín, la fruta robada pasa a tu mochila
	-- como Tools normales. GameServer mantiene el atributo IsInOwnGarden.
	----------------------------------------------------------------------
	local function depositCarried(player: Player)
		local list = carried[player]
		carried[player] = nil
		if list then
			for _, item in list do
				giveFruitTool(player, item.name, item.sizeMultiplier, item.mutation)
			end
		end
		broadcast(Steal.ClearStolenFruitVisuals, player.UserId)
		player:SetAttribute("CarryingStolenFruit", false)
		player:SetAttribute("StolenCarryValue", 0)
	end

	local function hookPlayer(player: Player)
		player:GetAttributeChangedSignal("IsInOwnGarden"):Connect(function()
			if player:GetAttribute("IsInOwnGarden") and carried[player] and #carried[player] > 0 then
				depositCarried(player)
			end
		end)
	end
	Players.PlayerAdded:Connect(hookPlayer)
	for _, player in Players:GetPlayers() do
		hookPlayer(player)
	end

	Players.PlayerRemoving:Connect(function(player)
		local s = activeSteal[player]
		if s and lockedTargets[s.key] == player then
			lockedTargets[s.key] = nil
		end
		activeSteal[player] = nil
		carried[player] = nil
	end)

	print("[PlantService] Steal (robo nocturno) listo")
end

----------------------------------------------------------------------
-- Mutaciones por clima. Las mutaciones CanGetOnGrowth=false (Frozen/Electric/
-- Starstruck/Bloodlit) solo salen durante su clima. Mientras dure, cada fruta
-- sin mutacion tiene una probabilidad por pasada de ganarla. Mapeo segun las
-- descripciones de WeatherData (Lightning="shocked", Snowfall="frozen", etc.).
----------------------------------------------------------------------
do
	local WeatherValues = ReplicatedStorage:FindFirstChild("WeatherValues")
	local WEATHER_MUTATION = {
		Lightning = "Electric",
		Snowfall = "Frozen",
		Starfall = "Starstruck",
	}
	local WEATHER_ROLL_INTERVAL = 4 -- seg entre pasadas
	local WEATHER_FRUIT_CHANCE = 0.05 -- prob. por fruta y por pasada

	local function activeWeatherMutation(): string?
		if workspace:GetAttribute("ActiveWeather") == "Bloodmoon" then
			return "Bloodlit"
		end
		if WeatherValues then
			for weather, mutation in WEATHER_MUTATION do
				if WeatherValues:GetAttribute(weather .. "_Playing") == true then
					return mutation
				end
			end
		end
		return nil
	end

	task.spawn(function()
		while true do
			task.wait(WEATHER_ROLL_INTERVAL)
			local mutation = activeWeatherMutation()
			if mutation then
				for userId, garden in gardens do
					for plantId, plantData in garden.Plants do
						local fruits = plantData.Fruits
						if fruits then
							for fruitId, fruitData in fruits do
								if (fruitData.Mutation == nil or fruitData.Mutation == "") and math.random() < WEATHER_FRUIT_CHANCE then
									fruitData.Mutation = mutation
									broadcast(Networking.Garden.FruitMutationUpdated, userId, plantId, fruitId, mutation)
								end
							end
						end
					end
				end
			end
		end
	end)
end

----------------------------------------------------------------------
-- Regadera: regar acelera el crecimiento de las plantas/frutas cercanas. El
-- cliente (WateringcanController) raycastea a una PlantArea y dispara
-- UseWateringCan(pos, canName, tool). Adelantamos PlantedAt/SpawnedAt (= mas
-- edad, capada a MaxAge), difundimos el nuevo Age y el FX del chorro.
----------------------------------------------------------------------
do
	local WATER_RADIUS = 10
	local WATER_BOOST = { ["Common Watering Can"] = 8, ["Super Watering Can"] = 25 }
	local lastWaterAt = {}

	Networking.WateringCan.UseWateringCan.OnServerEvent:Connect(function(player, pos, canName, tool)
		if typeof(pos) ~= "Vector3" then
			return
		end
		local now = os.clock()
		if (now - (lastWaterAt[player] or 0)) < 0.3 then
			return -- anti-spam (el cliente ya tiene cooldown 0.5s)
		end
		lastWaterAt[player] = now

		-- Gastar una regadera por uso (consume del stack; si no quedan, no riega).
		local consume = GameServerAPI.ConsumeGear
		if consume and not consume(player, canName) then
			return
		end

		local userId = player.UserId
		local garden = gardens[userId]
		local _, spawnPoint = getPlotReference(player)
		if not (garden and spawnPoint) then
			return
		end
		local boost = WATER_BOOST[canName] or 8
		local nowEpoch = os.time()

		local plantAges = {}
		for plantId, plantData in garden.Plants do
			local p = plantData.Positions
			if p then
				local worldPos = spawnPoint.CFrame:PointToWorldSpace(Vector3.new(p.PosX, p.PosY, p.PosZ))
				if (worldPos - pos).Magnitude <= WATER_RADIUS then
					plantData.PlantedAt = (plantData.PlantedAt or nowEpoch) - boost
					plantAges[plantId] = math.min(plantData.MaxAge or 0, nowEpoch - plantData.PlantedAt)
					local fruitAges, hasFruit = {}, false
					if plantData.Fruits then
						for fruitId, fruitData in plantData.Fruits do
							fruitData.SpawnedAt = (fruitData.SpawnedAt or nowEpoch) - boost
							local fMax = fruitData.MaxAge or FRUIT_GROW_SECONDS
							local fAge = math.min(fMax, nowEpoch - fruitData.SpawnedAt)
							fruitData.Age = fAge
							fruitAges[fruitId] = fAge
							hasFruit = true
						end
					end
					if hasFruit then
						broadcast(Networking.Garden.FruitAgeSync, userId, plantId, fruitAges)
					end
				end
			end
		end
		if next(plantAges) ~= nil then
			broadcast(Networking.Garden.PlantAgeSync, userId, plantAges)
		end

		-- FX del chorro para todos: el cliente (WateringcanController.PlayWaterStream)
		-- lee player.Character para ubicar el origen del chorro. Antes se mandaba el
		-- Tool -> p3.Character petaba ("Character is not a valid member of Tool").
		broadcast(Networking.WateringCan.WateringCanFx, pos, canName, player)
		player:SetAttribute("HasWateredPlants", true)
	end)

	Players.PlayerRemoving:Connect(function(player)
		lastWaterAt[player] = nil
	end)
end

----------------------------------------------------------------------
-- Regadores (Sprinklers): se colocan en el plot y aceleran el crecimiento de
-- las plantas/frutas en su radio mientras viven. El cliente (SprinklerController)
-- raycastea a una PlantArea propia y dispara PlaceSprinkler; el
-- SprinklerVisualizerController los renderiza desde Garden.SprinklerAdded con
-- Positions LOCALES al SpawnPoint (igual que las plantas). Se guardan en
-- gardens[uid].Sprinklers para que SyncAllGardens los reponga al reconectar.
----------------------------------------------------------------------
do
	local SprinklerData = require(ReplicatedStorage.SharedModules.SprinklerData)
	local sprinklerByName = {}
	for _, s in SprinklerData do
		sprinklerByName[s.SprinklerName] = s
	end
	local BOOST_INTERVAL = 2 -- seg entre pasadas de riego

	local function removeSprinkler(userId, id)
		local garden = gardens[userId]
		if garden and garden.Sprinklers then
			garden.Sprinklers[id] = nil
		end
		broadcast(Networking.Garden.SprinklerRemoved, userId, id)
	end

	Networking.Place.PlaceSprinkler.OnServerEvent:Connect(function(player, worldPos, name, tool, plotId)
		local data = sprinklerByName[name]
		if not data or typeof(worldPos) ~= "Vector3" then
			return
		end
		if typeof(tool) ~= "Instance" or not tool:IsA("Tool") or tool:GetAttribute("Sprinkler") ~= name then
			return
		end
		local plot, spawnPoint = getPlotReference(player)
		if not (plot and spawnPoint) then
			return
		end
		local zone = plot:FindFirstChild("Visual") and plot.Visual:FindFirstChild("GardenTotalArea")
		if zone then
			local rel = zone.CFrame:PointToObjectSpace(worldPos)
			local half = zone.Size / 2
			if math.abs(rel.X) > half.X + 4 or math.abs(rel.Z) > half.Z + 4 then
				return
			end
		end
		-- consumir 1 del stack (si no hay, rechazar la colocacion)
		local consume = GameServerAPI.ConsumeGear
		if not (consume and consume(player, name)) then
			return
		end
		local localPos = spawnPoint.CFrame:PointToObjectSpace(worldPos)
		local id = newId()
		local sdata = {
			SprinklerName = name,
			Positions = { PosX = localPos.X, PosY = localPos.Y, PosZ = localPos.Z, Rotation = 0 },
			PlacedAt = os.time(),
		}
		local userId = player.UserId
		if not gardens[userId] then
			gardens[userId] = { Plants = {} }
		end
		gardens[userId].Sprinklers = gardens[userId].Sprinklers or {}
		gardens[userId].Sprinklers[id] = sdata
		broadcast(Networking.Garden.SprinklerAdded, userId, id, sdata)

		task.delay(data.Lifetime or 120, function()
			local g = gardens[userId]
			if g and g.Sprinklers and g.Sprinklers[id] then
				removeSprinkler(userId, id)
			end
		end)
	end)

	-- Riego continuo: adelanta PlantedAt/SpawnedAt de plantas/frutas dentro del
	-- radio (distancia horizontal en espacio LOCAL al SpawnPoint = distancia real).
	-- El loop de crecimiento existente difunde el nuevo Age en su proxima pasada.
	task.spawn(function()
		while true do
			task.wait(BOOST_INTERVAL)
			local nowEpoch = os.time()
			for userId, garden in gardens do
				local sprinklers = garden.Sprinklers
				if sprinklers and next(sprinklers) ~= nil then
					for _, sdata in sprinklers do
						local data = sprinklerByName[sdata.SprinklerName]
						local sp = sdata.Positions
						if data and sp then
							local boost = math.max(0, ((data.GrowSpeedBonus or 1) - 1)) * BOOST_INTERVAL
							local radius = data.Radius or 20
							for _, plantData in garden.Plants do
								local p = plantData.Positions
								if p then
									local dx = p.PosX - sp.PosX
									local dz = p.PosZ - sp.PosZ
									if dx * dx + dz * dz <= radius * radius then
										plantData.PlantedAt = (plantData.PlantedAt or nowEpoch) - boost
										if plantData.Fruits then
											for _, fruitData in plantData.Fruits do
												fruitData.SpawnedAt = (fruitData.SpawnedAt or nowEpoch) - boost
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
	print("[PlantService] Sprinklers (colocacion + riego) listos")
end

----------------------------------------------------------------------
-- Trowel: mover una planta ya plantada. El cliente (TrowelController) mueve el
-- modelo localmente y dispara MovePlant(plantId, worldPos, rotDeg). El server
-- valida (planta propia, dentro del plot) y reubica; si no, MoveRejected y el
-- cliente revierte. Se re-difunde a los observadores (remove + add con el id).
----------------------------------------------------------------------
do
	Networking.Trowel.MovePlant.OnServerEvent:Connect(function(player, plantId, worldPos, rotDeg)
		if type(plantId) ~= "string" or typeof(worldPos) ~= "Vector3" then
			return
		end
		local userId = player.UserId
		local garden = gardens[userId]
		local plantData = garden and garden.Plants[plantId]
		if not plantData then
			return
		end
		local plot, spawnPoint = getPlotReference(player)
		if not (plot and spawnPoint) then
			Networking.Trowel.MoveRejected:FireClient(player, plantId)
			return
		end
		local zone = plot:FindFirstChild("Visual") and plot.Visual:FindFirstChild("GardenTotalArea")
		if zone then
			local rel = zone.CFrame:PointToObjectSpace(worldPos)
			local half = zone.Size / 2
			if math.abs(rel.X) > half.X + 2 or math.abs(rel.Z) > half.Z + 2 then
				Networking.Trowel.MoveRejected:FireClient(player, plantId)
				return
			end
		end
		local localPos = spawnPoint.CFrame:PointToObjectSpace(worldPos)
		plantData.Positions = plantData.Positions or {}
		plantData.Positions.PosX = localPos.X
		plantData.Positions.PosY = localPos.Y
		plantData.Positions.PosZ = localPos.Z
		if type(rotDeg) == "number" then
			plantData.Positions.Rotation = rotDeg
		end
		-- Reubicar para los demas (el que movio ya lo hizo localmente).
		for _, p in Players:GetPlayers() do
			if p ~= player then
				Networking.Garden.PlantRemoved:FireClient(p, userId, plantId)
				Networking.Garden.PlantAdded:FireClient(p, userId, plantId, plantData)
			end
		end
	end)
end

----------------------------------------------------------------------
-- Basic Pot (EmptyPot): "potea" una planta multi-cosecha ya madura. El cliente
-- (EmptyPotController) pone un prompt "Pot Plant" sobre las plantas crecidas y
-- dispara Garden.PotPlant(plantId). El server valida, consume un Basic Pot,
-- marca la planta como en maceta y confirma con PlantPotted (quita el prompt).
----------------------------------------------------------------------
do
	Networking.Garden.PotPlant.OnServerEvent:Connect(function(player, plantId)
		if type(plantId) ~= "string" then
			return
		end
		local userId = player.UserId
		local garden = gardens[userId]
		local plantData = garden and garden.Plants[plantId]
		if not plantData or plantData.IsPotted then
			return
		end
		local plantRuntime = runtime[userId] and runtime[userId][plantId]
		local entry = plantRuntime and plantRuntime.seed
		if not entry or entry.IsSingleHarvest then
			return
		end
		if (plantData.Age or 0) < (plantData.MaxAge or 0) then
			return -- aun no madura
		end
		local consume = GameServerAPI.ConsumeGear
		if not (consume and consume(player, "Basic Pot")) then
			return
		end
		plantData.IsPotted = true
		broadcast(Networking.Garden.PlantAdded, userId, plantId, plantData)
		Networking.Garden.PlantPotted:FireClient(player, plantId)
	end)
end

print("[PlantService] Tienda + plantar + crecimiento + venta listos")