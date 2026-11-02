--[[
	GunService  (Fase 10 — arma de fuego comprable)

	El prop Workspace.Misc.Gun tiene un ProximityPrompt ("Buy Gun"). Al activarlo
	le pedimos al jugador comprar el DevProduct "gun" (Data.Prods.gun.id). Cuando
	la compra se confirma (ProcessReceipt), le damos el Tool Gun con 20 balas.

	Munición y daño son AUTORITATIVOS del server:
	  · Cada Tool guarda las balas en el atributo "Charges" y su nombre muestra
	    "Gun (n)". Al llegar a 0 el Tool se destruye.
	  · El cliente (Tools.Gun.GunClient) solo pide "ShootGun" con el punto objetivo;
	    aquí raycasteamos desde la cabeza del tirador y aplicamos el daño.

	IMPORTANTE: este servicio es el DUEÑO de MarketplaceService.ProcessReceipt
	(solo puede haber uno en todo el juego). Otros DevProducts se añaden a la tabla
	`receiptHandlers`; los que no estén registrados devuelven NotProcessedYet para
	que Roblox reintente en otra sesión y no se pierda la compra.

	API: GunService:Init(), GunService:GiveGun(player)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local Prods = require(ReplicatedStorage.Data.Prods)
local DataService = require(ServerScriptService:WaitForChild("DataService"))

local GunService = {}

local GUN_ID          = Prods.gun.id
local MAX_CHARGES     = 20
local DAMAGE          = 100   -- 1 disparo tumba a un humanoide normal (100 HP)
local MAX_RANGE       = 300   -- studs
local FIRE_COOLDOWN   = 0.30  -- anti-spam server (el cliente usa 0.35)

-- M4: mismo sistema de disparo que Gun (findGun/onShoot no distinguen, solo
-- miran IsGun+Charges) pero PERSISTENTE (Inventory.M4Charges en el perfil,
-- ver DataService) y se puede comprar mas de uno.
local M4_ID           = Prods.m4.id
local M4_MAX_CHARGES  = 500

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function getTemplate()
	return ReplicatedStorage:WaitForChild("Tools"):WaitForChild("Gun")
end

local function findGun(player)
	for _, container in ipairs({ player.Character, player:FindFirstChildOfClass("Backpack") }) do
		if container then
			for _, obj in ipairs(container:GetChildren()) do
				if obj:IsA("Tool") and obj:GetAttribute("IsGun") then
					return obj
				end
			end
		end
	end
	return nil
end

local function ownerOf(tool)
	local p = tool.Parent
	if not p then return nil end
	if p:IsA("Backpack") then return p.Parent end
	return Players:GetPlayerFromCharacter(p)
end

local function setCharges(tool, n)
	tool:SetAttribute("Charges", n)
	-- generico: funciona para "Gun" y "M4" (o cualquier otro gun-tool futuro)
	-- en vez de hardcodear "Gun (n)".
	local base = tool.Name:match("^(.-)%s*%(%d+%)$") or tool.Name
	tool.Name = base .. " (" .. n .. ")"

	-- M4: sincroniza la municion restante al perfil (persistente). El slot
	-- identifica CUAL de los M4 del jugador es este Tool (puede tener varios).
	local slot = tool:GetAttribute("M4Slot")
	if slot then
		local player = ownerOf(tool)
		local data = player and DataService:Get(player)
		local charges = data and data.Inventory and data.Inventory.M4Charges
		if charges and charges[slot] ~= nil then
			charges[slot] = n
			DataService:PushCategory(player, "Inventory")
		end
	end

	if n <= 0 then
		task.delay(0.15, function()
			if tool.Parent then tool:Destroy() end
		end)
	end
end

-- Sube por el modelo buscando el Humanoid del objetivo (parte / accesorio / limb).
local function humanoidFromHit(inst)
	local model = inst:FindFirstAncestorWhichIsA("Model")
	while model do
		local hum = model:FindFirstChildOfClass("Humanoid")
		if hum then return hum end
		model = model:FindFirstAncestorWhichIsA("Model")
	end
	return nil
end

--------------------------------------------------------------------------------
-- Entregar el arma (usado por ProcessReceipt; reutilizable por clase/tienda)
--------------------------------------------------------------------------------
function GunService:GiveGun(player)
	-- Si ya tiene una, recargar a tope (comprar de nuevo repone balas).
	local existing = findGun(player)
	if existing then
		setCharges(existing, MAX_CHARGES)
		return true
	end

	local backpack = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 10)
	if not backpack then return false end

	local gun = getTemplate():Clone()
	gun:SetAttribute("Charges", MAX_CHARGES)
	gun.Name = "Gun (" .. MAX_CHARGES .. ")"
	gun.Parent = backpack
	return true
end

--------------------------------------------------------------------------------
-- M4 (rifle permanente, municion persistente, se puede comprar mas de uno)
--------------------------------------------------------------------------------
local function getM4Template()
	return ReplicatedStorage:WaitForChild("Tools"):WaitForChild("M4")
end

local function giveM4Tool(player, slot, charges)
	local backpack = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 10)
	if not backpack then return end
	local tool = getM4Template():Clone()
	tool:SetAttribute("M4Slot", slot)
	tool.Parent = backpack
	setCharges(tool, charges)
