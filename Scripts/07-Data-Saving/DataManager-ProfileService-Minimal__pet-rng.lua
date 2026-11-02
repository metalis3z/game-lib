-- Reference copy for study. Game: Pet RNG (pet-rng)
-- Original: ServerScriptService/Engine/Scripts/Data/DataManager.lua  (61 lines)
-- What it does: The shortest correct ProfileService setup: LoadProfileAsync, AddUserId, Reconcile, ListenToRelease kick, release on leave, handle players already in game.

--made by caelm

local dataManager = {}

-- [[Services/Constants]]
local profileService = require(script.ProfileService)
local dataTemplate = require(script.DataTemplate)
local leaderstats = require(script.Leaderstats)
local players = game:GetService("Players")

-- [[Variables]]
local CURRENT_DATA_VERSION = "official_v3"

-- [[Setting Up]]
local profileStore = profileService.GetProfileStore(CURRENT_DATA_VERSION, dataTemplate)
dataManager.profiles = {}

-- [[Functions]]
local function onProfileLoad(plr:Player, profile)
	leaderstats:CreateLeaderstats(plr, profile)
	print("Loaded "..plr.Name.."'s Profile")
	profile.Data.LogInTimes += 1
end

local function onPlayerAdded(plr:Player)
	local profile = profileStore:LoadProfileAsync("Player_" .. plr.UserId)
	if profile ~= nil then
		profile:AddUserId(plr.UserId)
		profile:Reconcile()
		profile:ListenToRelease(function()
			dataManager.profiles[plr] = nil
			plr:Kick()
		end)
		if plr:IsDescendantOf(players) == true then -- successfully loaded profile
			dataManager.profiles[plr] = profile
			onProfileLoad(plr, profile)
		else -- player left before load
			profile:Release()
		end
	else -- profile couldn't load
		plr:Kick() 
	end
end

local function onPlayerRemoving(plr:Player)
	local profile = dataManager.profiles[plr]
	if profile ~= nil then
		profile:Release()
	end
end

-- [[Main Connecting]]
players.PlayerAdded:Connect(onPlayerAdded)
players.PlayerRemoving:Connect(onPlayerRemoving)

-- [[Initialize]]
for _, plr in pairs(players:GetPlayers()) do
	task.spawn(onPlayerAdded, plr)
end

return dataManager
