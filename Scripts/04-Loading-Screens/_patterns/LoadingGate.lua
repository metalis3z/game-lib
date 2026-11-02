--!strict
-- LoadingGate (ModuleScript in ReplicatedStorage) - clean pattern, written for this reference library.
--
-- One place that answers "is this player done loading?" on BOTH client and server, and
-- (optionally) holds back the character spawn until the loading screen closes.
--
-- Ideas taken from:
--   drill-and-mine LoadingScreenController (LoadingFinished event + IsLoadingComplete() for other systems),
--   rivals-modded Bootstrap (server only spawns the character after LoadingScreenDone, with fallbacks),
--   smash-egg-for-animals (player attribute IntroState that the tutorial waits on),
--   prison-life systemintro (server tracks an "in intro" flag per player).
--
-- Usage
--   Server (Script in ServerScriptService):
--     local LoadingGate = require(game.ReplicatedStorage.LoadingGate)
--     LoadingGate.startServer({ holdSpawn = true, maxWait = 30 })
--     LoadingGate.onPlayerReady(function(player) print(player.Name, "finished loading") end)
--
--   Client (your loading screen LocalScript, when it closes):
--     LoadingGate.markDone()
--
--   Any client code that should wait for the loading screen:
--     LoadingGate.wait()            -- yields until done (returns immediately if already done)
--     if LoadingGate.isDone() then ... end
--
--   Any server code:
--     LoadingGate.isDone(player) / LoadingGate.wait(player)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ATTRIBUTE = "LoadingDone"
local REMOTE_NAME = "LoadingGateDone"

local LoadingGate = {}

local readyCallbacks: { (Player) -> () } = {}

local function getRemote(): RemoteEvent
	if RunService:IsServer() then
		local remote = script:FindFirstChild(REMOTE_NAME)
		if not remote then
			remote = Instance.new("RemoteEvent")
			remote.Name = REMOTE_NAME
			remote.Parent = script
		end
		return remote :: RemoteEvent
	end
	return script:WaitForChild(REMOTE_NAME) :: RemoteEvent
end

local function resolvePlayer(player: Player?): Player
	if player then
		return player
	end
	assert(RunService:IsClient(), "LoadingGate: pass a player when calling from the server")
	return Players.LocalPlayer
end

function LoadingGate.isDone(player: Player?): boolean
	return resolvePlayer(player):GetAttribute(ATTRIBUTE) == true
end

function LoadingGate.wait(player: Player?, timeout: number?): boolean
	local target = resolvePlayer(player)
	if target:GetAttribute(ATTRIBUTE) == true then
		return true
	end
	local deadline = timeout and (os.clock() + timeout)
	while target.Parent and target:GetAttribute(ATTRIBUTE) ~= true do
		if deadline and os.clock() > deadline then
			return false
		end
		task.wait(0.1)
	end
	return target:GetAttribute(ATTRIBUTE) == true
end

-- CLIENT: call once when your loading screen has closed.
function LoadingGate.markDone()
	assert(RunService:IsClient(), "LoadingGate.markDone is client-only")
	local player = Players.LocalPlayer
	if player:GetAttribute(ATTRIBUTE) == true then
		return
	end
	-- Set locally right away so client code can continue; the server sets the replicated copy.
	player:SetAttribute(ATTRIBUTE, true)
	getRemote():FireServer()
end

-- SERVER: register a callback fired once per player when they are ready.
function LoadingGate.onPlayerReady(callback: (Player) -> ())
	table.insert(readyCallbacks, callback)
end

-- SERVER: call once from a Script.
--   holdSpawn: if true, sets Players.CharacterAutoLoads = false and spawns the character on ready.
--   maxWait:   seconds before a player is treated as ready anyway (a broken client must still spawn).
function LoadingGate.startServer(options: { holdSpawn: boolean?, maxWait: number? }?)
	assert(RunService:IsServer(), "LoadingGate.startServer is server-only")
	local holdSpawn = options and options.holdSpawn or false
	local maxWait = (options and options.maxWait) or 30

	if holdSpawn then
		Players.CharacterAutoLoads = false
	end

	local function setReady(player: Player)
		if player:GetAttribute(ATTRIBUTE) == true or not player.Parent then
			return
		end
		player:SetAttribute(ATTRIBUTE, true)
		if holdSpawn and not player.Character then
			player:LoadCharacter()
		end
		for _, callback in readyCallbacks do
			task.spawn(callback, player)
		end
	end

	getRemote().OnServerEvent:Connect(setReady)

	local function onPlayerAdded(player: Player)
		if holdSpawn then
			-- With CharacterAutoLoads off we must respawn players ourselves after death.
			player.CharacterAdded:Connect(function(character)
				local humanoid = character:WaitForChild("Humanoid", 10) :: Humanoid?
				if humanoid then
					humanoid.Died:Connect(function()
						task.wait(Players.RespawnTime)
						if player.Parent then
							player:LoadCharacter()
						end
					end)
				end
			end)
		end
		task.delay(maxWait, setReady, player)
	end

	Players.PlayerAdded:Connect(onPlayerAdded)
	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end
end

return LoadingGate
