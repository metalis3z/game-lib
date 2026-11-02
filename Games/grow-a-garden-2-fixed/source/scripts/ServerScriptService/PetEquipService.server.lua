--credit to quartz games studio
--[[
	PetEquipService  (Etapa 1 del sistema de pets equipadas)

	Reconstruye el lado SERVIDOR de equipar pets (la UI del cliente ya existe:
	PetEquipController / PetListController disparan RequestEquipByName e
	escuchan PetEquipped). El cliente PetVisualController ya renderiza y hace
	seguir al pet con SOLO setear atributos en el "slot".

	Slots = Parts "PetPart1..30" en workspace.PlayerPetReferences.<playerName>
	(los crea WildPetService). Equipar = asignar a un slot libre los atributos
	que consume PetVisualController:
	  PetSpecies (dispara el spawn, se setea AL FINAL), PetId, PetSize, PetType,
	  PetVisible, PetAttached, SlotVisualIndex (destraba BuildSlotModel),
	  SlotOffsetX / SlotOffsetZ / SlotHeightOffset (formacion detras del dueno).

	Contrato de red (SharedModules.Networking.Pets):
	  RequestEquipByName(name)        cliente -> server
	  RequestUnequipByName(name)      cliente -> server
	  RequestUnequip(petId)           cliente -> server
	  RequestToggleFollower(petId)    cliente -> server
	  GetEquippedPets() :Response     -> { {Id, Name, Size, Type}, ... }
	  PetEquipped(petId, data)        server -> cliente (FireClient)
	  PetUnequipped(petId)            server -> cliente (FireClient)

	Las pets equipadas quedan expuestas via GameServerAPI.GetEquippedPets para
	que el futuro PetBehaviorService corra las habilidades sobre esos slots.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Networking = require(ReplicatedStorage.SharedModules.Networking)
local GameServerAPI = require(script.Parent.GameServerAPI)
local PetSlotPrices = require(ReplicatedStorage.SharedData.PetSlotPrices)

local PetModules = ReplicatedStorage.SharedModules.PetModules
local PlayerPetReferences = workspace:WaitForChild("PlayerPetReferences")

local BASE_SLOTS = 3          -- pets equipadas a la vez (RequestPurchasePetSlot puede subirlo)
local MAX_SLOTS = 8
local COLS = 3                -- ancho de la formacion
local SPACING_X = 3.5
local SPACING_Z = 3.5
local FRONT_GAP = 4           -- distancia detras del dueno (la primera fila)

-- [player] = { maxSlots = n, list = { { Id, Name, Slot } } }
local equippedByPlayer = {}

local moduleCache = {}
local function getModule(species)
	if moduleCache[species] ~= nil then
		return moduleCache[species] or nil
	end
	local m = PetModules:FindFirstChild(species)
	local cfg = false
	if m then
		local ok, result = pcall(require, m)
		if ok and type(result) == "table" then
			cfg = result
		end
	end
	moduleCache[species] = cfg
	return cfg or nil
end

local function getFolder(player)
	return PlayerPetReferences:FindFirstChild(player.Name)
end

local function ownedCount(player, petName)
	if GameServerAPI.GetOwnedPetCount then
		return GameServerAPI.GetOwnedPetCount(player, petName)
	end
	return 0
end

local function countEquippedOfName(player, petName)
	local data = equippedByPlayer[player]
	if not data then
		return 0
	end
	local n = 0
	for _, entry in ipairs(data.list) do
		if entry.Name == petName then
			n += 1
		end
	end
	return n
end

-- Reparte las pets equipadas en filas detras del dueno y setea las alturas.
local function relayout(player)
	local data = equippedByPlayer[player]
	if not data then
		return
	end
	for i, entry in ipairs(data.list) do
		local slot = entry.Slot
		if slot and slot.Parent then
			local idx = i - 1
			local row = math.floor(idx / COLS)
			local col = idx % COLS
			local offsetX = (col - (COLS - 1) / 2) * SPACING_X
			local offsetZ = FRONT_GAP + row * SPACING_Z -- +Z local = detras del dueno
			slot:SetAttribute("SlotVisualIndex", i)
			slot:SetAttribute("SlotOffsetX", offsetX)
			slot:SetAttribute("SlotOffsetZ", offsetZ)

			local mod = getModule(entry.Name)
			local height = 0
			if mod and mod.IsFlying then
				height = mod.FollowAirHeight or mod.AirHeight or 3
			end
			slot:SetAttribute("SlotHeightOffset", height)
		end
	end
end

local SLOT_ATTRS = {
	"PetSpecies", "PetId", "PetSize", "PetType", "PetVisible", "PetAttached",
	"PetClaim", "SlotVisualIndex", "SlotOffsetX", "SlotOffsetZ", "SlotHeightOffset",
	"SlotOverride", "CarryingFruit", "CarryingFruitSeed", "CarryingFruitSize",
	"CarryingFruitOvertimeGrowth", "CarryingFruitMutation",
}

local function clearSlot(slot)
	if not slot then
		return
	end
	for _, attr in ipairs(SLOT_ATTRS) do
		slot:SetAttribute(attr, nil)
	end
end

local function findFreeSlot(folder)
	for _, part in ipairs(folder:GetChildren()) do
		if part:IsA("BasePart") and string.match(part.Name, "^PetPart%d+$") then
			local species = part:GetAttribute("PetSpecies")
			if species == nil or species == "" then
				return part
			end
		end
	end
	return nil
end

-- Busca el Tool de pet (en mochila o personaje) con ese PetId. Permite que el
-- clic sobre el Tool (PetHandleController -> RequestToggleFollower) resuelva
-- nombre/size/type sin un registro aparte.
local function findPetToolById(player, petId)
	local containers = {}
	if player.Character then
		table.insert(containers, player.Character)
	end
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		table.insert(containers, backpack)
	end
	for _, container in ipairs(containers) do
		for _, tool in ipairs(container:GetChildren()) do
			if tool:IsA("Tool") and tool:GetAttribute("PetId") == petId then
				return tool
			end
		end
	end
	return nil
end

-- Busca un Tool de pet por NOMBRE cuyo PetId no este ya usado (para re-equipar
-- al volver ligando la pet al Tool reconstruido -> el toggle del clic funciona).
local function findPetToolByName(player, name, usedIds)
	for _, container in { player.Character, player:FindFirstChild("Backpack") } do
		if container then
			for _, tool in ipairs(container:GetChildren()) do
				if tool:IsA("Tool") and tool:GetAttribute("Pet") == name then
					local id = tool:GetAttribute("PetId")
					if id and not usedIds[id] then
						return tool
					end
				end
			end
		end
	end
	return nil
end

-- Persiste los nombres de las pets equipadas para la proxima sesion.
local function persistEquipped(player)
	local data = equippedByPlayer[player]
	if not data then
		return
	end
	local names = {}
	for _, entry in ipairs(data.list) do
		table.insert(names, entry.Name)
	end
	if GameServerAPI.SetEquippedPets then
		GameServerAPI.SetEquippedPets(player, names)
	end
end

local function equip(player, petName, petId, size, kind)
	if type(petName) ~= "string" or petName == "" then
		return
	end
	if not PetModules:FindFirstChild(petName) then
		return
	end
	local data = equippedByPlayer[player]
	if not data then
		return
	end
	if #data.list >= data.maxSlots then
		return
	end
	-- No equipar mas de las que se poseen
	if countEquippedOfName(player, petName) >= ownedCount(player, petName) then
		return
	end
	local folder = getFolder(player)
	if not folder then
		return
	end
	local slot = findFreeSlot(folder)
	if not slot then
		return
	end

	-- Reusar el PetId del Tool (si vino) para que el toggle del clic sea simetrico.
	petId = (type(petId) == "string" and petId ~= "") and petId or HttpService:GenerateGUID(false)
	size = size or "Normal"
	kind = kind or "Normal"
	slot:SetAttribute("PetId", petId)
	slot:SetAttribute("PetSize", size)
	slot:SetAttribute("PetType", kind)
	slot:SetAttribute("PetVisible", true)
	slot:SetAttribute("PetAttached", true)
	slot:SetAttribute("PetClaim", nil)
	-- PetSpecies AL FINAL: es lo que dispara el spawn en el cliente.
	slot:SetAttribute("PetSpecies", petName)

	table.insert(data.list, { Id = petId, Name = petName, Slot = slot })
	relayout(player)

	Networking.Pets.PetEquipped:FireClient(player, petId, {
		Name = petName,
		Id = petId,
		Size = size,
		Type = kind,
	})
	-- la pet equipada ya no va en la mochila: borrar su Tool (el del PetId, o uno
	-- de ese nombre). Se recrea al desequipar (unequip).
	local tool = findPetToolById(player, petId) or findPetToolByName(player, petName, {})
	if tool then
		tool:Destroy()
	end
	persistEquipped(player)
end

local function unequipById(player, petId)
	local data = equippedByPlayer[player]
	if not data then
		return
	end
	for i, entry in ipairs(data.list) do
		if entry.Id == petId then
			local size = entry.Slot and entry.Slot:GetAttribute("PetSize")
			local petType = entry.Slot and entry.Slot:GetAttribute("PetType")
			clearSlot(entry.Slot)
			table.remove(data.list, i)
			Networking.Pets.PetUnequipped:FireClient(player, petId)
			relayout(player)
			persistEquipped(player)
			-- vuelve a la mochila como Tool
			if GameServerAPI.GivePetTool then
				GameServerAPI.GivePetTool(player, entry.Name, size, petType)
			end
			return
		end
	end
end

local function unequipByName(player, petName)
	local data = equippedByPlayer[player]
	if not data then
		return
	end
	for i = #data.list, 1, -1 do
		if data.list[i].Name == petName then
			local entry = data.list[i]
			local size = entry.Slot and entry.Slot:GetAttribute("PetSize")
			local petType = entry.Slot and entry.Slot:GetAttribute("PetType")
			clearSlot(entry.Slot)
			table.remove(data.list, i)
			Networking.Pets.PetUnequipped:FireClient(player, entry.Id)
			relayout(player)
			persistEquipped(player)
			if GameServerAPI.GivePetTool then
				GameServerAPI.GivePetTool(player, entry.Name, size, petType)
			end
			return
		end
	end
end

----------------------------------------------------------------------
-- Ciclo de vida
----------------------------------------------------------------------
local function setupPlayer(player)
	equippedByPlayer[player] = { maxSlots = BASE_SLOTS, list = {} }
	player:SetAttribute("MaxEquippedPets", BASE_SLOTS) -- lo lee PetListController para "X/Y Active"
	-- Re-equipar las pets que estaban equipadas la sesion anterior, ligandolas al
	-- PetId del Tool reconstruido (rebuildPetTools) para que el toggle del clic
	-- siga funcionando.
	task.spawn(function()
		local deadline = os.clock() + 30
		while os.clock() < deadline do
			local char = player.Character
			if getFolder(player) and char and char:FindFirstChild("HumanoidRootPart") then
				break
			end
			task.wait(0.3)
		end
		task.wait(1.5) -- margen para que rebuildPetTools cree los Tools de pet
		local data = equippedByPlayer[player]
		if not data then
			return
		end
		-- aplicar el max de slots comprado (persistido) ANTES de re-equipar
		local savedMax = (GameServerAPI.GetSavedMaxEquippedPets and GameServerAPI.GetSavedMaxEquippedPets(player)) or BASE_SLOTS
		data.maxSlots = savedMax
		player:SetAttribute("MaxEquippedPets", savedMax)
		local saved = GameServerAPI.GetSavedEquippedPets and GameServerAPI.GetSavedEquippedPets(player) or {}
		local usedIds = {}
		for _, name in ipairs(saved) do
			local tool = findPetToolByName(player, name, usedIds)
			if tool then
				local id = tool:GetAttribute("PetId")
				usedIds[id] = true
				equip(player, name, id, tool:GetAttribute("PetSize"), tool:GetAttribute("PetType"))
			else
				equip(player, name) -- sin Tool (raro): igual la equipa
			end
		end
	end)
end

Players.PlayerAdded:Connect(setupPlayer)
for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end
Players.PlayerRemoving:Connect(function(player)
	equippedByPlayer[player] = nil
end)

----------------------------------------------------------------------
-- Handlers de red
----------------------------------------------------------------------
Networking.Pets.RequestEquipByName.OnServerEvent:Connect(function(player, petName)
	equip(player, petName)
end)

Networking.Pets.RequestUnequipByName.OnServerEvent:Connect(function(player, petName)
	if type(petName) == "string" then
		unequipByName(player, petName)
	end
end)

Networking.Pets.RequestUnequip.OnServerEvent:Connect(function(player, petId)
	if type(petId) == "string" then
		unequipById(player, petId)
	end
end)

-- Clic sobre el Tool de pet: alterna seguir. Si ya esta equipada con ese PetId
-- -> la desequipa; si no -> la equipa leyendo nombre/size/type del Tool.
Networking.Pets.RequestToggleFollower.OnServerEvent:Connect(function(player, petId)
	if type(petId) ~= "string" or petId == "" then
		return
	end
	local data = equippedByPlayer[player]
	if not data then
		return
	end
	for _, entry in ipairs(data.list) do
		if entry.Id == petId then
			unequipById(player, petId)
			return
		end
	end
	local tool = findPetToolById(player, petId)
	if not tool then
		return
	end
	equip(player, tool:GetAttribute("Pet"), petId, tool:GetAttribute("PetSize"), tool:GetAttribute("PetType"))
end)

-- Boton "+1 MAX" del PetList: sube MaxEquippedPets cobrando sheckles
-- (PetSlotPrices.Prices = 200k/1M/5M, tope AbsoluteMax=6). El cliente lee el
-- atributo MaxEquippedPets para "X/Y Active" y el precio del siguiente.
Networking.Pets.RequestPurchasePetSlot.OnServerEvent:Connect(function(player)
	local data = equippedByPlayer[player]
	if not data then
		return
	end
	local current = data.maxSlots
	if current >= PetSlotPrices.AbsoluteMax then
		return -- ya esta al maximo
	end
	local price = PetSlotPrices.GetNextPrice(current)
	if type(price) ~= "number" then
		return
	end
	local getSheckles = GameServerAPI.WaitFor and GameServerAPI.WaitFor("GetSheckles")
	local have = getSheckles and getSheckles(player) or 0
	if have < price then
		return -- sin sheckles suficientes
	end
	GameServerAPI.AddSheckles(player, -price)
	data.maxSlots = current + 1
	player:SetAttribute("MaxEquippedPets", data.maxSlots)
	if GameServerAPI.SetMaxEquippedPets then
		GameServerAPI.SetMaxEquippedPets(player, data.maxSlots)
	end
end)

Networking.Pets.GetEquippedPets.OnServerInvoke = function(player)
	local data = equippedByPlayer[player]
	local out = {}
	if data then
		for _, entry in ipairs(data.list) do
			table.insert(out, {
				Id = entry.Id,
				Name = entry.Name,
				Size = "Normal",
				Type = "Normal",
			})
		end
	end
	return out
end

----------------------------------------------------------------------
-- API para el futuro PetBehaviorService
----------------------------------------------------------------------
-- Devuelve { { Id, Name, Slot }, ... } de las pets equipadas del jugador.
GameServerAPI.GetEquippedPets = function(player: Player)
	local data = equippedByPlayer[player]
	if not data then
		return {}
	end
	local out = {}
	for _, entry in ipairs(data.list) do
		table.insert(out, { Id = entry.Id, Name = entry.Name, Slot = entry.Slot })
	end
	return out
end

----------------------------------------------------------------------
-- Seguir al dueño: los slots PetPartN los crea WildPetService ANCLADOS en
-- (0,0,0) y nadie los movia -> las pets equipadas nacian/quedaban en el origen
-- del mundo (lejos). El diseno original espera que el SERVER mueva cada slot a
-- la formacion detras del dueno; el cliente (PetVisualController) interpola
-- hacia el CFrame del slot. Asi la pet nace y sigue JUNTO al jugador para todos.
----------------------------------------------------------------------
RunService.Heartbeat:Connect(function()
	for player, data in equippedByPlayer do
		local character = player.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local pos = hrp.Position
			local look = hrp.CFrame.LookVector
			local flat = Vector3.new(look.X, 0, look.Z)
			if flat.Magnitude < 0.001 then
				flat = Vector3.new(0, 0, -1)
			end
			local baseCF = CFrame.lookAt(pos, pos + flat.Unit)
			for _, entry in ipairs(data.list) do
				local slot = entry.Slot
				if slot and slot.Parent then
					local ox = slot:GetAttribute("SlotOffsetX") or 0
					local oz = slot:GetAttribute("SlotOffsetZ") or 4
					local oy = slot:GetAttribute("SlotHeightOffset") or 0
					slot.CFrame = baseCF * CFrame.new(ox, -2.5 + oy, oz)
				end
			end
		end
	end
end)

print("[PetEquipService] listo")
