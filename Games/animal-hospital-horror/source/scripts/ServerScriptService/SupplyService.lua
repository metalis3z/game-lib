--[[
	SupplyService  (Fase 4c — estantes de suministro de curas)

	En el mapa hay estantes `Workspace.Model.Items.<Cura>` (Model con PrimaryPart
	"Main", varias Part con el icono en un BillboardGui, y un ProximityPrompt "PP"
	ya habilitado). Nadie los manejaba. Aquí cada estante entrega SU cura al
	backpack del jugador (ToolService:GrantCure), que aparece visible en la mano.

	Así las curas que no vienen en el kit inicial (Maple Syrup, Cough Syrup,
	Ointment, IV Drops...) se CONSIGUEN yendo a los estantes -> desbloquean sus
	enfermedades en PatientCareService.

	API: SupplyService:Init()
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local IllnessesAndCures = require(ReplicatedStorage.Data.IllnessesAndCures)
local ToolService = require(ServerScriptService:WaitForChild("ToolService"))

local SupplyService = {}

local function notify(player, text, color)
	Network:FireClient(player, "Notify", text, color)
end

local function wireShelf(model, cureName)
	local prompt = model:FindFirstChildWhichIsA("ProximityPrompt", true)
	if not prompt then return false end
	prompt.Enabled = true
	prompt.ActionText = "Take"
	prompt.ObjectText = cureName

	prompt.Triggered:Connect(function(player)
		if ToolService:HasCure(player, cureName) then
			notify(player, "You already have " .. cureName, Color3.fromRGB(255, 230, 120))
			return
		end
		if ToolService:GrantCure(player, cureName) then
			notify(player, "Picked up " .. cureName, Color3.fromRGB(120, 255, 150))
		end
	end)
	return true
end

function SupplyService:Init()
	if self._initialized then return end
	self._initialized = true

	local cures = IllnessesAndCures.GetCures()
	local wired = 0
	for _, inst in ipairs(workspace:GetDescendants()) do
		if inst:IsA("Model") and cures[inst.Name] then
			if wireShelf(inst, inst.Name) then
				wired += 1
			end
		end
	end

	print("[SupplyService] inicializado — " .. wired .. " estantes de cura activos")
end

return SupplyService
