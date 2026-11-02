--[[
	SkinwalkerService  (Fase 14 — skinwalker que llega como visitante y caza)

	El skinwalker LLEGA como un UniqueVisitor (mismo flujo: aparece en la calle,
	entra por la MainDoor y va al mostrador) pero en su FORM de monstruo,
	customizado con las piezas del leak:

	  · Base:   ReplicatedStorage.NPCs.Skinwalkers.Skinwalker  (rig skinned).
	  · Cara/ojos ReplicatedStorage.NPCs.SkinwalkerEasyAssets.*  (Face + Eyes 3D).
	  · Cuerpo:   ReplicatedStorage.NPCs.Textures.*  (SurfaceAppearance por parte).
	  · Foto:     ReplicatedStorage.NPCs.SkinwalkerPhotoFaces (reveal CursedPhoto).
	  · Form:     Animations.IdleSkinwalker  (su animación de estar quieto).
	  · Ataque:   Animations.Jumpscare       (al atacar a otro visitante).

	Comportamiento (Fase 15 — disfraz + revelación): LLEGA DISFRAZADO de visitante
	humano normal usando el flujo COMPLETO de PatientService (se sienta en las sillas,
	hace cola, check-in en el mostrador, espera... es un paciente real, indistinguible).
	RARA VEZ rompe la forma y SE REVELA: en su sitio se transforma en el rig monstruo
	(cara/ojos/textura/color), asusta a quien esté cerca, ataca a un UniqueVisitor
	cercano (Jumpscare, NUNCA al jugador) y se va. Solo el rig revelado lleva el tag
	"NPC" + reveals de cámara/foto (AnomalyService); disfrazado pasa por normal.

	API: :Init(), :SetEnabled(on), :SpawnSkinwalker([opts]) -> model, :DespawnAll()
]]

local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local ServerScriptService= game:GetService("ServerScriptService")
local CollectionService  = game:GetService("CollectionService")
local PhysicsService     = game:GetService("PhysicsService")

local Lib     = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local SanityService  = require(ServerScriptService:WaitForChild("SanityService"))
local AnomalyService = require(ServerScriptService:WaitForChild("AnomalyService"))
local PatientService = require(ServerScriptService:WaitForChild("PatientService"))
-- Solo por el cooldown global de jumpscares de pantalla (TryJumpscare).
local AnomalyEventService = require(ServerScriptService:WaitForChild("AnomalyEventService"))

local NPCs            = ReplicatedStorage:WaitForChild("NPCs")
local SKINWALKER_BASE = NPCs:WaitForChild("Skinwalkers"):WaitForChild("Skinwalker")
local EASY_ASSETS     = NPCs:WaitForChild("SkinwalkerEasyAssets")
local BODY_TEXTURES   = NPCs:WaitForChild("Textures")
local PHOTO_FACES     = NPCs:WaitForChild("SkinwalkerPhotoFaces")  -- caras "enojadas" (SecondFace)
local UNIQUE_VISITORS = NPCs:FindFirstChild("UniqueVisitors1")     -- paletas de color por pieza (Body*/Head)
local ANIMS           = ReplicatedStorage:WaitForChild("Animations")
local IDLE_ANIM       = ANIMS:WaitForChild("IdleSkinwalker")   -- su "form"
local ATTACK_ANIM     = ANIMS:WaitForChild("Jumpscare")        -- su ataque

local NPC_GROUP  = "PatientNPC"   -- mismo grupo que PatientService (atraviesa puertas)
local DOOR_GROUP = "MapDoors"
local MOUTH_PARTS = { "Gulp", "Tooth", "Spit", "TongueMesh" }
local SCREAM_CHANNEL = "JumpscareShadowWithEyesIMG"  -- ya bindeado en Jumpscares (cliente)

-- Puntos (MovePoints) — llega como visitante.
local SPAWN_POINT  = "outside"
local IDLE_POINT   = "checkIn2"   -- se queda cerca del mostrador, junto a los visitantes
local LEAVE_POINT  = "outside"

