--[[
	ToolService  (Fase 3/4 — el backpack del jugador)

	El backpack de Roblox (ReplicatedStorage.Purse, renombrado BackpackGui) es el
	core estándar: muestra los Tool que hay en Player.Backpack. Cada CURA de
	Data.IllnessesAndCures se puede volver un Tool:
	  · Name / ToolTip = nombre de la cura (ej. "Thermo", "IV Drops")
	  · TextureId       = la imagen de la cura (icono en la ranura del backpack)
	  · Attribute CureName = nombre de la cura  -> PatientCareService lo compara
	    contra la cura requerida por la enfermedad del paciente.

	IMPORTANTE (progresión): NO se dan las 17 curas al empezar (saturaba el hotbar
	y buggeaba la UI). Al spawnear solo se da un KIT INICIAL corto; el resto se
	CONSIGUE jugando (fases de tienda/suministros) vía :GrantCure. PatientCareService
	solo asigna enfermedades que puedas curar con lo que tienes, así siempre es
	jugable y la variedad crece cuando consigues más curas.

	RequiresHandle=false: no necesitan malla física para equiparse ni mostrar icono.

	API: ToolService:Init(), :GiveStarterKit(player), :GrantCure(player, cureName),
	     :HasCure(player, cureName)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local IllnessesAndCures = require(ReplicatedStorage.Data.IllnessesAndCures)

-- El jugador ENTRA SIN NADA: el backpack arranca vacío. Todas las curas se
-- consiguen jugando (estantes de suministro vía SupplyService:GrantCure).
local STARTER_CURES = {}

-- Cuánto SUBE el item respecto a la mano (studs), a la altura del pecho. Sube/baja
-- este número para afinar (2 = hombro, 1.2 = pecho, 0.5 = cintura).
local GRIP_RAISE = 1.2
-- Cuánto lo empuja hacia ADELANTE (frente al pecho). + = adelante, - = hacia el cuerpo.
local GRIP_FORWARD = 1.4

local ToolService = {}

local function buildCureTool(cure)
	local tool = Instance.new("Tool")
	tool.Name = cure.Name
	tool.ToolTip = cure.Name
	tool.TextureId = cure.Image or ""   -- icono en la ranura del backpack
	tool.RequiresHandle = true
	tool.CanBeDropped = false
	tool:SetAttribute("CureName", cure.Name)

	-- Handle en la mano: tablero fino INVISIBLE con el icono de la cura por ambas
	-- caras en Decals (los Decals se ven aunque el part sea transparente).
	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1, 1.2, 0.25)
	handle.Material = Enum.Material.SmoothPlastic
	handle.Color = Color3.fromRGB(235, 235, 235)
	handle.CanCollide = false
	handle.Massless = true
	handle.Transparency = 1   -- part invisible; los Decals del icono se siguen viendo
	handle.TopSurface = Enum.SurfaceType.Smooth
	handle.BottomSurface = Enum.SurfaceType.Smooth
	for _, face in ipairs({ Enum.NormalId.Front, Enum.NormalId.Back }) do
		local decal = Instance.new("Decal")
		decal.Texture = cure.Image or ""
		decal.Face = face
		decal.Parent = handle
	end
	handle.Parent = tool

	-- Posición del Handle en la mano vía Tool.Grip. El RightGripAttachment del Handle
	-- NO funcionaba (Roblox lo ignora aquí y usaba el Grip por defecto -> item pegado
	-- a la mano). El grip de la mano (R15, brazo abajo) tiene su eje Z = MUNDO-ARRIBA,
	-- así que subimos GRIP_RAISE por ahí y ponemos el tablero VERTICAL con el icono al
	-- frente. Handle.CFrame = mano.gripWorld * Grip:Inverse().
	tool.Grip = (CFrame.new(0, GRIP_FORWARD, GRIP_RAISE) * CFrame.Angles(math.rad(90), 0, 0)):Inverse()

	return tool
end

local function backpackOf(player)
	return player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 10)
end

-- ¿el jugador ya tiene esa cura (en backpack o equipada)?
function ToolService:HasCure(player, cureName)
	for _, container in ipairs({ player:FindFirstChildOfClass("Backpack"), player.Character }) do
		if container then
			for _, obj in ipairs(container:GetChildren()) do
				if obj:IsA("Tool") and obj:GetAttribute("CureName") == cureName then
					return true
				end
			end
		end
	end
	return false
end

-- Da una cura suelta (para tienda/suministros). No duplica.
function ToolService:GrantCure(player, cureName)
	local cure = IllnessesAndCures.GetCures()[cureName]
	if not cure then return false end
	if self:HasCure(player, cureName) then return true end
	local backpack = backpackOf(player)
	if not backpack then return false end
	buildCureTool(cure).Parent = backpack
	return true
end

-- Repone SOLO el kit inicial (limpia curas viejas primero para no duplicar).
function ToolService:GiveStarterKit(player)
	local backpack = backpackOf(player)
	if not backpack then return end

	for _, container in ipairs({ backpack, player.Character }) do
		if container then
			for _, obj in ipairs(container:GetChildren()) do
				if obj:IsA("Tool") and obj:GetAttribute("CureName") then
					obj:Destroy()
				end
			end
		end
	end

	local cures = IllnessesAndCures.GetCures()
	for _, name in ipairs(STARTER_CURES) do
		local cure = cures[name]
		if cure then
			buildCureTool(cure).Parent = backpack
		end
	end
end

function ToolService:Init()
	if self._initialized then return end
	self._initialized = true

	local function hook(player)
		player.CharacterAdded:Connect(function()
			-- El Backpack se recrea en cada spawn; reponemos el kit inicial.
			task.spawn(function()
				self:GiveStarterKit(player)
			end)
		end)
		if player.Character then
			task.spawn(function()
				self:GiveStarterKit(player)
			end)
		end
	end

	Players.PlayerAdded:Connect(hook)
	for _, player in ipairs(Players:GetPlayers()) do
		hook(player)
	end

	print("[ToolService] inicializado — kit inicial de curas en el backpack")
end

return ToolService
