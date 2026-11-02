--[[
	MorphEnvironmentReset

	PROBLEMA: al morfear, el servidor reemplaza el personaje
	(player.Character = newChar). Eso dispara CharacterAdded y la ScreenGui
	CharacterSelection tiene ResetOnSpawn = true -> el PlayerGui la DESTRUYE y la
	vuelve a clonar. El módulo Util.Buttons (que vive en StarterPlayerScripts y NO
	se reinicia) se queda guardando el panel destruido como "display actual", así
	que nunca ejecuta la parte que quita el blur: la pantalla se queda borrosa y
	oscura (Blur grande + Atmosphere.Density 1 / Offset 0.9) hasta reiniciar.

	SOLUCIÓN: cuando el personaje nuevo es un morph (atributo IsMorph), se cierra
	el panel que Buttons cree abierto, se ocultan los frames de la
	CharacterSelection recién clonada y se devuelven Lighting y FOV a los valores
	normales (los que tenía el juego al entrar, antes de tocar ningún menú).
]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local Atmosphere = Lighting:WaitForChild("Atmosphere", 10)
local Blur = Lighting:FindFirstChildOfClass("BlurEffect")

-- Ambiente "normal" = como estaba al entrar al juego.
local DEFAULTS = {
	Blur = Blur and Blur.Size or 0,
	Density = Atmosphere and Atmosphere.Density or 0.4,
	Offset = Atmosphere and Atmosphere.Offset or 0.9,
	FieldOfView = 70,
}

local TWEEN = TweenInfo.new(0.25, Enum.EasingStyle.Linear)

-- Cierra el panel que Util.Buttons todavía cree abierto (puede estar destruido
-- por el ResetOnSpawn; setear .Visible en un instance destruido no rompe nada).
local function closeOpenPanel()
	local ok, Lib = pcall(function()
		return require(ReplicatedStorage:WaitForChild("Lib", 10))
	end)
	if not ok or type(Lib) ~= "table" or not Lib.Buttons then
		return false
	end

	local hadPanel = false
	pcall(function()
		if Lib.Buttons.GetCurrentDisplay() then
			hadPanel = true
			Lib.Buttons.CloseCurrent()
		end
	end)
	return hadPanel
end

-- Oculta los frames de la CharacterSelection nueva (la que clonó el respawn).
local function hideSelectionFrames()
	local gui = LocalPlayer:FindFirstChild("PlayerGui")
	local selection = gui and gui:FindFirstChild("CharacterSelection")
	if not selection then
		return
	end
	for _, frame in ipairs(selection:GetChildren()) do
		if frame:IsA("GuiObject") then
			frame.Visible = false
			local modal = frame:FindFirstChild("modal")
			if modal then
				modal.Modal = false
			end
		end
	end
end

local function restoreEnvironment()
	local hadPanel = closeOpenPanel()
	hideSelectionFrames()

	if hadPanel then
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
	end

	-- Después del tween que dispara CloseCurrent, para que gane el nuestro.
	task.wait(0.2)

	if Blur then
		TweenService:Create(Blur, TWEEN, { Size = DEFAULTS.Blur }):Play()
	end
	if Atmosphere then
		Atmosphere.Density = DEFAULTS.Density
		Atmosphere.Offset = DEFAULTS.Offset
	end

	local camera = workspace.CurrentCamera
	if camera then
		TweenService:Create(camera, TWEEN, { FieldOfView = DEFAULTS.FieldOfView }):Play()
	end
end

-- El atributo IsMorph lo pone el servidor en el modelo antes de parentearlo,
-- pero puede llegar un instante después que CharacterAdded en el cliente.
local function isMorph(char)
	for _ = 1, 20 do
		if char:GetAttribute("IsMorph") then
			return true
		end
		task.wait(0.1)
	end
	return false
end

LocalPlayer.CharacterAdded:Connect(function(char)
	task.spawn(function()
		if isMorph(char) then
			restoreEnvironment()
		end
	end)
end)

if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("IsMorph") then
	task.spawn(restoreEnvironment)
end
