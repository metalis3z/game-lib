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

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local SanityService = require(ServerScriptService:WaitForChild("SanityService"))

local AnomaliesFolder = ReplicatedStorage:WaitForChild("NPCs"):WaitForChild("Anomalies")
local AreaDetectors = ReplicatedStorage:WaitForChild("AreaDetectors")

local START_DELAY    = 30   -- s antes de la primera anomalía
local CHECK_INTERVAL = 30   -- s entre intentos
local SCREAM_CHANNEL = "JumpscareShadowWithEyesIMG"  -- ya bindeado en Jumpscares (cliente)

-- Registro de anomalías. `kind`:
--   "tall"  -> protocolo por tag (cliente TallMonsterLocal).
--   "world" -> clona modelo(s) en una ubicación y drena cordura.
local ANOMALIES = {
	TallMonster = { kind = "tall",  locations = "TallMonsterLocations", cooldown = 60, lifetime = 30, weight = 2 },

	Shadow  = { kind = "world", models = { "Shadow" },   locations = "ShadowCamPoints",       cooldown = 45, lifetime = 12, drain = 8, range = 40, close = 12, jumpscare = true,  weight = 2, reason = "Shadow" },
	EyeMass = { kind = "world", models = { "EyeMass" },  locations = "CeilingMassLocations",  cooldown = 45, lifetime = 16, drain = 6, range = 45, close = 14, jumpscare = false, weight = 1, reason = "The Mass" },
	Ghost   = { kind = "world", models = { "Ghost" },    locations = "GhostSpawnPoints",      cooldown = 45, lifetime = 14, drain = 7, range = 40, close = 12, jumpscare = true,  weight = 1, reason = "Ghost" },
	Hider   = { kind = "world", models = { "Hider" },    locations = "RunnerLocations",       cooldown = 35, lifetime = 10, drain = 5, range = 35, close = 10, jumpscare = false, weight = 1, reason = "Hider" },

	-- Cama maldita: MonsterBed o MonsterBedLarge + Candles de acompañamiento.
	BedMonster = { kind = "world", models = { "MonsterBed", "MonsterBedLarge" }, companion = "Candles", locations = "RunnerLocations", cooldown = 60, lifetime = 18, drain = 6, range = 40, close = 12, jumpscare = false, weight = 1, reason = "Something in the bed" },

	-- El acechador usa la cabeza (TallMonsterHead ya la usa el jumpscare del stalker).
	Stalker = { kind = "world", models = { "TallMonsterHead" }, locations = "RunnerLocations", cooldown = 50, lifetime = 8, drain = 6, range = 30, close = 10, jumpscare = true, weight = 1, reason = "Stalker" },

	-- Figura lejana: variantes sueltas del monstruo alto que no tenían uso propio.
	Figure = { kind = "world", models = { "TallMonster0", "TallMonster2", "TallMonsterFace" }, locations = "TallMonsterLocations", cooldown = 50, lifetime = 12, drain = 5, range = 40, close = 12, jumpscare = false, weight = 1, reason = "A figure" },
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

	local origin = cf.Position
	pcall(function() origin = model:GetPivot().Position end)

	local scared = {}
	local deadline = os.clock() + cfg.lifetime
	while os.clock() < deadline and model.Parent do
		for _, plr in ipairs(alivePlayers()) do
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local dist = (hrp.Position - origin).Magnitude
				if cfg.jumpscare and cfg.close and dist <= cfg.close and not scared[plr] then
					scared[plr] = true
					SanityService:LoseSanity(plr, cfg.drain * 2, cfg.reason)
					Network:FireClient(plr, SCREAM_CHANNEL)
				elseif dist <= cfg.range then
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

	print("[AnomalyDirector] inicializado — anomalías físicas activas")
end

return AnomalyDirector
