--[[
	CheckInService  (Fase 2 — estación de recepción)

	Los models de Workspace.Misc.CheckIn ya traen ProximityPrompts (deshabilitados):
	  Computer   -> "Register"
	  Camera     -> "Take Photo"
	  Printer    -> "Print Badge"
	  PatientBadgeBase / VisitorBadgeBase -> "Take"
	Nadie los manejaba. Este servicio los hace funcionar como un flujo secuencial
	de registro, ligado al paciente que llega al mostrador (PatientService.Arrived):

	  Register -> Take Photo -> Print Badge -> Take (badge de Paciente o Visitante
	  según el atributo IsPatient del NPC) -> check-in completo.

	Solo se habilita un prompt a la vez; el resto quedan deshabilitados. Si el NPC
	se va a mitad, el flujo se aborta y la estación se resetea.

	API: CheckInService:Init()
]]

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local PatientService = require(ServerScriptService:WaitForChild("PatientService"))
local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network   -- para la flecha guía (OffscreenPointer vía "SetPointer")

local CheckInService = {}

local station        -- Workspace.Misc.CheckIn
local prompts = {}   -- { Computer, Camera, Printer, PatientBadge, VisitorBadge }
local busy = false
local activeForm     -- el Form clonado (Misc.Form/Form2) que el NPC "deja"
local activeFormPrompt -- ProximityPrompt usable del Form clonado (primer paso)
local activePhoto    -- la Photo clonada (Misc.Photo/Photo2) que el NPC "deja"
local activeBadge    -- el gafete clonado (Misc.PatientBadge/VisitorBadge) en su posición baked
local stepHighlight  -- Highlight de guía (se crea en Init; el Form que lo tenía fue borrado)
local activePlayer   -- el jugador que está haciendo el check-in (a él le apunta la flecha)

local function getPrompt(modelName)
	local m = station:FindFirstChild(modelName)
	return m and m:FindFirstChildWhichIsA("ProximityPrompt", true)
end

local function disableAll()
	for _, p in pairs(prompts) do
		if p then p.Enabled = false end
	end
end

-- Habilita un prompt y cede hasta que se use; aborta si el NPC se va.
local function useStep(prompt, actionText, npc)
	if not prompt then return true end -- si falta el modelo, no bloquees el flujo
	prompt.ActionText = actionText
	prompt.Enabled = true

	local triggered = false
	local conn = prompt.Triggered:Connect(function(player)
		triggered = true
		if player then activePlayer = player end   -- fija a quién guiar (el que hace el check-in)
	end)

	while not triggered and npc and npc.Parent do
		task.wait()
	end

	conn:Disconnect()
	prompt.Enabled = false
	return triggered
end

-- Da vida a la PANTALLA del Computer al pulsar "Register": barra de progreso,
-- sonidos (dial-up + loading) y el cartel "REGISTERED". Corre en el server y se
-- replica (SurfaceGui/Sounds están en Workspace). Con nil-checks para que, si
-- falta alguna parte del modelo, el flujo de check-in no se rompa.
local function playComputerRegister()
	local computer = station and station:FindFirstChild("Computer")
	local screen = computer and computer:FindFirstChild("Screen")
	local ui = screen and screen:FindFirstChild("UI")
	if not ui then return end

	local regFrame  = ui:FindFirstChild("Frame")
	local regBar    = regFrame and regFrame:FindFirstChild("Frame")
	local doneLabel = ui:FindFirstChild("Label")
	local dialUp    = screen:FindFirstChild("Internet Dial Up Sound")
	local loading   = ui:FindFirstChild("ui_loading")
	local confirm   = screen:FindFirstChild("Audio/confirmation_004")

	-- estado inicial
	if doneLabel then doneLabel.Visible = false end
	if regBar then regBar.Size = UDim2.new(0.075, -6, 1, -6) end
	if regFrame then regFrame.Visible = true end
	if dialUp then pcall(function() dialUp:Play() end) end
	if loading then pcall(function() loading:Play() end) end

	-- tecleo en el teclado (sonido Push del Keyboard, antes sin usar)
	local kb = computer:FindFirstChild("Keyboard")
	local push = kb and kb:FindFirstChild("Push", true)
	if push then
		task.spawn(function()
			for _ = 1, 7 do
				pcall(function() push:Play() end)
				task.wait(0.16)
			end
		end)
	end

	-- barra 7.5% -> 100%
	if regBar then
		local tween = TweenService:Create(regBar,
			TweenInfo.new(1.4, Enum.EasingStyle.Linear),
			{ Size = UDim2.new(1, -6, 1, -6) })
		tween:Play()
		tween.Completed:Wait()
	else
		task.wait(1.4)
	end

	-- registrado
	if regFrame then regFrame.Visible = false end
	if doneLabel then doneLabel.Visible = true end
	if confirm then pcall(function() confirm:Play() end) end
	task.wait(1)
	if doneLabel then doneLabel.Visible = false end
