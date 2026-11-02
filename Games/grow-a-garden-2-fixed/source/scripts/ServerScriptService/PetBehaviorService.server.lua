--credit to leon games studio
--[[
	PetBehaviorService (MODDED — reconstruido)
	====================================================================
	Las pasivas de las pets NO funcionaban porque los módulos de
	ReplicatedStorage.SharedModules.PetBehaviors hacen
	`ServerScriptService:WaitForChild("Services")` (una capa de servicios que
	este server reconstruido no tiene) y, sobre todo, el "PetBehaviorService"
	que debía CORRER las habilidades nunca se construyó (lo dice el propio
	PetEquipService: "el futuro PetBehaviorService").

	Este servicio implementa las pasivas de tipo BUFF (sin IA de movimiento):
	  • Frog            -> +salto       (boost * 5)
	  • Bunny           -> +velocidad   (boost * 5)
	  • Owl             -> +distancia de cámara/visión (boost * 12.5%)
	  • Deer            -> crecimiento   +(boost*10)% más rápido   (atributo PetGrowthMult)
	  • Unicorn         -> x(boost+1) prob. de Rainbow              (atributo PetRainbowMult)
	  • GoldenDragonfly -> x(boost+1) prob. de Gold                (atributo PetGoldMult)

	boost = PetTypes.GetBoostMultiplier(PetType) * PetSizes.GetBoostMultiplier(PetSize)
	(Normal=1, Big=2, Huge=3, Rainbow=x1.25 — combinables).

	Los buffs de crecimiento/mutación los CONSUME PlantService leyendo los
	atributos del jugador. Los de movimiento se aplican al Humanoid como un
	DELTA propio (no pisa los buffs temporales relativos de Mushroom/GhostPepper).

	Las pets equipadas se obtienen de GameServerAPI.GetEquippedPets (PetEquipService).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameServerAPI = require(script.Parent.GameServerAPI)
local PetSizes = require(ReplicatedStorage.SharedData.PetSizes)
local PetTypes = require(ReplicatedStorage.SharedData.PetTypes)

local POLL = 1.5 -- cada cuánto se re-evalúan las pets equipadas (gracias a los deltas es barato y seguro)

local getEquipped = GameServerAPI.WaitFor("GetEquippedPets")

-- [player] = { speed = <bonus aplicado>, jump = <bonus aplicado>, zoomBase = <zoom original> }
local applied: { [Player]: any } = {}

local function boostOf(entry): number
	local slot = entry.Slot
	local size = slot and slot:GetAttribute("PetSize")
	local ptype = slot and slot:GetAttribute("PetType")
	return PetTypes.GetBoostMultiplier(ptype) * PetSizes.GetBoostMultiplier(size)
end

-- Normaliza el nombre de especie a la clave de PetData (sin espacios): "Golden Dragonfly" -> "GoldenDragonfly"
local function speciesKey(name: string?): string
	if type(name) ~= "string" then
		return ""
	end
	return (name:gsub("%s", ""))
end

local function computeBuffs(player: Player)
	local speed, jump, viewPct = 0, 0, 0
	local growth, rainbow, gold = 1, 1, 1

	local ok, list = pcall(getEquipped, player)
	if not ok or type(list) ~= "table" then
		return speed, jump, viewPct, growth, rainbow, gold
	end

	for _, entry in ipairs(list) do
		local b = boostOf(entry)
		local key = speciesKey(entry.Name)

		if key == "Frog" then
			jump += b * 5
		elseif key == "Bunny" then
			speed += b * 5
		elseif key == "Owl" then
			viewPct += b * 12.5
		elseif key == "Deer" then
			growth += (b * 10) / 100
		elseif key == "Unicorn" then
			rainbow *= (b + 1)
		elseif key == "GoldenDragonfly" then
			gold *= (b + 1)
		end
	end

	return speed, jump, viewPct, growth, rainbow, gold
end

local function apply(player: Player)
	local rec = applied[player]
	if not rec then
		return
	end

	local speed, jump, viewPct, growth, rainbow, gold = computeBuffs(player)

	-- Atributos que lee PlantService (crecimiento / probabilidad de mutación)
	player:SetAttribute("PetGrowthMult", growth)
	player:SetAttribute("PetRainbowMult", rainbow)
	player:SetAttribute("PetGoldMult", gold)

	-- Movimiento: aplicar SOLO nuestro delta para coexistir con Mushroom/GhostPepper/Gear
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local dSpeed = speed - rec.speed
		if dSpeed ~= 0 then
			humanoid.WalkSpeed = math.max(0, humanoid.WalkSpeed + dSpeed)
			rec.speed = speed
		end
		local dJump = jump - rec.jump
		if dJump ~= 0 then
			if humanoid.UseJumpPower then
				humanoid.JumpPower = math.max(0, humanoid.JumpPower + dJump)
			else
				humanoid.JumpHeight = math.max(0, humanoid.JumpHeight + dJump)
			end
			rec.jump = jump
		end
	end

	-- Owl: distancia de cámara (multiplicativo sobre el original del jugador)
	if rec.zoomBase then
		player.CameraMaxZoomDistance = rec.zoomBase * (1 + viewPct / 100)
	end
end

local function onCharacterAdded(player: Player, character: Model)
	local rec = applied[player]
	if not rec then
		return
	end
	-- Humanoid nuevo => nuestras contribuciones al WalkSpeed/Jump vuelven a 0
	rec.speed = 0
	rec.jump = 0
	character:WaitForChild("Humanoid", 10)
	task.wait(0.15) -- dejar que otros sistemas seteen el WalkSpeed base primero
	apply(player)
end

local function onPlayerAdded(player: Player)
	applied[player] = {
		speed = 0,
		jump = 0,
		zoomBase = player.CameraMaxZoomDistance,
	}
	player.CharacterAdded:Connect(function(character)
		onCharacterAdded(player, character)
	end)
	if player.Character then
		task.spawn(onCharacterAdded, player, player.Character)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end
Players.PlayerRemoving:Connect(function(player)
	applied[player] = nil
end)

-- Re-evaluación periódica. Como apply() escribe SOLO el delta cuando el set de
-- pets cambia, este poll no pisa buffs temporales ni cuesta nada si nada cambió.
task.spawn(function()
	while true do
		task.wait(POLL)
		for player in applied do
			apply(player)
		end
	end
end)

print("[PetBehaviorService] listo — pasivas de buff activas (Frog/Bunny/Owl/Deer/Unicorn/GoldenDragonfly)")
