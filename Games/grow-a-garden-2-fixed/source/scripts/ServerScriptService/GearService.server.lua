--credit to quartz games studio
--[[
	GearService  (servidor)
	--------------------------------------------------------------------
	Tienda de gear (GearShop) + entrega/equipado, reconstruido sobre el
	contrato de RestockStoreController (idéntico a la SeedShop de
	PlantService) y los GearHandleControllers del cliente.

	Dos tipos de gear (GearShopData):
	  • Restock gear (tiene RestockChance): Tool APILABLE con atributo
	    <Tipo>=Nombre + Count. El cliente (p.ej. WateringcanHandleController,
	    SprinklerHandleController…) le clona el visual de Assets.<Carpeta>[Nombre]
	    al EQUIPAR. La categoría del inventario sale de ese atributo
	    (InventoryController.Main.getToolCategory). Tipos: Watering Can,
	    Sprinkler, Trowel, Mushroom, Gnome, Teleporter, EmptyPot, Flashbang.
	  • Equippable gear (EquippableGear=true: Sign/Lantern/Wheelbarrow):
	    compra PERMANENTE (OwnedEquippableGears) + equip/unequip; se difunde
	    GearEquipState. (El visual del equipado lo maneja su propio controller
	    si existe; aquí queda el estado correcto para la tienda.)

	Canales (Networking.GearShop):
	  PurchaseGear(name)      [event]   compra con sheckles (restock o equipable)
	  EquipGear(name)         [event]   equipa un equipable poseído
	  UnequipGear()           [event]   desequipa el actual
	  GearEquipState(name,b)  [→client] difunde estado de equipado
	  RequestEquippableState  [invoke]  -> {OwnedEquippableGears={[n]=true}, EquippedGear=n?}

	Stock (modelo GAG real, igual que la SeedShop): StockValues.GearShop.Items[name].Value
	= TOPE rodado (RestockValues), igual para todos; cada jugador resta sus compras
	en PlayerState.Data.PurchasedThisRestock["Gears"][name]. Restock cada 300s.
]]

local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local ServerScriptService= game:GetService("ServerScriptService")

local Networking    = require(ReplicatedStorage.SharedModules.Networking)
local GearShopData  = require(ReplicatedStorage.SharedModules.GearShopData)
local GameServerAPI = require(ServerScriptService.GameServerAPI)

local RESTOCK_INTERVAL = 60 -- MODDED: restock cada 1 minuto

local StockValues   = ReplicatedStorage:FindFirstChild("StockValues")
local GearShopStock = StockValues and StockValues:FindFirstChild("GearShop")
local GearItems     = GearShopStock and GearShopStock:FindFirstChild("Items")

local GShop = Networking.GearShop

----------------------------------------------------------------------
-- Índice por nombre + mapeo Tipo -> atributo del Tool
----------------------------------------------------------------------
local gearByName = {}
for _, entry in ipairs(GearShopData.Data) do
	gearByName[entry.ItemName] = entry
end

-- El inventario categoriza por el atributo; el HandleController clona el visual
-- de Assets.<Carpeta>[Nombre]. Sprinklers/Watering Cans llevan el tipo en el
-- ItemName, así que se detectan por substring.
local TYPE_ATTR = {
	Trowel = "Trowel",
	Mushroom = "Mushroom",
	Gnome = "Gnome",
	Teleporter = "Teleporter",
	EmptyPot = "EmptyPot",
	Flashbang = "Flashbang",
	Wheelbarrow = "Wheelbarrow",
	Sign = "Sign",
	Lantern = "Lantern",
	Crowbar = "Crowbar",
}

local function gearAttr(itemType: string?): string?
	if not itemType then
		return nil
	end
	if string.find(itemType, "Sprinkler") then
		return "Sprinkler"
	end
	if string.find(itemType, "Watering Can") then
		return "WateringCan"
	end
	return TYPE_ATTR[itemType]
