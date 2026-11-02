-- ExtraOpenClient
-- Muestra el boton "Extra" a quien tenga el ExtraPanel desbloqueado y con el
-- lo abre y lo cierra.
--
-- ClaraSigm1 lo ve al entrar; el resto recien cuando cumple los 10 minutos del
-- cartel de Workspace.Event. En ese momento el panel ademas se abre solo, para
-- que se note que lo gano.
--
-- Ojo: esto es cosmetico. El que decide de verdad es ExtraPanelWeatherServer.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Access = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ExtraPanelAccess"))

local button = script.Parent
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GROW_INFO = TweenInfo.new(0.1, Enum.EasingStyle.Sine)
local scale = button:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", button)

button.MouseEnter:Connect(function()
	TweenService:Create(scale, GROW_INFO, { Scale = 1.05 }):Play()
end)
button.MouseLeave:Connect(function()
	TweenService:Create(scale, GROW_INFO, { Scale = 1 }):Play()
end)
button.MouseButton1Down:Connect(function()
	TweenService:Create(scale, GROW_INFO, { Scale = 0.9 }):Play()
end)
button.MouseButton1Up:Connect(function()
	TweenService:Create(scale, GROW_INFO, { Scale = 1 }):Play()
end)

local function panel()
	-- lo buscamos en el momento: el panel tiene ResetOnSpawn = false, pero este
	-- boton se vuelve a clonar en cada respawn y la referencia vieja moriria.
	return playerGui:FindFirstChild("ExtraPanel")
end

button.MouseButton1Click:Connect(function()
	if not Access.canUse(player) then
		return
	end
	local gui = panel()
	if gui then
		gui.Enabled = not gui.Enabled
	end
end)

local wasAllowed = false
local firstRun = true

local function refresh()
	local allowed = Access.canUse(player)
	button.Visible = allowed

	-- al pasar de bloqueado a desbloqueado, abrirle el panel una sola vez.
	-- firstRun evita que se le abra solo a ClaraSigm1 apenas entra (y en
	-- cada respawn, porque TrollButton tiene ResetOnSpawn = true).
	if allowed and not wasAllowed and not firstRun then
		local gui = panel()
		if gui then
			gui.Enabled = true
		end
	end
	wasAllowed = allowed
	firstRun = false
end

player:GetAttributeChangedSignal(Access.UnlockedAttribute):Connect(refresh)
refresh()