end

-- Destello de la cámara al pulsar "Take Photo": prende el SpotLight `Flash` y
-- suena `Camera flash sound effect`. Server-side, se replica. nil-safe.
local function playCameraFlash()
	local camera = station and station:FindFirstChild("Camera")
	local handle = camera and camera:FindFirstChild("Handle")
	if not handle then return end
	local flash = handle:FindFirstChild("Flash")
	local sound = handle:FindFirstChild("Camera flash sound effect")
	if sound then pcall(function() sound:Play() end) end
	if flash and flash:IsA("Light") then
		flash.Enabled = true
		task.wait(0.12)
		flash.Enabled = false
	else
		task.wait(0.12)
	end
end

-- Campanilla al llegar el paciente al mostrador: sonido + partícula.
local function ringBell()
	local bell = station and station:FindFirstChild("Bell")
	local mesh = bell and bell:FindFirstChild("Primary Mesh")
	if not mesh then return end
	local snd = mesh:FindFirstChild("BellSound") or mesh:FindFirstChild("Sound")
	if snd then pcall(function() snd:Play() end) end
	local beats = mesh:FindFirstChild("Beats")
	if beats and beats:IsA("ParticleEmitter") then pcall(function() beats:Emit(12) end) end
end

-- Sonidos de impresión al pulsar "Print Badge".
local function playPrinter()
	local printer = station and station:FindFirstChild("Printer")
	local body = printer and printer:FindFirstChild("Printer")
	if not body then task.wait(0.8); return end
	for _, n in ipairs({ "Printer Start 2 (SFX)", "Computer Printer 2 (SFX)", "beep-1" }) do
		local s = body:FindFirstChild(n)
		if s then pcall(function() s:Play() end) end
	end
	task.wait(1.2)
end

-- Luz verde del Printer (Printer.Printer.green): se enciende (Transparency 0) cuando
-- el gafete ya está impreso, y se apaga (1) al reiniciar/terminar el flujo.
local function setPrinterLight(on)
	local printer = station and station:FindFirstChild("Printer")
	local body = printer and printer:FindFirstChild("Printer")
	local green = body and body:FindFirstChild("green")
	if green and green:IsA("BasePart") then
		green.Transparency = on and 0 or 1
	end
end

-- Gafete: escribe el nombre del NPC en el Tag y suena el papel al retirarlo.
local function badgeBaseFor(isPatient)
	return station and station:FindFirstChild(isPatient and "PatientBadgeBase" or "VisitorBadgeBase")
end

local function setBadgeName(isPatient, name)
	local base = badgeBaseFor(isPatient)
	local tag = base and base:FindFirstChild("Tag")
	local ui = tag and tag:FindFirstChild("UI")
	local label = ui and ui:FindFirstChild("Label")
	if label and label:IsA("TextLabel") then label.Text = name or "" end
end

local function playBadgeTake(isPatient)
	local base = badgeBaseFor(isPatient)
	local paper = base and base:FindFirstChild("Paper", true)
	if paper then pcall(function() paper:Play() end) end
end

-- Golpe fantasma en el vidrio de recepción (scare de baja probabilidad). Muestra
-- la grieta un momento y la restaura (captura su transparencia original: seguro).
local function maybeWindowKnock()
	if math.random() > 0.22 then return end
	local window = station and station:FindFirstChild("Window")
	local glass = window and window:FindFirstChild("Glass")
	if not glass then return end
	for _, n in ipairs({ "Thud1", "SuspenseHit" }) do
		local s = glass:FindFirstChild(n)
		if s then pcall(function() s:Play() end) end
	end
	local decal = glass:FindFirstChild("Cracked glass")
	if decal and decal:IsA("Decal") then
		local orig = decal.Transparency
		decal.Transparency = 0
		task.delay(2.5, function()
			if decal and decal.Parent then decal.Transparency = orig end
		end)
	end