end

local function isEquippable(entry): boolean
	return entry ~= nil and entry.EquippableGear == true
end

----------------------------------------------------------------------
-- Estado por jugador
----------------------------------------------------------------------
local counts           = {}  -- [uid][name] = cantidad (gear apilable)
local ownedEquippable  = {}  -- [uid][name] = true
local equippedGear     = {}  -- [uid] = name | nil
local materializeEquippable, removeEquippableTool  -- forward (definidos más abajo)

----------------------------------------------------------------------
-- Tools de gear apilables (restock)
----------------------------------------------------------------------
local function findGearTool(player: Player, name: string): Tool?
	for _, container in { player:FindFirstChild("Backpack"), player.Character } do
		if container then
			for _, t in container:GetChildren() do
				if t:IsA("Tool") and t:GetAttribute("GearItem") == name then
					return t
				end
			end
		end
	end
	return nil
end

-- Dónde vive el visual de cada tipo en ReplicatedStorage.Assets:
--   PER_NAME: carpeta con un Model por nombre (Assets.<folder>[name]).
--   SINGLE:   el propio Assets.<folder> ES el modelo (un único item de ese tipo).
local Assets   = ReplicatedStorage:WaitForChild("Assets")
local PER_NAME = { WateringCan = "WateringCans", Sprinkler = "Sprinklers", Mushroom = "Mushrooms" }
local SINGLE   = { Trowel = "Trowel", Gnome = "Gnome", Teleporter = "Teleporter", Flashbang = "Flashbang", EmptyPot = "POT" }
-- Tipos cuyo handle lo arma SU HandleController en el cliente (existe el script
-- <Tipo>HandleController). Para estos el server NO debe armar handle (evita el
-- conflicto cliente/servidor). EmptyPot/Flashbang NO tienen controller -> el
-- server sigue siendo su unico visual.
local CLIENT_HANDLED_GEAR = {
	WateringCan = true, Sprinkler = true, Mushroom = true,
	Trowel = true, Gnome = true, Teleporter = true, Crowbar = true,
}

local function resolveGearModel(name: string, attr: string?): Instance?
	if not attr then
		return nil
	end
	if PER_NAME[attr] then
		local folder = Assets:FindFirstChild(PER_NAME[attr])
		return folder and folder:FindFirstChild(name)
	end
	if SINGLE[attr] then
		return Assets:FindFirstChild(SINGLE[attr])
	end
	return nil
end

