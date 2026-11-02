--[[
    TrollSpectatorClient
    Modo espectador de la GUI Troll: Frame.TextLabel muestra el jugador
    espectado actualmente (DisplayName arriba, @Username abajo). Los botones
    "next"/"previous" ciclan entre TODOS los jugadores del server (excepto
    tu mismo). La camara sigue de verdad al jugador (CameraSubject).

    Se activa cuando la ScreenGui Troll pasa a Enabled=true (la abre el boton
    del HUD, ver TrollOpenClient) y se desactiva (restaura tu propia camara)
    cuando se cierra (boton Back, tambien en TrollOpenClient).
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local trollGui = script.Parent
local frame = trollGui:WaitForChild("Frame")
local textLabel = frame:WaitForChild("TextLabel")
local nextBtn = trollGui:WaitForChild("next")
local prevBtn = trollGui:WaitForChild("previous")

-- Sincroniza el target con el server (TrollActionServer) para que los botones
-- de accion (fling/explode/freeze/trip/kill/kick) sepan a quien afectar.
local SetTrollTarget = ReplicatedStorage:WaitForChild("Events"):WaitForChild("SetTrollTarget")

local targets = {}         -- lista estable de jugadores espectables (todos menos LocalPlayer)
local selectedPlayer = nil
local charAddedConn = nil

local function rebuildTargets()
	targets = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			table.insert(targets, p)
		end
	end
	table.sort(targets, function(a, b) return a.UserId < b.UserId end)
end

local function indexOf(player)
	for i, p in ipairs(targets) do
		if p == player then return i end
	end
	return nil
end

local function updateLabel(player)
	if not player then
		textLabel.Text = "Sin jugadores"
		return
	end
	textLabel.Text = player.DisplayName .. string.char(10) .. "@" .. player.Name
end

-- Restaura la camara del jugador a si mismo (modo normal).
local function restoreOwnCamera()
	local camera = Workspace.CurrentCamera
	if not camera then return end
	camera.CameraType = Enum.CameraType.Custom
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	camera.CameraSubject = hum or char or camera.CameraSubject
end

-- Engancha la camara al Humanoid del jugador espectado (y se re-engancha solo
-- si ese jugador respawnea mientras lo estamos espectando).
local function attachCameraTo(player)
	if charAddedConn then
		charAddedConn:Disconnect()
		charAddedConn = nil
	end
	local camera = Workspace.CurrentCamera
	if not (camera and player) then return end

	local function applyChar(char)
		local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
		if hum then
			camera.CameraType = Enum.CameraType.Custom
			camera.CameraSubject = hum
		end
	end

	if player.Character then applyChar(player.Character) end
	charAddedConn = player.CharacterAdded:Connect(applyChar)
end

local function selectCurrent()
	updateLabel(selectedPlayer)
	SetTrollTarget:FireServer(selectedPlayer)
	if selectedPlayer then
		attachCameraTo(selectedPlayer)
	else
		if charAddedConn then
			charAddedConn:Disconnect()
			charAddedConn = nil
		end
		restoreOwnCamera()
	end
end

-- delta = 1 (next) / -1 (previous). Cicla con wraparound; si no habia
-- seleccion, next arranca en el primero y previous en el ultimo.
local function step(delta)
	rebuildTargets()
	if #targets == 0 then
		selectedPlayer = nil
		selectCurrent()
		return
	end
	local idx = selectedPlayer and indexOf(selectedPlayer)
	if not idx then
		idx = (delta > 0) and 0 or 1
	end
	idx = ((idx - 1 + delta) % #targets) + 1
	selectedPlayer = targets[idx]
	selectCurrent()
end

local function stopSpectating()
	selectedPlayer = nil
	selectCurrent()
end

nextBtn.MouseButton1Click:Connect(function() step(1) end)
prevBtn.MouseButton1Click:Connect(function() step(-1) end)

-- Si el jugador espectado se va del server, pasar automaticamente al siguiente.
Players.PlayerRemoving:Connect(function(p)
	if p == selectedPlayer and trollGui.Enabled then
		step(1)
	end
end)

trollGui:GetPropertyChangedSignal("Enabled"):Connect(function()
	if trollGui.Enabled then
		rebuildTargets()
		selectedPlayer = targets[1]
		selectCurrent()
	else
		stopSpectating()
	end
end)