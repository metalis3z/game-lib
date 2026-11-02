--[[
	ShiftService  (Fase 4 — turnos / rondas / progresión)

	La espina que hace "avanzar la historia": el jugador trabaja TURNOS (shifts).
	Cada turno:
	  · Sube el número de noche -> Players:SetAttribute("Night", n)  (el cliente
	    StarterGui.Shift muestra "Shift N").
	  · Pone un objetivo (SetObjective) "Heal X patients".
	  · Cuenta pacientes curados (PatientCareService.PatientHealed) y admitidos
	    (PatientService.CheckedIn); cada cura da Cash (ya lo hace PatientCareService)
	    + XP aquí.
	  · Al cumplir la cuota -> fin de turno: bonus de Cash, XP de turno, sube de
	    Level si toca (desbloquea LevelPerks vía ClassService), muestra el reporte
	    (DisplayRoundStats) y arranca el siguiente turno, más difícil.

	Así Cash, Class (perks por nivel), Shift y las Tools se CONSIGUEN jugando.

	API: ShiftService:Init()
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network

local DataService = require(ServerScriptService:WaitForChild("DataService"))
local ClassService = require(ServerScriptService:WaitForChild("ClassService"))
local SanityService = require(ServerScriptService:WaitForChild("SanityService"))
local PatientService = require(ServerScriptService:WaitForChild("PatientService"))
local PatientCareService = require(ServerScriptService:WaitForChild("PatientCareService"))
local RejectionService = require(ServerScriptService:WaitForChild("RejectionService"))
local AnomalyEventService = require(ServerScriptService:WaitForChild("AnomalyEventService"))
local AnomalyDirector = require(ServerScriptService:WaitForChild("AnomalyDirector"))
local SkinwalkerService = require(ServerScriptService:WaitForChild("SkinwalkerService"))

--------------------------------------------------------------------------------
-- Config / balance
--------------------------------------------------------------------------------
local QUOTA_BASE = 3        -- pacientes a curar en el turno 1
local QUOTA_STEP = 1        -- +cuota por noche
local BONUS_BASE = 50       -- $ bonus de fin de turno (x noche)
local XP_PER_HEAL = 10
local XP_PER_SHIFT = 25
local INTERMISSION = 20     -- s de reporte entre turnos (> que la animación de DisplayRoundStats)

local function xpThreshold(level)
	return 100 * level       -- XP necesaria para subir del nivel `level`
end

--------------------------------------------------------------------------------
local ShiftService = {}

local shift = nil           -- estado del turno actual
local ending = false

local function quotaFor(night)
	return QUOTA_BASE + (night - 1) * QUOTA_STEP
end

-- silent=true evita el jingle "mission" del cliente (para updates de progreso).
local function setObjectiveAll(text, silent)
	for _, player in ipairs(Players:GetPlayers()) do
		Network:FireClient(player, "SetObjective", text, silent and true or nil)
	end
end

local function notify(player, text, color)
	Network:FireClient(player, "Notify", text, color)
end

-- playSound=true solo al fijar el objetivo del turno (suena una vez); los updates
-- de progreso van silenciosos.
local function updateObjective(playSound)
	if not shift then return end
	setObjectiveAll(("Heal patients (%d/%d)"):format(shift.healed, shift.quota), not playSound)
end

-- Suma XP y procesa subidas de nivel (aplica nuevos perks vía ClassService).
local function addXP(player, amount)
	local stats = DataService:GetStats(player)
	if not stats then return end
	stats.XP = (stats.XP or 0) + amount
	stats.Level = stats.Level or 1

	while stats.XP >= xpThreshold(stats.Level) do
		stats.XP = stats.XP - xpThreshold(stats.Level)
		stats.Level = stats.Level + 1
		ClassService:Apply(player) -- desbloquea LevelPerks del nuevo nivel
		notify(player, "Level up! You are now level " .. stats.Level, Color3.fromRGB(120, 200, 255))
	end

	DataService:PushCategory(player, "Stats")
end

--------------------------------------------------------------------------------
local function performanceFor(s)
	if s.deaths == 0 and s.healed >= s.quota then
		return { Name = "Excellent", Color = Color3.fromRGB(120, 255, 150), Value = 1.2 }
	elseif s.deaths == 0 then
		return { Name = "Good", Color = Color3.fromRGB(255, 230, 120), Value = 1 }
	end
	return { Name = "Rough", Color = Color3.fromRGB(255, 120, 120), Value = 0.85 }
end

local function bestDoctor(s)
	local best, bestN = nil, -1
	for name, n in pairs(s.perPlayerHeals) do
		if n > bestN then best, bestN = name, n end
	end
	return best
end

local function startShift(night)
	shift = {
		night = night,
		quota = quotaFor(night),
		healed = 0,
		admitted = 0,
		anomalies = 0,
		deaths = 0,
		earnings = 0,
		perPlayerHeals = {},
	}
	ending = false

	Players:SetAttribute("Night", night)

	-- terror activo SOLO durante el turno (antes corria sin parar toda la
	-- partida, incluso en el intermission entre turnos -- por eso drenaba
	-- cordura "todo el rato" sin que tuviera que ver con estar trabajando)
	pcall(function() AnomalyEventService:SetEnabled(true) end)
	pcall(function() AnomalyDirector:SetEnabled(true) end)
	pcall(function() SkinwalkerService:SetEnabled(true) end)

	-- puerta abierta + cordura reiniciada al empezar
	pcall(function()
		local DoorService = require(ServerScriptService:WaitForChild("DoorService"))
		if DoorService.OpenMainDoor then DoorService:OpenMainDoor() end
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		SanityService:Reset(player)
		notify(player, "Shift " .. night .. " started — heal " .. shift.quota .. " patients", Color3.fromRGB(200, 220, 255))
	end

	updateObjective(true)
end

local function endShift()
	if ending or not shift then return end
	ending = true
	local s = shift

	setObjectiveAll("")

	-- fin del turno: se apaga el terror hasta el proximo turno (intermission
	-- a salvo) y se despawnea lo que hubiera activo en ese momento
	pcall(function() AnomalyEventService:SetEnabled(false) end)
	pcall(function() AnomalyDirector:SetEnabled(false) end)
	pcall(function() SkinwalkerService:SetEnabled(false) end)
	pcall(function() SkinwalkerService:DespawnAll() end)

	local bonus = BONUS_BASE * s.night
	local perf = performanceFor(s)
	local best = bestDoctor(s)

	for _, player in ipairs(Players:GetPlayers()) do
		local total = DataService:AddCash(player, bonus) or 0
		addXP(player, XP_PER_SHIFT)

		Network:FireClient(player, "DisplayRoundStats", {
			PatientsHealed = s.healed,
			VisitorsAdmitted = s.admitted,
			AnomaliesPrevented = s.anomalies,
			Deaths = s.deaths,
			Performance = perf,
			Cash = s.earnings + bonus,  -- ganado este turno (score)
			LocalCash = total,           -- total acumulado
			Bonus = bonus,
			BestDoctor = best or player.Name,
		})
		DataService:Save(player)
	end

	task.delay(INTERMISSION, function()
		startShift(s.night + 1)
	end)
end

--------------------------------------------------------------------------------
-- Enganches de eventos
--------------------------------------------------------------------------------
local function onHealed(player, reward)
	if not shift or ending then return end
	shift.healed += 1
	shift.earnings += (reward or 0)
	shift.perPlayerHeals[player.Name] = (shift.perPlayerHeals[player.Name] or 0) + 1
	addXP(player, XP_PER_HEAL)
	updateObjective()

	if shift.healed >= shift.quota then
		endShift()
	end
end

local function onCheckedIn()
	if not shift or ending then return end
	shift.admitted += 1
end

local function onAnomalyPrevented()
	if not shift or ending then return end
	shift.anomalies += 1
end

local function watchDeaths(player)
	local function hookChar(char)
		local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
		if hum then
			hum.Died:Connect(function()
				if shift then shift.deaths += 1 end
			end)
		end
	end
	player.CharacterAdded:Connect(hookChar)
	if player.Character then hookChar(player.Character) end
end

-- Reenvía el objetivo del turno a UN jugador (para restaurarlo tras un objetivo
-- temporal, p.ej. los pasos del check-in). Silencioso (sin jingle).
function ShiftService:PushObjectiveTo(player)
	if not (shift and player) then return end
	Network:FireClient(player, "SetObjective", ("Heal patients (%d/%d)"):format(shift.healed, shift.quota), true)
end

-- Salta a una noche concreta (o avanza 1 si night es nil). Reinicia el turno.
function ShiftService:GoToShift(night)
	ending = false
	startShift(math.max(1, night or ((shift and shift.night or 0) + 1)))
end

--------------------------------------------------------------------------------
function ShiftService:Init()
	if self._initialized then return end
	self._initialized = true

	PatientCareService.PatientHealed.Event:Connect(onHealed)
	PatientService.CheckedIn.Event:Connect(onCheckedIn)
	RejectionService.AnomalyPrevented.Event:Connect(onAnomalyPrevented)

	for _, player in ipairs(Players:GetPlayers()) do
		watchDeaths(player)
	end
	Players.PlayerAdded:Connect(watchDeaths)

	-- Comando de PRUEBA (solo en Studio): en el chat escribí "/shift" para avanzar 1
	-- turno, o "/shift 5" para saltar a la noche 5. Para usarlo en un servidor real,
	-- quitá el `if ...IsStudio()`.
	if game:GetService("RunService"):IsStudio() then
		local function hookChat(player)
			player.Chatted:Connect(function(msg)
				local num = msg:match("^/shift%s*(%d*)$")
				if not num then return end
				local target = (num ~= "" and tonumber(num)) or ((shift and shift.night or 0) + 1)
				ShiftService:GoToShift(target)
				notify(player, "→ Shift " .. (shift and shift.night or "?"), Color3.fromRGB(200, 220, 255))
			end)
		end
		for _, p in ipairs(Players:GetPlayers()) do hookChat(p) end
		Players.PlayerAdded:Connect(hookChat)
	end

	-- Arranca el primer turno (deja cargar perfiles/personaje).
	task.spawn(function()
		task.wait(3)
		startShift(1)
	end)

	-- print("[ShiftService] inicializado — turnos + progresión activos")
end

return ShiftService
