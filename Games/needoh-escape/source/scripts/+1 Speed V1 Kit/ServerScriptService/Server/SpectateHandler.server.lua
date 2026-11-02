--!strict
-- LOCATION: ServerScriptService/Controllers/SpectateHandler
-- Live spectate system: client clicks "Spectate" on a TimeLeaderboard entry,
-- server validates the target is mid-speedrun, then tells the requester's
-- client to swap its camera to follow the target's character in real time.
-- Session ends when: target touches SpeedRun End, target dies, target leaves,
-- or spectator leaves / requests stop.

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace          = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")

local SpeedRunFolder = Workspace:WaitForChild("SpeedRun")
local EndPart = SpeedRunFolder:WaitForChild("End") :: BasePart

local SpectateHandler = {}

local events: {[string]: RemoteEvent} = {}

-- spectator -> target Player currently being watched
local activeSpectates: {[Player]: Player} = {}
-- target -> set of spectators watching them (for fast lookup on end-touch/death)
local watchersOf: {[Player]: {[Player]: boolean}} = {}

local SpeedRunController: any = nil

-- [ HELPERS ] ----------------------------------------------------------------

local function getPlayerFromTouchPart(part: BasePart): Player?
	local character = part:FindFirstAncestorOfClass("Model")
	if not character then return nil end
	return Players:GetPlayerFromCharacter(character)
end

local function addWatcher(target: Player, spectator: Player)
	if not watchersOf[target] then
		watchersOf[target] = {}
	end
	watchersOf[target][spectator] = true
end

local function removeWatcher(target: Player, spectator: Player)
	local set = watchersOf[target]
	if not set then return end
	set[spectator] = nil
	if next(set) == nil then
		watchersOf[target] = nil
	end
end

-- Ends one specific spectator's session and tells their client to restore camera.
local function endSpectateFor(spectator: Player, reason: string)
	local target = activeSpectates[spectator]
	if not target then return end

	activeSpectates[spectator] = nil
	removeWatcher(target, spectator)

	if events.StopSpectate and spectator.Parent == Players then
		events.StopSpectate:FireClient(spectator, reason)
	end
end

-- Ends ALL spectate sessions watching a given target (e.g. target finished/died/left).
local function endAllSpectatesOf(target: Player, reason: string)
	local set = watchersOf[target]
	if not set then return end

	-- Copy keys first since endSpectateFor mutates the table we're iterating
	local spectatorsToEnd: {Player} = {}
	for spectator in pairs(set) do
		table.insert(spectatorsToEnd, spectator)
	end

	for _, spectator in ipairs(spectatorsToEnd) do
		endSpectateFor(spectator, reason)
	end

	watchersOf[target] = nil
end

-- [ START SPECTATE ] ----------------------------------------------------------

local function onRequestSpectate(spectator: Player, targetUserId: any)
	if type(targetUserId) ~= "number" then return end

	local target = Players:GetPlayerByUserId(targetUserId)
	if not target or target.Parent ~= Players then
		if events.SpectateFailed then
			events.SpectateFailed:FireClient(spectator, "PlayerNotFound")
		end
		return
	end

	if target == spectator then
		if events.SpectateFailed then
			events.SpectateFailed:FireClient(spectator, "CannotSpectateSelf")
		end
		return
	end

	if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
		if events.SpectateFailed then
			events.SpectateFailed:FireClient(spectator, "TargetNoCharacter")
		end
		return
	end

	-- Must actually be mid-run to spectate live (this is a LIVE view, not a ghost replay)
	if not SpeedRunController or not SpeedRunController:IsInActiveRun(target) then
		if events.SpectateFailed then
			events.SpectateFailed:FireClient(spectator, "TargetNotRunning")
		end
		return
	end

	-- If already spectating someone, swap cleanly first
	if activeSpectates[spectator] then
		endSpectateFor(spectator, "Swapped")
	end

	activeSpectates[spectator] = target
	addWatcher(target, spectator)

	if events.StartSpectate then
		events.StartSpectate:FireClient(spectator, target.UserId, target.Name)
	end
end

local function onRequestStopSpectate(spectator: Player)
	endSpectateFor(spectator, "Manual")
end

-- [ TARGET TOUCHES END ] -------------------------------------------------------

local function onEndTouched(otherPart: BasePart)
	local target = getPlayerFromTouchPart(otherPart)
	if not target then return end
	if not watchersOf[target] then return end -- nobody is watching this player, nothing to do

	endAllSpectatesOf(target, "RunFinished")
end

-- [ TARGET DIES / LEAVES MID-RUN ] ---------------------------------------------

local function setupCharacterAdded(target: Player, character: Model)
	local humanoid = character:WaitForChild("Humanoid") :: Humanoid
	humanoid.Died:Connect(function()
		if watchersOf[target] then
			endAllSpectatesOf(target, "TargetDied")
		end
	end)
end

-- [ SETUP ] --------------------------------------------------------------------

function SpectateHandler:Init(controllers: {[string]: any})
	SpeedRunController = controllers.SpeedRunController
end

function SpectateHandler:SetupSharedInstances()
	local e = ReplicatedStorage:FindFirstChild("Events")
	if not e then
		e = Instance.new("Folder")
		e.Name = "Events"
		e.Parent = ReplicatedStorage
	end

	local function mk(cl: string, nm: string): RemoteEvent
		local existing = e:FindFirstChild(nm)
		if existing then
			events[nm] = existing :: RemoteEvent
			return existing :: RemoteEvent
		end
		local x = Instance.new(cl)
		x.Name = nm
		x.Parent = e
		events[nm] = x :: any
		return x :: RemoteEvent
	end

	mk("RemoteEvent", "RequestSpectate")     -- client -> server: { targetUserId }
	mk("RemoteEvent", "RequestStopSpectate") -- client -> server: stop watching
	mk("RemoteEvent", "StartSpectate")       -- server -> client: { targetUserId, targetName }
	mk("RemoteEvent", "StopSpectate")        -- server -> client: { reason }
	mk("RemoteEvent", "SpectateFailed")      -- server -> client: { reason }
end

function SpectateHandler:Start()
	EndPart.Touched:Connect(onEndTouched)

	if events.RequestSpectate then
		events.RequestSpectate.OnServerEvent:Connect(onRequestSpectate)
	end
	if events.RequestStopSpectate then
		events.RequestStopSpectate.OnServerEvent:Connect(onRequestStopSpectate)
	end

	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(character)
			setupCharacterAdded(player, character)
		end)
		if player.Character then
			setupCharacterAdded(player, player.Character)
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		-- If this player was spectating someone, clean that up
		endSpectateFor(player, "SpectatorLeft")

		-- If this player was being watched by others, end those sessions too
		if watchersOf[player] then
			endAllSpectatesOf(player, "TargetLeft")
		end
	end)
end

return SpectateHandler