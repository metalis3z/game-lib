--[[
	AnomalyService  (Fase 5 — skinwalkers / anomalías)  ·  reescrito Fase 5c

	Los visitantes IMPOSTOR (atributo Fake=true que PatientService pone en
	Doctor/Ron/Clown de UniqueVisitors) son las anomalías: NO son pacientes reales,
	hay que RECHAZARLOS. Este servicio los marca como skinwalkers y les asigna un
	"disguise reveal" para que las CÁMARAS y las FOTOS los delaten.

	Cómo se aplican (CLIENTE, ya existente — NO tocar):
	  · UI.CameraSystem, al encender la cámara, por cada NPC tageado hace
	    `Lib.ApplySkinwalkerDisguiseReveal(npc, "CameraEffect")`.
	  · UI.PhotoSystem hace lo mismo con `PhotoEffect`.
	  · SkinwalkerDisguiseRevealLocal lee el atributo del NPC ("CameraEffect" /
	    "PhotoEffect", y sus variantes "…2"), busca ese módulo en
	    ReplicatedStorage.AnomalyEvents.DisguiseReveals y llama .Apply(npc)/.UnDo(npc).

	Papel del SERVER (este módulo): elegir QUÉ reveal usa cada impostor por canal
	(cámara / foto) y dejar preparados los PRE-REQUISITOS que ese reveal necesita
	(atributos + instancias) para que el Apply del cliente funcione. Se cubren los
	9 módulos de DisguiseReveals mediante un catálogo con:
	   Compatible(rig) -> puede el rig mostrar este reveal
	   Setup(rig)      -> preparación server-side antes de que el cliente lo aplique
	   Channels        -> en qué canal(es) luce bien (camera / photo)

	Estado de cada reveal frente a los rigs actuales (verificado):
	   HiddenFace ✓  DifferentFace ✓  CursedPhoto(foto) ✓  SkinwalkerOpensMouth ✓
	   VoidPresence ✓  BrokenBones ✓  Static(foto) ✓  TwistNeck ✓ (Setup crea NeckBone)
	   DifferentEars ✗  (ningún rig trae mallas SecondEars/Ears → se auto-descarta)

	API: :Init(), :IsSkinwalker(npc), :MarkSkinwalker(npc[, opts]),
	     :AssignReveal(npc, cameraName, photoName)  (forzado manual / testing)
]]

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PatientService = require(ServerScriptService:WaitForChild("PatientService"))

local REVEALS_FOLDER = ReplicatedStorage:WaitForChild("AnomalyEvents"):WaitForChild("DisguiseReveals")

--========================================================================
-- Helpers de rig
--========================================================================

local SKINWALKER_PARTS = { "Gulp", "Tooth", "TongueMesh", "Spit", "Teeth" }

-- Bone que controla la cabeza (cadena spine.NNN más alta), usado por TwistNeck.
local function getHeadBone(rig)
	local top
	for _, d in ipairs(rig:GetDescendants()) do
		if d:IsA("Bone") then
			local n = d.Name
			if n:match("^spine%.%d+$") then
				if not top or n > top.Name then top = d end
			elseif not top and (n:lower():find("neck") or n:lower():find("head")) then
				top = d
			end
		end
	end
	return top
end

local function hasFaceSurface(rig)
	return rig:FindFirstChild("Head.002") ~= nil or rig:FindFirstChild("Face") ~= nil
end

-- Textura de cara actual (para poder restaurarla en UnDo vía atributo OriginalFace).
local function currentFaceTexture(rig)
	local h2 = rig:FindFirstChild("Head.002")
	if h2 then return h2.TextureID end
	local face = rig:FindFirstChild("Face")
	if face and (face:IsA("Decal") or face:IsA("Texture") or face:IsA("MeshPart")) then
		return face.TextureID
	end
	return nil
end

local function hasSkinwalkerParts(rig)
	for _, n in ipairs(SKINWALKER_PARTS) do
		local p = rig:FindFirstChild(n)
		if p and p:IsA("BasePart") then return true end
	end
	return false
end

local function hasBones(rig)
	for _, d in ipairs(rig:GetDescendants()) do
		if d:IsA("Bone") then return true end
	end
	return false
end

--========================================================================
-- Setups reutilizables
--========================================================================

