--credit to leon games studio
--[[
	OpSeedAdminCommand  (MODDED)
	Comando de chat para que SOLO dos admins se den semillas con alto/ancho a elegir.

	Uso (escribir en el chat del juego):
		/opseed <semilla> <alto> <ancho>
		/opseed <semilla> <tamaño>      -> usa el mismo valor para alto y ancho
		/opseed <semilla>               -> alto=ancho=5 por defecto

	Ejemplos:
		/opseed Carrot 10 3      -> zanahoria alta y delgada
		/opseed Strawberry 2 8   -> fresa baja y ancha
		/opseed Pumpkin 6        -> calabaza 6x6

	Tras darte la semilla, plántala normalmente y la planta crecerá con el
	alto/ancho elegido. La proporción se conserva durante el crecimiento.
]]

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameServerAPI = require(ServerScriptService:WaitForChild("GameServerAPI"))
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)

-- Solo estos UserIds pueden usar el comando.
local ADMINS = {
	[317845352] = true,
	[2602303896] = true,
}

-- Límites de seguridad para no romper el render con valores absurdos.
local MIN_MUL, MAX_MUL = 0.1, 200

-- nombre en minúsculas -> SeedName real
local seedLookup = {}
for _, entry in SeedData do
	if entry.SeedName then
		seedLookup[entry.SeedName:lower()] = entry.SeedName
	end
end

local function resolveSeed(name: string): string?
	if not name or name == "" then
		return nil
	end
	name = name:lower()
	-- coincidencia exacta
	if seedLookup[name] then
		return seedLookup[name]
	end
	-- coincidencia parcial (la más corta gana, para ser determinista)
	local best
	for k, real in seedLookup do
		if k:find(name, 1, true) then
			if not best or #k < #best then
				best = k
			end
		end
	end
	return best and seedLookup[best] or nil
end

local function clamp(n: number): number
	return math.clamp(n, MIN_MUL, MAX_MUL)
end

local function handle(player: Player, message: string)
	if not ADMINS[player.UserId] then
		return
	end

	local trimmed = message:gsub("^%s+", "")
	local cmd, rest = trimmed:match("^(%S+)%s*(.*)$")
	if not cmd then
		return
	end
	cmd = cmd:lower()
	if cmd ~= "/opseed" and cmd ~= "!opseed" and cmd ~= "/seed" then
		return
	end

	local tokens = {}
	for w in (rest or ""):gmatch("%S+") do
		table.insert(tokens, w)
	end
	if #tokens == 0 then
		warn("[opseed] uso: /opseed <semilla> <alto> <ancho>")
		return
	end

	-- Recortar hasta dos números finales como alto/ancho (el resto es el nombre).
	local height, width
	if #tokens >= 2 and tonumber(tokens[#tokens]) and tonumber(tokens[#tokens - 1]) then
		width = tonumber(tokens[#tokens])
		height = tonumber(tokens[#tokens - 1])
		table.remove(tokens)
		table.remove(tokens)
	elseif tonumber(tokens[#tokens]) then
		height = tonumber(tokens[#tokens])
		width = height
		table.remove(tokens)
	end
	height = clamp(height or 5)
	width = clamp(width or height)

	local seedName = table.concat(tokens, " ")
	local real = resolveSeed(seedName)
	if not real then
		warn(("[opseed] semilla no encontrada: %q"):format(seedName))
		return
	end

	-- size base = 1: el tamaño total lo determinan alto/ancho.
	local ok = GameServerAPI.GiveOpSizeSeed(player, real, 1, height, width)
	if ok then
		print(("[opseed] %s recibió '%s' (alto=%.2f, ancho=%.2f)"):format(player.Name, real, height, width))
	else
		warn(("[opseed] no se pudo dar la semilla '%s'"):format(real))
	end
end

local function hook(player: Player)
	player.Chatted:Connect(function(message)
		handle(player, message)
	end)
end

Players.PlayerAdded:Connect(hook)
for _, p in Players:GetPlayers() do
	hook(p)
end
