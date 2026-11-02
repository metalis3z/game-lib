--[[ NotifModule — el "toast" del AdminPanel.

	ARREGLO: la primera línea era
	    require(ReplicatedStorage.Modules.ServicesLoader.MessagesService)
	y ese módulo NO existe en este lugar (la carpeta Modules vino vacía del dump),
	así que el require TIRABA ERROR y se caían de una los 7 scripts del AdminPanel
	que lo usan (AdminActionsClient, AdminCooldownClient, los morphs, EventRunner,
	SessionSettings...). Ahora se intenta usar MessagesService si algún día está,
	y si no se cae al sistema de notificaciones propio del juego (Lib.Notify).
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- MessagesService del pack, SI existe (sin reventar si no).
local MessagesService
pcall(function()
	local modules = ReplicatedStorage:FindFirstChild("Modules")
	local loader = modules and modules:FindFirstChild("ServicesLoader")
	local service = loader and loader:FindFirstChild("MessagesService")
	if service then
		MessagesService = require(service)
	end
end)

-- Respaldo: las notificaciones normales del juego.
local Lib
pcall(function()
	Lib = require(ReplicatedStorage:WaitForChild("Lib", 10))
end)

local OK_COLOR = Color3.fromRGB(120, 255, 150)
local ERR_COLOR = Color3.fromRGB(255, 120, 120)

local function show(text, success)
	local isError = success == false

	if MessagesService then
		MessagesService:PlayMessage(text, isError and "Error" or "Success")
		return
	end

	if Lib and Lib.Notify then
		Lib.Notify(text, isError and ERR_COLOR or OK_COLOR)
		return
	end

	print("[AdminPanel] " .. text)
end

local Notif = script.Parent:FindFirstChild("Notif")
if Notif then
	Notif:Destroy()
end

local lastShown = {}

return function(text, success)
	if type(text) ~= "string" or text == "" then
		return
	end

	local now = os.clock()
	local last = lastShown[text]
	if last and now - last < 0.15 then
		return
	end

	lastShown[text] = now
	show(text, success)
end
