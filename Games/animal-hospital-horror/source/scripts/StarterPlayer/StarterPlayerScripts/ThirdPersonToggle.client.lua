-- ThirdPersonToggle
-- Presiona F (o el botón en mobile) para alternar entre:
--   * Tercera persona con mouse LIBRE (cursor normal, camara como el Roblox normal)
--   * Primera persona ORIGINAL del juego (mira/crosshair, camara pegada)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Cursor original del juego (la mira). Si el juego lo cambia, ajusta este id.
local ORIGINAL_CURSOR = "http://www.roblox.com/asset/?id=11514440775"
-- Zoom de la tercera persona al presionar F
local THIRD_PERSON_DISTANCE = 12   -- que tan lejos sale la camara
local THIRD_PERSON_MAX      = 20   -- igual al max original del juego
local inThirdPerson = false

-- Deteccion simple de mobile: tiene touch pero no mouse/teclado fisico
local isMobile = UserInputService.TouchEnabled
	and not UserInputService.MouseEnabled
	and not UserInputService.KeyboardEnabled

local function getMouse()
	return LocalPlayer:GetMouse()
end

local function enterThirdPerson()
	inThirdPerson = true
	LocalPlayer.CameraMode = Enum.CameraMode.Classic
	-- Forzar la camara a salir a tercera persona
	LocalPlayer.CameraMinZoomDistance = THIRD_PERSON_DISTANCE
	LocalPlayer.CameraMaxZoomDistance = THIRD_PERSON_MAX
	-- Mouse libre y cursor normal (flecha)
	UserInputService.MouseIconEnabled = true
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	local m = getMouse()
	if m then
		m.Icon = ""
	end
end

local function enterFirstPerson()
	inThirdPerson = false
	-- Volver al estado original: mira + camara pegada en primera persona
	local m = getMouse()
	if m then
		m.Icon = ORIGINAL_CURSOR
	end
	LocalPlayer.CameraMode = Enum.CameraMode.Classic
	-- Snap hacia adentro (primera persona) jalando el zoom al minimo por un frame
	LocalPlayer.CameraMinZoomDistance = 0.5
	LocalPlayer.CameraMaxZoomDistance = 0.5
	task.wait()
	-- Restaurar el rango original para que el scroll siga funcionando como en el juego
	LocalPlayer.CameraMaxZoomDistance = THIRD_PERSON_MAX
end

local function toggleCamera()
	if inThirdPerson then
		enterFirstPerson()
	else
		enterThirdPerson()
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	-- Ignorar si el juego ya proceso la tecla (chat, ProximityPrompt de Foto, etc.)
	if gameProcessed then
		return
	end
	if input.KeyCode == Enum.KeyCode.F then
		toggleCamera()
	end
end)

-- Si el personaje reaparece mientras estabas en tercera persona, reaplicar
LocalPlayer.CharacterAdded:Connect(function()
	if inThirdPerson then
		task.wait(0.5)
		enterThirdPerson()
	end
end)

-- ==== Soporte de boton mobile ====
local function setupMobileButton()
	local mobileButtonsGui = PlayerGui:WaitForChild("MOBILE_BUTTONS", 10)
	if not mobileButtonsGui then
		warn("ThirdPersonToggle: no se encontro MOBILE_BUTTONS en PlayerGui")
		return
	end

	-- Solo mostrar el ScreenGui completo si el usuario esta en mobile
	mobileButtonsGui.Enabled = isMobile

	if not isMobile then
		return
	end

	local camFolder = mobileButtonsGui:WaitForChild("Cam", 10)
	local baseButton = camFolder and camFolder:WaitForChild("Base", 10)

	if not baseButton then
		warn("ThirdPersonToggle: no se encontro Cam > Base en MOBILE_BUTTONS")
		return
	end

	baseButton.Activated:Connect(function()
		toggleCamera()
	end)
end

setupMobileButton()