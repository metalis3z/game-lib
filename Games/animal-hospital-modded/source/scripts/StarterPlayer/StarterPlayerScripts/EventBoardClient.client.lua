-- EventBoardClient
-- Maneja todo el cartel de Workspace.Event:
--   rainbow sobre TODO el modelo (Board, build y los TextLabel de adentro)
--   Timer -> cuenta regresiva de los 10 minutos que desbloquean el ExtraPanel
--
-- Vive en StarterPlayerScripts y no colgado del Board porque:
--   a) un LocalScript dentro de Workspace no corre, y
--   b) el timer es POR JUGADOR, asi que cada uno tiene que ver su propio numero
--      en el mismo cartel. Pintarlo desde el server mostraria un solo valor
--      para todos.
--
-- El rainbow tambien va del lado del cliente a proposito: hacerlo en el server
-- replicaria un Color nuevo a todos los jugadores en cada frame. Como el tono
-- sale de GetServerTimeNow (mismo reloj para todos), igual todos ven el mismo
-- color al mismo tiempo, sin gastar red.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Access = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ExtraPanelAccess"))

local player = Players.LocalPlayer

local event = workspace:WaitForChild("Event")
local board = event:WaitForChild("Board")
local root = board:WaitForChild("SurfaceGui"):WaitForChild("Frame")
local timerLabel = root:WaitForChild("RewardsFrame"):WaitForChild("Timer")

-- El label ya venia con el prefijo "Timer:", lo respetamos.
local TIMER_PREFIX = "Timer: "
local RAINBOW_PERIOD = 5 -- segundos para dar la vuelta entera al arcoiris

----------------------------------------------------------------------
-- Rainbow
----------------------------------------------------------------------

local parts = {}
local labels = {}

local function collect()
	table.clear(parts)
	table.clear(labels)
	for _, d in ipairs(event:GetDescendants()) do
		if d:IsA("BasePart") then
			table.insert(parts, d)
		elseif d:IsA("TextLabel") or d:IsA("TextButton") then
			table.insert(labels, { label = d, stroke = d:FindFirstChildOfClass("UIStroke") })
		end
	end
end

collect()

-- si mas adelante agregan o sacan piezas del cartel, la lista se rearma sola.
-- El defer es porque DescendantRemoving avisa ANTES de que se vaya el hijo.
event.DescendantAdded:Connect(function()
	task.defer(collect)
end)
event.DescendantRemoving:Connect(function()
	task.defer(collect)
end)

RunService.RenderStepped:Connect(function()
	local hue = (workspace:GetServerTimeNow() % RAINBOW_PERIOD) / RAINBOW_PERIOD
	local bright = Color3.fromHSV(hue, 1, 1)
	-- el contorno va media vuelta atras para que el texto no se pierda
	local outline = Color3.fromHSV((hue + 0.5) % 1, 1, 0.35)

	for _, part in ipairs(parts) do
		part.Color = bright
	end
	for _, entry in ipairs(labels) do
		entry.label.TextColor3 = bright
		if entry.stroke then
			entry.stroke.Color = outline
		end
	end
end)

----------------------------------------------------------------------
-- Cuenta regresiva
----------------------------------------------------------------------

local function clockText(seconds)
	seconds = math.max(0, math.ceil(seconds))
	return ("%02d:%02d"):format(math.floor(seconds / 60), seconds % 60)
end

task.spawn(function()
	while true do
		if Access.canUse(player) then
			timerLabel.Text = TIMER_PREFIX .. "UNLOCKED"
		else
			local deadline = player:GetAttribute(Access.DeadlineAttribute)
			if deadline then
				timerLabel.Text = TIMER_PREFIX .. clockText(deadline - workspace:GetServerTimeNow())
			else
				-- todavia no llego el atributo del server
				timerLabel.Text = TIMER_PREFIX .. clockText(Access.RequiredSeconds)
			end
		end
		task.wait(0.25)
	end
end)
