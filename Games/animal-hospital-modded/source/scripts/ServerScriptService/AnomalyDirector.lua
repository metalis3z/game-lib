--[[
	AnomalyDirector  (Fase 9 — director de anomalías físicas)

	El leak trajo los MODELOS (ReplicatedStorage.NPCs.Anomalies) y las UBICACIONES
	(ReplicatedStorage.AreaDetectors), pero NO el script del server que las lanzaba.
	Sin él, ni Shadow ni TallMonster salían jamás: su código CLIENTE en
	AnomalyEvents.Local reacciona a tags/attrs que nadie ponía.

	Este servicio es ese director. Cada CHECK_INTERVAL, si hay jugadores vivos,
	dispara UNA anomalía al azar (respetando cooldown y sin solaparla consigo misma):

	  · TallMonster -> protocolo original: crea una Part con tag "TallMonsterSpawn"
	    + attr TallMonsterSpawn=true en una TallMonsterLocations. El cliente
	    (AnomalyEvents.Local.TallMonsterLocal) hace aparición + peek + jumpscare.

	  · Shadow/EyeMass/Ghost/Hider/BedMonster/Stalker/Figure -> anomalía "de mundo":
	    clona el modelo (anclado) en su ubicación real, drena cordura a los jugadores
	    cercanos mientras vive, hace jumpscare de pantalla si alguien se acerca
	    demasiado (canal de red "JumpscareShadowWithEyesIMG", que el cliente
	    AnomalyEvents.Local.Jumpscares ya maneja), y lo despawnea.

	Así TODOS los hijos de NPCs.Anomalies aparecen y asustan en el juego.

	API: :Init(), :SetEnabled(on), :Trigger(name), :TriggerRandom()
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")

local SanityService = require(ServerScriptService:WaitForChild("SanityService"))
-- Solo por el cooldown global de jumpscares (TryJumpscare), para que las
-- anomalías cercanas no encadenen sustos de pantalla uno detrás de otro.
local AnomalyEventService = require(ServerScriptService:WaitForChild("AnomalyEventService"))

local AnomaliesFolder = ReplicatedStorage:WaitForChild("NPCs"):WaitForChild("Anomalies")
local AreaDetectors = ReplicatedStorage:WaitForChild("AreaDetectors")

-- Frecuencia SUBIDA a pedido: se ven mas monstruos y ademas CAMINAN por el mapa
-- (antes salian anclados en un punto fijo y desaparecian enseguida).
-- UNA anomalía cada 10 minutos (600 s), de a una por vez.
local START_DELAY    = 600  -- s antes de la primera anomalía
local CHECK_INTERVAL = 600  -- s entre anomalías (10 min)
local MAX_ACTIVE     = 1    -- cuantas anomalías de mundo pueden convivir a la vez
-- Los que caminan lo hacen de forma KINEMATICA (el modelo esta anclado y se mueve
-- por PivotTo): nada de fisica, no empujan al jugador ni se caen del mapa.
local WALK_ANIM_ID   = "rbxassetid://71726815866919"  -- Walk(Old), la misma de los NPC
local WANDER_RADIUS  = 70   -- studs: solo camina a marcadores cercanos (no cruza el mapa)
-- El jumpscare de pantalla ya no se manda directo: va por
-- AnomalyEventService:TryJumpscare (canal + cooldown global por jugador).

-- Registro de anomalías. `kind`:
--   "tall"  -> protocolo por tag (cliente TallMonsterLocal).
--   "world" -> clona modelo(s) en una ubicación y drena cordura.
local ANOMALIES = {
	TallMonster = { kind = "tall",  locations = "TallMonsterLocations", cooldown = 90, lifetime = 30, weight = 2 },

	-- walk = true -> patrulla entre marcadores cercanos de su carpeta; speed en studs/s.
	Shadow  = { kind = "world", models = { "Shadow" },   locations = "ShadowCamPoints",       cooldown = 70, lifetime = 25, drain = 8, range = 40, close = 12, jumpscare = true,  weight = 2, reason = "Shadow",   walk = true, speed = 7 },
	EyeMass = { kind = "world", models = { "EyeMass" },  locations = "CeilingMassLocations",  cooldown = 70, lifetime = 18, drain = 6, range = 45, close = 14, jumpscare = false, weight = 1, reason = "The Mass" },
	Ghost   = { kind = "world", models = { "Ghost" },    locations = "GhostSpawnPoints",      cooldown = 70, lifetime = 28, drain = 7, range = 40, close = 12, jumpscare = true,  weight = 1, reason = "Ghost",    walk = true, speed = 5 },
	Hider   = { kind = "world", models = { "Hider" },    locations = "RunnerLocations",       cooldown = 55, lifetime = 22, drain = 5, range = 35, close = 10, jumpscare = false, weight = 2, reason = "Hider",    walk = true, speed = 9 },

	-- Cama maldita: MonsterBed o MonsterBedLarge + Candles de acompañamiento.
	BedMonster = { kind = "world", models = { "MonsterBed", "MonsterBedLarge" }, companion = "Candles", locations = "RunnerLocations", cooldown = 100, lifetime = 20, drain = 6, range = 40, close = 12, jumpscare = false, weight = 1, reason = "Something in the bed" },

	-- El acechador usa la cabeza (TallMonsterHead ya la usa el jumpscare del stalker).
	Stalker = { kind = "world", models = { "TallMonsterHead" }, locations = "RunnerLocations", cooldown = 90, lifetime = 18, drain = 6, range = 30, close = 10, jumpscare = true, weight = 2, reason = "Stalker", walk = true, speed = 8 },

	-- Figura lejana: variantes sueltas del monstruo alto que no tenían uso propio.
	Figure = { kind = "world", models = { "TallMonster0", "TallMonster2" }, locations = "TallMonsterLocations", cooldown = 70, lifetime = 24, drain = 5, range = 40, close = 12, jumpscare = false, weight = 2, reason = "A figure", walk = true, speed = 6 },

	-- Cara espeluznante (TallMonsterFace): separada de Figure para que salga RARA VEZ.
	-- cooldown largo + weight bajo = aparece muy de vez en cuando.
	CreepyFace = { kind = "world", models = { "TallMonsterFace" }, locations = "TallMonsterLocations", cooldown = 300, lifetime = 12, drain = 5, range = 40, close = 12, jumpscare = false, weight = 1, reason = "A face" },
}

local AnomalyDirector = {}
AnomalyDirector.Enabled = true
AnomalyDirector.active = {}      -- [name] = true mientras corre
AnomalyDirector.lastFired = {}   -- [name] = os.clock()

----------------------------------------------------------------------
-- helpers
----------------------------------------------------------------------
local function activeFolder()
	local f = workspace:FindFirstChild("ActiveAnomalies")
	if not f then
		f = Instance.new("Folder")
		f.Name = "ActiveAnomalies"
		f.Parent = workspace
	end
	return f
end

local function alivePlayers()
	local list = {}
	for _, p in ipairs(Players:GetPlayers()) do
		local char = p.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hum and hrp and hum.Health > 0 then
			list[#list + 1] = p
		end
	end
	return list
end

local function pickMarker(folderName)
	local folder = AreaDetectors:FindFirstChild(folderName)
	if not folder then return nil end
	local kids = folder:GetChildren()
	if #kids == 0 then return nil end
	return kids[math.random(1, #kids)]
end

local function markerCFrame(marker)
	if marker:IsA("BasePart") then return marker.CFrame end
	if marker:IsA("Attachment") then return marker.WorldCFrame end
	local ok, cf = pcall(function() return marker:GetPivot() end)
	return ok and cf or CFrame.new()
end

-- Deja un clon inofensivo y anclado (sin scripts, sin colisión, sin barra de vida).
local function neutralize(model)
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BaseScript") or d:IsA("ProximityPrompt") then
			d:Destroy()
		end
	end
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
		elseif d:IsA("Humanoid") then
			d.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			d.HealthDisplayDistance = 0
			d.NameDisplayDistance = 0
		end
	end
end

----------------------------------------------------------------------
-- Patrulla (caminar por el mapa)
----------------------------------------------------------------------
-- Marcador al azar de la carpeta pero CERCA de `fromPos` (para que camine por la
-- zona y no se cruce medio mapa en linea recta). Si no hay ninguno cerca, uno
-- cualquiera.
local function pickNearbyMarker(folderName, fromPos, maxDist)
	local folder = AreaDetectors:FindFirstChild(folderName)
	if not folder then return nil end
	local near = {}
	for _, m in ipairs(folder:GetChildren()) do
		local ok, cf = pcall(function() return markerCFrame(m) end)
		if ok and (cf.Position - fromPos).Magnitude <= maxDist then
			near[#near + 1] = m
		end
	end
	if #near > 0 then
		return near[math.random(1, #near)]
	end
	return pickMarker(folderName)
end

-- Mueve el modelo (anclado) hasta targetPos a `speed` studs/s, mirando hacia
-- donde camina. Kinematico: PivotTo por frame, sin fisica.
local function stepTo(model, targetPos, speed, deadline)
	local startCF = model:GetPivot()
	local flat = Vector3.new(targetPos.X, startCF.Position.Y, targetPos.Z)
	local delta = flat - startCF.Position
	local dist = delta.Magnitude
	if dist < 1 then return end

	local dir = delta.Unit
	local faceCF = CFrame.lookAt(startCF.Position, startCF.Position + dir)
	local dur = dist / math.max(speed, 0.1)
	local t0 = os.clock()

	while model.Parent and os.clock() < deadline do
		local a = (os.clock() - t0) / dur
		if a >= 1 then break end
		model:PivotTo(faceCF + dir * (dist * a))
		task.wait()
	end
	if model.Parent then
		model:PivotTo(faceCF + dir * dist)
	end
end

-- Camina de marcador en marcador mientras viva. Si el rig tiene Humanoid, le
-- pone la anim de caminata para que no se vea deslizando.
local function wander(model, cfg, deadline)
	local track
	local hum = model:FindFirstChildOfClass("Humanoid")
	if hum then
		local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator")
		animator.Parent = hum
		local anim = Instance.new("Animation")
		anim.AnimationId = WALK_ANIM_ID
		local ok, t = pcall(function() return animator:LoadAnimation(anim) end)
		if ok and t then
			track = t
			track.Looped = true
			pcall(function() track:Play() end)
		end
	end

	while model.Parent and os.clock() < deadline do
		local here = model:GetPivot().Position
		local marker = pickNearbyMarker(cfg.locations, here, WANDER_RADIUS)
		if marker then
			stepTo(model, markerCFrame(marker).Position, cfg.speed or 6, deadline)
		end
		task.wait(math.random(6, 20) / 10)   -- pausa corta antes del siguiente punto
	end

	if track then pcall(function() track:Stop() end) end
end

local function cloneAnomaly(name)
	local template = AnomaliesFolder:FindFirstChild(name)
	if not template then return nil end
	local clone = template:Clone()
	neutralize(clone)
	return clone
end

----------------------------------------------------------------------
-- TallMonster: protocolo por tag (lo maneja el cliente)
----------------------------------------------------------------------
local function triggerTall(cfg)
	local marker = pickMarker(cfg.locations)
	if not marker then return end

	local part = Instance.new("Part")
	part.Name = "TallMonsterSpawnPoint"
	part.Size = Vector3.new(1, 1, 1)
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CFrame = markerCFrame(marker)
	for k, v in pairs(marker:GetAttributes()) do  -- copia Corner / NoSecurity, etc.
		part:SetAttribute(k, v)
	end
	part:SetAttribute("TallMonsterSpawn", true)
	part.Parent = activeFolder()
	CollectionService:AddTag(part, "TallMonsterSpawn")

	-- El cliente pone el attr en false cuando dispara el jumpscare; si no, lo cortamos.
	local deadline = os.clock() + cfg.lifetime
	while os.clock() < deadline and part.Parent and part:GetAttribute("TallMonsterSpawn") do
		task.wait(0.5)
	end

	part:SetAttribute("TallMonsterSpawn", false)
	CollectionService:RemoveTag(part, "TallMonsterSpawn")
	task.wait(1)
	part:Destroy()
end

----------------------------------------------------------------------
-- Anomalía de mundo genérica
----------------------------------------------------------------------
local function triggerWorld(cfg)
	local marker = pickMarker(cfg.locations)
	if not marker then return end
	local cf = markerCFrame(marker)

	local model = cloneAnomaly(cfg.models[math.random(1, #cfg.models)])
	if not model then return end
	model.Parent = activeFolder()
	pcall(function() model:PivotTo(cf) end)

	if cfg.companion then
		local comp = cloneAnomaly(cfg.companion)
		if comp then
			comp.Parent = model
			pcall(function() comp:PivotTo(cf) end)
		end
	end

	local deadline = os.clock() + cfg.lifetime

	-- Los que patrullan se mueven en paralelo al loop de cordura de abajo.
	if cfg.walk then
		task.spawn(function()
			local ok, err = pcall(wander, model, cfg, deadline)
			if not ok then
				warn("[AnomalyDirector] wander error: " .. tostring(err))
			end
		end)
	end

	-- scared/drained: cada jugador solo pierde cordura UNA vez por aparicion de
	-- la anomalia (antes el rango ambiental repetia cfg.drain cada 2s mientras
	-- el jugador estuviera dentro de cfg.range -- hasta 45 studs -- durante
	-- toda la vida de la anomalia, y hasta los que SI activaban el jumpscare
	-- cercano seguian cayendo en esta rama despues porque close esta dentro
	-- de range. Eso era el drenaje "todo el rato" sin motivo aparente).
	local scared = {}
	local drained = {}
	while os.clock() < deadline and model.Parent do
		-- posición VIVA (los que patrullan se mueven, así que el rango y el
		-- jumpscare cercano tienen que seguir al modelo, no al punto de spawn)
		local origin = cf.Position
		pcall(function() origin = model:GetPivot().Position end)
		for _, plr in ipairs(alivePlayers()) do
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local dist = (hrp.Position - origin).Magnitude
				if cfg.jumpscare and cfg.close and dist <= cfg.close and not scared[plr] then
					scared[plr] = true
					drained[plr] = true
					SanityService:LoseSanity(plr, cfg.drain * 2, cfg.reason)
					-- Respeta el cooldown global: si le acaban de hacer uno, no
					-- vuelve a saltar la pantalla (igual pierde cordura).
					AnomalyEventService:TryJumpscare(plr)
				elseif dist <= cfg.range and not drained[plr] then
					drained[plr] = true
					SanityService:LoseSanity(plr, cfg.drain, cfg.reason)
				end
			end
		end
		task.wait(2)
	end

	model:Destroy()
end

----------------------------------------------------------------------
-- API
----------------------------------------------------------------------
function AnomalyDirector:SetEnabled(on)
	self.Enabled = on and true or false
end

function AnomalyDirector:Trigger(name)
	local cfg = ANOMALIES[name]
	if not cfg then return false end
	if self.active[name] then return false end

	self.active[name] = true
	self.lastFired[name] = os.clock()

	task.spawn(function()
		local ok, err = pcall(function()
			if cfg.kind == "tall" then
				triggerTall(cfg)
			else
				triggerWorld(cfg)
			end
		end)
		if not ok then
			warn("[AnomalyDirector] " .. name .. " error: " .. tostring(err))
		end
		self.active[name] = nil
	end)
	return true
end

function AnomalyDirector:TriggerRandom()
	local now = os.clock()

	-- Tope de anomalías simultáneas: con el intervalo corto y las vidas largas
	-- se juntan varias caminando a la vez; MAX_ACTIVE evita que sea un desfile.
	local activeCount = 0
	for _ in pairs(self.active) do
		activeCount += 1
	end
	if activeCount >= MAX_ACTIVE then return end

	local pool, total = {}, 0
	for name, cfg in pairs(ANOMALIES) do
		local last = self.lastFired[name]
		local ready = (not self.active[name]) and (not last or (now - last) >= (cfg.cooldown or 30))
		if ready then
			local w = cfg.weight or 1
			total = total + w
			pool[#pool + 1] = { name = name, upto = total }
		end
	end
	if total == 0 then return end

	local roll = math.random() * total
	for _, entry in ipairs(pool) do
		if roll <= entry.upto then
			self:Trigger(entry.name)
			return
		end
	end
end

function AnomalyDirector:Init()
	if self._initialized then return end
	self._initialized = true

	task.spawn(function()
		task.wait(START_DELAY)
		while true do
			task.wait(CHECK_INTERVAL)
			if self.Enabled and #alivePlayers() > 0 then
				self:TriggerRandom()
			end
		end
	end)

	-- print("[AnomalyDirector] inicializado — anomalías físicas activas")
end

return AnomalyDirector
