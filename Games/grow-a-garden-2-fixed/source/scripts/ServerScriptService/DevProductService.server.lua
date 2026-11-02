--credit to quartz games studio
--[[
	DevProductService  (servidor)
	--------------------------------------------------------------------
	Lado servidor que faltaba para que las COMPRAS entreguen su item.

	El dump ya trae publicados los 474 DevProducts reales en el atributo
	workspace.RemoteDeveloperProducts (formato JSON: { {Key, TokenCost,
	ProductId}, ... }). El cliente los lee y muestra precios / promptea la
	compra. Lo que NUNCA se exporto fue el lado servidor que otorga el item
	tras pagar:  ProcessReceipt (compra Robux) e InstantGrant (compra
	instantanea sin Robux). Sin eso, comprar no daba nada.

	Este script:
	  • Mapea ProductId -> Key desde el atributo.
	  • Activa workspace.InstantPurchasesEnabled = true  ->  el cliente
	    enruta las compras por Networking.DevProducts.InstantGrant (sin
	    Robux), ideal para testear en Studio y sin depender de que los
	    productos pertenezcan a este lugar. Ponlo en false para volver a
	    compras Robux nativas (que usan ProcessReceipt, tambien implementado).
	  • Otorga al comprar:
	      - Currency:Sheckles:N  -> AddSheckles(N)            (fiable)
	      - Seed:Nombre:Cant     -> GiveSeed(nombre, cant)    (fiable)
	      - Gamepass:*           -> marca OwnedGamepasses
	      - Resto (Gear/SeedPack/Crate/Standalone/SkillUpgrade/Guild/…):
	        aun NO se materializa el item (esos sistemas de inventario no
	        estan reconstruidos en el server). Se loguea y se consume la
	        compra para no re-promptear en bucle.
	  • Soporta el sufijo ':Gift' (entrega al objetivo fijado por
	    Networking.DevProducts.SetGiftTarget) y los canales de gamepass.
]]

local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local ServerScriptService= game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService        = game:GetService("HttpService")

local Networking      = require(ReplicatedStorage.SharedModules.Networking)
local RobuxShopContent= require(ReplicatedStorage.SharedModules.RobuxShopContent)
local GameServerAPI   = require(ServerScriptService.GameServerAPI)

local DevP = Networking.DevProducts

----------------------------------------------------------------------
-- Mapa ProductId -> Key (desde el atributo ya publicado)
----------------------------------------------------------------------
local productKeyById = {}
local productIdByKey = {}  -- inverso: Key -> ProductId (para validar el pending purchase)

local function loadProducts()
	local raw = workspace:GetAttribute("RemoteDeveloperProducts")
	if type(raw) ~= "string" or raw == "" then
		return 0
	end
	local ok, data = pcall(function() return HttpService:JSONDecode(raw) end)
	if not ok or type(data) ~= "table" then
		return 0
	end
	local n = 0
	for _, e in ipairs(data) do
		if type(e) == "table" and type(e[1]) == "string" and type(e[3]) == "number" then
			productKeyById[e[3]] = e[1]
			productIdByKey[e[1]] = e[3]
			n += 1
		end
	end
	return n
end

-- Overrides del usuario: mapea TU ProductId -> Key para que ProcessReceipt
-- (compras Robux reales) entregue el item correcto. Ver SharedModules.DevProductOverrides.
local DevProductOverrides = require(ReplicatedStorage.SharedModules.DevProductOverrides)
local function applyProductOverrides()
	for key, productId in pairs(DevProductOverrides.Products or {}) do
		if type(key) == "string" and type(productId) == "number" then
			productKeyById[productId] = key
			productIdByKey[key] = productId
		end
	end
end

local loaded = loadProducts()
applyProductOverrides()