end

-- Repone TODOS los M4 que el jugador ya tenia (uno por cada slot con balas
-- > 0 en el perfil). Se llama UNA vez por join, no en cada respawn (el
-- Backpack ya sobrevive solo a la muerte, dar de nuevo duplicaria el arma).
local function restoreM4s(player)
	local data = DataService:Get(player)
	local charges = data and data.Inventory and data.Inventory.M4Charges
	if not charges then return end
	for slot, n in ipairs(charges) do
		if n and n > 0 then
			giveM4Tool(player, slot, n)
		end
	end
end

-- Compra: agrega un slot nuevo (municion llena) al perfil y da el Tool.
-- Llamable varias veces -> varios M4 independientes, cada uno con su propia
-- municion (ver setCharges, que sincroniza charges[slot] al disparar).
local function buyM4(player)
	local data = DataService:Get(player)
	if not data then return false end
	data.Inventory.M4Charges = data.Inventory.M4Charges or {}
	table.insert(data.Inventory.M4Charges, M4_MAX_CHARGES)
	local slot = #data.Inventory.M4Charges
	DataService:PushCategory(player, "Inventory")
	giveM4Tool(player, slot, M4_MAX_CHARGES)
	return true
end

--------------------------------------------------------------------------------
-- Disparo (autoritativo)
--------------------------------------------------------------------------------
local lastShot = {}   -- [player] = os.clock()

local function onShoot(player, target)
	if typeof(target) ~= "Vector3" then return end

	local now = os.clock()
	if lastShot[player] and now - lastShot[player] < FIRE_COOLDOWN then return end

	local char = player.Character
	local head = char and (char:FindFirstChild("Head") or char.PrimaryPart)
	local myHum = char and char:FindFirstChildOfClass("Humanoid")
	if not (head and myHum and myHum.Health > 0) then return end

	local gun = findGun(player)
	if not gun then return end
	local charges = gun:GetAttribute("Charges") or 0
	if charges <= 0 then return end

	lastShot[player] = now

	-- Origen autoritativo = cabeza del tirador; dirección hacia el objetivo pedido.
	local origin = head.Position
	local diff = target - origin
	if diff.Magnitude < 0.1 then return end

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { char }
	local result = workspace:Raycast(origin, diff.Unit * MAX_RANGE, params)

	-- Se gasta la bala al disparar, pegue o no.
	setCharges(gun, charges - 1)

	-- El M4 se distingue por su atributo M4Slot (findGun devuelve primero la que
	-- esta EQUIPADA, que es la que disparo).
	local isM4 = gun:GetAttribute("M4Slot") ~= nil

	if result then
		local hitHum = humanoidFromHit(result.Instance)
		if hitHum and hitHum ~= myHum and hitHum.Health > 0 then
			local model = hitHum.Parent
			local hitPlayer = model and Players:GetPlayerFromCharacter(model)
			if model and model:HasTag("NPC") then
				-- NPC baleado: NO muere, pasa a "downed" para cargarlo a Emergency.
				local Emergency = require(ServerScriptService:WaitForChild("EmergencyService"))
				Emergency:Down(model, player)
			elseif hitPlayer then
				-- El M4 NO puede matar jugadores (tampoco morfeados: el morph
				-- sigue siendo player.Character, asi que GetPlayerFromCharacter
				-- lo detecta igual). La Gun normal si les hace daño.
				if not isM4 then
					hitHum:TakeDamage(DAMAGE)
				end
			else
				hitHum:TakeDamage(DAMAGE)
			end
		end
	end