-- Arma el Handle (y sus partes soldadas) en el server desde el asset, así el gear
-- es visible apenas se equipa y NO depende de que el HandleController del cliente
-- exista/corra. Con RequiresHandle=false el Tool nunca se "desequipa solo". Si el
-- controller del tipo existe, hará ClearHandle al guardar y lo reconstruye al
-- reequipar (mismo asset → consistente).
local function buildGearHandle(tool: Tool, name: string, attr: string?)
	local src = resolveGearModel(name, attr)
	if not src then
		return  -- tipo sin asset directo (p.ej. equipable): el controller se encarga
	end
	local clone = src:Clone()

	local handle: BasePart?
	if clone:IsA("BasePart") then
		handle = clone
	elseif clone:IsA("Model") then
		handle = clone.PrimaryPart or clone:FindFirstChild("Handle") or clone:FindFirstChildWhichIsA("BasePart", true)
	else
		handle = clone:FindFirstChild("Handle") or clone:FindFirstChildWhichIsA("BasePart", true)
	end
	if not handle then
		clone:Destroy()
		return
	end

	-- Prepara todas las partes (sin colisión/ancla) y suéldalas al Handle; apaga VFX.
	local toWeld = {}
	for _, d in (clone:IsA("BasePart") and { clone } or clone:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = false
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			d.Massless = true
			if d ~= handle then
				table.insert(toWeld, d)
			end
		elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Fire") or d:IsA("Smoke") or d:IsA("Sparkles") or d:IsA("Light") then
			d.Enabled = false
		end
	end
	for _, d in toWeld do
		local w = Instance.new("WeldConstraint")
		w.Part0 = handle
		w.Part1 = d
		w.Parent = d
	end

	handle.Name = "Handle"
	if clone:IsA("BasePart") then
		handle.Parent = tool
	else
		handle.Parent = tool           -- el Handle suelto a la raíz del Tool
		clone.Name = "Build"
		clone.Parent = tool            -- el resto del modelo, soldado al Handle
	end
end

local function spawnGearTool(player: Player, name: string, count: number): Tool
	local entry = gearByName[name]
	local attr = entry and gearAttr(entry.ItemType)
	local tool = Instance.new("Tool")
	tool.Name = name
	tool.RequiresHandle = false           -- nunca se "desequipa solo" aunque le falte Handle
	tool.CanBeDropped = false
	tool.TextureId = (entry and entry.IMG) or ""
	tool:SetAttribute("GearItem", name)   -- clave de búsqueda propia
	tool:SetAttribute("Count", count)
	if attr then
		tool:SetAttribute(attr, name)     -- categoría (Main) + lo que lee el HandleController
		tool:SetAttribute("MainCategory", "Gear")
	end
	-- IMPORTANTE: NO armar el handle en el server para los tipos que tienen su
	-- HandleController en el cliente. Si se arma en ambos lados, el cliente hace
	-- ClearHandle sobre el handle del server (instancia replicada que NO puede
	-- destruir de verdad) y construye el suyo encima -> conflicto/desync: el
	-- modelo no aparece al equipar y el item se ve raro en la mochila. El cliente
	-- ya arma el visual de todos los jugadores. El handle server queda SOLO como
	-- fallback para tipos sin controller (EmptyPot/Flashbang).
	if attr and not CLIENT_HANDLED_GEAR[attr] then
		pcall(buildGearHandle, tool, name, attr)
	end
	tool.Parent = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack")
	return tool
end

local function syncGearTool(player: Player, name: string, count: number)
	local tool = findGearTool(player, name)
	if count <= 0 then
		if tool then
			tool:Destroy()
		end
	elseif tool then
		tool:SetAttribute("Count", count)
	else
		spawnGearTool(player, name, count)
	end
end

-- Entrega gear. Expuesto a DevProductService (compra Robux). Para equipables
-- marca el desbloqueo permanente; para restock apila en el Backpack.
local function giveGear(player: Player, name: string, amount: number?): boolean
	local entry = gearByName[name]
	if not entry then
		return false
	end
	local uid = player.UserId
	if isEquippable(entry) then
		ownedEquippable[uid] = ownedEquippable[uid] or {}
		ownedEquippable[uid][name] = true
		-- Auto-equipar al comprar/otorgar: el cliente (RestockStoreController) solo
		-- marca como "owned" al recibir GearEquipState(name, true) -> el boton pasa
		-- a "Unequip" y la Tool aparece en el inventario (Backpack). Comprado una
		-- sola vez y para siempre (purchaseGear rechaza "already-owned").
		local prev = equippedGear[uid]
		if prev and prev ~= name then
			GShop.GearEquipState:FireClient(player, prev, false)
			if removeEquippableTool then
				removeEquippableTool(player)
			end
		end
		equippedGear[uid] = name
		GShop.GearEquipState:FireClient(player, name, true)
		if materializeEquippable then
			materializeEquippable(player, name)
		end
		return true
	end
	counts[uid] = counts[uid] or {}
	counts[uid][name] = (counts[uid][name] or 0) + (amount or 1)
	syncGearTool(player, name, counts[uid][name])
	return true
end

GameServerAPI.GiveGear = giveGear

----------------------------------------------------------------------
-- USO DEL GEAR: consumo, activacion de hongos/flashbang, equipables y firma.
-- [añadido] Conecta los controllers cliente ya existentes (MushroomController,
-- FlashbangVFXController, SignToolController, WheelbarrowController) con su
-- autoridad de servidor, que no existia en la reconstruccion.
----------------------------------------------------------------------
local MushroomData = require(ReplicatedStorage.SharedModules.MushroomData)
local mushroomByName = {}
for _, m in ipairs(MushroomData.Data) do
	mushroomByName[m.Name] = m
end

-- Consume 1 unidad de un gear apilable (cuenta). Expuesto a PlantService
-- (sprinkler) y al servicio de gnomos para descontar stock al colocar/usar.
local function consumeGear(player: Player, name: string): boolean
	local uid = player.UserId
	local c = counts[uid]
	if not c or (c[name] or 0) <= 0 then
		return false
	end
	c[name] = c[name] - 1
	syncGearTool(player, name, c[name])
	return true
end
GameServerAPI.ConsumeGear = consumeGear
GameServerAPI.GetGearCount = function(player: Player, name: string): number
	local c = counts[player.UserId]
	return (c and c[name]) or 0
end

-- Snapshot del gear para persistir (GameServer.syncProfileFromState lo jala al
-- guardar, igual que el jardín). Copias planas para no guardar referencias vivas.
GameServerAPI.GetGearSave = function(player: Player)
	local uid = player.UserId
	local gears = {}
	for name, n in (counts[uid] or {}) do
		if type(n) == "number" and n > 0 then
			gears[name] = n
		end
	end
	local owned = {}
	for name in (ownedEquippable[uid] or {}) do
		owned[name] = true
	end
	local signText = ""
	local sv = player:FindFirstChild("SignText")
	if sv then
		signText = sv.Value
	end
	return { Gears = gears, Owned = owned, Equipped = equippedGear[uid] or false, SignText = signText }
end

----------------------------------------------------------------------
-- Hongos: buff temporal AUTORITATIVO (WalkSpeed/JumpPower/escala/transparencia
-- replican a todos). Dura MushroomData.LastTime. El FX de color y el highlight
-- de invisibilidad se mandan al PROPIO jugador (su MushroomController los pinta
-- sobre LocalPlayer.Character). Re-usar el mismo hongo cancela y reaplica.
----------------------------------------------------------------------
local mushroomToken: { [Player]: any } = {}
local function applyMushroom(player: Player, name: string)
	local data = mushroomByName[name]
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not (data and humanoid and character) then
		return
	end
	local token = {}
	mushroomToken[player] = token

	local restore
	if name == "Speed Mushroom" then
		humanoid.WalkSpeed = humanoid.WalkSpeed + 5
		restore = function()
			if humanoid.Parent then humanoid.WalkSpeed = math.max(0, humanoid.WalkSpeed - 5) end
		end
	elseif name == "Jump Mushroom" then
		if humanoid.UseJumpPower then
			humanoid.JumpPower = humanoid.JumpPower + 5
			restore = function()
				if humanoid.Parent then humanoid.JumpPower = math.max(0, humanoid.JumpPower - 5) end
			end
		else
			humanoid.JumpHeight = humanoid.JumpHeight + 5
			restore = function()
				if humanoid.Parent then humanoid.JumpHeight = math.max(0, humanoid.JumpHeight - 5) end
			end
		end
	elseif name == "Shrink Mushroom" then
		character:ScaleTo(character:GetScale() * 0.75)
		restore = function()
			if character.Parent then character:ScaleTo(character:GetScale() / 0.75) end
		end
	elseif name == "Supersize Mushroom" then
		character:ScaleTo(character:GetScale() * 1.25)
		restore = function()
			if character.Parent then character:ScaleTo(character:GetScale() / 1.25) end
		end
	elseif name == "Invisibility Mushroom" then
		local originals = {}
		for _, d in character:GetDescendants() do
			if d:IsA("BasePart") and d.Transparency < 1 then
				originals[d] = d.Transparency
				d.Transparency = math.max(d.Transparency, 0.7)
			end
		end
		restore = function()
			for d, tr in originals do
				if d.Parent then d.Transparency = tr end
			end
		end
		Networking.Mushrooms.SetInvisiblity:FireClient(player, true)
	end

	if data.Color then
		Networking.Mushrooms.PlayFX:FireClient(player, data.Color)
	end

	task.delay(data.LastTime or 30, function()
		if mushroomToken[player] ~= token then
			return
		end
		mushroomToken[player] = nil
		if restore then
			restore()
		end
		if name == "Invisibility Mushroom" then
			Networking.Mushrooms.SetInvisiblity:FireClient(player, false)
		end
	end)
end

----------------------------------------------------------------------
-- Flashbang: al activarse ciega a los jugadores cercanos (su
-- FlashbangVFXController pinta el flash blanco al recibir Flashbang.Detonate).
----------------------------------------------------------------------
local FLASHBANG_RADIUS = 70
local function detonateFlashbang(user: Player)
	local character = user.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local origin = root and root.Position
	if not origin then
		return
	end
	for _, p in Players:GetPlayers() do
		local pc = p.Character
		local pr = pc and pc:FindFirstChild("HumanoidRootPart")
		if pr and (pr.Position - origin).Magnitude <= FLASHBANG_RADIUS then
			Networking.Flashbang.Detonate:FireClient(p)
		end
	end
end

----------------------------------------------------------------------
-- Watcher de activacion: Tool.Activated tambien dispara en el server cuando el
-- dueño hace click con el gear equipado. Los hongos/flashbang no tienen canal
-- cliente->servidor; esta es su autoridad.
----------------------------------------------------------------------
local watchedTools: { [Tool]: boolean } = {}
local function watchGearTool(tool: Instance)
	if typeof(tool) ~= "Instance" or not tool:IsA("Tool") or watchedTools[tool] then
		return
	end
	local mushroom = tool:GetAttribute("Mushroom")
	local isFlash = tool:GetAttribute("Flashbang") ~= nil
	if not (mushroom or isFlash) then
		return
	end
	watchedTools[tool] = true
	tool.Activated:Connect(function()
		local player = Players:GetPlayerFromCharacter(tool.Parent)
		if not player then
			return
		end
		if mushroom then
			if consumeGear(player, mushroom) then
				applyMushroom(player, mushroom)
			end
		elseif isFlash then
			if consumeGear(player, "Flashbang") then
				detonateFlashbang(player)
			end
		end
	end)
	tool.Destroying:Connect(function()
		watchedTools[tool] = nil
	end)
end

local function watchPlayerGear(player: Player)
	local function scan(container: Instance?)
		if not container then
			return
		end
		for _, t in container:GetChildren() do
			watchGearTool(t)
		end
		container.ChildAdded:Connect(watchGearTool)
	end
	scan(player:FindFirstChild("Backpack") or player:WaitForChild("Backpack"))
	if player.Character then
		scan(player.Character)
	end
	player.CharacterAdded:Connect(scan)
end

----------------------------------------------------------------------
-- Gear EQUIPABLE (Sign/Lantern/Wheelbarrow): hasta ahora "equipar" solo marcaba
-- un estado y el jugador nunca recibia una Tool. Aqui la materializamos para que
-- sus controllers (SignToolController/WheelbarrowController) tengan con que
-- trabajar. Sign = cartel con texto editable; Lantern = farol con luz.
----------------------------------------------------------------------
local equippableTool: { [Player]: Tool } = {}

local function attachHandleFromModel(tool: Tool, model: Instance): BasePart?
	local clone = model:Clone()
	local handle: BasePart? = (clone:IsA("BasePart") and clone)
		or clone.PrimaryPart
		or clone:FindFirstChild("Handle")
		or clone:FindFirstChild("Primary")
		or clone:FindFirstChildWhichIsA("BasePart", true)
	if not handle then
		clone:Destroy()
		return nil
	end
	local toWeld = {}
	for _, d in (clone:IsA("BasePart") and { clone } or clone:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = false
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			d.Massless = true
			if d ~= handle then
				table.insert(toWeld, d)
			end
		elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") then
			d.Enabled = false
		end
	end
	for _, d in toWeld do
		local w = Instance.new("WeldConstraint")
		w.Part0 = handle
		w.Part1 = d
		w.Parent = d
	end
	handle.Name = "Handle"
	handle.Parent = tool
	if not clone:IsA("BasePart") then
		clone.Name = "Build"
		clone.Parent = tool
	end
	return handle
end

local function refreshSignText(player: Player)
	local tool = equippableTool[player]
	if not tool then
		return
	end
	local sv = player:FindFirstChild("SignText")
	local text = (sv and sv.Value) or ""
	-- el modelo Assets.Props.Sign ya trae Part.SurfaceGui.TextLabel: lo escribimos
	for _, label in tool:GetDescendants() do
		if label:IsA("TextLabel") then
			label.Text = text
		end
	end
end

function materializeEquippable(player: Player, name: string)
	local prev = equippableTool[player]
	if prev then
		prev:Destroy()
		equippableTool[player] = nil
	end
	local entry = gearByName[name]
	if not (entry and isEquippable(entry)) then
		return
	end
	local attr = gearAttr(entry.ItemType)
	local tool = Instance.new("Tool")
	tool.Name = name
	tool.CanBeDropped = false
	tool.TextureId = entry.IMG or ""
	tool:SetAttribute("MainCategory", "Gear")
	tool:SetAttribute("EquippableGearItem", name)
	if attr then
		tool:SetAttribute(attr, name)
	end

	local handle: BasePart?
	if name == "Sign" then
		local props = Assets:FindFirstChild("Props")
		local model = props and props:FindFirstChild("Sign")
		if model then
			handle = attachHandleFromModel(tool, model)
		end
	end
	if not handle then
		local part = Instance.new("Part")
		part.Name = "Handle"
		part.Size = Vector3.new(1, 1.6, 1)
		part.Color = Color3.fromRGB(120, 84, 48)
		part.Material = Enum.Material.Wood
		part.CanCollide = false
		part.Parent = tool
		handle = part
	end

	if name == "Lantern" and handle then
		local light = Instance.new("PointLight")
		light.Brightness = 3
		light.Range = 22
		light.Color = Color3.fromRGB(255, 214, 140)
		light.Shadows = true
		light.Parent = handle
	end

	tool.RequiresHandle = true
	tool.Parent = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack")
	equippableTool[player] = tool
	if name == "Sign" then
		refreshSignText(player)
	end
end

function removeEquippableTool(player: Player)
	local t = equippableTool[player]
	if t then
		t:Destroy()
	end
	equippableTool[player] = nil
end

-- Firma: SignToolController dispara SetSignText al confirmar el menu. Guardamos
-- el texto en player.SignText (lo lee el propio controller) y refrescamos el
-- cartel en mano.
Networking.SignTool.SetSignText.OnServerEvent:Connect(function(player, text)
	if type(text) ~= "string" then
		return
	end
	text = string.sub(text, 1, 100)
	-- Filtro de chat de Roblox: no permitir malas palabras en el cartel.
	local TextService = game:GetService("TextService")
	local ok, filtered = pcall(function()
		local result = TextService:FilterStringAsync(text, player.UserId)
		return result:GetNonChatStringForBroadcastAsync()
	end)
	if ok and type(filtered) == "string" then
		text = filtered
	end
	local sv = player:FindFirstChild("SignText")
	if not sv then
		sv = Instance.new("StringValue")
		sv.Name = "SignText"
		sv.Parent = player
	end
	sv.Value = text
	refreshSignText(player)
end)

-- Restaura el gear guardado al unirse (espera al perfil vía GetSavedGear): gear
-- apilable (counts + Tools en el backpack), equipables poseidos y el equipado.
local function restoreGear(player: Player)
	local getSaved = GameServerAPI.GetSavedGear
	if not getSaved then
		return
	end
	local saved = getSaved(player)
	if not saved or player.Parent == nil then
		return
	end
	local uid = player.UserId
	if type(saved.Gears) == "table" then
		counts[uid] = counts[uid] or {}
		for name, n in saved.Gears do
			if gearByName[name] and type(n) == "number" and n > 0 and not counts[uid][name] then
				counts[uid][name] = n
				syncGearTool(player, name, n)
			end
		end
	end
	if type(saved.Owned) == "table" then
		ownedEquippable[uid] = ownedEquippable[uid] or {}
		for name in saved.Owned do
			if gearByName[name] then
				ownedEquippable[uid][name] = true
			end
		end
	end
	-- texto del cartel guardado (antes de materializar el Sign para que aparezca)
	if type(saved.SignText) == "string" and saved.SignText ~= "" then
		local sv = player:FindFirstChild("SignText")
		if not sv then
			sv = Instance.new("StringValue")
			sv.Name = "SignText"
			sv.Parent = player
		end
		sv.Value = saved.SignText
	end
	if type(saved.Equipped) == "string" and ownedEquippable[uid] and ownedEquippable[uid][saved.Equipped] then
		equippedGear[uid] = saved.Equipped
		GShop.GearEquipState:FireClient(player, saved.Equipped, true)
		materializeEquippable(player, saved.Equipped)
	end
end

local function respawnGear(player: Player)
	local c = counts[player.UserId]
	if not c then
		return
	end
	for name, count in c do
		if count > 0 then
			syncGearTool(player, name, count)
		end
	end
end

----------------------------------------------------------------------
-- Stock / restock (idéntico al de PlantService)
----------------------------------------------------------------------
local function rollAmount(entry): number
	-- MODDED: stock fijo por rareza, SIEMPRE en stock. Common=14, el resto=5.
	if entry.Rarity == "Common" then
		return 14
	end
	return 5
end

local function restockShop()
	if GearItems then
		for name, entry in gearByName do
			if entry.RestockChance then  -- solo gear de restock (no equipables)
				local nv = GearItems:FindFirstChild(name)
				if nv and nv:IsA("NumberValue") then
					nv.Value = rollAmount(entry)
				end
			end
		end
	end
	if GearShopStock then
		local now = os.time()
		local last = GearShopStock:FindFirstChild("UnixLastRestock")
		local next_ = GearShopStock:FindFirstChild("UnixNextRestock")
		if last then last.Value = now end
		if next_ then next_.Value = now + RESTOCK_INTERVAL end
	end
	for _, player in Players:GetPlayers() do
		GameServerAPI.ResetPurchases(player, "Gears")
	end
end

----------------------------------------------------------------------
-- Compra (sheckles)
----------------------------------------------------------------------
local function purchaseGear(player: Player, name)
	local entry = gearByName[name]
	if not entry then
		return false, "no-entry"
	end
	local price = entry.Cost or 0

	if isEquippable(entry) then
		local uid = player.UserId
		if ownedEquippable[uid] and ownedEquippable[uid][name] then
			return false, "already-owned"  -- ya es suyo; equipar va por EquipGear
		end
		if GameServerAPI.WaitFor("GetSheckles")(player) < price then
			return false, "no-sheckles"
		end
		GameServerAPI.AddSheckles(player, -price)
		giveGear(player, name)  -- marca owned + difunde estado
		if GameServerAPI.PlaySFX then GameServerAPI.PlaySFX(player, "Purchase") end
		return true
	end

	-- Restock gear: stock por jugador = tope - comprado
	local nv = GearItems and GearItems:FindFirstChild(name)
	local maxStock = (nv and nv:IsA("NumberValue")) and nv.Value or 0
	local purchased = GameServerAPI.GetPurchaseCount(player, "Gears", name)
	if maxStock - purchased <= 0 then
		return false, "no-stock"
	end
	if GameServerAPI.WaitFor("GetSheckles")(player) < price then
		return false, "no-sheckles"
	end
	GameServerAPI.AddSheckles(player, -price)
	GameServerAPI.IncrementPurchase(player, "Gears", name)
	giveGear(player, name)
	if GameServerAPI.PlaySFX then GameServerAPI.PlaySFX(player, "Purchase") end
	return true
end

GShop.PurchaseGear.OnServerEvent:Connect(purchaseGear)

----------------------------------------------------------------------
-- Equipar / desequipar (equipables)
----------------------------------------------------------------------
GShop.EquipGear.OnServerEvent:Connect(function(player: Player, name)
	if type(name) ~= "string" then
		return
	end
	local uid = player.UserId
	if not (ownedEquippable[uid] and ownedEquippable[uid][name]) then
		return
	end
	local prev = equippedGear[uid]
	if prev and prev ~= name then
		GShop.GearEquipState:FireClient(player, prev, false)
	end
	equippedGear[uid] = name
	GShop.GearEquipState:FireClient(player, name, true)
	materializeEquippable(player, name)  -- darle la Tool fisica al equipar
end)

GShop.UnequipGear.OnServerEvent:Connect(function(player: Player)
	local uid = player.UserId
	local cur = equippedGear[uid]
	if not cur then
		return
	end
	equippedGear[uid] = nil
	GShop.GearEquipState:FireClient(player, cur, false)
	removeEquippableTool(player)  -- quitar la Tool fisica al desequipar
end)

GShop.RequestEquippableState.OnServerInvoke = function(player: Player)
	local uid = player.UserId
	local owned = {}
	for name in pairs(ownedEquippable[uid] or {}) do
		owned[name] = true
	end
	return {
		OwnedEquippableGears = owned,
		EquippedGear = equippedGear[uid],
	}
end

----------------------------------------------------------------------
-- Respawn / limpieza
----------------------------------------------------------------------
local function hookPlayer(player: Player)
	-- StringValue de la firma (lo lee SignToolController) y watcher de activacion.
	if not player:FindFirstChild("SignText") then
		local sv = Instance.new("StringValue")
		sv.Name = "SignText"
		sv.Parent = player
	end
	watchPlayerGear(player)
	task.spawn(restoreGear, player)  -- gear persistido (espera al perfil)
	player.CharacterAdded:Connect(function()
		task.wait(0.4)
		respawnGear(player)
		local uid = player.UserId
		if equippedGear[uid] then
			GShop.GearEquipState:FireClient(player, equippedGear[uid], true)
			materializeEquippable(player, equippedGear[uid])  -- re-crear Tool al respawnear
		end
	end)
end

for _, p in Players:GetPlayers() do
	hookPlayer(p)
end
Players.PlayerAdded:Connect(hookPlayer)
Players.PlayerRemoving:Connect(function(player)
	local uid = player.UserId
	counts[uid] = nil
	ownedEquippable[uid] = nil
	equippedGear[uid] = nil
end)

-- MODDED: exponer restock del gear shop (botón Restock del Admin Panel / Robux)
GameServerAPI.RestockGearShop = restockShop

----------------------------------------------------------------------
-- Arranque: stock inicial + bucle de restock
----------------------------------------------------------------------
restockShop()
task.spawn(function()
	while true do
		local next_ = GearShopStock and GearShopStock:FindFirstChild("UnixNextRestock")
		local waitFor = (next_ and next_.Value or (os.time() + RESTOCK_INTERVAL)) - os.time()
		task.wait(math.max(1, waitFor))
		restockShop()
	end
end)

print("[GearService] listo — tienda de gear (compra/stock/equip) + entrega de tools")
