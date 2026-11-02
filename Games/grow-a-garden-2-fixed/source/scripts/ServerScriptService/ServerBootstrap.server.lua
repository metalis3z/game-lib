--credit to prince games studio
--[[
	ServerBootstrap
	Lado servidor mínimo reconstruido para este dump (el ServerScriptService
	original no se exportó). Crea las instancias por-jugador "inertes" que los
	LocalScripts esperan y arranca el spawn. La parte de gameplay (réplica
	PlayerState, leaderstats, plots) vive en GameServer.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Crear el remote de Packet lo ANTES posible: el cliente (Packet) hace
-- WaitForChild("RemoteEvent") al requerir Networking, y el primer controller
-- (WateringcanController, StartOrder=1) bloqueaba ~3.5s esperándolo. Requerir
-- Networking aquí, al arranque del server, crea ese RemoteEvent de inmediato.
pcall(require, ReplicatedStorage.SharedModules.Networking)

-- Con esto Roblox spawnea y respawnea solo; el gating por perfil ya no existe
Players.CharacterAutoLoads = true

local function ensureValue(parent: Instance, className: string, name: string, value: any)
	local existing = parent:FindFirstChild(name)
	if existing then
		return existing
	end
	local inst = Instance.new(className)
	inst.Name = name
	if value ~= nil then
		(inst :: any).Value = value
	end
	inst.Parent = parent
	return inst
end

local function onPlayerAdded(player: Player)
	-- Valores por-jugador que los LocalScripts esperan con WaitForChild
	ensureValue(player, "BoolValue", "HideCollectProximityPrompts", false)

	-- Settings (SettingsController + sliders de BGM/SFX)
	local settings = player:FindFirstChild("Settings")
	if not settings then
		settings = Instance.new("Folder")
		settings.Name = "Settings"
		settings.Parent = player
	end
	ensureValue(settings, "NumberValue", "Music_Volume", 0.5)
	ensureValue(settings, "NumberValue", "SFX_Volume", 0.5)

	-- MushroomData (MushroomUIClient itera sus hijos)
	if not player:FindFirstChild("MushroomData") then
		local mushroomData = Instance.new("Folder")
		mushroomData.Name = "MushroomData"
		mushroomData.Parent = player
	end

	-- Señal de "datos cargados" que desbloquea ControllerStarter y LoadingScreen
	player:AddTag("PersistentLoaded")

	-- Por si el jugador entró antes de activar CharacterAutoLoads
	if not player.Character then
		task.spawn(function()
			player:LoadCharacter()
		end)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end

-- Consumidores de la telemetría del ClientKit. El servidor original los
-- implementaba; sin listeners Studio reporta "Remote event invocation discarded".
local clientKit = ReplicatedStorage:WaitForChild("UserGenerated")
	:WaitForChild("Analytics")
	:WaitForChild("ClientKit")

clientKit:WaitForChild("Ping").OnServerEvent:Connect(function(player, _seq, sentServerTime)
	if typeof(sentServerTime) == "number" then
		local pingMs = math.max(0, (workspace:GetServerTimeNow() - sentServerTime) * 1000)
		player:SetAttribute("PingMs", math.floor(pingMs + 0.5))
	end
end)
clientKit:WaitForChild("FocusState").OnServerEvent:Connect(function() end)
clientKit:WaitForChild("MenuState").OnServerEvent:Connect(function() end)
clientKit:WaitForChild("Accept").OnServerEvent:Connect(function() end)