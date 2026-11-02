--[[
	PatientCareService  (Fase 3 — el loop de curar)

	Después del check-in, un PACIENTE real (no visitante impostor) es admitido:
	  1. Se le asigna una sala médica libre (Workspace.Rooms.Medical.RoomN) y camina
	     a su punto MovePoints.Patient (junto a la cama).
	  2. Se le asigna una enfermedad al azar del tipo de sala (Data.IllnessesAndCures),
	     OCULTA: el jugador debe escanear al paciente en el Analyzer de la sala
	     (minijuego de diagnóstico) para revelarla; luego el prompt "Heal" la muestra.
	  3. El jugador se acerca con la CURA correcta equipada del backpack (atributo
	     CureName == Illness.HealedWith) y activa el prompt -> curado:
	        · DataService:AddCash  (recompensa)
	        · SanityService:GainSanity  (recuperas cordura al curar)
	        · notificación al jugador
	     El paciente se retira, libera la sala y entra el siguiente.
	  Con la cura equivocada: notifica qué necesita y no cura.

	Se engancha vía PatientService.CareHandler (seteado en Init), sin require
	circular: este módulo requiere PatientService, no al revés.

	API: PatientCareService:Init()
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local Players = game:GetService("Players")

local IllnessesAndCures = require(ReplicatedStorage.Data.IllnessesAndCures)

local DataService = require(ServerScriptService:WaitForChild("DataService"))
local SanityService = require(ServerScriptService:WaitForChild("SanityService"))
local PatientService = require(ServerScriptService:WaitForChild("PatientService"))
local MinigameService = require(ServerScriptService:WaitForChild("MinigameService"))

--------------------------------------------------------------------------------
-- Config
--------------------------------------------------------------------------------
local ROOM_TYPE = "Medical"
local HEAL_REWARD = 25   -- $ por paciente curado
local HEAL_SANITY = 5    -- cordura recuperada al curar
local SCAN_DURATION = 2.6 -- s que tarda el escaneo del Analyzer (diagnóstico)

local PatientCareService = {}
-- Se dispara (player, reward) cada vez que un paciente es curado. ShiftService lo
-- usa para contar curados, sumar XP y llevar las ganancias del turno.
PatientCareService.PatientHealed = Instance.new("BindableEvent")
local rooms = {}         -- { { name=, point=BasePart, occupied=false }, ... }

--------------------------------------------------------------------------------
local function notify(player, text, color)
	Network:FireClient(player, "Notify", text, color)
end

local function collectRooms()
	local roomsFolder = workspace:FindFirstChild("Rooms")
	local typeFolder = roomsFolder and roomsFolder:FindFirstChild(ROOM_TYPE)
	if not typeFolder then return end
	for _, roomFolder in ipairs(typeFolder:GetChildren()) do
		local mp = roomFolder:FindFirstChild("MovePoints")
		local point = mp and mp:FindFirstChild("Patient")
		if point and point:IsA("BasePart") then
			local number = tonumber(roomFolder.Name:match("%d+")) or (#rooms + 1)
			local mg = roomFolder:FindFirstChild("Minigame")
			local analyzer = mg and mg:FindFirstChild("Analyzer")
			local bed = mg and mg:FindFirstChild("Bed")
			local monitor = mg and mg:FindFirstChild("Monitor")
			local tv = mg and mg:FindFirstChild("TV")
			table.insert(rooms, { name = roomFolder.Name, number = number, point = point, occupied = false, analyzer = analyzer, bed = bed, monitor = monitor, tv = tv })
		end
	end
end

local reservedByNpc = {}   -- [npc] = room (reservado en el check-in, usado en Admit)
local lastRoomIdx = 0

-- Reserva la SIGUIENTE sala libre en round-robin (los pacientes rotan entre salas
-- y no siempre caen en Room1). nil si todas ocupadas.
local function reserveFreeRoom()
	for _ = 1, #rooms do
		lastRoomIdx = (lastRoomIdx % #rooms) + 1
		local room = rooms[lastRoomIdx]
		if not room.occupied then
			room.occupied = true
			return room
		end
	end
	return nil
end

-- Llamado por PatientService en el check-in: reserva la sala y devuelve su NÚMERO,
-- para que el anuncio ("go to room N") coincida con la sala real a la que camina.
function PatientCareService:ReserveRoom(npc)
	local room = reserveFreeRoom()
	if not room then return nil end
	reservedByNpc[npc] = room
	return room.number
end

local function currentNight()
	return Players:GetAttribute("Night") or 1
end

-- Nombres de cura que ALGÚN jugador tiene ahora mismo (backpack o equipada).
local function ownedCureNames()
	local owned = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		for _, container in ipairs({ plr:FindFirstChildOfClass("Backpack"), plr.Character }) do
			if container then
				for _, obj in ipairs(container:GetChildren()) do
					local cn = obj:IsA("Tool") and obj:GetAttribute("CureName")
					if cn then owned[cn] = true end
				end
			end
		end
	end
	return owned
end

-- Enfermedad del tipo de sala que sea CURABLE con lo que el jugador tiene y esté
-- disponible en la noche actual (MinNight). Así siempre se puede curar; la
-- variedad crece cuando consigues más curas. Fallback: cualquiera del tipo.
local function pickIllness()
	local night = currentNight()
	local list = IllnessesAndCures.GetIllnessesByRoomType(ROOM_TYPE)
	if #list == 0 then return nil end

	-- VARIEDAD: cualquier enfermedad del tipo de sala disponible esta noche (MinNight),
	-- sin importar qué curas tenga el jugador. Cada enfermedad pide SU cura distinta;
	-- si no la tenés, la conseguís por el juego (SupplyService).
	local candidates = {}
	for _, illness in ipairs(list) do
		if not (illness.MinNight and night < illness.MinNight) then
			table.insert(candidates, illness)
		end
	end
	if #candidates == 0 then
		return list[math.random(1, #list)]
	end
	return candidates[math.random(1, #candidates)]
end

-- Nombre de la cura del Tool que el jugador tiene equipado (o nil).
local function equippedCure(player)
	local char = player.Character
	local tool = char and char:FindFirstChildOfClass("Tool")
	return tool and tool:GetAttribute("CureName")
end

--------------------------------------------------------------------------------
local SLEEP_ANIM_ID = "rbxassetid://75555438749766" -- Sleep (echado en la cama)
local bedTracks = {}  -- [npc] = AnimationTrack (para pararla al levantarse)

-- El paciente se ECHA en la cama de su sala: lo coloca en el punto InBed, lo fija
-- ahí (anclado) y reproduce la animación Sleep. Atributo InBed corta el walk/idle
-- (PatientService.setupWalkAnimation lo respeta).
local function layInBed(npc, room)
	local bed = room.bed
	local inBed = bed and bed:FindFirstChild("InBed")
	local hrp = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
	local hum = npc:FindFirstChildOfClass("Humanoid")
	if not (inBed and hrp and hum) then return end

	npc:SetAttribute("InBed", true)
	pcall(function() hrp:SetNetworkOwner(nil) end)
	pcall(function() hrp.CFrame = inBed.CFrame end)
	hrp.Anchored = true

	local animator = hum:FindFirstChildOfClass("Animator")
	if animator then
		local anim = Instance.new("Animation")
		anim.AnimationId = SLEEP_ANIM_ID
		local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
		if ok and track then
			track.Looped = true
			track.Priority = Enum.AnimationPriority.Action
			track:Play(0.3)
			bedTracks[npc] = track
		end
	end
end

-- Se levanta de la cama (al curarse) para poder irse caminando.
local function getUpFromBed(npc)
	npc:SetAttribute("InBed", false)
	local hrp = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
	if hrp then hrp.Anchored = false end
	local track = bedTracks[npc]
	if track then pcall(function() track:Stop(0.2) end) end
	bedTracks[npc] = nil
end

local function completeHeal(player, npc, room)
	getUpFromBed(npc)  -- se levanta antes de retirarse
	npc:SetAttribute("Healed", true)
	DataService:AddCash(player, HEAL_REWARD)
	SanityService:GainSanity(player, HEAL_SANITY, "Healed a patient")

	local who = npc:GetAttribute("DisplayName") or npc.Name
	notify(player, "Healed " .. who .. " (+$" .. HEAL_REWARD .. ")", Color3.fromRGB(120, 255, 150))

	PatientCareService.PatientHealed:Fire(player, HEAL_REWARD)

	room.occupied = false
	task.spawn(function()
		PatientService:LeaveAndDespawn(npc)
	end)
end

-- Escaneo de diagnóstico en el Analyzer de la sala: anima la pantalla (barra de
-- progreso + beep + luz + sonido microwave) y al final revela la enfermedad en el
-- Label. Server-side (SurfaceGui/Sounds en Workspace se replican). nil-safe.
local function analyzerScreen(analyzer)
	local screen = analyzer and analyzer:FindFirstChild("Screen")
	local ui = screen and screen:FindFirstChild("UI")
	return screen, ui,
		ui and ui:FindFirstChild("Frame"),
		ui and ui:FindFirstChild("Label"),
		screen and screen:FindFirstChild("PointLight")
end

-- Los 4 botones físicos del Analyzer (Buttons.1..4) se encienden en verde/neón en
-- secuencia mientras escanea, y se apagan al resetear. Guarda el color original.
local BUTTON_ON = Color3.fromRGB(80, 255, 120)

local function analyzerButtons(analyzer)
	local model = analyzer and analyzer:FindFirstChild("Buttons")
	local t = {}
	if model then
		for _, b in ipairs(model:GetChildren()) do
			if b:IsA("BasePart") then table.insert(t, b) end
		end
		table.sort(t, function(a, b) return a.Name < b.Name end)   -- 1,2,3,4
	end
	return t
end

local function setButton(b, on)
	if b:GetAttribute("OrigColor") == nil then
		b:SetAttribute("OrigColor", b.Color)
	end
	if on then
		b.Color = BUTTON_ON
		b.Material = Enum.Material.Neon
	else
		local oc = b:GetAttribute("OrigColor")
		if oc then b.Color = oc end
		b.Material = Enum.Material.SmoothPlastic
	end
end

local function runAnalyzerScan(analyzer, illnessName)
	local screen, _, frame, title, light = analyzerScreen(analyzer)
	local bar = frame and frame:FindFirstChild("Frame")
	local beep = screen and screen:FindFirstChild("beep")
	local micro = screen and screen:FindFirstChild("microwave")

	if title and title:IsA("TextLabel") then title.Text = "SCANNING…" end
	if frame then frame.Visible = true end
	if micro then pcall(function() micro:Play() end) end

	local buttons = analyzerButtons(analyzer)
	local steps = 10
	for i = 1, steps do
		if bar then bar.Size = UDim2.new(i / steps, bar.Size.X.Offset, bar.Size.Y.Scale, bar.Size.Y.Offset) end
		if light then light.Enabled = (i % 2 == 0) end
		-- enciende los botones en secuencia según el progreso
		local lit = math.ceil((i / steps) * #buttons)
		for bi, b in ipairs(buttons) do
			setButton(b, bi <= lit)
		end
		if beep then pcall(function() beep:Play() end) end
		task.wait(SCAN_DURATION / steps)
	end

	if title and title:IsA("TextLabel") then title.Text = illnessName end
	if light then light.Enabled = true end
end

local function resetAnalyzerScreen(analyzer)
	local _, _, frame, title, light = analyzerScreen(analyzer)
	if title and title:IsA("TextLabel") then title.Text = "" end
	if frame then frame.Visible = false end
	if light then light.Enabled = false end
	for _, b in ipairs(analyzerButtons(analyzer)) do setButton(b, false) end
end

-- ===== Pantallas de la sala: Monitor (reporte del paciente) + TV (tratamiento y
-- curación) + ambiente (encender/apagar con sonidos). Todo nil-safe: si a una sala
-- le falta el modelo o algún Label, simplemente se ignora. =====
local function screenUI(model)
	local screen = model and model:FindFirstChild("Screen")
	return screen, screen and screen:FindFirstChild("UI")
end

local function playIn(inst, soundName)
	local s = inst and inst:FindFirstChild(soundName)
	if s and s:IsA("Sound") then pcall(function() s:Play() end) end
end

local function setLabel(parent, name, text)
	local l = parent and parent:FindFirstChild(name)
	if l and l:IsA("TextLabel") then l.Text = text end
end

-- Monitor.Report: nombre/raza del paciente + enfermedad (nil -> "UNKNOWN").
local function monitorReport(room, npc, illnessName)
	local _, ui = screenUI(room.monitor)
	local report = ui and ui:FindFirstChild("Report")
	if not report then return end
	report.Visible = true
	setLabel(report, "Title", npc:GetAttribute("DisplayName") or npc.Name)
	setLabel(report, "race", npc:GetAttribute("Race") or npc:GetAttribute("Species") or "Patient")
	setLabel(report, "illnesses", illnessName or "UNKNOWN")
end

-- Monitor.Action: estado (header + notice). header=nil -> oculta.
local function monitorAction(room, header, notice)
	local _, ui = screenUI(room.monitor)
	local action = ui and ui:FindFirstChild("Action")
	if not action then return end
	action.Visible = header ~= nil
	if header then setLabel(action, "header", header) end
	if notice then setLabel(action, "notice", notice) end
end

-- TV.Report: tratamiento requerido + checklist (1 ítem = la cura, con su icono).
local function tvReport(room, cureDef)
	local _, ui = screenUI(room.tv)
	local report = ui and ui:FindFirstChild("Report")
	if not report then return end
	report.Visible = true
	setLabel(report, "treatment", cureDef and ("Treatment: " .. cureDef.Name) or "Awaiting diagnosis…")
	local inv = report:FindFirstChild("inv")
	local template = report:FindFirstChild("Folder") and report.Folder:FindFirstChild("Template")
	if not (inv and template) then return end
	for _, c in ipairs(inv:GetChildren()) do
		if c:IsA("GuiObject") and c.Name == "Item" then c:Destroy() end
	end
	if cureDef then
		local item = template:Clone()
		item.Name = "Item"
		item.Visible = true
		local icon = item:FindFirstChild("icon")
		if icon and icon:IsA("ImageLabel") then icon.Image = cureDef.Image or "" end
		setLabel(item, "name", cureDef.Name)
		local check = item:FindFirstChild("check")
		if check then check.Visible = false end
		item.Parent = inv
	end
end

-- TV.Healing: barra de progreso (alpha 0..1; nil -> oculta).
local function tvHealing(room, alpha)
	local _, ui = screenUI(room.tv)
	local healing = ui and ui:FindFirstChild("Healing")
	if not healing then return end
	if alpha == nil then healing.Visible = false; return end
	healing.Visible = true
	local outer = healing:FindFirstChild("Frame")
	local bar = outer and outer:FindFirstChild("Frame")
	if bar and bar:IsA("GuiObject") then
		bar.Size = UDim2.new(math.clamp(alpha, 0, 1), bar.Size.X.Offset, bar.Size.Y.Scale, bar.Size.Y.Offset)
	end
end

-- Marca la cura como aplicada (check del ítem) y suena "completado".
local function tvMarkCured(room)
	local _, ui = screenUI(room.tv)
	local report = ui and ui:FindFirstChild("Report")
	local inv = report and report:FindFirstChild("inv")
	local item = inv and inv:FindFirstChild("Item")
	local check = item and item:FindFirstChild("check")
	if check then check.Visible = true end
	local tvScreen = room.tv and room.tv:FindFirstChild("Screen")
	local tvBase = room.tv and room.tv:FindFirstChild("Base")
	playIn(tvBase, "LevelComplete")
	playIn(tvScreen, "Baldi's Basics Plus: Math Machine Correct")
end

-- Enciende las pantallas al admitir al paciente (ambiente + reporte inicial).
local function screensOn(room, npc)
	-- Activa los SurfaceGui (vienen con Enabled=false en el build); sin esto no se ve nada.
	local _, mui = screenUI(room.monitor)
	local _, tui = screenUI(room.tv)
	if mui then mui.Enabled = true end
	if tui then tui.Enabled = true end
	local mScreen = room.monitor and room.monitor:FindFirstChild("Screen")
	playIn(mScreen, "ui_loading")
	playIn(mScreen, "beep-1")
	local diagnosed = npc:GetAttribute("Diagnosed") == true
	monitorReport(room, npc, diagnosed and npc:GetAttribute("Illness") or nil)
	monitorAction(room, "PATIENT ADMITTED", diagnosed and "Diagnosed" or "Awaiting diagnosis")
	tvReport(room, nil)
	tvHealing(room, nil)
end

-- Apaga las pantallas al irse el paciente (oculta UI + sonido de apagado).
local function screensOff(room)
	local _, mui = screenUI(room.monitor)
	if mui then
		if mui:FindFirstChild("Report") then mui.Report.Visible = false end
		if mui:FindFirstChild("Action") then mui.Action.Visible = false end
		mui.Enabled = false   -- apaga el SurfaceGui del Monitor
	end
	local tScreen, tui = screenUI(room.tv)
	playIn(tScreen, "computer turn off")
	if tui then
		if tui:FindFirstChild("Report") then tui.Report.Visible = false end
		if tui:FindFirstChild("Healing") then tui.Healing.Visible = false end
		tui.Enabled = false   -- apaga el SurfaceGui de la TV
	end
end

function PatientCareService:Admit(npc)
	-- usa la sala reservada en el check-in (para que coincida con lo anunciado)
	local room = reservedByNpc[npc]
	reservedByNpc[npc] = nil
	if not room then
		room = reserveFreeRoom()
	end
	if not room then
		PatientService:LeaveAndDespawn(npc)
		return
	end
	local point = room.point

	-- camina a la sala y se coloca junto a la cama
	PatientService:WalkTo(npc, point.Position)
	if not npc.Parent then
		room.occupied = false
		return
	end
	pcall(function() npc:PivotTo(point.CFrame) end)

	local illness = pickIllness()
	if not illness then
		room.occupied = false
		PatientService:LeaveAndDespawn(npc)
		return
	end
	local requiredCure = illness.HealedWith
	npc:SetAttribute("Illness", illness.Name)
	npc:SetAttribute("RequiredCure", requiredCure)

	local root = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
	if not root then
		room.occupied = false
		PatientService:LeaveAndDespawn(npc)
		return
	end

	layInBed(npc, room)  -- el paciente se echa en la cama con la animación Sleep

	-- DIAGNÓSTICO: si la sala tiene Analyzer, la enfermedad queda OCULTA hasta que
	-- el jugador escanee al paciente en el Analyzer. Sin Analyzer -> ya diagnosticado.
	local analyzer = room.analyzer
	local analyzerPrompt = analyzer and analyzer:FindFirstChildWhichIsA("ProximityPrompt", true)
	local needsDiagnosis = analyzerPrompt ~= nil
	npc:SetAttribute("Diagnosed", not needsDiagnosis)
	screensOn(room, npc)   -- enciende Monitor + TV (ambiente + reporte inicial)
	if not needsDiagnosis then
		-- sin Analyzer: ya diagnosticado -> muestra enfermedad y tratamiento de una
		monitorReport(room, npc, illness.Name)
		monitorAction(room, "DIAGNOSIS", illness.Name)
		tvReport(room, IllnessesAndCures.GetCures()[requiredCure])
	end

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Heal"
	prompt.ObjectText = needsDiagnosis and "Scan at the Analyzer first" or illness.Name
	prompt.HoldDuration = 1
	prompt.MaxActivationDistance = 10
	prompt.RequiresLineOfSight = false
	prompt.Parent = root

	local requiresSurgery = false
	do
		local cureDef = IllnessesAndCures.GetCures()[requiredCure]
		requiresSurgery = cureDef ~= nil and cureDef.Surgery == true
	end

	local healed = false
	local busy = false     -- cirugía en curso (evita re-disparar)
	local scanning = false -- escaneo en curso
	local conn, scanConn

	local function cleanup()
		if conn and conn.Connected then conn:Disconnect() end
		if scanConn and scanConn.Connected then scanConn:Disconnect() end
		if analyzerPrompt then analyzerPrompt.Enabled = false end
		if analyzer then resetAnalyzerScreen(analyzer) end
	end

	local function finishHeal(player)
		if healed then return end
		healed = true
		prompt:Destroy()
		-- Pantallas: barra de curación se llena + cura marcada + estado "TREATED".
		for i = 1, 6 do tvHealing(room, i / 6); task.wait(0.05) end
		tvMarkCured(room)
		monitorAction(room, "TREATED", npc:GetAttribute("Illness") or "Done")
		cleanup()
		completeHeal(player, npc, room)
	end

	-- Escaneo en el Analyzer -> revela la enfermedad y habilita curar.
	if needsDiagnosis then
		analyzerPrompt.ActionText = "Scan"
		analyzerPrompt.ObjectText = "Diagnose patient"
		analyzerPrompt.HoldDuration = 0.5
		analyzerPrompt.MaxActivationDistance = 10
		analyzerPrompt.RequiresLineOfSight = false
		analyzerPrompt.Enabled = true
		scanConn = analyzerPrompt.Triggered:Connect(function(player)
			if scanning or healed or not npc.Parent then return end
			if npc:GetAttribute("Diagnosed") then return end
			scanning = true
			analyzerPrompt.Enabled = false
			runAnalyzerScan(analyzer, illness.Name)
			scanning = false
			if not npc.Parent or healed then return end
			npc:SetAttribute("Diagnosed", true)
			prompt.ObjectText = illness.Name
			monitorReport(room, npc, illness.Name)          -- Monitor revela la enfermedad
			monitorAction(room, "DIAGNOSIS", illness.Name)
			tvReport(room, IllnessesAndCures.GetCures()[requiredCure])  -- TV muestra el tratamiento + checklist
			notify(player, "Diagnosis: " .. illness.Name .. " — treat with " .. requiredCure,
				Color3.fromRGB(150, 220, 255))
		end)
	end

	conn = prompt.Triggered:Connect(function(player)
		if healed or busy or not npc.Parent then return end
		if not npc:GetAttribute("Diagnosed") then
			notify(player, "Scan the patient at the Analyzer to diagnose first.",
				Color3.fromRGB(255, 210, 120))
			return
		end
		if equippedCure(player) ~= requiredCure then
			notify(player,
				"Wrong treatment! " .. illness.Name .. " needs " .. requiredCure .. ".",
				Color3.fromRGB(255, 120, 120))
			return
		end

		if requiresSurgery then
			-- cura de cirugía -> minijuego de latido; cura al completarlo
			busy = true
			prompt.Enabled = false
			MinigameService:StartSurgery(player, npc, function(success)
				busy = false
				if success then
					finishHeal(player)
				elseif npc.Parent and not healed then
					prompt.Enabled = true -- falló/canceló: reintentar
				end
			end)
		else
			finishHeal(player)
		end
	end)

	-- si el paciente se va/despawnea sin curarse, libera la sala y limpia todo
	npc.AncestryChanged:Connect(function(_, parent)
		if not parent then
			screensOff(room)   -- apaga Monitor + TV al irse el paciente
			if not healed then
				room.occupied = false
				cleanup()
			end
		end
	end)

	-- El paciente se QUEJA mientras espera (hasta que lo curen o se vaya).
	task.spawn(function()
		while npc.Parent and not healed do
			task.wait(math.random(16, 26))
			if npc.Parent and not healed then
				Network:FireAllClients("PlayCutscene", "Complain", npc)
			end
		end
	end)
end

--------------------------------------------------------------------------------
function PatientCareService:Init()
	if self._initialized then return end
	self._initialized = true

	collectRooms()
	if #rooms == 0 then
		warn("[PatientCareService] no hallé salas en Workspace.Rooms." .. ROOM_TYPE ..
			" con MovePoints.Patient — los pacientes se retirarán sin curar")
	end

	-- Engancha en el flujo de PatientService (post check-in).
	PatientService.CareHandler = function(npc)
		PatientCareService:Admit(npc)
	end
	-- Reserva de sala en el check-in (para que el número anunciado sea el correcto).
	PatientService.ReserveCareRoom = function(npc)
		return PatientCareService:ReserveRoom(npc)
	end

	print("[PatientCareService] inicializado — " .. #rooms .. " salas médicas, loop de curar activo")
end

return PatientCareService
