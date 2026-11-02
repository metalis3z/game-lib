--credit to prince games studio
--[[
	ExclusiveShopService
	--------------------------------------------------------------------
	Lado SERVIDOR de la tienda exclusiva (SeedShop > ExclusiveShop).

	Lee ReplicatedStorage.SharedModules.ExclusiveShopData, mantiene el
	stock por rareza (Secret / Super / Exotic), reabastece periodicamente
	segun RestockChance / RestockTime / GarenteedStock y replica el estado
	a los clientes con Networking.ExclusiveShop.DealUpdate -- evento que el
	ExclusiveStoreController del cliente ya consume.

	Contrato que espera el cliente (por cada rareza ACTIVA):
		[rareza] = {
			items       = { { itemName, image, stock, productKey, giftable } },
			expiresAt   = <os.time del momento en que el trato se va>,
			restockTime = <duracion del ciclo; alimenta la barra "Leaves In">,
		}
	El cliente solo usa items[1]: cada rareza muestra UN trato a la vez.
	Si una rareza no aparece en el snapshot, el cliente la borra (clearDeal).

	Nota: en este lugar DevProducts.Products esta vacio, asi que el precio
	en Robux no resolvera (el cliente degrada a "Buy" y la compra real no
	procede hasta poblar DevProducts). Tratos, stock, temporizador y
	restock funcionan de todos modos.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Networking = require(ReplicatedStorage.SharedModules.Networking)
local ExclusiveShopData = require(ReplicatedStorage.SharedModules.ExclusiveShopData)

local DealUpdate = Networking.ExclusiveShop.DealUpdate

-- Cada cuanto re-emitimos el estado actual a TODOS, independiente del
-- restock. Asegura que un cliente que recien abre la tienda (su
-- ExclusiveStoreController acaba de conectar OnClientEvent) vea los
-- tratos en pocos segundos en vez de esperar al proximo restock (Exotic
-- restockea cada 300s).
local BROADCAST_INTERVAL = 5

-- Estado vivo por rareza: { item = <itemData>, stock = n, expiresAt = t, restockTime = n }
local active = {}

--------------------------------------------------------------------
-- Seleccion ponderada
--------------------------------------------------------------------
-- Elige un Amount segun una lista { {Amount, Chance}, ... } (Chance en %).
local function rollAmount(amounts)
	if not amounts then
		return 0
	end
	local roll = math.random() * 100
	local acc = 0
	for _, entry in ipairs(amounts) do
		acc += entry.Chance or 0
		if roll <= acc then
			return entry.Amount or 0
		end
	end
	return 0
end

-- Elige un item de la rareza, ponderado por ItemRestockChance.
local function pickItem(items)
	local total = 0
	for _, item in ipairs(items) do
		total += item.ItemRestockChance or 0
	end
	if total <= 0 then
		return items[1]
	end
	local roll = math.random() * total
	local acc = 0
	for _, item in ipairs(items) do
		acc += item.ItemRestockChance or 0
		if roll <= acc then
			return item
		end
	end
	return items[#items]
end

--------------------------------------------------------------------
-- Snapshot / broadcast
--------------------------------------------------------------------
-- Construye el snapshot completo (todas las rarezas con stock > 0).
-- Limpia de paso las rarezas cuyo trato ya expiro.
local function buildSnapshot()
	local now = os.time()
	local snapshot = {}
	for rarity, state in pairs(active) do
		if state.expiresAt <= now then
			active[rarity] = nil
		elseif state.stock > 0 then
			local item = state.item
			snapshot[rarity] = {
				items = {
					{
						itemName   = item.ItemName,
						image      = item.Image,
						stock      = state.stock,
						productKey = "ExclusiveGear:" .. item.ItemName .. ":1",
						giftable   = item.Giftable == true,
					},
				},
				expiresAt   = state.expiresAt,
				restockTime = state.restockTime,
			}
		end
	end
	return snapshot
end

local function broadcast()
	DealUpdate:FireAllClients(buildSnapshot())
end

--------------------------------------------------------------------
-- Restock
--------------------------------------------------------------------
-- Reabastece una rareza. Devuelve true si quedo con stock.
local function restock(rarity, cfg)
	local guaranteed = cfg.GarenteedStock or 0
	local stocked = guaranteed > 0 or (math.random() * 100) <= (cfg.RestockChance or 0)

	if not stocked then
		active[rarity] = nil
		return false
	end

	local item = pickItem(cfg.Items)
	if not item then
		active[rarity] = nil
		return false
	end

	-- Las RestockAmounts del tier mandan; si no, las del item.
	local amount = rollAmount(cfg.RestockAmounts or item.RestockAmounts)
	amount = math.max(amount, guaranteed)
	if cfg.MaximumStock then
		amount = math.min(amount, cfg.MaximumStock)
	end

	if amount <= 0 then
		active[rarity] = nil
		return false
	end

	local restockTime = cfg.RestockTime or 60
	active[rarity] = {
		item        = item,
		stock       = amount,
		restockTime = restockTime,
		expiresAt   = os.time() + restockTime,
	}
	return true
end

-- Un bucle independiente por rareza, cada uno a su propia cadencia.
local function runRarity(rarity, cfg)
	local period = cfg.RestockTime or 60
	while true do
		restock(rarity, cfg)
		broadcast()
		task.wait(period)
	end
end

--------------------------------------------------------------------
-- Arranque
--------------------------------------------------------------------
-- Al entrar, empuja el estado actual unas veces para sobrevivir a la
-- carrera con el ExclusiveStoreController que aun se esta cargando.
Players.PlayerAdded:Connect(function(player)
	task.spawn(function()
		for _ = 1, 5 do
			if player.Parent == nil then
				return
			end
			DealUpdate:FireClient(player, buildSnapshot())
			task.wait(2)
		end
	end)
end)

-- Bucle de restock por rareza.
for rarity, cfg in pairs(ExclusiveShopData.Data) do
	task.spawn(runRarity, rarity, cfg)
end

-- Heartbeat: re-emite el estado actual a todos cada pocos segundos.
task.spawn(function()
	while true do
		task.wait(BROADCAST_INTERVAL)
		broadcast()
	end
end)
