-- TutorialService: server half of the first-join tutorial.
-- The client (StarterPlayerScripts.TutorialController) asks GetTutorialStatus
-- whether to run; completion lands in the profile's TutorialComplete field
-- (already in GameConfig.Data.PlayerDataTemplate from the removed legacy
-- tutorial) so the tutorial runs ONCE per account. Players who clearly
-- progressed before this system shipped (extra drills owned / level 5+) are
-- auto-marked complete so veterans never see it.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local tutorialFolder = Remotes:FindFirstChild("Tutorial")
if not tutorialFolder then
	tutorialFolder = Instance.new("Folder")
	tutorialFolder.Name = "Tutorial"
	tutorialFolder.Parent = Remotes
end

local function ensureRemote(className, name)
	local r = tutorialFolder:FindFirstChild(name)
	if not r then
		r = Instance.new(className)
		r.Name = name
		r.Parent = tutorialFolder
	end
	return r
end

local GetTutorialStatus = ensureRemote("RemoteFunction", "GetTutorialStatus")
local CompleteTutorial = ensureRemote("RemoteEvent", "CompleteTutorial")

-- Required in the BACKGROUND, same rule as StrengthClickServer: the
-- PlayerDataService/GameConfig require chain once froze whole scripts at
-- module level. Until it resolves, status invokes just keep polling.
local PlayerDataService
task.spawn(function()
	PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
end)

local function countOwnedDrills(data)
	if type(data.OwnedDrills) ~= "table" then return 0 end
	local n = 0
	for _ in pairs(data.OwnedDrills) do n += 1 end
	return n
end

-- true = run the tutorial. Waits for the profile so a fast-loading client
-- can't race the data mirror; a load that never lands returns false (never
-- trap a player in a tutorial the server can't complete).
GetTutorialStatus.OnServerInvoke = function(player)
	local deadline = os.clock() + 20
	while os.clock() < deadline and player.Parent do
		local data = PlayerDataService and PlayerDataService.GetPlayerData(player)
		if data then
			if data.TutorialComplete then
				return false
			end
			-- Veteran auto-skip: the field is new, existing accounts have it
			-- unset. Anyone past the tutorial's own milestones (bought a
			-- drill beyond the default Wood, or leveled past 5) completes
			-- silently instead of being walked through the basics.
			if countOwnedDrills(data) > 1 or (tonumber(data.Level) or 1) >= 5 then
				data.TutorialComplete = true
				PlayerDataService.ScheduleSave(player)
				return false
			end
			return true
		end
		task.wait(0.25)
	end
	return false
end

CompleteTutorial.OnServerEvent:Connect(function(player)
	local data = PlayerDataService and PlayerDataService.GetPlayerData(player)
	if not data or data.TutorialComplete then return end
	data.TutorialComplete = true
	PlayerDataService.ScheduleSave(player)
end)
