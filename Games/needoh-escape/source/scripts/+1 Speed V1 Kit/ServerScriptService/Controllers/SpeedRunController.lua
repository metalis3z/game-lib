--!strict
-- LOCATION: ServerScriptService/Controllers/SpeedRunController

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local PlayerController = require(ServerScriptService.Controllers.PlayerController)

local SpeedRunController = {}

local events: {[string]: RemoteEvent} = {}
local activeRuns: {[Player]: number} = {}      -- player -> start time (os.clock)
local savedElapsed: {[Player]: number} = {}    -- elapsed saved at death, restored on revive

local SpeedRunFolder = Workspace:WaitForChild("SpeedRun")
local StartPart = SpeedRunFolder:WaitForChild("Start")
local EndPart = SpeedRunFolder:WaitForChild("End")

-- [ HELPERS ] ----------------------------------------------------------------

local function getPlayerFromPart(part: BasePart): Player?
	local character = part:FindFirstAncestorOfClass("Model")
	if not character then return nil end
	return Players:GetPlayerFromCharacter(character)
end

local function formatTime(seconds: number): string
	local minutes = math.floor(seconds / 60)
	local secs    = math.floor(seconds % 60)
	local millis  = math.floor((seconds % 1) * 1000)
	return string.format("%02d:%02d.%03d", minutes, secs, millis)
end

local function isToggledOn(player: Player): boolean
	local profile = PlayerController:GetProfile(player)
	if not profile then return false end
	return profile.Data.SpeedRunToggle or false
end

-- ONLY called from onEndTouched — the player physically touched the end part.
-- Death and revive paths never call this, so the leaderboard only ever reflects
-- genuine completed runs.
local function saveTime(player: Player, finalTime: number)
	local profile = PlayerController:GetProfile(player)
	local hiddenStats = player:FindFirstChild("HiddenStats")
	if not hiddenStats then return end

	local timeValue = hiddenStats:FindFirstChild("BestSpeedRunTime") :: StringValue?
	if not timeValue then
		timeValue = Instance.new("StringValue")
		timeValue.Name = "BestSpeedRunTime"
		timeValue.Parent = hiddenStats
	end

	local formatted = formatTime(finalTime)
	local existing = (timeValue :: StringValue).Value

	local shouldSave = false
	if existing == "" then
		shouldSave = true
	else
		local em, es, ems = existing:match("(%d+):(%d+)%.(%d+)")
		if em and es and ems then
			local existingSeconds = tonumber(em) * 60 + tonumber(es) + tonumber(ems) / 1000
			if finalTime < existingSeconds then
				shouldSave = true
			end
		else
			shouldSave = true
		end
	end

	if shouldSave then
		(timeValue :: StringValue).Value = formatted
		if profile then
			profile.Data.BestSpeedRunTime = formatted
		end
	end
end

-- [ START / END HANDLERS ] ------------------------------------------------

local function onStartTouched(otherPart: BasePart)
	local player = getPlayerFromPart(otherPart)
	if not player then return end
	if not isToggledOn(player) then return end

	-- Fresh run: clear any saved elapsed from a prior death
	savedElapsed[player] = nil
	activeRuns[player] = os.clock()

	if events.SpeedRunStart then
		events.SpeedRunStart:FireClient(player)
	end
end

local function onEndTouched(otherPart: BasePart)
	local player = getPlayerFromPart(otherPart)
	if not player then return end
	if not isToggledOn(player) then return end

	local startTime = activeRuns[player]
	if not startTime then return end

	-- This is the ONLY place a time is committed to the profile/leaderboard.
	-- The clock has been running continuously since the start touch (or since
	-- a revive resumed it), so finalTime is the true wall-clock run time
	-- excluding any time spent dead/loading.
	local finalTime = os.clock() - startTime
	activeRuns[player] = nil
	savedElapsed[player] = nil

	saveTime(player, finalTime)

	if events.SpeedRunEnd then
		events.SpeedRunEnd:FireClient(player, finalTime)
	end
end

-- [ DEATH HANDLING ] -------------------------------------------------------

