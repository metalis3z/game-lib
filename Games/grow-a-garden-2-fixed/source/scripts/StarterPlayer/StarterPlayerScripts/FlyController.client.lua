--credit to leon games studio
--[[
	FlyController  (MODDED, cliente)
	Ejecuta el vuelo cuando el server (FlyAdminCommand) lo autoriza por FlyRemote.
	El server ya valida el UserId, así que aquí solo obedecemos el toggle.

	Controles mientras vuelas:
		W/A/S/D  -> mover según la cámara
		Espacio  -> subir
		Shift/Ctrl izquierdo -> bajar
	La velocidad sube mientras mantengas el movimiento (hasta MAX_SPEED).
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local FlyRemote = ReplicatedStorage:WaitForChild("FlyRemote")

local BASE_SPEED = 50    -- studs/seg al empezar a moverte
local MAX_SPEED = 220    -- tope al mantener el movimiento
local ACCEL = 120        -- studs/seg de aceleración

local flying = false
local conn: RBXScriptConnection? = nil
local bv: BodyVelocity? = nil
local bg: BodyGyro? = nil
local currentSpeed = BASE_SPEED

local function getParts()
	local char = LocalPlayer.Character
	if not char then
		return nil, nil
	end
	return char:FindFirstChild("HumanoidRootPart"), char:FindFirstChildOfClass("Humanoid")
end

local function stopFly()
	flying = false
	currentSpeed = BASE_SPEED
	if conn then
		conn:Disconnect()
		conn = nil
	end
	if bv then
		bv:Destroy()
		bv = nil
	end
	if bg then
		bg:Destroy()
		bg = nil
	end
	local _, hum = getParts()
	if hum then
		hum.PlatformStand = false
	end
end

local function startFly()
	local root, hum = getParts()
	if not root or not hum then
		return
	end
	if flying then
		return
	end
	flying = true
	currentSpeed = BASE_SPEED
	hum.PlatformStand = true

	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1, 1, 1) * 1e6
	bv.Velocity = Vector3.zero
	bv.Parent = root

	bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(1, 1, 1) * 1e6
	bg.P = 1e4
	bg.CFrame = root.CFrame
	bg.Parent = root

	conn = RunService.RenderStepped:Connect(function(dt)
		if not flying or not bv or not bg then
			return
		end
		local r = getParts()
		if not r then
			return
		end
		local cam = workspace.CurrentCamera
		local dir = Vector3.zero

		-- no mover si estás escribiendo en el chat / un TextBox
		if not UserInputService:GetFocusedTextBox() then
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				dir -= Vector3.new(0, 1, 0)
			end
		end

		if dir.Magnitude > 0 then
			currentSpeed = math.min(MAX_SPEED, currentSpeed + ACCEL * dt)
			bv.Velocity = dir.Unit * currentSpeed
		else
			currentSpeed = BASE_SPEED
			bv.Velocity = Vector3.zero
		end
		bg.CFrame = cam.CFrame
	end)
end

FlyRemote.OnClientEvent:Connect(function(enabled)
	if enabled == nil then
		if flying then stopFly() else startFly() end
	elseif enabled then
		startFly()
	else
		stopFly()
	end
end)

-- al morir/respawnear se pierde el BodyVelocity (era del personaje viejo): limpiar.
LocalPlayer.CharacterAdded:Connect(function()
	stopFly()
end)
