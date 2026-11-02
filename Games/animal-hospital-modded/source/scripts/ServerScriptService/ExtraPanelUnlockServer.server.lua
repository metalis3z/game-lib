-- ExtraPanelUnlockServer
-- Le cuenta 10 minutos a cada jugador desde que entra y al cumplirse le
-- desbloquea el ExtraPanel.
--
-- El contador es POR JUGADOR y no se persiste a propósito: si se va del server
-- pierde el progreso y al volver arranca de cero. Eso sale gratis porque todo
-- el estado vive en atributos del Player, que mueren con el.
--
-- Quien decide es este script; el cliente solo dibuja la cuenta regresiva.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Access = require(ReplicatedStorage.Modules.ExtraPanelAccess)

local function startTimer(player)
	if Access.isAdmin(player) then
		-- ella no espera
		player:SetAttribute(Access.UnlockedAttribute, true)
		player:SetAttribute(Access.DeadlineAttribute, 0)
		return
	end

	player:SetAttribute(Access.UnlockedAttribute, false)
	-- GetServerTimeNow es el mismo reloj en server y clientes, asi que el
	-- cliente puede restar contra esto sin que se le vaya desfasando.
	player:SetAttribute(Access.DeadlineAttribute, workspace:GetServerTimeNow() + Access.RequiredSeconds)

	task.delay(Access.RequiredSeconds, function()
		-- si se fue (o se fue y volvio) este hilo ya no aplica: al reconectar
		-- corre un startTimer nuevo con su propio delay
		if player.Parent ~= Players then
			return
		end
		player:SetAttribute(Access.UnlockedAttribute, true)
	end)
end

Players.PlayerAdded:Connect(startTimer)

-- por si el script arranca despues que algun jugador (Studio, hot reload)
for _, player in ipairs(Players:GetPlayers()) do
	if player:GetAttribute(Access.DeadlineAttribute) == nil then
		startTimer(player)
	end
end
