--[[
	AnomalyService  (Fase 5 — skinwalkers / anomalías)

	Los visitantes IMPOSTOR (atributo Fake=true que PatientService ya pone en
	Doctor/Ron/Clown de UniqueVisitors) son las anomalías: NO son pacientes reales,
	hay que RECHAZARLOS. Este servicio los marca como skinwalkers y les asigna un
	"disguise reveal" para que las CÁMARAS los delaten:
	  · El cliente UI.CameraSystem, al encender la cámara, hace por cada NPC tageado
	    `Lib.ApplySkinwalkerDisguiseReveal(npc, "CameraEffect")`, que lee el atributo
	    `CameraEffect` del NPC y aplica ese módulo de DisguiseReveals. UI.PhotoSystem
	    hace lo mismo con `PhotoEffect`.
	  · Usamos "HiddenFace" (rig-agnóstico: pone un billboard sin cara sobre el Head)
	    para que el impostor se vea claramente MAL a través de la cámara/foto y el
	    jugador pueda detectarlo antes de decidir en el mostrador (RejectionService).

	API: AnomalyService:Init(), :IsSkinwalker(npc), :MarkSkinwalker(npc)
]]

local ServerScriptService = game:GetService("ServerScriptService")

local PatientService = require(ServerScriptService:WaitForChild("PatientService"))

-- Revelado rig-agnóstico (necesita solo un Head, que los rigs R6 tienen).
local REVEAL = "HiddenFace"

local AnomalyService = {}

function AnomalyService:IsSkinwalker(npc)
	return npc:GetAttribute("Skinwalker") == true
end

function AnomalyService:MarkSkinwalker(npc)
	npc:SetAttribute("Skinwalker", true)
	-- Atributos que leen CameraSystem/PhotoSystem para revelar la anomalía.
	npc:SetAttribute("CameraEffect", REVEAL)
	npc:SetAttribute("PhotoEffect", REVEAL)
end

function AnomalyService:Init()
	if self._initialized then return end
	self._initialized = true

	-- Al llegar al mostrador, si es impostor lo marcamos (las cámaras lo delatan).
	PatientService.Arrived.Event:Connect(function(npc)
		if npc:GetAttribute("Fake") == true and not self:IsSkinwalker(npc) then
			self:MarkSkinwalker(npc)
		end
	end)

	print("[AnomalyService] inicializado — impostores revelables por cámara/foto")
end

return AnomalyService