-- MODDED: registrar los DevProductId de ProductIds (P2W / Admin / Pets) con keys
-- sintéticas. Estas compras usan MarketplaceService:PromptProductPurchase directo
-- (P2WClient / AdminBuyClient / PetBuyClient), así que ProcessReceipt necesita
-- mapear ProductId -> key para saber qué entregar. (IDs en 0 no se registran.)
local ProductIds = require(ReplicatedStorage.SharedModules.ProductIds)
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local MODDED_KEY_BY_NAME = {
	SpawnAllWeathers  = "P2W:SpawnAllWeathers",
	OPSeedPacks       = "P2W:OPSeedPacks",
	RandomOpPet       = "P2W:RandomOpPet",
	OpSizeRandomSeed  = "P2W:OpSizeRandomSeed",
	SpawnRandomHugeOpPet = "P2W:SpawnRandomHugeOpPet",
	RainbowRaccoon    = "P2W:RainbowRaccoon",
	RainbowIceSerpent = "P2W:RainbowIceSerpent",
	AdminPanel5       = "Admin:5",
	AdminPanel10      = "Admin:10",
	AdminPanel15      = "Admin:15",
	AdminPanelPerm    = "Admin:Permanent",
	PetRaccoon        = "Pet:Raccoon",
	PetIceSerpent     = "Pet:IceSerpent",
	PetUnicorn        = "Pet:Unicorn",
	PetDragonfly      = "Pet:GoldenDragonfly",
	BanHammer         = "Item:BanHammer",
	BanHammerRevenge  = "Item:BanHammerRevenge",
}
local function registerModdedProductIds()
	for name, key in pairs(MODDED_KEY_BY_NAME) do
		local id = ProductIds.Products and ProductIds.Products[name]
		if type(id) == "number" and id > 0 then
			productKeyById[id] = key
			productIdByKey[key] = id
		end
	end
end
registerModdedProductIds()

-- MODDED: registrar los tiers del multiplicador de sheckles (cada tier su DevProductId único).
local MultiplierProductIds = require(ReplicatedStorage.SharedModules.MultiplierProductIds)
local function registerMultiplierTiers()
	for _, tier in ipairs(MultiplierProductIds.ScheckleTiers or {}) do
		if type(tier.productId) == "number" and tier.productId > 0 and type(tier.mult) == "number" then
			local key = "Mult:Sheckles:" .. tostring(tier.mult)
			productKeyById[tier.productId] = key
			productIdByKey[key] = tier.productId
		end
	end
end
registerMultiplierTiers()
if loaded == 0 then
	-- Por si el atributo lo setea algo mas tarde.
	task.spawn(function()
		workspace:GetAttributeChangedSignal("RemoteDeveloperProducts"):Wait()
		loaded = loadProducts()
		applyProductOverrides()
		print(("[DevProductService] productos cargados (tardio): %d"):format(loaded))
	end)
end

-- gamepassKey -> nombre legible (para marcar OwnedGamepasses como espera el RobuxShop)
local gamepassNameByKey = {}
for _, g in ipairs(RobuxShopContent.Gears or {}) do
	if g.GamepassKey and g.Name then
		gamepassNameByKey[g.GamepassKey] = g.Name
	end
end

----------------------------------------------------------------------
-- MODDED: precios para la economía interna "Fake Robux".
-- El precio cobrado = el MISMO precio en Robux del ítem (GetProductInfo). El
-- cliente usa la misma fuente, así el precio mostrado y el cobrado coinciden.
-- Se cobra SIEMPRE en la moneda interna, NUNCA en Robux reales.
----------------------------------------------------------------------
local gamepassIdByKey = {}
local function loadGamepassIds()
	local raw = workspace:GetAttribute("RemoteGamepasses")
	if type(raw) == "string" and raw ~= "" then
		local ok, data = pcall(function() return HttpService:JSONDecode(raw) end)
		if ok and type(data) == "table" then
			for _, e in ipairs(data) do
				if type(e) == "table" and type(e[1]) == "string" and type(e[2]) == "number" then
					gamepassIdByKey[e[1]] = e[2]
				end
			end
		end
	end
	for key, id in pairs(DevProductOverrides.Gamepasses or {}) do
		if type(key) == "string" and type(id) == "number" then
			gamepassIdByKey[key] = id
		end
	end
end
loadGamepassIds()
if next(gamepassIdByKey) == nil then
	task.spawn(function()
		workspace:GetAttributeChangedSignal("RemoteGamepasses"):Wait()
		loadGamepassIds()
	end)
end

local priceCache = {}  -- [key] = precio en Fake Robux

local function gamepassKeyFor(key)
	if key:sub(1, 9) == "Gamepass:" then
		return key
	end
	if key:sub(1, 5) == "Gift:" then
		local name = key:split(":")[2]
		return name and ("Gamepass:" .. name) or nil
	end
	return nil
end

