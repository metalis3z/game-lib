--credit to quartz games studio
--[[
	WeatherService  (servidor)
	--------------------------------------------------------------------
	El cliente (StarterPlayerScripts.Controllers.WeatherController) muestra cada
	clima leyendo atributos en ReplicatedStorage.WeatherValues:
	  <Nombre>_Playing  (bool)  -> arranca/para los efectos + UI del clima
	  <Nombre>_EndTime  (unix)  -> cuenta regresiva del header (DateTime.now().UnixTimestamp)
	WeatherController.SetupWeather conecta un listener de <Nombre>_Playing por cada
	clima con Frame en WeatherUI (Rain/Lightning/Rainbow/Snowfall/Starfall) — cada
	uno es INDEPENDIENTE, no hay exclusión mutua en el cliente.

	Por eso, si el server pone varios _Playing=true a la vez, el cliente los muestra
	TODOS juntos. El sistema real de GAG es mutuamente excluyente: un solo clima
	activo por vez, con periodos despejados entre medio. Este servicio implementa
	eso con UN planificador:
	  • Solo un clima activo a la vez (al arrancar uno, apaga los demás).
	  • Periodo despejado (CLEAR_GAP) entre climas.
	  • Selección ponderada por Occurance (Rain 120 = común … Starfall 30 = raro).
	  • Duración = Last del clima.
	Force/Stop (admin) interrumpen respetando la exclusión.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WeatherData = require(ReplicatedStorage.SharedModules.WeatherData)

local CLEAR_GAP_MIN = 20   -- seg de clima despejado (mínimo) entre eventos
local CLEAR_GAP_MAX = 60   -- seg de clima despejado (máximo) entre eventos

local WeatherValues = ReplicatedStorage:FindFirstChild("WeatherValues")
if not WeatherValues then
	WeatherValues = Instance.new("Folder")
	WeatherValues.Name = "WeatherValues"
	WeatherValues.Parent = ReplicatedStorage
end

local function setPlaying(name: string, playing: boolean, endTime: number?)
	if endTime then
		WeatherValues:SetAttribute(name .. "_EndTime", endTime)
	end
	WeatherValues:SetAttribute(name .. "_Playing", playing)
end

local function findEntry(name: string)
	for _, w in WeatherData.Data do
		if w.Name == name then
			return w
		end
	end
	return nil
end

----------------------------------------------------------------------
-- Estado: un solo clima activo. busyUntil = hasta cuándo (no arrancar otro antes).
----------------------------------------------------------------------
local busyUntil = 0

local function stopAllPlaying()
	for _, w in WeatherData.Data do
		if not w.AlwaysOn and WeatherValues:GetAttribute(w.Name .. "_Playing") then
			setPlaying(w.Name, false, os.time())
		end
	end
end

-- Arranca 'w' por 'duration' (o su Last), apagando cualquier otro clima.
local function startWeather(w, duration: number?): number
	stopAllPlaying()
	local last = math.max(5, math.floor(duration or w.Last or 120))
	busyUntil = os.time() + last
	setPlaying(w.Name, true, os.time() + last)
	-- Apaga al terminar su duración (salvo que otro/force lo haya reemplazado).
	task.delay(last, function()
		if WeatherValues:GetAttribute(w.Name .. "_Playing") and os.time() >= busyUntil - 1 then
			setPlaying(w.Name, false, os.time())
		end
	end)
	return last
end

-- Selección ponderada por Occurance (mayor = más frecuente).
local function weightedPick()
	local total = 0
	for _, w in WeatherData.Data do
		if not w.AlwaysOn then
			total += math.max(1, w.Occurance or 1)
		end
	end
	if total <= 0 then
		return nil
	end
	local r = math.random() * total
	local acc = 0
	for _, w in WeatherData.Data do
		if not w.AlwaysOn then
			acc += math.max(1, w.Occurance or 1)
			if r <= acc then
				return w
			end
		end
	end
	return nil
end

----------------------------------------------------------------------
-- Estado inicial: despejado (AlwaysOn, si hubiera, queda encendido fijo).
----------------------------------------------------------------------
for _, w in WeatherData.Data do
	if w.AlwaysOn then
		setPlaying(w.Name, true, os.time() + 31536000) -- 1 año
	else
		setPlaying(w.Name, false, os.time())
	end
end

----------------------------------------------------------------------
-- Planificador único: despejado -> un clima -> despejado -> …
----------------------------------------------------------------------
task.spawn(function()
	while true do
		if os.time() >= busyUntil then
			-- periodo despejado
			task.wait(math.random(CLEAR_GAP_MIN, CLEAR_GAP_MAX))
			-- si nadie forzó un clima durante el hueco, elegimos uno
			if os.time() >= busyUntil then
				local w = weightedPick()
				if w then
					local last = startWeather(w)
					task.wait(last)
				end
			end
		else
			task.wait(1)
		end
	end
end)

----------------------------------------------------------------------
-- API admin (forzar/parar clima desde comandos u otros scripts)
----------------------------------------------------------------------
local WeatherService = {}
function WeatherService.Force(name: string, duration: number?)
	local entry = findEntry(name)
	if not entry then
		return false
	end
	startWeather(entry, duration)
	return true
end
function WeatherService.Stop(name: string?)
	if name then
		setPlaying(name, false, os.time())
	else
		stopAllPlaying()
	end
	busyUntil = 0 -- permite que el planificador elija de nuevo tras el próximo hueco
end
-- MODDED: forzar TODOS los climas a la vez (P2W "Spawn All Weathers").
function WeatherService.ForceAll(duration: number?)
	local last = math.max(5, math.floor(duration or 120))
	busyUntil = os.time() + last
	for _, w in WeatherData.Data do
		if not w.AlwaysOn then
			setPlaying(w.Name, true, os.time() + last)
		end
	end
	task.delay(last, function()
		if os.time() >= busyUntil - 1 then
			stopAllPlaying()
		end
	end)
	return last
end
_G.WeatherService = WeatherService

print("[WeatherService] Planificador de clima activo (1 a la vez, ponderado por Occurance)")
