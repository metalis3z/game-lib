--[[
	ConsumableService  (Fase 11 — consumibles de cordura tipo "handle")

	Items que el jugador sostiene en la mano (Tool con Handle) y USA (clic) para
	restaurar cordura. Al usarse se CONSUMEN (el Tool se destruye).

	  · Coffee    — lo entrega la CoffeeMachine (MiscService) al preparar café.
	  · Chocolate — se COMPRA (DevProduct "chocolate", R$25) desde el póster
	                Workspace.Model (prompt "Buy Chocolate").
	  · Brain     — se CONSIGUE JUGANDO: cada N pacientes curados te dan uno
	                (restaura cordura completa). No es monetización.

	El uso es autoritativo del server (Tool.Activated corre en el server): valida
	al dueño, hace SanityService:GainSanity y destruye el Tool. El feedback visual
	(+X verde, sonido Sparkle) lo dispara solo SanityLocal al subir la cordura.

	GunService es el dueño de ProcessReceipt; aquí registramos el chocolate con
	GunService:RegisterProduct.

	API: ConsumableService:Init(), :Give(player, itemName)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")

local SanityService = require(ServerScriptService:WaitForChild("SanityService"))
local GunService = require(ServerScriptService:WaitForChild("GunService"))
local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local Prods = require(ReplicatedStorage.Data.Prods)

local ConsumableService = {}

-- Definición de cada consumible: icono (mismo del póster), cordura que restaura,
-- color del Handle.
local ITEMS = {
	Coffee = {
		Icon   = "rbxassetid://118223977489343",
		Sanity = 20,
		Color  = Color3.fromRGB(120, 72, 40),
	},
	Chocolate = {
		Icon   = "rbxassetid://105387786256230",
		Sanity = 60,   -- "Chocolate (60% Sanity)" del prompt del Chocolate bar
		Color  = Color3.fromRGB(90, 55, 30),
	},
	Brain = {
		Icon   = "rbxassetid://95188227883169",
		Sanity = 100,  -- cordura completa
		Color  = Color3.fromRGB(230, 150, 160),
	},
	Cola = {
		Icon     = "rbxassetid://78353908683334",
		Speed    = 32,   -- Run Cola: corre más rápido un rato
		Duration = 8,
		Color    = Color3.fromRGB(120, 40, 40),
	},
}

-- Cada cuántos pacientes curados se regala un Brain (ajustable).
local BRAIN_EVERY_N_HEALS = 5

--------------------------------------------------------------------------------
-- Construcción del Tool (Handle visible con el icono por ambas caras)
--------------------------------------------------------------------------------
local function buildTool(itemName)
	local item = ITEMS[itemName]

	local tool = Instance.new("Tool")
	tool.Name = itemName
	tool.ToolTip = "Use to restore sanity"
	tool.TextureId = item.Icon      -- icono en la ranura del backpack
	tool.RequiresHandle = true
	tool.CanBeDropped = false
	tool:SetAttribute("ConsumableName", itemName)

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1, 1, 0.35)
	handle.Material = Enum.Material.SmoothPlastic
	handle.Color = item.Color
	handle.CanCollide = false
	handle.Massless = true
	handle.Transparency = 1   -- Handle invisible: solo se ve el icono (Decals)
	for _, face in ipairs({ Enum.NormalId.Front, Enum.NormalId.Back }) do
		local decal = Instance.new("Decal")
		decal.Texture = item.Icon
		decal.Face = face
		decal.Parent = handle
	end
	handle.Parent = tool

	-- Colocación en la mano: 1er num = más lejos del cuerpo, 2do = más arriba.
	tool.Grip = (CFrame.new(0, 1.9, 1.7) * CFrame.Angles(math.rad(90), 0, 0)):Inverse()

	return tool
end

--------------------------------------------------------------------------------
-- Consumo (autoritativo, Tool.Activated corre en el server)
--------------------------------------------------------------------------------
local function consume(tool)
	if tool:GetAttribute("Consumed") then return end

	local char = tool.Parent
	local player = char and Players:GetPlayerFromCharacter(char)
	if not player then return end

	local itemName = tool:GetAttribute("ConsumableName")
	local item = ITEMS[itemName]
	if not item then return end

	tool:SetAttribute("Consumed", true)   -- evita doble uso si se spamea el clic
	if item.Sanity then
		SanityService:GainSanity(player, item.Sanity, itemName)
	end
	if item.Speed then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = item.Speed
			task.delay(item.Duration or 8, function()
				local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
				if h then h.WalkSpeed = 16 end   -- restaura al normal
			end)
		end
	end

	task.delay(0.1, function()
		if tool.Parent then tool:Destroy() end
	end)
end

--------------------------------------------------------------------------------
-- Entregar un consumible al backpack
--------------------------------------------------------------------------------
function ConsumableService:Give(player, itemName)
	if not ITEMS[itemName] then return false end
	local backpack = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 10)
	if not backpack then return false end

	local tool = buildTool(itemName)
	tool.Activated:Connect(function()
		consume(tool)
	end)
	tool.Parent = backpack
	return true
end

--------------------------------------------------------------------------------
-- Brain por jugar: cada N curas
--------------------------------------------------------------------------------
local healCount = {}   -- [player] = número de curas acumuladas

local function onPatientHealed(player)
	if not player then return end
	healCount[player] = (healCount[player] or 0) + 1
	if healCount[player] >= BRAIN_EVERY_N_HEALS then
		healCount[player] = 0
		ConsumableService:Give(player, "Brain")
		pcall(function()
			Network:FireClient(player, "Notify", "You earned a Brain! Use it to fully restore sanity.", Color3.fromRGB(230, 150, 160))
		end)
	end
end

--------------------------------------------------------------------------------
function ConsumableService:Init()
	if self._initialized then return end
	self._initialized = true

	-- Chocolate: registrar su DevProduct en el dueño del ProcessReceipt.
	GunService:RegisterProduct(Prods.chocolate.id, function(player)
		return self:Give(player, "Chocolate")
	end)

	-- Infinite Sanity: cordura infinita por el resto de la sesion (se pierde
	-- si el jugador se va, no se persiste). Boton Admin del menu.
	if Prods.infinite_sanity then
		GunService:RegisterProduct(Prods.infinite_sanity.id, function(player)
			SanityService:GrantInfiniteSanity(player)
			return true
		end)
	end

	-- AllTool ("GET ALL TOOLS"): gun + todos los consumibles.
	if Prods.all_tools then
		GunService:RegisterProduct(Prods.all_tools.id, function(player)
			GunService:GiveGun(player)
			self:Give(player, "Coffee")
			self:Give(player, "Chocolate")
			self:Give(player, "Brain")
			self:Give(player, "Cola")
			return true
		end)
	end

	-- (La COMPRA del chocolate la dispara el Script dentro de Workspace.Chocolate bar.PP;
	--  aquí solo registramos el grant vía ProcessReceipt, arriba.)

	-- Brain: se consigue curando pacientes.
	local PatientCareService = require(ServerScriptService:WaitForChild("PatientCareService"))
	PatientCareService.PatientHealed.Event:Connect(function(player)
		onPatientHealed(player)
	end)

	-- Limpieza
	Players.PlayerRemoving:Connect(function(plr) healCount[plr] = nil end)

	-- print("[ConsumableService] inicializado — Coffee (máquina) / Chocolate (compra) / Brain (curas)")
end

return ConsumableService