-- Comportamiento
local START_DELAY    = 20    -- s antes del primer skinwalker automático
local RESPAWN_DELAY   = 120   -- s entre skinwalkers automáticos
local LIFETIME        = 70    -- s que se queda antes de irse
local ATTACK_INTERVAL = 12    -- s entre chequeos de ataque
local ATTACK_CHANCE   = 0.16  -- prob. de atacar en cada chequeo (rara vez)
local REVEAL_INTERVAL = 8     -- s entre chequeos de revelación mientras está disfrazado
local REVEAL_CHANCE   = 0.16  -- prob. de romper el disfraz y revelarse en cada chequeo (rara vez)
local WITNESS_RANGE   = 40    -- studs: jugadores que ven el ataque reciben el susto
local WITNESS_SANITY  = 8     -- cordura que pierde quien lo presencia
local WALK_SPEED      = 8

-- Color del monstruo: la mayoría salen RAINBOW (ciclo de tono animado mientras viven);
-- el resto adopta la paleta de color por pieza de un visitante de UniqueVisitors1.
local RAINBOW_CHANCE  = 0.6   -- prob. de que un skinwalker salga rainbow (resto = paleta visitante)
local SOLID_SAT       = 0.85  -- saturación del color de respaldo si no hay UniqueVisitors1
local RAINBOW_STEP    = 0.02  -- avance de tono por tick
local RAINBOW_TICK    = 0.06  -- s entre ticks del rainbow

--========================================================================
-- Colisión (idempotente, igual que PatientService)
--========================================================================
local function ensureCollisionGroups()
	for _, g in ipairs({ NPC_GROUP, DOOR_GROUP }) do
		if not PhysicsService:IsCollisionGroupRegistered(g) then
			pcall(function() PhysicsService:RegisterCollisionGroup(g) end)
		end
	end
	pcall(function() PhysicsService:CollisionGroupSetCollidable(NPC_GROUP, DOOR_GROUP, false) end)
end

