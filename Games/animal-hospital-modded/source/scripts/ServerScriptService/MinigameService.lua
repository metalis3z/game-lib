--[[
	MinigameService  (Fase 5 — cirugías / minijuego de latido)

	Las curas con Surgery=true (Data.IllnessesAndCures: IV Drops, Medicine, Antibiotics,
	Bandages, Scissors, Scalpel, Medkit, Transplant, Organ) requieren una "cirugía":
	el minijuego de latido del cliente (UI.HeartbeatMinigameLocal). Contrato:
	  · Server -> FireClient(plr, "StartHeartbeatMinigame", id)   (id truthy)
	  · Cliente al terminar -> FireServer("HeartbeatMinigameComplete", id, success)
	  · Server -> FireClient(plr, "StopHeartbeatMinigame", id)    (cancelar)

	PatientCareService llama :StartSurgery(player, npc, callback); cuando el cliente
	confirma, callback(true) -> se completa la cura. Timeout -> callback(false).

	API: MinigameService:Init(), :StartSurgery(player, npc, callback)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network

local SURGERY_TIMEOUT = 60 -- s antes de cancelar la cirugía si el cliente no responde

local MinigameService = {}
local pending = {}  -- [id] = { player=, callback=, npc= }
local nextId = 0

function MinigameService:StartSurgery(player, npc, callback)
	nextId += 1
	local id = nextId
	pending[id] = { player = player, callback = callback, npc = npc }

	Network:FireClient(player, "StartHeartbeatMinigame", id)

	task.delay(SURGERY_TIMEOUT, function()
		if pending[id] then
			pending[id] = nil
			Network:FireClient(player, "StopHeartbeatMinigame", id)
			pcall(callback, false)
		end
	end)
end

function MinigameService:Init()
	if self._initialized then return end
	self._initialized = true

	Network:Connect("HeartbeatMinigameComplete", function(player, id, success)
		local p = pending[id]
		if not p or p.player ~= player then return end
		pending[id] = nil
		pcall(p.callback, success and true or false)
	end)

	-- print("[MinigameService] inicializado — cirugías (heartbeat) listas")
end

return MinigameService