end

--------------------------------------------------------------------------------
-- ProcessReceipt (dueño único)
--------------------------------------------------------------------------------
local receiptHandlers = {
	[GUN_ID] = function(player)
		return GunService:GiveGun(player)
	end,
	[M4_ID] = buyM4,
}

-- Otros servicios registran aquí sus DevProducts (GunService es el dueño único
-- de ProcessReceipt). handler(player) -> true si se entregó. Se puede llamar en
-- cualquier momento (processReceipt lee la tabla en vivo).
function GunService:RegisterProduct(productId, handler)
	receiptHandlers[productId] = handler
end

-- Entrega un producto SIN cobrarlo (regalos / comandos de admin). Usa el MISMO
-- handler que el recibo de compra, así el regalo hace exactamente lo mismo que
-- la compra real. Devuelve true si se entregó.
function GunService:GrantProduct(player, productId)
	local handler = receiptHandlers[productId]
	if not handler then return false, "sin entrega registrada" end
	local ok, result = pcall(handler, player)
	if not ok then
		warn("[GunService] GrantProduct fallo: " .. tostring(result))
		return false, "error en la entrega"
	end
	return result ~= false
end

-- Nombres de los productos que HOY tienen entrega registrada (para el comando).
function GunService:GetGrantableIds()
	local ids = {}
	for id in pairs(receiptHandlers) do
		ids[#ids + 1] = id
	end
	return ids
end

local function processReceipt(info)
	local handler = receiptHandlers[info.ProductId]
	if not handler then
		-- No es un producto que manejemos (todavía): reintentar luego, no perder la compra.
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local player = Players:GetPlayerByUserId(info.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local ok, granted = pcall(handler, player)
	if ok and granted then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	-- Falló la entrega: reintentar en la próxima oportunidad.
	return Enum.ProductPurchaseDecision.NotProcessedYet
end

--------------------------------------------------------------------------------
function GunService:Init()
	if self._initialized then return end
	self._initialized = true

	-- (La COMPRA la dispara el Script dentro de Workspace.Misc.Gun.PP;
	--  aquí solo damos el arma vía ProcessReceipt + manejamos el disparo.)

	-- Disparo autoritativo.
	Network:Connect("ShootGun", onShoot)

	-- Limpieza de cooldowns.
	Players.PlayerRemoving:Connect(function(plr) lastShot[plr] = nil end)

	-- M4: reponer los que el jugador ya tenia guardados (persistente).
	Players.PlayerAdded:Connect(function(player) task.spawn(restoreM4s, player) end)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(restoreM4s, player)
	end

	-- Dueño del ProcessReceipt.
	MarketplaceService.ProcessReceipt = processReceipt

	-- print("[GunService] inicializado — prop 'Buy Gun' + ProcessReceipt (gun id " .. GUN_ID .. ")")
end

return GunService