local function setupCharacterAdded(player: Player, character: Model)
	local humanoid = character:WaitForChild("Humanoid") :: Humanoid

	humanoid.Died:Connect(function()
		local startTime = activeRuns[player]
		if startTime then
			-- Save elapsed so revive can restore the clock from the right point.
			-- BestSpeedRunTime in the profile is NOT touched here.
			savedElapsed[player] = os.clock() - startTime
			activeRuns[player] = nil
			if events.SpeedRunReset then
				events.SpeedRunReset:FireClient(player)
			end
		end
	end)
end

-- [ PUBLIC API ] ------------------------------------------------------------

-- Called by PlayerController after a revive teleport completes.
-- Restores the run clock from the moment of death so no time is added
-- for the death+purchase+load sequence.
function SpeedRunController:ResumeAfterRevive(player: Player)
	local elapsed = savedElapsed[player]
	if not elapsed then return end
	if not isToggledOn(player) then return end

	savedElapsed[player] = nil
	activeRuns[player] = os.clock() - elapsed

	if events.SpeedRunStart then
		events.SpeedRunStart:FireClient(player, elapsed)
	end
end

function SpeedRunController:SetToggle(player: Player, value: boolean)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	profile.Data.SpeedRunToggle = value

	if not value then
		activeRuns[player] = nil
		savedElapsed[player] = nil
		if events.SpeedRunReset then
			events.SpeedRunReset:FireClient(player)
		end
	end

	local h = player:FindFirstChild("HiddenStats")
	if h then
		local toggleVal = h:FindFirstChild("SpeedRunToggle") :: BoolValue?
		if toggleVal then toggleVal.Value = value end
	end
end

function SpeedRunController:GetToggle(player: Player): boolean
	return isToggledOn(player)
end

function SpeedRunController:IsInActiveRun(player: Player): boolean
	return activeRuns[player] ~= nil
end

-- [ SETUP ] ----------------------------------------------------------------

function SpeedRunController:SetupSharedInstances()
	local e = ReplicatedStorage:FindFirstChild("Events")
	if not e then
		e = Instance.new("Folder")
		e.Name = "Events"
		e.Parent = ReplicatedStorage
	end

	local function mk(cl: string, nm: string)
		local x = Instance.new(cl)
		x.Name = nm
		x.Parent = e
		events[nm] = x :: any
	end

	mk("RemoteEvent", "SpeedRunStart")
	mk("RemoteEvent", "SpeedRunEnd")
	mk("RemoteEvent", "SpeedRunReset")
	mk("RemoteEvent", "SpeedRunToggle")
	mk("RemoteEvent", "SpeedRunInit")
end

function SpeedRunController:Start()
	StartPart.Touched:Connect(onStartTouched)
	EndPart.Touched:Connect(onEndTouched)

	if events.SpeedRunToggle then
		events.SpeedRunToggle.OnServerEvent:Connect(function(player, value)
			if typeof(value) ~= "boolean" then return end
			SpeedRunController:SetToggle(player, value)
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(character)
			setupCharacterAdded(player, character)
		end)

		if player.Character then
			setupCharacterAdded(player, player.Character)
		end

		task.spawn(function()
			local h = player:WaitForChild("HiddenStats", 10)
			if not h then return end

			local profile = nil
			for _ = 1, 100 do
				profile = PlayerController:GetProfile(player)
				if profile then break end
				task.wait(0.1)
			end
			if not profile then return end

			if profile.Data.SpeedRunToggle == nil then
				profile.Data.SpeedRunToggle = false
			end
			if profile.Data.BestSpeedRunTime == nil then
				profile.Data.BestSpeedRunTime = ""
			end

			local toggleVal = h:FindFirstChild("SpeedRunToggle") :: BoolValue?
			if not toggleVal then
				toggleVal = Instance.new("BoolValue")
				toggleVal.Name = "SpeedRunToggle"
				toggleVal.Parent = h
			end
			toggleVal.Value = profile.Data.SpeedRunToggle

			local timeVal = h:FindFirstChild("BestSpeedRunTime") :: StringValue?
			if not timeVal then
				timeVal = Instance.new("StringValue")
				timeVal.Name = "BestSpeedRunTime"
				timeVal.Parent = h
			end
			timeVal.Value = profile.Data.BestSpeedRunTime

			if events.SpeedRunInit then
				events.SpeedRunInit:FireClient(
					player,
					profile.Data.SpeedRunToggle,
					profile.Data.BestSpeedRunTime
				)
			end
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		activeRuns[player] = nil
		savedElapsed[player] = nil
	end)
end

return SpeedRunController