local function priceForKey(key)
	if type(key) ~= "string" then
		return 0
	end
	if key:sub(1, 6) == "Admin:" then
		return 0  -- MODDED: el Admin Panel es GRATIS
	end
	if priceCache[key] ~= nil then
		return priceCache[key]
	end
	local price = 0
	local gpKey = gamepassKeyFor(key)
	if gpKey then
		local id = gamepassIdByKey[gpKey] or gamepassIdByKey[key]
		if id then
			local ok, info = pcall(function()
				return MarketplaceService:GetProductInfo(id, Enum.InfoType.GamePass)
			end)
			if ok and type(info) == "table" and type(info.PriceInRobux) == "number" then
				price = info.PriceInRobux
			end
		end
	else
		local effKey = key
		if effKey:sub(-5) == ":Gift" then
			effKey = effKey:sub(1, -6)
		end
		local id = productIdByKey[effKey] or productIdByKey[key]
		if id then
			local ok, info = pcall(function()
				return MarketplaceService:GetProductInfo(id, Enum.InfoType.Product)
			end)
			if ok and type(info) == "table" and type(info.PriceInRobux) == "number" then
				price = info.PriceInRobux
			end
		end
	end
	priceCache[key] = price
	return price
end

local function gamepassAlreadyOwned(player, key)
	local name = gamepassNameByKey[key]
	if not name then
		name = key:split(":")[2]
	end
	if not name then
		return false
	end
	local owned = player:GetAttribute("OwnedGamepasses")
	owned = (type(owned) == "string") and owned or ""
	for entry in owned:gmatch("[^,]+") do
		if entry == name then
			return true
		end
	end
	return false
end

----------------------------------------------------------------------
-- Objetivo de regalo (SetGiftTarget se dispara antes de comprar un :Gift)
----------------------------------------------------------------------
local giftTargetByPlayer = {}  -- [player] = { userId = n, at = os.time() }

DevP.SetGiftTarget.OnServerEvent:Connect(function(player, userId)
	if type(userId) == "number" then
		giftTargetByPlayer[player] = { userId = userId, at = os.time() }
	end
end)

----------------------------------------------------------------------
-- Pending purchase: el cliente avisa QUÉ Key va a comprar ANTES de abrir el
-- prompt de Robux. Necesario para compras a granel (x3/x10) que comparten un
-- mismo ProductId entre todas las semillas/gears: con el ProductId solo no se
-- sabe cuál ítem fue. ProcessReceipt usa esta Key VALIDANDO que su ProductId
-- coincida con el comprado (así nadie escala a un producto de otro precio).
----------------------------------------------------------------------
local pendingByPlayer = {}  -- [player] = { key = "Seed:Carrot:3", at = os.time() }

local function getPendingPurchaseRemote()
	local folder = ReplicatedStorage:FindFirstChild("RemoteEvents")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "RemoteEvents"
		folder.Parent = ReplicatedStorage
	end
	local remote = folder:FindFirstChild("DevProductPendingPurchase")
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = "DevProductPendingPurchase"
		remote.Parent = folder
	end
	return remote
end

getPendingPurchaseRemote().OnServerEvent:Connect(function(player, key)
	if type(key) == "string" and #key <= 120 then
		pendingByPlayer[player] = { key = key, at = os.time() }
	end
end)

local function resolveRecipient(buyer, isGift)
	if not isGift then
		return buyer
	end
	local gt = giftTargetByPlayer[buyer]
	if gt and (os.time() - gt.at) <= 300 then
		local target = Players:GetPlayerByUserId(gt.userId)
		if target then
			return target
		end
	end
	return buyer  -- fallback: si el objetivo no esta, lo recibe el comprador
end

----------------------------------------------------------------------
-- Gear de gamepass: al poseer el gamepass se materializa su Tool en la mochila.
-- NOTA: las HABILIDADES de combate (PowerHose/FreezeRay/VineWrapper) NO tienen
-- lado servidor reconstruido (sin handlers de Networking.* para esos canales);
-- aquí se ENTREGA el gear (se posee/sostiene). Rainbow Carpet sale de su asset.
----------------------------------------------------------------------
local Assets = ReplicatedStorage:FindFirstChild("Assets")
-- Gear de gamepass -> atributo de su Tool. Rainbow Carpet = Tool listo en Assets;
-- los de combate (Freeze Ray/Vine Wrapper/Power Hose) se construyen desde los Models
-- copiados a Assets (de las GearScenes, traen Handle propio). Las habilidades viven
-- en GearUsageService (canales Networking.{FreezeRay,VineWrapper,PowerHose}.*).
local GAMEPASS_GEAR = {
	["Rainbow Carpet"] = "Carpet",
	["Freeze Ray"]     = "FreezeRay",
	["Vine Wrapper"]   = "VineWrapper",
	["Power Hose"]     = "PowerHose",
}
-- Icono del gear para el inventario (Tool.TextureId) = imagen del gamepass.
local GAMEPASS_GEAR_IMAGE = {
	["Rainbow Carpet"] = "rbxassetid://81568908694561",
	["Freeze Ray"]     = "rbxassetid://106117717561001",
	["Power Hose"]     = "rbxassetid://109454165112630",
	["Vine Wrapper"]   = "rbxassetid://93226922521003",
}

