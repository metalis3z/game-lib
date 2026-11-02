-- ExtraPanelWeatherServer
-- Recibe los pedidos de clima del ExtraPanel y los ejecuta.
--
-- ESTE es el candado de verdad: esconder el boton en el cliente es solo
-- cosmetico (cualquiera con un executor puede prender la GUI), asi que la
-- unica proteccion que cuenta es este chequeo. No sacarlo.
--
-- Quien puede lo decide ExtraPanelAccess: ClaraSigm1 siempre, y cualquiera que
-- haya cumplido los 10 minutos del cartel de Workspace.Event.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Access = require(ReplicatedStorage.Modules.ExtraPanelAccess)
local WeatherHandler = require(ReplicatedStorage.Modules.WeatherHandler)

-- Limites de duracion (segundos) que aceptamos del cliente.
local MIN_DURATION = 5
local MAX_DURATION = 30 * 60

-- Un clima cada tanto, para que no se pueda spamear el remote.
local COOLDOWN = 2

local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AdminWeather")

-- El comando de Cmdr ya hace todo el trabajo pesado (modelo, luces, musica,
-- baseplate, limpieza al terminar). Lo reusamos en vez de duplicarlo; le
-- pasamos un context vacio porque la funcion no lo usa, y un tercer argumento
-- con la duracion custom (parche nuestro, Cmdr sigue mandando nil).
local commands = ServerScriptService:FindFirstChild("Cmdr")
commands = commands and commands:FindFirstChild("Commands")
local runnerModule = commands and commands:FindFirstChild("weatherEventServer")

local runWeather
if runnerModule then
	local ok, result = pcall(require, runnerModule)
	if ok and type(result) == "function" then
		runWeather = result
	else
		warn("[ExtraPanelWeather] no pude cargar weatherEventServer:", result)
	end
else
	warn("[ExtraPanelWeather] no encontre Cmdr.Commands.weatherEventServer")
end

local lastUse = 0

local function fail(player, message)
	remote:FireClient(player, false, message)
end

remote.OnServerEvent:Connect(function(player, weatherKey, duration)
	if not Access.canUse(player) then
		warn(("[ExtraPanelWeather] %s (%d) pidio clima sin tener el panel desbloqueado")
			:format(player.Name, player.UserId))
		return
	end

	if not runWeather then
		return fail(player, "El sistema de clima no cargo")
	end

	if type(weatherKey) ~= "string" then
		return fail(player, "Pedido invalido")
	end

	local config = WeatherHandler.WheatherList[weatherKey]
	if not config then
		return fail(player, "No existe el clima " .. weatherKey)
	end

	local now = os.clock()
	if now - lastUse < COOLDOWN then
		return fail(player, "Esperá un segundo")
	end
	lastUse = now

	local seconds = tonumber(duration) or config.Time
	seconds = math.clamp(math.floor(seconds), MIN_DURATION, MAX_DURATION)

	local ok, result = pcall(runWeather, {}, weatherKey, seconds)
	if not ok then
		warn("[ExtraPanelWeather] fallo al lanzar " .. weatherKey .. ": " .. tostring(result))
		return fail(player, "Error al lanzar el clima")
	end

	-- weatherEventServer devuelve un string SOLO cuando algo salio mal
	-- (tipo invalido, carpeta o modelo faltante). Si devuelve nil, arranco.
	if type(result) == "string" then
		return fail(player, result)
	end

	remote:FireClient(player, true, ("%s por %ds"):format(weatherKey, seconds))
end)