-- Los reveals de cara (DifferentFace / CursedPhoto) capturan SecondFace al aplicar
-- y restauran desde OriginalFace al deshacer. Si OriginalFace no está, el UnDo del
-- cliente no restaura y la cara swapeada persiste al apagar cámara. Lo fijamos aquí.
local function setupOriginalFace(rig)
	if rig:GetAttribute("OriginalFace") == nil then
		local tex = currentFaceTexture(rig)
		if tex then rig:SetAttribute("OriginalFace", tex) end
	end
end

-- TwistNeck necesita un ObjectValue "NeckBone" apuntando al hueso de la cabeza;
-- el cliente HeadRotationLocal lo rota hacia la cámara mientras esté el tag.
local function setupNeckBone(rig)
	if rig:FindFirstChild("NeckBone") then return true end
	local bone = getHeadBone(rig)
	if not bone then return false end
	local ov = Instance.new("ObjectValue")
	ov.Name = "NeckBone"
	ov.Value = bone
	ov.Parent = rig
	return true
end

--========================================================================
-- Catálogo de los 9 DisguiseReveals
--========================================================================
-- Channels: en qué canal luce el efecto. camera = CCTV (CameraSystem),
-- photo = cámara de fotos (PhotoSystem). additive = puede apilarse como reveal
-- secundario ("…2") sin pelearse con la cara/billboard del primario.

local REVEALS = {
	{
		Name = "HiddenFace", camera = true, photo = true, additive = false,
		Compatible = function(rig) return rig:FindFirstChild("Head") ~= nil end,
		Setup = function() end,
	},
	{
		Name = "DifferentFace", camera = true, photo = true, additive = false,
		Compatible = function(rig) return hasFaceSurface(rig) end,
		Setup = setupOriginalFace,
	},
	{
		Name = "CursedPhoto", camera = false, photo = true, additive = false,
		Compatible = function(rig) return hasFaceSurface(rig)
			and ReplicatedStorage.NPCs:FindFirstChild("SkinwalkerPhotoFaces") ~= nil end,
		Setup = setupOriginalFace,
	},
	{
		Name = "SkinwalkerOpensMouth", camera = true, photo = true, additive = true,
		Compatible = function(rig)
			return hasSkinwalkerParts(rig)
				and rig:FindFirstChildOfClass("Humanoid") ~= nil
				and ReplicatedStorage:FindFirstChild("Animations")
				and ReplicatedStorage.Animations:FindFirstChild("IdleSkinwalker") ~= nil
		end,
		Setup = function() end,
	},
	{
		Name = "VoidPresence", camera = true, photo = true, additive = true,
		Compatible = function(rig)
			return rig:FindFirstChild("Head") ~= nil and rig:FindFirstChild("Body") ~= nil
				and ReplicatedStorage.Misc:FindFirstChild("Particles")
				and ReplicatedStorage.Misc.Particles:FindFirstChild("Lost") ~= nil
		end,
		Setup = function() end,
	},
	{
		Name = "BrokenBones", camera = true, photo = true, additive = true,
		Compatible = function(rig) return hasBones(rig) end,
		Setup = function() end,
	},
	{
		Name = "Static", camera = false, photo = true, additive = false,
		Compatible = function() return true end, -- overlay de PhotoUI (client), rig-agnóstico
		Setup = function() end,
	},
	{
		Name = "TwistNeck", camera = true, photo = true, additive = true,
		Compatible = function(rig) return getHeadBone(rig) ~= nil end,
		Setup = setupNeckBone,
	},
	{
		Name = "DifferentEars", camera = true, photo = true, additive = false,
		Compatible = function(rig)
			return rig:FindFirstChild("SecondEars") ~= nil and rig:FindFirstChild("Ears") ~= nil
		end,
		Setup = function() end,
	},
}

local REVEAL_BY_NAME = {}
for _, r in ipairs(REVEALS) do REVEAL_BY_NAME[r.Name] = r end

local function candidates(rig, channel)
	local list = {}
	for _, r in ipairs(REVEALS) do
		if r[channel] and r.Compatible(rig) then
			table.insert(list, r)
		end
	end
	return list
end