end

-- Guía visual: adorna el Highlight reusable (creado en Init) a la INSTANCIA del
-- paso actual (prop o el Form clonado). nil -> apaga la guía.
local function highlightInstance(inst)
	if not stepHighlight then return end
	if inst then
		stepHighlight.Adornee = inst
		stepHighlight.Enabled = true
	else
		stepHighlight.Adornee = nil
		stepHighlight.Enabled = false
	end
end

local function highlightStep(propName)
	highlightInstance(propName and station:FindFirstChild(propName))
end

-- La flecha (OffscreenPointer) exige un Model con PrimaryPart. Se lo aseguramos.
local function ensurePrimary(model)
	if not (model and model:IsA("Model")) then return nil end
	if not model.PrimaryPart then
		local part = model:FindFirstChildWhichIsA("BasePart", true)
		if not part then return nil end
		model.PrimaryPart = part
	end
	return model
end

-- Guía al jugador que hace el check-in: mueve su flecha al Model del paso actual y
-- muestra el TEXTO del objetivo (silencioso). model/text nil = apaga flecha y texto.
local function guideTo(model, text)
	if not activePlayer then return end
	Network:FireClient(activePlayer, "SetObjective", text or "", true, ensurePrimary(model))
end

-- Resalta, apunta la flecha y pone el texto del paso (por nombre). nil = apaga todo.
local function guideStep(propName, text)
	highlightStep(propName)
	guideTo(propName and station:FindFirstChild(propName), text)
end

-- El NPC "deja" su formulario: clona ReplicatedStorage.Misc.Form al mostrador. La
-- plantilla conserva su posición del mostrador (patrón del leak), así que aparece
-- en su sitio sin reposicionar. Se ve una instancia nueva "ActiveForm" en Workspace.
-- Clona una plantilla de Misc al mostrador (sin scripts/prompts, anclada). Las
-- plantillas conservan su posición baked: Form/Photo -> checkIn, Form2/Photo2 -> checkIn2.
-- Clona una plantilla de Misc al mostrador (sin scripts; prompts opcional). Las
-- plantillas conservan su posición baked: Form/Photo -> checkIn, Form2/Photo2 -> checkIn2.
local function clonePropTo(templateName, keepPrompts)
	local misc = ReplicatedStorage:FindFirstChild("Misc")
	local template = misc and misc:FindFirstChild(templateName)
	if not (template and station) then return nil end
	local clone = template:Clone()
	for _, d in ipairs(clone:GetDescendants()) do
		if d:IsA("BaseScript") then
			d:Destroy()
		elseif d:IsA("ProximityPrompt") and not keepPrompts then
			d:Destroy()
		end
	end
	for _, d in ipairs(clone:GetDescendants()) do
		if d:IsA("BasePart") then d.Anchored = true; d.CanCollide = false end
	end
	clone.Parent = station
	return clone
end

-- El NPC deja su FORMULARIO al llegar (Form/Form2). Deja un ProximityPrompt USABLE
-- sobre una parte del form (el del template cuelga del Model y no renderiza).
local function dropForm(npc)
	if activeForm then activeForm:Destroy() end
	activeFormPrompt = nil
	local n = npc:GetAttribute("CheckInStation") or 1
	activeForm = clonePropTo(n == 2 and "Form2" or "Form", true)
	if not activeForm then return end
	activeForm.Name = "ActiveForm"

	local part = activeForm:FindFirstChild("Paper") or activeForm:FindFirstChildWhichIsA("BasePart", true)
	local pp = activeForm:FindFirstChildWhichIsA("ProximityPrompt", true)
	if part then
		if not pp then pp = Instance.new("ProximityPrompt") end
		pp.Parent = part
		pp.MaxActivationDistance = 10
		pp.RequiresLineOfSight = false
		pp.Enabled = false
		activeFormPrompt = pp

		-- Al ACTIVAR el prompt del form, apaga su CheckStepHighlight (el highlight
		-- baked que el Form trae de Misc.Form; sin esto queda encendido hasta que
		-- el form se destruye).
		local formHighlight = activeForm:FindFirstChild("CheckStepHighlight", true)
		if formHighlight then
			pp.Triggered:Connect(function()
				formHighlight.Enabled = false
			end)
		end
	end
