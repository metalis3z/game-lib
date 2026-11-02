--[[
	MiscService  (Fase 2 — props interactivos de Workspace.Misc)

	Muchos models de Misc traen ProximityPrompts sin handler server. Este servicio
	activa los MECÁNICOS/autocontenidos:

	  · SecurityCamPC.PP ("Security Cams")  -> habilita el prompt. El cliente
	    (UI.CameraSystem ya conecta su .Triggered) abre la vista de cámaras CCTV.
	  · ShutterButton ("Locked")            -> abre/cierra las persianas
	    (Misc.Shutters suben/bajan con sus sonidos rise/drop). Texto alterna.
	  · CheckInCounter.Screen               -> display: muestra el nº de paciente
	    actual ("NOW SERVING") cuando alguien llega al mostrador.

	Los props con ECONOMÍA (Gun/ShopItems/Nurse/TaserStation/ExtinguisherStation)
	van en la slice de tienda+herramientas (necesitan cash y tools).

	API: MiscService:Init()
]]

local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")

local PatientService = require(ServerScriptService:WaitForChild("PatientService"))
local SanityService = require(ServerScriptService:WaitForChild("SanityService"))
local ConsumableService = require(ServerScriptService:WaitForChild("ConsumableService"))

local MiscService = {}
local Misc = workspace:WaitForChild("Misc")

--------------------------------------------------------------------------------
-- SecurityCamPC (CCTV) — el cliente ya maneja el .Triggered; solo habilitar
--------------------------------------------------------------------------------
local function setupSecurityCam()
	local spc = Misc:FindFirstChild("SecurityCamPC")
	local prompt = spc and spc:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt then
		prompt.Enabled = true
	end
end

--------------------------------------------------------------------------------
-- ShutterButton -> Shutters (abrir/cerrar)
--------------------------------------------------------------------------------
local function setupShutters()
	local button = Misc:FindFirstChild("ShutterButton")
	local shutters = Misc:FindFirstChild("Shutters")
	local prompt = button and button:FindFirstChildWhichIsA("ProximityPrompt", true)
	if not (prompt and shutters) then return end

	local parts = {}         -- [part] = closedCFrame
	local sounds = { rise = nil, drop = nil }
	for _, d in ipairs(shutters:GetDescendants()) do
		if d:IsA("BasePart") then
			parts[d] = d.CFrame
		elseif d:IsA("Sound") then
			if d.Name == "rise" then sounds.rise = d
			elseif d.Name == "drop" then sounds.drop = d end
		end
	end

	local open = false
	local animating = false
	local TW = TweenInfo.new(1.5, Enum.EasingStyle.Quad)

	prompt.ActionText = "Open Shutters"
	prompt.Triggered:Connect(function()
		if animating then return end
		animating = true
		open = not open
		local snd = open and sounds.rise or sounds.drop
		if snd then snd:Play() end
		for part, closed in pairs(parts) do
			local goal = open and (closed + Vector3.new(0, part.Size.Y - 0.1, 0)) or closed
			TweenService:Create(part, TW, { CFrame = goal }):Play()
		end
		prompt.ActionText = open and "Close Shutters" or "Open Shutters"
		task.wait(TW.Time)
		animating = false
	end)
end

--------------------------------------------------------------------------------
-- CheckInCounter — pantalla de estado
--------------------------------------------------------------------------------
local function setupCounterScreen()
	local counter = Misc:FindFirstChild("CheckInCounter")
	local screen = counter and counter:FindFirstChild("Screen")
	local ui = screen and screen:FindFirstChild("UI")
	local frame = ui and ui:FindFirstChild("Frame")
	if not frame then return end

	local header = frame:FindFirstChild("header")
	local num = frame:FindFirstChild("num")
	local ticket = 0

	if header then header.Text = "READY" end
	if num then num.Text = "-" end

	PatientService.Arrived.Event:Connect(function(npc)
		ticket += 1
		if header then header.Text = "NOW SERVING" end
		if num then num.Text = "#" .. ticket end
	end)
end

--------------------------------------------------------------------------------
-- CoffeeMachine — café que restaura cordura (brew + vapor + cooldown)
--------------------------------------------------------------------------------
local COFFEE_SANITY   = 20  -- cordura que restaura un café
local COFFEE_BREW     = 2   -- s de preparación
local COFFEE_COOLDOWN = 10  -- s de espera tras servir

local function setupCoffeeMachine()
	local machine = Misc:FindFirstChild("CoffeeMachine")
	local coffee = machine and machine:FindFirstChild("Coffee")
	local prompt = coffee and coffee:FindFirstChildWhichIsA("ProximityPrompt", true)
	if not prompt then return end

	local brew  = coffee:FindFirstChild("Brew")
	local ding  = coffee:FindFirstChild("Ding")
	local steam = coffee:FindFirstChild("PE")
	local att   = machine:FindFirstChild("Attachment")
	local ui    = att and att:FindFirstChild("UI")
	local status = ui and ui:FindFirstChild("status")
	local effect = ui and ui:FindFirstChild("effect")

	local function setStatus(t) if status then status.Text = t end end
	local function setEffect(t) if effect then effect.Text = t end end

	setStatus("Ready")
	setEffect("Restores sanity")

	local busy = false
	prompt.ActionText = "Get Coffee"
	prompt.Triggered:Connect(function(player)
		if busy then return end
		busy = true
		prompt.Enabled = false
		setStatus("Brewing...")
		if brew then pcall(function() brew:Play() end) end
		if steam and steam:IsA("ParticleEmitter") then steam.Enabled = true end

		task.wait(COFFEE_BREW)

		if steam and steam:IsA("ParticleEmitter") then steam.Enabled = false end
		if ding then pcall(function() ding:Play() end) end

		if player and player.Parent then
			ConsumableService:Give(player, "Coffee")   -- te llevas el café (Tool) para beberlo
		end
		setStatus("Enjoy!")
		setEffect("Coffee added to your bag")

		task.wait(COFFEE_COOLDOWN)
		setStatus("Ready")
		setEffect("Restores sanity")
		prompt.Enabled = true
		busy = false
	end)
end

--------------------------------------------------------------------------------
function MiscService:Init()
	if self._initialized then return end
	self._initialized = true

	pcall(setupSecurityCam)
	pcall(setupShutters)
	pcall(setupCounterScreen)
	pcall(setupCoffeeMachine)

	-- print("[MiscService] inicializado — CCTV / persianas / pantalla mostrador / café")
end

return MiscService
