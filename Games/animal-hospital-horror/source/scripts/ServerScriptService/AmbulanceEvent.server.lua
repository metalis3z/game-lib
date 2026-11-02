--[[
	AmbulanceEvent
	La ambulancia (ReplicatedStorage.Misc.Ambulance, tag "Ambulance") tiene toda la
	cutscene CLIENTE ya hecha (Cutscenes.AmbulanceArrives / AmbulanceLeaves: entra con
	sirena desde MovePoints.Ambulance1 -> Ambulance2 y luego sale a Ambulance3), pero
	NADIE la disparaba desde el server.

	Este script dispara la secuencia a TODOS los clientes:
	  AmbulanceArrives  ->  (se queda AMBULANCE_STAY seg)  ->  AmbulanceLeaves

	Cómo se dispara:
	  · Comando de PRUEBA (solo Studio): en el chat "/ambulance".
	  · API: _G.RunAmbulanceEvent() o requiriendo desde otro script (ver abajo).
	Para engancharlo a un evento real (ataque de anomalía, fin de turno, etc.) llamá
	a runAmbulanceEvent() desde ese sistema.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network

local AMBULANCE_STAY = 20   -- segundos que la ambulancia se queda antes de irse

local running = false

local function runAmbulanceEvent()
	if running then return end
	running = true

	-- 1) llega con sirena (cutscene cliente mueve la Ambulance a MovePoints.Ambulance2)
	Network:FireAllClients("PlayCutscene", "AmbulanceArrives")

	-- 2) dura la "emergencia"
	task.wait(AMBULANCE_STAY)

	-- 3) se va (vuelve a ReplicatedStorage.Misc)
	Network:FireAllClients("PlayCutscene", "AmbulanceLeaves")

	running = false
end

-- expuesto para engancharlo desde otros sistemas (turnos, anomalías, etc.)
_G.RunAmbulanceEvent = runAmbulanceEvent

-- Comando de PRUEBA (solo en Studio). Para usarlo en vivo, quitá el if IsStudio().
if RunService:IsStudio() then
	local function hookChat(player)
		player.Chatted:Connect(function(msg)
			if msg:lower():match("^/ambulance$") then
				task.spawn(runAmbulanceEvent)
			end
		end)
	end
	for _, p in ipairs(Players:GetPlayers()) do hookChat(p) end
	Players.PlayerAdded:Connect(hookChat)
end

print("[AmbulanceEvent] listo — probá con '/ambulance' en el chat (Studio)")