local function findGamepassTool(player, attr, name)
	for _, container in { player:FindFirstChild("Backpack"), player.Character } do
		if container then
			for _, tool in container:GetChildren() do
				if tool:IsA("Tool") and (tool:GetAttribute(attr) or tool.Name == name) then
					return tool
				end
			end
		end
	end
	return nil
end

-- Construye un Tool desde un Model de gear (mueve Handle + partes soldadas al Tool).
local function buildToolFromModel(model, name, attr)
	local tool = Instance.new("Tool")
	tool.Name = name
	tool.CanBeDropped = false
	tool:SetAttribute(attr, name)
	tool:SetAttribute("MainCategory", "Gear")
	local clone = model:Clone()
	-- (se conservan los scripts del gear, p.ej. Power Hose.PowerWasher = VFX del chorro)
	for _, child in clone:GetChildren() do
		child.Parent = tool
	end
	clone:Destroy()
	for _, d in tool:GetDescendants() do
		if d:IsA("BasePart") then
			d.Anchored = false
			d.CanCollide = false
			d.Massless = true
		end
	end
	tool.RequiresHandle = tool:FindFirstChild("Handle") ~= nil
	return tool
end

local function giveGamepassGear(player, name)
	local attr = GAMEPASS_GEAR[name]
	if not attr then
		return
	end
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then
		return
	end
	if findGamepassTool(player, attr, name) then
		return -- ya lo tiene
	end
	local asset = Assets and Assets:FindFirstChild(name)
	local tool
	if asset and asset:IsA("Tool") then
		tool = asset:Clone()
		tool:SetAttribute(attr, name)
		tool:SetAttribute("MainCategory", "Gear")
	elseif asset and asset:IsA("Model") then
		tool = buildToolFromModel(asset, name, attr)
	else
		return -- sin asset, no entregar (evita Tools rotos)
	end
	local img = GAMEPASS_GEAR_IMAGE[name]
	if img then
		tool.TextureId = img -- icono en el inventario
	end
	pcall(function() tool:AddTag(attr) end)
	tool.Parent = backpack
end

----------------------------------------------------------------------
-- Otorgar gamepass: marca el atributo OwnedGamepasses (el RobuxShop lo lee) y
-- entrega el gear correspondiente.
----------------------------------------------------------------------
local function grantGamepass(buyer, key, isGift)
	local recipient = resolveRecipient(buyer, isGift)
	local name = gamepassNameByKey[key]
	if not name then
		-- key tipo "Gift:Nombre:1": el nombre va en la posicion 2
		local parts = key:split(":")
		name = (parts[1] == "Gift") and parts[2] or nil
	end
	if not name then
		return false, "gamepass desconocido"
	end
	local owned = recipient:GetAttribute("OwnedGamepasses")
	owned = (type(owned) == "string") and owned or ""
	for entry in owned:gmatch("[^,]+") do
		if entry == name then
			giveGamepassGear(recipient, name) -- asegura el tool aunque ya lo tuviera
			return true, "ya lo tenia"
		end
	end
	recipient:SetAttribute("OwnedGamepasses", (owned == "") and name or (owned .. "," .. name))
	giveGamepassGear(recipient, name)
	return true, "ok"
end