end

-- Textura de cara del NPC (rig custom Head.002 / rig normal Face) para la foto.
local function npcFaceTexture(npc)
	for _, name in ipairs({ "Head.002", "Face" }) do
		local p = npc:FindFirstChild(name, true)
		if p and p:IsA("MeshPart") and p.TextureID ~= "" then return p.TextureID end
		if p then
			local dec = p:FindFirstChildWhichIsA("Decal")
			if dec and dec.Texture ~= "" then return dec.Texture end
		end
	end
	local head = npc:FindFirstChild("Head")
	local hdec = head and head:FindFirstChildWhichIsA("Decal")
	if hdec and hdec.Texture ~= "" then return hdec.Texture end
	return nil
end

-- La FOTO aparece al usar la Camera (Photo/Photo2) con la CARA del NPC en la Picture.
-- CONSERVA su PP: la plantilla está tageada "Inspect" y UI.InspectLocal hace `p1.PP`
-- (hijo directo del Model) -> si le quito el PP, InspectLocal:71 crashea (desconexión).
-- Así el prompt de "Inspect" sale en la PHOTO (como pediste), no en el NPC.
local function dropPhoto(npc)
	if activePhoto then activePhoto:Destroy() end
	local n = npc:GetAttribute("CheckInStation") or 1
	activePhoto = clonePropTo(n == 2 and "Photo2" or "Photo", true)  -- keepPrompts (Inspect)
	if not activePhoto then return end
	activePhoto.Name = "ActivePhoto"

	-- Ya NO lo maneja InspectLocal: el PP de la Photo dispara la PhotoUI (viewport
	-- 3D del NPC + skinwalker reveal), no el hold físico. Quitamos el tag Inspect.
	CollectionService:RemoveTag(activePhoto, "Inspect")

	local pic = activePhoto:FindFirstChild("Picture")
	if pic and pic:IsA("BasePart") then
		if not activePhoto.PrimaryPart then activePhoto.PrimaryPart = pic end
		-- la cara del NPC en la foto física del mostrador
		local tex = npcFaceTexture(npc)
		if tex then
			for _, face in ipairs({ Enum.NormalId.Front, Enum.NormalId.Back }) do
				local decal = Instance.new("Decal")
				decal.Face = face
				decal.Texture = tex
				decal.Parent = pic
			end
		end
		-- PP sobre la Picture -> abre la PhotoUI con el modelo 3D del NPC.
		local pp = activePhoto:FindFirstChildWhichIsA("ProximityPrompt", true)
		if pp then
			pp.Parent = pic
			pp.ActionText = "View Photo"
			pp.Enabled = true
			pp.Triggered:Connect(function(player)
				local PhotoService = require(ServerScriptService:WaitForChild("PhotoService"))
				PhotoService:TakePhoto(player, npc)
			end)
		end
	end
end

-- Quita lo que el NPC dejó (form + foto) al terminar/abortar.
local function removeForm()
	if activeForm then activeForm:Destroy(); activeForm = nil end
	if activePhoto then activePhoto:Destroy(); activePhoto = nil end
	if activeBadge then activeBadge:Destroy(); activeBadge = nil end
	activeFormPrompt = nil
end

-- Offset del gafete en el pecho del NPC (ajustable si queda mal colocado).
local BADGE_OFFSET = CFrame.new(0, 0.4, -0.6)

-- Cuánto SALE el gafete de su base al estar listo (studs en X, mundo). El diseñador
-- lo quiere ~ -1.5 en X (de -96.747 sale a ~ -98.075). Ajustable.
local BADGE_SLIDE = Vector3.new(-1.5, 0, 0)
local badgeHome = {}   -- CFrame original de cada base (para devolverla a su sitio)

