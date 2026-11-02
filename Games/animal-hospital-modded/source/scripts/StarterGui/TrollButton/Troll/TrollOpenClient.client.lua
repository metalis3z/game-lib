-- TrollOpenClient
-- Boton "Troll": hover-grow (inline, sin depender de ButtonAnimation del juego
-- de origen -- esa depende a su vez de TweenFOV/TweenUIStrokes/Notification/
-- RemoteGUI/SoundService.Game.SFX, nada de eso existe en este juego) y al
-- pulsarlo esconde TODAS las demas ScreenGuis (recordando su Enabled previo) y
-- muestra la ScreenGui "Troll". El boton "Back" DENTRO de esa GUI restaura
-- exactamente el estado que tenian antes (no fuerza todo a true).
-- Tambien aplica hover-grow a todos los botones (GuiButton) dentro de la GUI Troll.

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local trollButton = script.Parent
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local trollGui = playerGui:WaitForChild("Troll")

local GROW_INFO = TweenInfo.new(0.1, Enum.EasingStyle.Sine)

local function hoverGrow(button)
	local scale = button:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", button)
	button.MouseEnter:Connect(function()
		TweenService:Create(scale, GROW_INFO, { Scale = 1.05 }):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(scale, GROW_INFO, { Scale = 1 }):Play()
	end)
	button.MouseButton1Down:Connect(function()
		TweenService:Create(scale, GROW_INFO, { Scale = 0.85 }):Play()
	end)
	button.MouseButton1Up:Connect(function()
		TweenService:Create(scale, GROW_INFO, { Scale = 1 }):Play()
	end)
end

hoverGrow(trollButton)

-- Hover-grow para TODOS los botones dentro de la GUI Troll (next/previous/Back
-- + fling/explode/freeze/kill/trip/kick en TrollFrame y ServerTrollFrame).
for _, d in ipairs(trollGui:GetDescendants()) do
	if d:IsA("GuiButton") then
		hoverGrow(d)
	end
end

local savedStates = nil

local function openTroll()
	if trollGui.Enabled then return end
	savedStates = {}
	for _, gui in ipairs(playerGui:GetChildren()) do
		if gui:IsA("ScreenGui") and gui ~= trollGui then
			savedStates[gui] = gui.Enabled
			gui.Enabled = false
		end
	end
	trollGui.Enabled = true
end

local function closeTroll()
	trollGui.Enabled = false
	if savedStates then
		for gui, wasEnabled in pairs(savedStates) do
			if gui.Parent then
				gui.Enabled = wasEnabled
			end
		end
		savedStates = nil
	end
end

trollButton.MouseButton1Click:Connect(openTroll)

local backButton = trollGui:WaitForChild("Back")
backButton.MouseButton1Click:Connect(closeTroll)