----------------------------------------------------------------------
-- Otorgar un producto por su Key
----------------------------------------------------------------------
local function grantByKey(buyer, key)
	if type(key) ~= "string" then
		return false, "key invalida"
	end

	-- gamepasses
	if key:sub(1, 9) == "Gamepass:" or key:sub(1, 5) == "Gift:" then
		return grantGamepass(buyer, key, key:sub(1, 5) == "Gift:")
	end

	-- sufijo :Gift  ->  regalo
	local isGift = false
	local effKey = key
	if effKey:sub(-5) == ":Gift" then
		isGift = true
		effKey = effKey:sub(1, -6)
	end

	local recipient = resolveRecipient(buyer, isGift)
	local parts = effKey:split(":")
	local cat = parts[1]

	if cat == "Currency" and parts[2] == "Sheckles" then
		local amount = tonumber(parts[3]) or 0
		if amount <= 0 then
			return false, "monto invalido"
		end
		GameServerAPI.WaitFor("AddSheckles")(recipient, amount)
		return true, ("+%d sheckles"):format(amount)

	elseif cat == "Seed" then
		local seedName = parts[2]
		local qty = tonumber(parts[3]) or 1
		local ok = GameServerAPI.WaitFor("GiveSeed")(recipient, seedName, qty)
		return ok, ok and ("+%dx %s"):format(qty, seedName) or "semilla desconocida"

	elseif cat == "SeedPack" then
		local packName = parts[2]
		local qty = tonumber(parts[3]) or 1
		local ok = GameServerAPI.WaitFor("GiveSeedPack")(recipient, packName, qty)
		return ok, ok and ("+%dx %s"):format(qty, packName) or "seed pack desconocido"

	elseif cat == "Gear" then
		local name = parts[2]
		local qty = tonumber(parts[3]) or 1
		local ok = GameServerAPI.WaitFor("GiveGear")(recipient, name, qty)
		return ok, ok and ("+%dx %s"):format(qty, name) or "gear desconocido"

	elseif cat == "ExclusiveGear" then
		-- Algunos ExclusiveGear son gear (Super Watering Can, Teleporter…) y
		-- otros son packs (p.ej. "Common Seed Pack"). Probamos gear y caemos a pack.
		local name = parts[2]
		local qty = tonumber(parts[3]) or 1
		if GameServerAPI.WaitFor("GiveGear")(recipient, name, qty) then
			return true, ("+%dx %s"):format(qty, name)
		end
		local ok = GameServerAPI.WaitFor("GiveSeedPack")(recipient, name, qty)
		return ok, ok and ("+%dx %s"):format(qty, name) or "exclusive gear desconocido"

	elseif cat == "Crate" or cat == "GuildCrate" then
		local crateName = parts[2]
		local qty = tonumber(parts[3]) or 1
		if not crateName or crateName == "" then
			return false, "crate desconocido"
		end
		local ok = GameServerAPI.WaitFor("GiveCrate")(recipient, crateName, qty)
		return ok, ok and ("+%dx %s"):format(qty, crateName) or "crate desconocido"

	elseif cat == "Prop" or cat == "Cosmetic" then
		local propName = parts[2]
		local qty = tonumber(parts[3]) or 1
		if not propName or propName == "" then
			return false, "prop desconocido"
		end
		local ok = GameServerAPI.WaitFor("GiveProp")(recipient, propName, qty)
		return ok, ok and ("+%dx %s"):format(qty, propName) or "prop desconocido"

	elseif cat == "Standalone" and parts[2] == "StarterPack" then
		-- Compra única: si ya lo compró, no re-entregar.
		if GameServerAPI.IsStarterPackBought and GameServerAPI.IsStarterPackBought(recipient) then
			return true, "starter pack ya comprado"
		end
		local items = RobuxShopContent.StarterPack and RobuxShopContent.StarterPack.Items or {}
		for _, item in ipairs(items) do
			local n = tonumber(item.Count) or 1
			if item.Type == "SeedPack" then
				GameServerAPI.WaitFor("GiveSeedPack")(recipient, item.Name, n)
			elseif item.Type == "Gear" then
				GameServerAPI.WaitFor("GiveGear")(recipient, item.Name, n)
			elseif item.Type == "Seed" then
				GameServerAPI.WaitFor("GiveSeed")(recipient, item.Name, n)
			end
		end
		if GameServerAPI.MarkStarterPackBought then
			GameServerAPI.MarkStarterPackBought(recipient)
		end
		return true, "starter pack entregado"

	elseif cat == "Standalone" and parts[2] == "Grow Plant" then
		-- MODDED: crecer al instante la planta marcada por Networking.GrowPlant
		GameServerAPI.WaitFor("GrowOnePlant")(recipient)
		return true, "grow plant"

	elseif cat == "Standalone" and parts[2] == "Grow All" then
		-- MODDED: crecer al instante todas las plantas del jugador
		GameServerAPI.WaitFor("GrowAllPlants")(recipient)
		return true, "grow all"

	elseif cat == "Mult" and parts[2] == "Sheckles" then
		-- MODDED: multiplicador de sheckles (P2W x2/x4/...). Sube al tier comprado.
		local mult = tonumber(parts[3]) or 0
		if mult <= 0 then
			return false, "multiplicador inválido"
		end
		local cur = GameServerAPI.WaitFor("GetSheckleMultiplier")(recipient)
		if mult > cur then
			GameServerAPI.WaitFor("SetSheckleMultiplier")(recipient, mult)
		end
		return true, ("sheckle x%d"):format(mult)

	elseif cat == "Restock" then
		-- MODDED: botón Restock de las tiendas. Comparten un mismo DevID; la key
		-- exacta (Seeds/Gears/Props) llega por el pending purchase del cliente.
		local which = parts[2]
		if which == "Seeds" then
			GameServerAPI.WaitFor("RestockSeedShop")()
			return true, "seed shop restock"
		elseif which == "Gears" then
			local fn = GameServerAPI.RestockGearShop
			if fn then fn() end
			return true, "gear shop restock"
		elseif which == "Props" or which == "Crates" then
			GameServerAPI.WaitFor("RestockCrateShop")()
			return true, "props shop restock"
		end
		return true, ("restock %s"):format(tostring(which))


	elseif cat == "Pet" then
		-- MODDED: pet comprada en RobuxShop > Pets (parts[2] = nombre real de la pet)
		GameServerAPI.WaitFor("AddPet")(recipient, parts[2])
		return true, ("pet %s"):format(tostring(parts[2]))

	elseif cat == "Admin" then
		-- MODDED: acceso al Admin Panel (RobuxShop > Admin)
		local kind = parts[2]
		if kind == "Permanent" then
			recipient:SetAttribute("OwnsAdminPanel", true)  -- persiste vía GameServer
			return true, "admin panel permanente"
		end
		local minutes = tonumber(kind) or 0
		if minutes <= 0 then
			return false, "duracion admin invalida"
		end
		local now = os.time()
		local current = recipient:GetAttribute("AdminPanelUntil")
		local base = (type(current) == "number" and current > now) and current or now
		recipient:SetAttribute("AdminPanelUntil", base + minutes * 60)
		return true, ("admin panel %d min"):format(minutes)

	elseif cat == "Item" and parts[2] == "BanHammer" then
		-- MODDED: Ban Hammer (compra directa por Robux). La entrega real del tool
		-- la hace BanHammerService vía GameServerAPI.GiveBanHammer.
		GameServerAPI.WaitFor("GiveBanHammer")(recipient)
		return true, "ban hammer"

	elseif cat == "Item" and parts[2] == "BanHammerRevenge" then
		-- MODDED: Revenge (compra Robux). Libera al baneado y manda preso al baneador.
		GameServerAPI.WaitFor("DoBanRevenge")(recipient)
		return true, "ban hammer revenge"

	elseif cat == "P2W" then
		-- MODDED: botones P2W (compra directa por ProductIds)
		local what = parts[2]
		if what == "SpawnAllWeathers" then
			if _G.WeatherService and _G.WeatherService.ForceAll then
				_G.WeatherService.ForceAll(120)
			end
			return true, "all weathers"
		elseif what == "OPSeedPacks" then
			GameServerAPI.WaitFor("GiveSeedPack")(recipient, "Ghost Pepper Pack", 5)
			return true, "OP seed packs"
		elseif what == "RandomOpPet" then
			local pool = { "BlackDragon", "IceSerpent", "GoldenDragonfly", "Unicorn" }
			local pick = pool[math.random(#pool)]
			GameServerAPI.WaitFor("AddPet")(recipient, pick)
			return true, ("random OP pet: %s"):format(pick)
		elseif what == "SpawnRandomHugeOpPet" then
			local pool = { "BlackDragon", "IceSerpent", "GoldenDragonfly", "Unicorn" }
			-- 1) dar una Huge OP pet DIRECTO al comprador
			local owned = pool[math.random(#pool)]
			GameServerAPI.WaitFor("AddPet")(recipient, owned, "Huge")
			-- 2) y ADEMÁS spawnear una Huge OP wild pet en el área
			local wild = pool[math.random(#pool)]
			GameServerAPI.WaitFor("SpawnWildPet")(wild, "Huge")
			return true, ("huge op: dada %s + wild %s"):format(owned, wild)
		elseif what == "OpSizeRandomSeed" then
			local names = {}
			for _, e in pairs(SeedData) do
				if type(e) == "table" and type(e.SeedName) == "string" then
					names[#names + 1] = e.SeedName
				end
			end
			if #names == 0 then
				return false, "sin seeds"
			end
			local pick = names[math.random(#names)]
			GameServerAPI.WaitFor("GiveOpSizeSeed")(recipient, pick, 20)
			return true, ("op size seed: %s"):format(pick)
		elseif what == "RainbowRaccoon" then
			GameServerAPI.WaitFor("AddPet")(recipient, "Raccoon")
			return true, "rainbow raccoon"
		elseif what == "RainbowIceSerpent" then
			GameServerAPI.WaitFor("AddPet")(recipient, "IceSerpent")
			return true, "rainbow ice serpent"
		end
		return false, "P2W desconocido"
	end

	-- Categorias cuyo item aun no se materializa en el server reconstruido.
	warn(("[DevProductService] '%s' comprado por %s: entrega de categoria '%s' aun no implementada (Sheckles y Seeds si funcionan).")
		:format(key, buyer.Name, tostring(cat)))
	return true, "compra consumida (entrega pendiente)"
end

----------------------------------------------------------------------
-- InstantGrant (compra instantanea, sin Robux)  ·  el camino de testeo
----------------------------------------------------------------------
DevP.InstantGrant.OnServerInvoke = function(player, key)
	-- MODDED: cobrar en Fake Robux antes de entregar (server-authoritative).
	local price = priceForKey(key)
	if price > 0 and not GameServerAPI.WaitFor("SpendFakeRobux")(player, price) then
		return false, "No tienes suficientes Fake Robux"
	end
	local ok, msg = grantByKey(player, key)
	if not ok and price > 0 then
		GameServerAPI.WaitFor("AddFakeRobux")(player, price)  -- reembolso si falló la entrega
	end
	if ok and GameServerAPI.PlaySFX then
		GameServerAPI.PlaySFX(player, "Purchase")
	end
	print(("[DevProductService] InstantGrant %s -> %s (%s) [%d FR]"):format(player.Name, tostring(key), tostring(msg), price))
	return ok, msg
end

DevP.InstantGrantGamepass.OnServerInvoke = function(player, key)
	-- MODDED: si ya lo posee, sólo re-asegurar el gear (sin cobrar de nuevo).
	if gamepassAlreadyOwned(player, key) then
		return grantGamepass(player, key, false)
	end
	local price = priceForKey(key)
	if price > 0 and not GameServerAPI.WaitFor("SpendFakeRobux")(player, price) then
		return false, "No tienes suficientes Fake Robux"
	end
	local ok, msg = grantGamepass(player, key, false)
	if not ok and price > 0 then
		GameServerAPI.WaitFor("AddFakeRobux")(player, price)
	end
	if ok and GameServerAPI.PlaySFX then
		GameServerAPI.PlaySFX(player, "Purchase")
	end
	return ok, msg
end

----------------------------------------------------------------------
-- MODDED: compras por Fake Robux para botones FUERA de la tienda (P2W, Pets,
-- BanHammer, etc.) que antes llamaban a MarketplaceService directo. El cliente
-- (SharedModules.FakeBuy) muestra el prompt y luego invoca esto con el id.
----------------------------------------------------------------------
local function getRF(name)
	local folder = ReplicatedStorage:FindFirstChild("RemoteEvents")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "RemoteEvents"
		folder.Parent = ReplicatedStorage
	end
	local rf = folder:FindFirstChild(name)
	if not rf then
		rf = Instance.new("RemoteFunction")
		rf.Name = name
		rf.Parent = folder
	end
	return rf
end

-- Dev product por ProductId -> resuelve la Key, cobra Fake Robux y entrega.
getRF("FakeBuyProduct").OnServerInvoke = function(player, productId)
	if type(productId) ~= "number" then
		return false, "id inválido"
	end
	local key = productKeyById[productId]
	if not key then
		return false, "producto no mapeado"
	end
	local price = priceForKey(key)
	if price > 0 and not GameServerAPI.WaitFor("SpendFakeRobux")(player, price) then
		return false, "No tienes suficientes Fake Robux"
	end
	local ok, msg = grantByKey(player, key)
	if not ok and price > 0 then
		GameServerAPI.WaitFor("AddFakeRobux")(player, price)
	end
	if ok and GameServerAPI.PlaySFX then
		GameServerAPI.PlaySFX(player, "Purchase")
	end
	print(("[DevProductService] FakeBuyProduct %s -> %s (%s) [%d FR]"):format(player.Name, tostring(key), tostring(msg), price))
	return ok, msg
end

-- Gamepass por GamepassId -> resuelve la Key, cobra (si no lo tiene) y entrega.
getRF("FakeBuyGamepass").OnServerInvoke = function(player, gamepassId)
	if type(gamepassId) ~= "number" then
		return false, "id inválido"
	end
	local key
	for k, id in pairs(gamepassIdByKey) do
		if id == gamepassId then
			key = k
			break
		end
	end
	if not key then
		return false, "gamepass no mapeado"
	end
	if gamepassAlreadyOwned(player, key) then
		return grantGamepass(player, key, false)
	end
	local price = priceForKey(key)
	if price > 0 and not GameServerAPI.WaitFor("SpendFakeRobux")(player, price) then
		return false, "No tienes suficientes Fake Robux"
	end
	local ok, msg = grantGamepass(player, key, false)
	if not ok and price > 0 then
		GameServerAPI.WaitFor("AddFakeRobux")(player, price)
	end
	if ok and GameServerAPI.PlaySFX then
		GameServerAPI.PlaySFX(player, "Purchase")
	end
	return ok, msg
end

DevP.GamepassPurchased.OnServerInvoke = function(player, key)
	return grantGamepass(player, key, false)
end

-- Tokens no estan modelados en este server reconstruido.
DevP.PurchaseWithTokens.OnServerInvoke = function()
	return false, "Tokens no soportados en este servidor"
end

----------------------------------------------------------------------
-- ProcessReceipt (compras Robux reales; activo si InstantPurchases = false)
----------------------------------------------------------------------
local processedReceipts = {}

MarketplaceService.ProcessReceipt = function(receipt)
	local player = Players:GetPlayerByUserId(receipt.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local pid = ("%d_%s"):format(receipt.PlayerId, tostring(receipt.PurchaseId))
	if processedReceipts[pid] then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local key = productKeyById[receipt.ProductId]

	-- Compras a granel con ID compartido (x3/x10): preferir la Key que el cliente
	-- declaró por DevProductPendingPurchase, pero SOLO si su ProductId coincide con
	-- el realmente comprado (anti-escalada: no puede cambiar a otro precio/producto).
	local pending = pendingByPlayer[player]
	if pending and type(pending.key) == "string"
		and (os.time() - pending.at) <= 1200
		and productIdByKey[pending.key] == receipt.ProductId then
		key = pending.key
	end

	if not key then
		warn(("[DevProductService] ProcessReceipt: ProductId %s sin Key mapeada"):format(tostring(receipt.ProductId)))
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local ok = pcall(grantByKey, player, key)
	if not ok then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	pendingByPlayer[player] = nil
	processedReceipts[pid] = true
	if GameServerAPI.PlaySFX then
		GameServerAPI.PlaySFX(player, "Purchase")
	end
	return Enum.ProductPurchaseDecision.PurchaseGranted
end

----------------------------------------------------------------------
-- Modo de compra instantanea (sin Robux) para testeo.
-- Pon esto en false (o usa el comando Cmdr 'instantpurchases') para volver
-- a compras Robux nativas via ProcessReceipt.
----------------------------------------------------------------------
-- false = compras Robux REALES (el botón abre el prompt de Robux y ProcessReceipt
-- entrega). Requiere que el ProductId/GamepassId sea TUYO (ver DevProductOverrides).
-- Ponlo en true sólo para testear entrega sin Robux (InstantGrant).
-- MODDED: true = todas las compras se pagan con Fake Robux (no se abre el prompt
-- de Robux reales). El cobro/entrega lo hacen InstantGrant / InstantGrantGamepass.
workspace:SetAttribute("InstantPurchasesEnabled", true)

----------------------------------------------------------------------
-- Re-entregar el gear de los gamepasses poseídos al unirse/respawnear
-- (GameServer restaura el atributo OwnedGamepasses desde el perfil).
----------------------------------------------------------------------
local function applyOwnedGamepasses(player)
	local owned = player:GetAttribute("OwnedGamepasses")
	if type(owned) ~= "string" or owned == "" then
		return
	end
	for name in owned:gmatch("[^,]+") do
		giveGamepassGear(player, name)
	end
end

local function hookGamepassPlayer(player)
	task.spawn(function()
		-- esperar a que GameServer ponga el atributo desde el perfil
		for _ = 1, 150 do
			if player:GetAttribute("OwnedGamepasses") ~= nil then
				break
			end
			task.wait(0.1)
		end
		applyOwnedGamepasses(player)
	end)
	player:GetAttributeChangedSignal("OwnedGamepasses"):Connect(function()
		applyOwnedGamepasses(player)
	end)
	player.CharacterAdded:Connect(function()
		task.wait(0.5)
		applyOwnedGamepasses(player)
	end)
end
Players.PlayerAdded:Connect(hookGamepassPlayer)
for _, p in Players:GetPlayers() do
	hookGamepassPlayer(p)
end

Players.PlayerRemoving:Connect(function(player)
	giftTargetByPlayer[player] = nil
	pendingByPlayer[player] = nil
end)

print(("[DevProductService] listo — %d productos mapeados · InstantPurchases ON · Sheckles+Seeds entregables"):format(loaded))