-- Desliza suavemente la base del gafete: out=true la saca a su posición "listo",
-- out=false la devuelve a su sitio original. La base está anclada (teleport rígido).
local function slideBadgeBase(base, out)
	if not base then return end
	ensurePrimary(base)   -- pivote consistente (PrimaryPart) para sacar y devolver exacto
	local home = badgeHome[base]
	if not home then
		home = base:GetPivot()
		badgeHome[base] = home
	end
	local target = out and (home + BADGE_SLIDE) or home
	local startPos = base:GetPivot().Position
	local targetPos = target.Position
	for i = 1, 12 do
		base:PivotTo(home.Rotation + startPos:Lerp(targetPos, i / 12))
		task.wait(0.02)
	end
	base:PivotTo(target)
end

-- Clona el gafete (Misc.PatientBadge/VisitorBadge, con sufijo "2" en el checkin2) a su
-- POSICIÓN BAKED del mostrador, con el nombre del NPC. Ya NO se lo suelda al NPC.
local function giveBadge(npc, isPatient)
	if activeBadge then activeBadge:Destroy(); activeBadge = nil end
	local n = npc:GetAttribute("CheckInStation") or 1
	local base = isPatient and "PatientBadge" or "VisitorBadge"
	local misc = ReplicatedStorage:FindFirstChild("Misc")
	local name = (n == 2 and misc and misc:FindFirstChild(base .. "2")) and (base .. "2") or base
	local badge = clonePropTo(name, false)   -- a su posición baked, anclado, sin scripts/prompts
	if not badge then return end
	badge.Name = "ActiveBadge"
	activeBadge = badge

	local tag = badge:FindFirstChild("Tag")
	local ui = tag and tag:FindFirstChild("UI")
	local label = ui and ui:FindFirstChild("Label")
	if label and label:IsA("TextLabel") then
		label.Text = npc:GetAttribute("DisplayName") or npc.Name
	end
end

-- Crea UN ProximityPrompt sobre el NPC (p.ej. "Talk"). ActionText por parámetro.
local function makeNpcPrompt(npc, actionText)
	local root = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
	if not root then return nil end
	local pp = Instance.new("ProximityPrompt")
	pp.ActionText = actionText or "Talk"
	pp.ObjectText = npc:GetAttribute("DisplayName") or npc.Name
	pp.MaxActivationDistance = 10
	pp.RequiresLineOfSight = false
	pp.HoldDuration = 0.5
	pp.Enabled = false
	pp.Parent = root
	return pp
end

-- Sellar el formulario: sonido de papel + sello (del Form CLONADO por el NPC).
local function playFormStamp()
	local paperPart = activeForm and activeForm:FindFirstChild("Paper")
	if not paperPart then return end
	local paper = paperPart:FindFirstChild("Paper")
	local stamp = paperPart:FindFirstChild("Stamp Sound")
	if paper then pcall(function() paper:Play() end) end
	task.wait(0.25)
	if stamp then pcall(function() stamp:Play() end) end
	task.wait(0.4)
end