--========================================================================
-- Customización (color + cara + ojos + boca)
--========================================================================
-- Recolorea el cuerpo. Los MeshParts del Texture model SON los cuerpos (malla propia
-- + SurfaceAppearance) y su MeshId difiere del rig, así que copiar solo el SA mapea
-- mal las UVs. Por eso SWAPEAMOS: usamos el MeshPart del Texture model como cuerpo,
-- transfiriéndole los hijos (Motor6D/Attachments) del viejo para conservar el rig y
-- la posición. Las Body.NNN que ese set no cubre igualan color/material + SA genérico.
local function applyBodyTexture(rig, texModel)
	local genericPart = texModel:FindFirstChild("Body")
	local genericSA = genericPart and genericPart:FindFirstChildOfClass("SurfaceAppearance")
	local byName = {}
	for _, part in ipairs(texModel:GetChildren()) do
		if part:IsA("MeshPart") then byName[part.Name] = part end
	end
	-- recolecta primero (vamos a reemplazar instancias mientras iteramos)
	local rigParts = {}
	for _, part in ipairs(rig:GetChildren()) do
		if part:IsA("MeshPart") and (part.Name == "Head" or part.Name:match("^Body")) then
			rigParts[#rigParts+1] = part
		end
	end
	for _, old in ipairs(rigParts) do
		local tex = byName[old.Name]
		if tex then
			local np = tex:Clone()
			np.Name = old.Name
			np.CFrame = old.CFrame
			np.Anchored = false
			np.CanCollide = old.CanCollide
			for _, ch in ipairs(old:GetChildren()) do ch.Parent = np end  -- Motor6D/Attachments
			np.Parent = rig
			-- repunta CUALQUIER joint del rig que apuntara al viejo. CLAVE: la WeldConstraint
			-- HumanoidRootPart<->Body.003 vive DENTRO del HumanoidRootPart (no del body); sin
			-- repuntarla, el cuerpo se desconecta del HRP y el NPC se queda parado sin caminar.
			for _, j in ipairs(rig:GetDescendants()) do
				if j:IsA("Motor6D") or j:IsA("Weld") or j:IsA("WeldConstraint") then
					if j.Part0 == old then j.Part0 = np end
					if j.Part1 == old then j.Part1 = np end
				end
			end
			old:Destroy()
		elseif genericPart then
			old.Color = genericPart.Color
			old.Material = genericPart.Material
			if genericSA then
				local ex = old:FindFirstChildOfClass("SurfaceAppearance")
				if ex then ex:Destroy() end
				genericSA:Clone().Parent = old
			end
		end
	end
end

local function applyFaceTexture(rig, easyAsset)
	local assetFace = easyAsset:FindFirstChild("Face")
	local rigFace = rig:FindFirstChild("Head.002")
	if not (assetFace and rigFace) then return end
	local tex = assetFace.TextureID
	rigFace.TextureID = tex
	if rig:FindFirstChild("Head.004") then rig["Head.004"].TextureID = tex end
	rig:SetAttribute("CalmFace", tex)  -- cara base; se restaura tras enojarse
end

-- Ojos 3D: ancla al CENTROIDE del cúmulo (los assets están modelados inconsistentes;
-- ver Fase 14). DEBE llamarse DESPUÉS del PivotTo (el weld fija la pose actual).
local function applyEyes(rig, easyAsset)
	local eyesModel = easyAsset and easyAsset:FindFirstChild("Eyes")
	local assetFace = easyAsset and easyAsset:FindFirstChild("Face")
	local rigFace = rig:FindFirstChild("Head.002")
	if not (eyesModel and assetFace and rigFace) then return end

	local parts, sum = {}, Vector3.zero
	for _, src in ipairs(eyesModel:GetDescendants()) do
		if src:IsA("BasePart") then parts[#parts+1] = src; sum += src.Position end
	end
	if #parts == 0 then return end
	local centroid = sum / #parts
	local faceRot = assetFace.CFrame - assetFace.CFrame.Position
	local refCF = CFrame.new(centroid) * faceRot

	if rig:FindFirstChild("SkinwalkerEyes") then rig.SkinwalkerEyes:Destroy() end
	local holder = Instance.new("Folder")
	holder.Name = "SkinwalkerEyes"
	holder.Parent = rig
	for _, src in ipairs(parts) do
		local part = src:Clone()
		for _, j in ipairs(part:GetChildren()) do
			if j:IsA("JointInstance") or j:IsA("WeldConstraint") then j:Destroy() end
		end
		part.CFrame = rigFace.CFrame * refCF:ToObjectSpace(src.CFrame)
		part.Anchored = false
		part.CanCollide = false
		part.CanQuery = false
		part.Massless = true
		part.CollisionGroup = NPC_GROUP
		if part.Name == "Cone" then part.Transparency = 0 end
		part.Parent = holder
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = rigFace
		weld.Part1 = part
		weld.Parent = part
	end
end

local function revealMouth(rig)
	for _, n in ipairs(MOUTH_PARTS) do
		local p = rig:FindFirstChild(n)
		if p and p:IsA("BasePart") then p.Transparency = 0 end
	end
end

-- EasyAssets que traen ojos 3D (sub-model Eyes), para garantizar ojos siempre.
local EYE_ASSETS = {}
for _, a in ipairs(EASY_ASSETS:GetChildren()) do
	if a:FindFirstChild("Eyes") then EYE_ASSETS[#EYE_ASSETS+1] = a end
end

-- Garantiza que el skinwalker traiga ojos: si el asset de cara no tenía, usa uno que sí.
local function ensureEyes(rig)
	local eyesF = rig:FindFirstChild("SkinwalkerEyes")
	if eyesF and #eyesF:GetChildren() > 0 then return end
	if #EYE_ASSETS == 0 then return end
	applyEyes(rig, EYE_ASSETS[math.random(1, #EYE_ASSETS)])
end

-- Cara "enojada": al atacar swapea Head.002/004 a una SkinwalkerPhotoFace y marca el
-- atributo SecondFace (el mismo que usan los reveals DifferentFace/CursedPhoto); al
-- terminar vuelve a la CalmFace.
local function setAngryFace(rig, on)
	local h2, h4 = rig:FindFirstChild("Head.002"), rig:FindFirstChild("Head.004")
	if on then
		local faces = PHOTO_FACES:GetChildren()
		local pick = faces[math.random(1, #faces)]
		local tex = pick and pick:IsA("MeshPart") and pick.TextureID
		if not tex then return end
		if h2 then h2.TextureID = tex end
		if h4 then h4.TextureID = tex end
		rig:SetAttribute("SecondFace", tex)
	else
		local calm = rig:GetAttribute("CalmFace")
		if calm then
			if h2 then h2.TextureID = calm end
			if h4 then h4.TextureID = calm end
		end
		rig:SetAttribute("SecondFace", nil)
	end
end

-- Prepara el rig como visitante: desancla, colisión, netowner, tag "NPC".
local function prepRig(rig)
	rig:SetAttribute("IsSkinwalkerMonster", true)  -- para no atacarse entre skinwalkers
	local hum = rig:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = WALK_SPEED
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		hum.HealthDisplayDistance = 0
		hum.NameDisplayDistance = 0
	end
	for _, d in ipairs(rig:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = false
			pcall(function() d.CollisionGroup = NPC_GROUP end)
		end
	end
	local hrp = rig:FindFirstChild("HumanoidRootPart")
	if hrp then pcall(function() hrp:SetNetworkOwner(nil) end) end
	CollectionService:AddTag(rig, "NPC")
end

-- Carga las pistas de animación (form + ataque) y arranca la form en loop.
local function setupAnimations(rig)
	local hum = rig:FindFirstChildOfClass("Humanoid")
	if not hum then return nil end
	local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
	local tracks = {}
	pcall(function()
		local idle = animator:LoadAnimation(IDLE_ANIM)
		idle.Looped = true
		idle.Priority = Enum.AnimationPriority.Idle
		idle:Play()
		tracks.idle = idle
	end)
	pcall(function()
		local atk = animator:LoadAnimation(ATTACK_ANIM)
		atk.Looped = false
		atk.Priority = Enum.AnimationPriority.Action
		tracks.attack = atk
	end)
	return tracks
end

--========================================================================
-- Color del monstruo (tinte sobre el cuerpo)
--========================================================================
-- Recolecta las piezas del cuerpo (Head + Body*). Tras applyBodyTexture TODAS
-- llevan un SurfaceAppearance (swap o genérico), así que tintamos su .Color
-- (multiplica el ColorMap) y de paso el Color del MeshPart como fallback.
local function bodyParts(rig)
	local list = {}
	for _, p in ipairs(rig:GetDescendants()) do
		if p:IsA("MeshPart") and (p.Name == "Head" or p.Name:match("^Body")) then
			list[#list+1] = p
		end
	end
	return list
end

local function tintPart(part, color)
	pcall(function() part.Color = color end)
	local sa = part:FindFirstChildOfClass("SurfaceAppearance")
	if sa then pcall(function() sa.Color = color end) end
end

-- Copia la paleta de color por pieza de un visitante aleatorio de UniqueVisitors1:
-- cada Body*/Head del visitante tiñe la pieza homónima del skinwalker (mismo esquema
-- de nombres). Las piezas que el visitante no cubra reciben su color de "Body".
local function applyVisitorPalette(rig)
	local pool = UNIQUE_VISITORS and UNIQUE_VISITORS:GetChildren()
	if not pool or #pool == 0 then return false end
	local model = pool[math.random(1, #pool)]
	local byName = {}
	for _, p in ipairs(model:GetDescendants()) do
		if (p:IsA("MeshPart") or p:IsA("Part")) and (p.Name == "Head" or p.Name:match("^Body")) then
			byName[p.Name] = byName[p.Name] or p.Color
		end
	end
	local fill = byName["Body"] or byName["Head"]
	local applied = false
	for _, p in ipairs(bodyParts(rig)) do
		local c = byName[p.Name] or fill
		if c then tintPart(p, c); applied = true end
	end
	if applied then rig:SetAttribute("MonsterColor", "Visitor:" .. model.Name) end
	return applied
end

-- Aplica el color al skinwalker YA PARENTEADO (el rainbow necesita rig.Parent para
-- vivir). RAINBOW_CHANCE salen rainbow; el resto usa la paleta de un visitante.
local function applyMonsterColor(rig)
	local parts = bodyParts(rig)
	if #parts == 0 then return end
	if math.random() < RAINBOW_CHANCE then
		rig:SetAttribute("MonsterColor", "Rainbow")
		task.spawn(function()
			local t = math.random()
			while rig.Parent do
				t = (t + RAINBOW_STEP) % 1
				local color = Color3.fromHSV(t, 1, 1)
				for _, p in ipairs(parts) do
					if p.Parent then tintPart(p, color) end
				end
				task.wait(RAINBOW_TICK)
			end
		end)
	elseif not applyVisitorPalette(rig) then
		-- respaldo si no existe UniqueVisitors1: color sólido aleatorio
		local color = Color3.fromHSV(math.random(), SOLID_SAT, 1)
		rig:SetAttribute("MonsterColor", "Solid")
		for _, p in ipairs(parts) do tintPart(p, color) end
	end
end

-- Ensambla color + cara + boca (ojos van tras el PivotTo, ver applyEyes).
local function assemble(opts)
	opts = opts or {}
	local rig = SKINWALKER_BASE:Clone()

	local texPool = BODY_TEXTURES:GetChildren()
	local tex = (opts.texture and BODY_TEXTURES:FindFirstChild(opts.texture)) or texPool[math.random(1, #texPool)]
	if tex then applyBodyTexture(rig, tex) end

	local easyPool = EASY_ASSETS:GetChildren()
	local easy = (opts.face and EASY_ASSETS:FindFirstChild(opts.face)) or easyPool[math.random(1, #easyPool)]
	if easy then applyFaceTexture(rig, easy) end

	revealMouth(rig)
	rig:SetAttribute("EasyAsset", easy and easy.Name or "")
	rig:SetAttribute("SkinwalkerVariant", (tex and tex.Name or "?") .. "/" .. (easy and easy.Name or "?"))
	return rig
end

--========================================================================
-- Objetivos: SOLO otros visitantes (UniqueVisitors), nunca el jugador.
--========================================================================
local function findVisitorTarget(rig)
	local hrp = rig:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end
	local best, bestDist
	for _, npc in ipairs(workspace.NPCs:GetChildren()) do
		if npc ~= rig
			and npc:HasTag("NPC")
			and not npc:GetAttribute("IsSkinwalkerMonster") then
			local hum = npc:FindFirstChildOfClass("Humanoid")
			local nhrp = npc:FindFirstChild("HumanoidRootPart")
			if hum and nhrp and hum.Health > 0 then
				local d = (nhrp.Position - hrp.Position).Magnitude
				if not bestDist or d < bestDist then best, bestDist = npc, d end
			end
		end
	end
	return best
end

--========================================================================
-- Servicio
--========================================================================
local SkinwalkerService = {}
SkinwalkerService.Enabled = true
SkinwalkerService.active = {}   -- [model] = true

local function alivePlayers()
	local list = {}
	for _, p in ipairs(Players:GetPlayers()) do
		local char = p.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hum and hrp and hum.Health > 0 then list[#list+1] = p end
	end
	return list
end

-- Susto atmosférico a quien PRESENCIA el ataque (no es un ataque al jugador).
local function scareWitnesses(originPos)
	for _, plr in ipairs(alivePlayers()) do
		local phrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
		if phrp and (phrp.Position - originPos).Magnitude <= WITNESS_RANGE then
			SanityService:LoseSanity(plr, WITNESS_SANITY, "Skinwalker")
			-- Pasa por el cooldown global de jumpscares (AnomalyEventService),
			-- para que no salten dos sustos de pantalla seguidos.
			AnomalyEventService:TryJumpscare(plr)
		end
	end
end

-- Ataca a un visitante: se acerca, reproduce Jumpscare y se lo lleva.
local function attackVisitor(rig, target, tracks)
	local nhrp = target:FindFirstChild("HumanoidRootPart")
	if not nhrp then return end
	PatientService:WalkTo(rig, nhrp)                    -- follows a moving target
	if not (rig.Parent and target.Parent) then return end
	setAngryFace(rig, true)                             -- se enoja: SecondFace
	if tracks and tracks.attack then
		tracks.attack:Play()
	end
	scareWitnesses(nhrp.Position)
	task.wait((tracks and tracks.attack and tracks.attack.Length > 0 and tracks.attack.Length) or 1.2)
	-- se lo lleva
	local thum = target:FindFirstChildOfClass("Humanoid")
	if thum then thum.Health = 0 end
	for _, p in ipairs(target:GetDescendants()) do
		if p:IsA("BasePart") then pcall(function() p.Transparency = 1 end) end
	end
	task.wait(0.3)
	pcall(function() PatientService:Despawn(target) end)
	if rig.Parent then setAngryFace(rig, false) end     -- vuelve a la cara calmada
end

-- Construye el rig MONSTRUO ya colocado en `cframe` (la revelación): look + ojos +
-- color + animaciones + marca de reveals cámara/foto. Devuelve rig, tracks.
local function buildMonsterRig(opts, cframe)
	local rig = assemble(opts)
	rig:PivotTo(cframe + Vector3.new(0, 2, 0))
	rig.Parent = workspace.NPCs
	prepRig(rig)
	pcall(function() applyEyes(rig, EASY_ASSETS:FindFirstChild(rig:GetAttribute("EasyAsset"))) end)
	pcall(function() ensureEyes(rig) end)          -- siempre vienen con ojos de los EasyAssets
	pcall(function() applyMonsterColor(rig) end)   -- color vivo aleatorio (o rainbow raro)
	local tracks = setupAnimations(rig)
	-- Reveals cámara/foto: foto = CursedPhoto (SkinwalkerPhotoFaces).
	pcall(function() AnomalyService:MarkSkinwalker(rig, { photo = "CursedPhoto" }) end)
	return rig, tracks
end

function SkinwalkerService:SetEnabled(on)
	self.Enabled = on and true or false
end

function SkinwalkerService:SpawnSkinwalker(opts)
	opts = opts or {}
	ensureCollisionGroups()

	-- 1) LLEGA DISFRAZADO: un visitante humano normal con el flujo COMPLETO de
	--    PatientService (se sienta, hace cola, check-in...). Es un paciente real.
	local disguise = PatientService:SpawnPatient()
	if not disguise then
		warn("[SkinwalkerService] no se pudo crear el disfraz (PatientService:SpawnPatient)")
		return nil
	end
	disguise:SetAttribute("IsSkinwalkerDisguise", true)
	self.active[disguise] = true

	task.spawn(function()
		local deadline = os.clock() + (opts.lifetime or LIFETIME)
		local revealed = false

		-- 2) Mientras esté disfrazado y vivo, RARA VEZ rompe la forma y se revela.
		--    (si termina su rutina de visitante y se va antes, nunca se revela)
		while disguise.Parent and os.clock() < deadline do
			task.wait(opts.revealInterval or REVEAL_INTERVAL)
			if not disguise.Parent then break end
			if math.random() < (opts.revealChance or REVEAL_CHANCE) then
				revealed = true
				break
			end
		end

		-- 3a) Nunca se reveló: era solo un visitante más; que siga/termine su rutina.
		if not revealed or not disguise.Parent then
			self.active[disguise] = nil
			return
		end

		-- 3b) REVELACIÓN: captura su sitio, lo saca del flujo de visitante y lo
		--     reemplaza AHÍ MISMO por el rig monstruo.
		local hrp = disguise:FindFirstChild("HumanoidRootPart")
		local cframe = (hrp and hrp.CFrame) or CFrame.new()
		pcall(function() PatientService:RemoveFromWaiting(disguise) end)
		self.active[disguise] = nil
		pcall(function() disguise:Destroy() end)

		local rig, tracks = buildMonsterRig(opts, cframe)
		self.active[rig] = true

		-- Susto inmediato a quien presencie la transformación.
		scareWitnesses(cframe.Position)

		-- Ataca a un UniqueVisitor cercano si lo hay (nunca al jugador).
		local target = findVisitorTarget(rig)
		if target then
			pcall(function() attackVisitor(rig, target, tracks) end)
		end

		-- Se va por la calle y despawnea.
		self.active[rig] = nil
		if rig.Parent then
			local leavePart = PatientService:MovePoint(LEAVE_POINT)
			if leavePart then pcall(function() PatientService:WalkTo(rig, leavePart.Position) end) end
			if rig.Parent then rig:Destroy() end
		end
	end)

	return disguise
end

function SkinwalkerService:DespawnAll()
	for rig in pairs(self.active) do
		if rig and rig.Parent then
			pcall(function() PatientService:RemoveFromWaiting(rig) end)  -- por si es un disfraz en la sala
			rig:Destroy()
		end
		self.active[rig] = nil
	end
end

function SkinwalkerService:Init()
	if self._initialized then return end
	self._initialized = true
	ensureCollisionGroups()

	task.spawn(function()
		task.wait(START_DELAY)
		while true do
			if self.Enabled and #alivePlayers() > 0 and next(self.active) == nil then
				pcall(function() self:SpawnSkinwalker() end)
			end
			task.wait(RESPAWN_DELAY)
		end
	end)

	-- print("[SkinwalkerService] inicializado — llega DISFRAZADO de visitante y rara vez se revela")
end

return SkinwalkerService
