-- TrollFreeAdmin
-- "thehalconyt1" tiene el panel Troll gratis SIEMPRE, automatico apenas se
-- une (no hace falta escribir nada). Ademas queda el comando de chat
-- "/troll free" para poder apagarlo/prenderlo a mano si alguna vez se
-- quiere probar el flujo de compra real. Nombre hardcodeado, no depende de
-- ninguna lista de admins compartida — es exclusivo, nadie mas lo puede usar.
-- TrollActionServer.FreeTrollAction comprueba ESE mismo atributo + el nombre
-- otra vez del lado del server antes de aplicar cualquier accion del panel
-- Troll gratis -> no se puede spoofear desde el cliente.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FREE_TROLL_PLAYER_NAME = "thehalconyt1"

local remoteGui = ReplicatedStorage:FindFirstChild("RemoteGUI")
local notifyEvent = remoteGui and remoteGui:FindFirstChild("UNotifyEvent")
local function notify(player, title, kind)
	if notifyEvent then
		notifyEvent:FireClient(player, title, 4, kind or "Success")
	end
end

local function handleChat(player, msg)
	if player.Name ~= FREE_TROLL_PLAYER_NAME then return end
	local cmd = msg:lower():gsub("^%s+", ""):gsub("%s+$", "")
	if cmd ~= "/troll free" then return end

	local nowFree = not player:GetAttribute("TrollFree")
	player:SetAttribute("TrollFree", nowFree)
	notify(player, nowFree and "Troll GRATIS activado!" or "Troll gratis desactivado", "Success")
	print(("[TrollFreeAdmin] %s TrollFree = %s"):format(player.Name, tostring(nowFree)))
end

local function hook(player)
	if player.Name == FREE_TROLL_PLAYER_NAME then
		player:SetAttribute("TrollFree", true)
		print("[TrollFreeAdmin] " .. player.Name .. " TrollFree = true (automatico al unirse)")
	end
	player.Chatted:Connect(function(msg) handleChat(player, msg) end)
end

Players.PlayerAdded:Connect(hook)
for _, p in ipairs(Players:GetPlayers()) do task.spawn(hook, p) end