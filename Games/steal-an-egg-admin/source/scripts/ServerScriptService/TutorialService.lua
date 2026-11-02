--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local DataService = require(ServerScriptService.DataService)
local GuardTutorial = require(ReplicatedStorage.Shared.Types.GuardTutorial)

local TutorialService = {}

export type RuntimeState = {
	Enabled: boolean,
	PausedForAdminAbuse: boolean,
	Revision: number,
}

local sync_cooldown = 0.25

local adminAbuseActive = false
local revision = 0
local lastSyncAt: { [Player]: number } = {}

local function buildRuntimeState(): RuntimeState
	return {
		Enabled = not adminAbuseActive,
		PausedForAdminAbuse = adminAbuseActive,
		Revision = revision,
	}
end

local function broadcastStateShift()
	Remotes.GuardOnboarding.LiveStateShifted:FireAllClients(buildRuntimeState())
end

local function onAdminAbuseChanged()
	local nowActive = Workspace:GetAttribute("Event_AdminAbuse") == true
	if nowActive == adminAbuseActive then
		return
	end
	adminAbuseActive = nowActive
	revision += 1
	broadcastStateShift()
end

local function handleProgressSync(player: Player, progress: unknown): (boolean, any?)
	local now = os.clock()
	local last = lastSyncAt[player]
	if last ~= nil and now - last < sync_cooldown then
		return false, nil
	end
	lastSyncAt[player] = now

	local ok, sanitized = pcall(GuardTutorial.SanitizeProgress, progress)
	if not ok or sanitized == nil then
		return false, nil
	end

	local data = DataService.Get(player)
	if data == nil then
		return false, nil
	end

	data.GuardTutorialProgress = sanitized
	DataService.SyncChange(player, "GuardTutorialProgress", sanitized)
	return true, sanitized
end

function TutorialService.Init()
	Remotes.GuardOnboarding.AskLiveState.OnServerInvoke = function(_player: Player): RuntimeState
		return buildRuntimeState()
	end

	Remotes.GuardOnboarding.AskProgressSync.OnServerInvoke = handleProgressSync

	Players.PlayerRemoving:Connect(function(player)
		lastSyncAt[player] = nil
	end)

	Workspace:GetAttributeChangedSignal("Event_AdminAbuse"):Connect(onAdminAbuseChanged)
	onAdminAbuseChanged()
end

function TutorialService.Start() end

return TutorialService