local function runFlow(npc)
	if busy then return end
	busy = true
	disableAll()
	activePlayer = nil  -- se fija cuando alguien activa el primer prompt (el form)
	setPrinterLight(false)  -- luz verde apagada hasta que el gafete se imprima

	ringBell()          -- campanilla de llegada
	maybeWindowKnock()  -- posible golpe en el vidrio (scare)

	-- Paso 1: el NPC deja su FORMULARIO (con prompt). Se resalta y lo revisas.
	dropForm(npc)
	highlightInstance(activeForm)
	playFormStamp()      -- papel al dejar el formulario
	local completed = npc.Parent ~= nil
	completed = completed and useStep(activeFormPrompt, "Review Form", npc)

	-- Paso 2: foto en la Camera -> aparece la Photo con la CARA del NPC.
	if completed then guideStep("Camera", "Take the photo") end
	completed = completed and useStep(prompts.Camera, "Take Photo", npc)
	if completed then
		playCameraFlash()               -- destello + sonido de la cámara
		dropPhoto(npc)                  -- la foto (con la cara del NPC) aparece
		completed = npc.Parent ~= nil
	end

	-- Paso 3: registrar en el Computer (con la foto).
	if completed then guideStep("Computer", "Register the patient") end
	completed = completed and useStep(prompts.Computer, "Register", npc)
	if completed then
		playComputerRegister()          -- feedback en la pantalla del PC
		completed = npc.Parent ~= nil
	end

	-- Paso 3: imprimir el gafete en la Printer.
	if completed then guideStep("Printer", "Print the badge") end
	completed = completed and useStep(prompts.Printer, "Print Badge", npc)
	if completed then
		playPrinter()                   -- sonidos de impresión
		setPrinterLight(true)           -- gafete impreso -> luz verde encendida
		completed = npc.Parent ~= nil
	end

	-- Paso 4: el gafete SALE de su base (se desliza) y se activa SU ProximityPrompt
	-- para tomarlo; al tomarlo se lo pones al NPC (visitor/patient) y la base vuelve.
	if completed then
		local isPatient = npc:GetAttribute("IsPatient") == true
		local base = badgeBaseFor(isPatient)
		local basePrompt = base and base:FindFirstChildWhichIsA("ProximityPrompt", true)
		if basePrompt then
			basePrompt.MaxActivationDistance = 10
			basePrompt.RequiresLineOfSight = false
		end
		slideBadgeBase(base, true)                 -- la base sale a su posición "listo"
		highlightInstance(base)                    -- resalta la base del gafete
		guideTo(base, "Take the badge")            -- flecha + objetivo -> base del gafete
		completed = useStep(basePrompt, "Take Badge", npc)
		slideBadgeBase(base, false)                -- la base vuelve a su sitio
		if completed then
			playBadgeTake(isPatient)
			giveBadge(npc, isPatient)               -- le pega el gafete al NPC
		end
	end

	-- Paso 5: hablar con el visitor. Solo UN prompt "Talk" en el NPC (apagamos
	-- cualquier otro prompt suyo, p.ej. Inspect). Al activarlo -> se va a su Room.
	if completed then
		for _, d in ipairs(npc:GetDescendants()) do
			if d:IsA("ProximityPrompt") then d.Enabled = false end
		end
		local talkPrompt = makeNpcPrompt(npc, "Talk")
		highlightInstance(npc)
		guideTo(npc, "Talk to the visitor")
		completed = useStep(talkPrompt, "Talk", npc)
		if talkPrompt then talkPrompt:Destroy() end
	end

	guideStep(nil)      -- apaga la guía (highlight + flecha) al terminar/abortar
	setPrinterLight(false)  -- apaga la luz verde
	removeForm()        -- quita el Form clonado del mostrador
	disableAll()
	busy = false

	-- restaura el objetivo del turno ("Heal patients") para quien hizo el check-in
	if activePlayer then
		require(ServerScriptService:WaitForChild("ShiftService")):PushObjectiveTo(activePlayer)
	end

	if completed and npc and npc.Parent then
		PatientService:CompleteCheckIn(npc)
	end
end

function CheckInService:Init()
	if self._initialized then return end
	self._initialized = true

	station = workspace.Misc:FindFirstChild("CheckIn")
	if not station then
		warn("[CheckInService] no existe Workspace.Misc.CheckIn")
		return
	end

	prompts.Form = getPrompt("Form")
	prompts.Computer = getPrompt("Computer")
	prompts.Camera = getPrompt("Camera")
	prompts.Printer = getPrompt("Printer")
	prompts.PatientBadge = getPrompt("PatientBadgeBase")
	prompts.VisitorBadge = getPrompt("VisitorBadgeBase")
	-- Highlight de guía: usa la plantilla del diseñador (Misc.CheckStepHighlight)
	-- con sus propiedades (morado, Occluded). Si falta, uno básico de respaldo.
	local hlTemplate = ReplicatedStorage.Misc:FindFirstChild("CheckStepHighlight")
	stepHighlight = hlTemplate and hlTemplate:Clone() or Instance.new("Highlight")
	stepHighlight.Name = "CheckStepHighlight"
	stepHighlight.Adornee = nil
	stepHighlight.Enabled = false
	stepHighlight.Parent = station

	disableAll()
	highlightStep(nil)  -- la guía arranca apagada (se prende en cada paso)

	PatientService.Arrived.Event:Connect(function(npc)
		task.spawn(runFlow, npc)
	end)

	print("[CheckInService] inicializado — estación de check-in activa")
end

return CheckInService
