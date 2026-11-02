--[[
	PhotoService  (Fase 5 — foto de inspección)

	Añade un prompt "Photo" (tecla F) sobre el visitante que llega al mostrador. Al
	usarlo, se le muestra al jugador una FOTO del visitante en la PhotoUI del cliente
	(UI.PhotoSystem, evento RevealPhoto). El cliente aplica el atributo `PhotoEffect`
	del modelo: si es impostor, AnomalyService le puso "HiddenFace" -> en la foto
	SALE SIN CARA -> el jugador confirma que es un skinwalker antes de decidir en el
	mostrador (RejectionService).

	Contrato (UI.PhotoSystem):
	  RevealPhoto(sourceNpc, modelToClone, isSecondCam) ; ResetPhoto(isSecondCam)

	NOTA: la detección por CÁMARA de seguridad (CCTV) ya funciona vía AnomalyService
	+ UI.CameraSystem; esta foto es una segunda vía de inspección de cerca.

	API: PhotoService:Init()
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local PatientService = require(ServerScriptService:WaitForChild("PatientService"))

local PHOTO_SHOW_TIME = 6
local COOLDOWN = 3

local PhotoService = {}
local lastPhoto = {} -- [player] = os.clock()

-- Copia del visitante lista para el viewport (sin scripts/prompts, con Animator).
-- DEBE quedar parentada a algo replicado (ReplicatedStorage) o llega nil al
-- cliente por el remote -> UI.PhotoSystem:40 (p2:Clone()) reventaba.
local function photoClone(npc)
	local clone = npc:Clone()
	for _, d in ipairs(clone:GetDescendants()) do
		if d:IsA("ProximityPrompt") or d:IsA("BaseScript") then
			d:Destroy()
		end
	end
	-- el cliente hace Humanoid:WaitForChild("Animator") -> garantizamos que exista
	local hum = clone:FindFirstChildOfClass("Humanoid")
	if hum and not hum:FindFirstChildOfClass("Animator") then
		Instance.new("Animator").Parent = hum
	end
	clone.Parent = ReplicatedStorage:FindFirstChild("Misc") or ReplicatedStorage
	Debris:AddItem(clone, 20) -- el cliente ya lo clona; limpiamos el del server
	return clone
end

local function takePhoto(player, npc)
	if not npc.Parent then return end
	local t = os.clock()
	if lastPhoto[player] and t - lastPhoto[player] < COOLDOWN then return end
	lastPhoto[player] = t

	local clone = photoClone(npc)
	Network:FireClient(player, "RevealPhoto", npc, clone, false)
	task.delay(PHOTO_SHOW_TIME, function()
		Network:FireClient(player, "ResetPhoto", false)
	end)
end

local function addPhotoPrompt(npc)
	local root = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
	if not root then return end
	if root:FindFirstChild("PhotoPrompt") then return end

	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "PhotoPrompt"
	prompt.ActionText = "Photo"
	prompt.ObjectText = "Inspect"
	prompt.KeyboardKeyCode = Enum.KeyCode.F
	prompt.MaxActivationDistance = 12
	prompt.RequiresLineOfSight = false
	prompt.UIOffset = Vector2.new(0, 80)
	prompt.Parent = root

	prompt.Triggered:Connect(function(player)
		takePhoto(player, npc)
	end)
end

-- Público: dispara la foto del NPC en la PhotoUI (viewport 3D + skinwalker reveal).
-- Lo llama CheckInService desde el PP del Photo model del mostrador.
function PhotoService:TakePhoto(player, npc)
	takePhoto(player, npc)
end

function PhotoService:Init()
	if self._initialized then return end
	self._initialized = true

	-- DESACTIVADO: ya NO se pone el prompt "Photo" sobre el NPC. La foto ahora
	-- aparece en el Photo MODEL del mostrador (CheckInService.dropPhoto) con la cara
	-- del NPC + su propio prompt Inspect. (addPhotoPrompt/takePhoto/photoClone quedan
	-- por si se quiere reactivar la vía RevealPhoto/PhotoUI desde otro trigger.)
	-- PatientService.Arrived.Event:Connect(function(npc)
	-- 	addPhotoPrompt(npc)
	-- end)

	Players.PlayerRemoving:Connect(function(player)
		lastPhoto[player] = nil
	end)

	-- print("[PhotoService] inicializado — (prompt Photo en NPC DESACTIVADO; la foto va en el Photo model)")
end

return PhotoService