local function pick(list)
	if #list == 0 then return nil end
	return list[math.random(1, #list)]
end

--========================================================================
-- Servicio
--========================================================================

local AnomalyService = {}

function AnomalyService:IsSkinwalker(npc)
	return npc:GetAttribute("Skinwalker") == true
end

-- Aplica (prepara) un reveal concreto en un canal ("CameraEffect"/"PhotoEffect"),
-- corriendo su Setup y fijando el atributo que lee el cliente. Devuelve el reveal.
local function applyReveal(npc, attr, reveal)
	if not reveal then return nil end
	reveal.Setup(npc)
	npc:SetAttribute(attr, reveal.Name)
	return reveal
end

--[[
	Marca un NPC como skinwalker y le asigna reveals de cámara y foto.
	opts (opcional): { camera = "Nombre", photo = "Nombre", allowSecondary = bool }
	  · Si el NPC ya trae CameraEffect/PhotoEffect (puesto por un diseñador), se respeta.
	  · Por defecto se elige un reveal compatible aleatorio por canal + 35% de reveal
	    secundario apilable (canal "…2").
]]
function AnomalyService:MarkSkinwalker(npc, opts)
	opts = opts or {}
	npc:SetAttribute("Skinwalker", true)

	--- Canal CÁMARA -------------------------------------------------------
	local cam
	if npc:GetAttribute("CameraEffect") ~= nil then
		cam = REVEAL_BY_NAME[npc:GetAttribute("CameraEffect")]
		if cam then cam.Setup(npc) end
	else
		local forced = opts.camera and REVEAL_BY_NAME[opts.camera]
		cam = applyReveal(npc, "CameraEffect", (forced and forced.Compatible(npc) and forced) or pick(candidates(npc, "camera")))
	end

	--- Canal FOTO ---------------------------------------------------------
	local pho
	if npc:GetAttribute("PhotoEffect") ~= nil then
		pho = REVEAL_BY_NAME[npc:GetAttribute("PhotoEffect")]
		if pho then pho.Setup(npc) end
	else
		local forced = opts.photo and REVEAL_BY_NAME[opts.photo]
		pho = applyReveal(npc, "PhotoEffect", (forced and forced.Compatible(npc) and forced) or pick(candidates(npc, "photo")))
	end

	--- Reveal SECUNDARIO apilable (opcional) ------------------------------
	-- El cliente también aplica CameraEffect2 / PhotoEffect2. Añadimos uno
	-- "additive" (no toca cara/billboard) para más variedad/terror.
	local allowSecondary = opts.allowSecondary
	if allowSecondary == nil then allowSecondary = math.random() < 0.35 end
	if allowSecondary then
		local extras = {}
		for _, r in ipairs(candidates(npc, "camera")) do
			if r.additive and (not cam or r.Name ~= cam.Name) then table.insert(extras, r) end
		end
		local second = pick(extras)
		if second and npc:GetAttribute("CameraEffect2") == nil then
			applyReveal(npc, "CameraEffect2", second)
			-- que también luzca en la foto si aplica a ese canal
			if second.photo and npc:GetAttribute("PhotoEffect2") == nil
				and (not pho or pho.Name ~= second.Name) then
				applyReveal(npc, "PhotoEffect2", second)
			end
		end
	end

	return npc:GetAttribute("CameraEffect"), npc:GetAttribute("PhotoEffect")
end

-- Forzado directo (testing / diseño): asigna reveals nombrados a ambos canales.
function AnomalyService:AssignReveal(npc, cameraName, photoName)
	npc:SetAttribute("Skinwalker", true)
	if cameraName then applyReveal(npc, "CameraEffect", REVEAL_BY_NAME[cameraName]) end
	if photoName then applyReveal(npc, "PhotoEffect", REVEAL_BY_NAME[photoName]) end
end

-- Expuesto por si otros servicios quieren consultar el catálogo.
function AnomalyService:GetCompatibleReveals(npc, channel)
	local names = {}
	for _, r in ipairs(candidates(npc, channel or "camera")) do table.insert(names, r.Name) end
	return names
end

function AnomalyService:Init()
	if self._initialized then return end
	self._initialized = true

	-- Al llegar al mostrador, si es impostor lo marcamos (las cámaras/fotos lo delatan).
	PatientService.Arrived.Event:Connect(function(npc)
		if npc:GetAttribute("Fake") == true and not self:IsSkinwalker(npc) then
			self:MarkSkinwalker(npc)
		end
	end)

	-- print("[AnomalyService] inicializado — 9 DisguiseReveals disponibles, asignación por canal (cámara/foto)")
end

return AnomalyService
