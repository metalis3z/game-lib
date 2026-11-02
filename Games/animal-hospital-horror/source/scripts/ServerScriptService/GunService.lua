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

local GunService = {}

local GUN_ID          = Prods.gun.id
local MAX_CHARGES     = 20
local DAMAGE          = 100   -- 1 disparo tumba a un humanoide normal (100 HP)
local MAX_RANGE       = 300   -- studs
local FIRE_COOLDOWN   = 0.30  -- anti-spam server (el cliente usa 0.35)

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

local function setCharges(tool, n)
	tool:SetAttribute("Charges", n)
	tool.Name = "Gun (" .. n .. ")"
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

	if result then
		local hitHum = humanoidFromHit(result.Instance)
		if hitHum and hitHum ~= myHum and hitHum.Health > 0 then
			local model = hitHum.Parent
			if model and model:HasTag("NPC") then
				-- NPC baleado: NO muere, pasa a "downed" para cargarlo a Emergency.
				local Emergency = require(ServerScriptService:WaitForChild("EmergencyService"))
				Emergency:Down(model, player)
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
}

-- Otros servicios registran aquí sus DevProducts (GunService es el dueño único
-- de ProcessReceipt). handler(player) -> true si se entregó. Se puede llamar en
-- cualquier momento (processReceipt lee la tabla en vivo).
function GunService:RegisterProduct(productId, handler)
	receiptHandlers[productId] = handler
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

	-- Dueño del ProcessReceipt.
	MarketplaceService.ProcessReceipt = processReceipt

	print("[GunService] inicializado — prop 'Buy Gun' + ProcessReceipt (gun id " .. GUN_ID .. ")")
end

return GunService
