--[[
	RejectionService  (Fase 5 — decisión Admitir / Rechazar en el mostrador)

	Tras el check-in, el JUGADOR decide: ¿es un paciente real (ADMITIR -> va a su
	sala a curarse) o un impostor/skinwalker (RECHAZAR)? Dos ProximityPrompts sobre
	el NPC ("Admit" = E, "Reject" = Q). Puntaje:
	  · Rechazar impostor  -> correcto: +$, +cordura, cuenta AnomaliesPrevented,
	    cutscene "VisitorRejected".
	  · Rechazar paciente  -> error: pierdes cordura (perdiste un paciente real).
	  · Admitir impostor   -> error: pierdes cordura (dejaste pasar una anomalía).
	  · Admitir paciente   -> correcto: pasa a cuidados (el $ viene de curarlo).

	Detección: mira al visitante por la CÁMARA de seguridad; si es impostor,
	AnomalyService le puso `CameraEffect` y se verá sin cara.

	Se engancha vía PatientService.DecisionHandler (seteado en Init).

	API: RejectionService:Init()
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network

local DataService = require(ServerScriptService:WaitForChild("DataService"))
local SanityService = require(ServerScriptService:WaitForChild("SanityService"))
local PatientService = require(ServerScriptService:WaitForChild("PatientService"))

--------------------------------------------------------------------------------
local REJECT_REWARD = 20     -- $ por rechazar bien a un impostor
local REJECT_SANITY = 3      -- cordura por acierto
local MISTAKE_SANITY = 12    -- cordura perdida por error

local RejectionService = {}
-- Se dispara (player) al rechazar bien a un impostor. ShiftService cuenta AnomaliesPrevented.
RejectionService.AnomalyPrevented = Instance.new("BindableEvent")

local function notify(player, text, color)
	Network:FireClient(player, "Notify", text, color)
end

local function playCutsceneAll(name, npc)
	for _, player in ipairs(Players:GetPlayers()) do
		Network:FireClient(player, "PlayCutscene", name, npc)
	end
end

local function makePrompt(parent, action, keyCode, yOffset)
	local p = Instance.new("ProximityPrompt")
	p.ActionText = action
	p.KeyboardKeyCode = keyCode
	p.MaxActivationDistance = 12
	p.RequiresLineOfSight = false
	p.UIOffset = Vector2.new(0, yOffset)
	p.Parent = parent
	return p
end

function RejectionService:Decide(npc)
	local root = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
	if not root then
		PatientService:LeaveAndDespawn(npc)
		return
	end

	local isImpostor = npc:GetAttribute("Fake") == true
	local who = npc:GetAttribute("DisplayName") or npc.Name

	local admit = makePrompt(root, "Admit", Enum.KeyCode.E, 0)
	local reject = makePrompt(root, "Reject", Enum.KeyCode.Q, 40)

	local decided = false
	local function finish(player, isAdmit)
		if decided then return end
		decided = true
		admit:Destroy()
		reject:Destroy()

		if isAdmit then
			if isImpostor then
				-- dejó pasar una anomalía
				SanityService:LoseSanity(player, MISTAKE_SANITY, "Admitted an impostor")
				notify(player, who .. " was an impostor!", Color3.fromRGB(255, 120, 120))
				PatientService:LeaveAndDespawn(npc)
			else
				notify(player, "Admitted " .. who, Color3.fromRGB(120, 255, 150))
				PatientService:AdmitToCare(npc)
			end
		else -- reject
			playCutsceneAll("VisitorRejected", npc)
			if isImpostor then
				DataService:AddCash(player, REJECT_REWARD)
				SanityService:GainSanity(player, REJECT_SANITY, "Rejected an impostor")
				RejectionService.AnomalyPrevented:Fire(player)
				notify(player, "Rejected an impostor! (+$" .. REJECT_REWARD .. ")", Color3.fromRGB(120, 255, 150))
			else
				SanityService:LoseSanity(player, MISTAKE_SANITY, "Rejected a real patient")
				notify(player, who .. " was a real patient!", Color3.fromRGB(255, 120, 120))
			end
			PatientService:LeaveAndDespawn(npc)
		end
	end

	admit.Triggered:Connect(function(player) finish(player, true) end)
	reject.Triggered:Connect(function(player) finish(player, false) end)

	-- si el NPC se va solo, limpia
	npc.AncestryChanged:Connect(function(_, parent)
		if not parent then decided = true end
	end)
end

function RejectionService:Init()
	if self._initialized then return end
	self._initialized = true

	PatientService.DecisionHandler = function(npc)
		RejectionService:Decide(npc)
	end

	print("[RejectionService] inicializado — decisión Admit/Reject en el mostrador")
end

return RejectionService
