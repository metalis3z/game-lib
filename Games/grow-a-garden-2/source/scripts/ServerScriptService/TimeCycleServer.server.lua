--credit to quartz games studio
--[[
	TimeCycleServer
	Driver del ciclo día/noche.

	El cliente (TimeCycleController) y la barra (TimeCycleBarController) NO
	calculan la fase: la leen de atributos en workspace y se BLOQUEAN con un
	repeat/until hasta que existan. El servidor original los ponía; como el
	ServerScriptService se borró en el dump, aquí se reconstruye ese driver.

	Contrato EXACTO (leído de los controllers cliente):
	  workspace.ActivePhase   : string  -- "Day" | "Sunset" | "Night"
	                                       TimeCycleController y las luces de
	                                       noche dependen de esto.
	  workspace.PhaseDuration : number  -- TIMESTAMP en unidades de
	                                       workspace:GetServerTimeNow() en el que
	                                       la fase ACTUAL termina. La barra hace:
	                                       restante = PhaseDuration - GetServerTimeNow()
	  workspace.ActiveWeather : string  -- clima elegido para la fase. Al ponerlo
	                                       autoritativo, barra y escena leen el
	                                       MISMO valor y coinciden (misma luna).

	El ciclo se alinea a os.time() (UTC, igual en todos los clientes) para que
	el seed de clima del cliente, floor(os.time()/CYCLE), cambie justo cuando
	empieza cada Día.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TimeCycleData = require(ReplicatedStorage.SharedModules.TimeCycleData)

----------------------------------------------------------------------
-- Fases ordenadas por StartOrder, con offset acumulado dentro del ciclo
----------------------------------------------------------------------
local phases = {}
for name, info in TimeCycleData.Data do
	table.insert(phases, {
		Name = name,
		Lasts = info.Lasts,
		Order = info.StartOrder,
		Weathers = info.Weathers,
	})
end
table.sort(phases, function(a, b)
	return a.Order < b.Order
end)

local CYCLE = 0
for _, p in phases do
	p.StartAt = CYCLE
	CYCLE += p.Lasts
end

----------------------------------------------------------------------
-- Clima ponderado por Chance, determinista por seed (orden estable por nombre)
----------------------------------------------------------------------
local function pickWeather(weathers, rng)
	local names = {}
	local total = 0
	for name, w in weathers do
		table.insert(names, name)
		total += w.Chance
	end
	table.sort(names)

	local roll = rng:NextNumber() * total
	local acc = 0
	for _, name in names do
		acc += weathers[name].Chance
		if roll <= acc then
			return name
		end
	end
	return names[1]
end

----------------------------------------------------------------------
-- Fase actual a partir de os.time()
----------------------------------------------------------------------
local function currentPhase()
	local now = os.time()
	local cycleIndex = math.floor(now / CYCLE)
	local pos = now % CYCLE
	for i = #phases, 1, -1 do
		local p = phases[i]
		if pos >= p.StartAt then
			local remaining = (p.StartAt + p.Lasts) - pos
			return p, remaining, cycleIndex, i
		end
	end
	local p = phases[1]
	return p, p.Lasts - pos, cycleIndex, 1
end

local function apply()
	local phase, remaining, cycleIndex, phaseIndex = currentPhase()
	local weather = pickWeather(phase.Weathers, Random.new(cycleIndex * 1000 + phaseIndex))

	-- Poner clima y fin ANTES que ActivePhase: cuando el cliente vea
	-- ActivePhase (que es su condición de desbloqueo) los otros ya existen.
	workspace:SetAttribute("ActiveWeather", weather)
	workspace:SetAttribute("PhaseDuration", workspace:GetServerTimeNow() + remaining)
	workspace:SetAttribute("ActivePhase", phase.Name)
	return remaining
end

----------------------------------------------------------------------
-- Bucle principal: aplica y duerme hasta el fin exacto de la fase
----------------------------------------------------------------------
task.spawn(function()
	while true do
		local remaining = apply()
		task.wait(math.max(remaining, 0) + 0.1) -- +0.1 para cruzar el límite
	end
end)

print(("[TimeCycleServer] Ciclo día/noche activo (ciclo de %ds)"):format(CYCLE))
