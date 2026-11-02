-- Small requests the client makes while it loads.
--
--   Misc.RequestFFlags                      -> { [flagName] = value }   (FFlagController; UpdateFFlag pushes)
--   Misc.RequestTaskRefreshTimeRemaining    -> seconds                  (TimerController "TaskRefresh")
--   Misc.RequestAdventCalendarTimeRemaining -> seconds                  (TimerController "AdventCalendar")
--   Misc.RequestSeasonTimer                 -> seconds                  (SeasonController)
--   Misc.RequestEventTimer                  -> seconds                  (EventController)
--   Misc.RequestInviteData                  -> string                   (SocialController, invite hash)
--   Matchmaking.RequestPartyInviteData      -> string                   (PartyInviteSlot)
--   Misc.RequestGroupMembers                -> {}                       (Credits page)
--   Misc.RequestProfile(targetPlayer)       -> profile card             (Pages.ViewProfile)
--
-- Daily timers roll over at 00:00 UTC. The daily shop is ShopService's.
--
-- Flags the interface sets once seen:
--   Misc.ViewedPatchNotes()               -> LastPatchNotesVersion = CONSTANTS.GAME_VERSION
--   Misc.ViewedDailyShop()                -> LastDailyShopSeen = today's shop day
--   Misc.UnderstoodWarning(warnID)        -> drops that entry from ModerationWarningMessages
--   Data.PromptedNotificationPrompt()     -> PromptedNotificationPrompt = true
--   Data.UpdateMobileButtonSettings(profile, layout | nil) -> MobileButtonSettings[profile]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Misc = Remotes:WaitForChild("Misc")

local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))
local SettingsLibrary = require(Modules:WaitForChild("SettingsLibrary"))
local PlayerDataService = require(script.Parent.PlayerDataService)

local DAY = 86400

local function secondsToNextDay(): number
	return DAY - os.time() % DAY
end

local function seasonSecondsRemaining(): number
	local ok, seconds = pcall(function()
		local SeasonLibrary = require(Modules:WaitForChild("SeasonLibrary"))
		return SeasonLibrary:GetTimeUntilNextSeasonWeek()
	end)
	if ok and type(seconds) == "number" and seconds == seconds then
		return math.max(seconds, 0)
	end
	return 7 * DAY - os.time() % (7 * DAY)
end

local MiscService = {}

-- Pages.ViewProfile shows these; a nil answer closes the page, which is what "viewing
-- someone's profile doesn't work" was (RemoteFallbacks answered nil).
--   Level, RankedCurrentELO (nil = unranked, SeasonLibrary:GetRank says "Unranked"),
--   FavoriteMap (a DuelLibrary.Maps key), CasualWins, CasualWinPercent, RankedWins,
--   RankedWinPercent (0-1 fraction; -1 = no games -> "N/A"), FavoriteWeapons = a list of
--   WeaponInventory entries (WeaponSlot.new(entry.Name, entry) shows the equipped skin).
local PROFILE_WEAPONS = 3

local function stat(data, name: string, default: any): any
	local value = data[name]
	if value == nil then
		return default
	end
	return value
end

local function winPercent(data, percentField: string, wonField: string, playedField: string?, lostField: string?): number
	local stored = tonumber(data[percentField])
	if stored then
		return stored
	end
	local won = tonumber(data[wonField]) or 0
	local played = playedField and tonumber(data[playedField])
	if not played and lostField then
		played = won + (tonumber(data[lostField]) or 0)
	end
	if not played or played <= 0 then
		return -1
	end
	-- a fraction: StatisticsLibrary's TostringFunction turns 0.5 into "50%"
	return won / played
end

local function rankedELO(data): number?
	local ok, SeasonLibrary = pcall(require, Modules:WaitForChild("SeasonLibrary"))
	local season = ok and SeasonLibrary.CurrentSeason
	local record = season and data.Seasons and data.Seasons[season.Name]
	local ranked = record and record.RankedPerformances and record.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME]
	return ranked and tonumber(ranked.CurrentELO) or nil
end

-- "Most played": nothing records per-weapon play time yet, so favourited weapons first, then the
-- highest level / XP (a proxy for use).
-- Only what WeaponSlot reads (ItemLibrary:GetViewModelImage(Name, Skin)) travels, as a fresh
-- table: another player's saved entry can carry anything (old fields, odd key types) and one
-- value a RemoteFunction can't carry fails the whole answer.
local function weaponCard(entry): { [string]: any }
	local skin = entry.Skin
	if type(skin) == "table" then
		skin = type(skin.Name) == "string" and { Name = skin.Name, Inverted = skin.Inverted == true or nil } or nil
	elseif type(skin) ~= "string" then
		skin = nil
	end
	return {
		Name = entry.Name,
		Level = tonumber(entry.Level) or 1,
		XP = tonumber(entry.XP) or 0,
		Skin = skin,
	}
end

local function favoriteWeapons(data): { any }
	local ItemLibrary = require(Modules:WaitForChild("ItemLibrary"))
	local weapons = {}
	for _, entry in data.WeaponInventory or {} do
		-- ItemLibrary.Items[name] must exist: WeaponSlot indexes its .Status.
		if type(entry) == "table" and type(entry.Name) == "string" and ItemLibrary.Items[entry.Name] then
			table.insert(weapons, {
				entry = entry,
				favorited = entry.IsFavorited == true,
				level = tonumber(entry.Level) or 0,
				xp = tonumber(entry.XP) or 0,
			})
		end
	end
	table.sort(weapons, function(a, b)
		if a.favorited ~= b.favorited then
			return a.favorited
		end
		if a.level ~= b.level then
			return a.level > b.level
		end
		return a.xp > b.xp
	end)
	local top = {}
	for index = 1, math.min(PROFILE_WEAPONS, #weapons) do
		top[index] = weaponCard(weapons[index].entry)
	end
	return top
end

-- A card with nothing in it but the player's level (their Level attribute, which PlayerService
-- keeps for everyone): what the page gets while their data is still loading, or if reading it
-- failed, so the page shows zeros instead of closing.
local function blankCard(target: Player): { [string]: any }
	return {
		Level = tonumber(target:GetAttribute("Level")) or 1,
		RankedCurrentELO = nil,
		FavoriteMap = nil,
		CasualWins = 0,
		CasualWinPercent = -1,
		RankedWins = 0,
		RankedWinPercent = -1,
		FavoriteWeapons = {},
	}
end

function MiscService.GetProfileCard(target: Player): { [string]: any }?
	-- Another player's data can still be loading (ProfileStore waits out a session another server
	-- holds), so give it a moment rather than answering nil -- nil closes the page.
	local data = PlayerDataService.WaitForData(target, 5)
	if not data then
		warn("[Misc] RequestProfile: no data for " .. target.Name .. " yet, sending a blank card")
		return blankCard(target)
	end

	local card = blankCard(target)
	local parts = {
		Level = function() return tonumber(stat(data, "Level", 1)) or card.Level end,
		RankedCurrentELO = function() return rankedELO(data) end,
		FavoriteMap = function() return type(data.StatisticFavoriteMap) == "string" and data.StatisticFavoriteMap or nil end,
		CasualWins = function() return tonumber(stat(data, "StatisticDuelsWon", 0)) or 0 end,
		CasualWinPercent = function() return winPercent(data, "StatisticDuelsWinPercent", "StatisticDuelsWon", "StatisticDuelsPlayed", "StatisticDuelsLost") end,
		RankedWins = function() return tonumber(stat(data, "StatisticRankedDuelsWon", 0)) or 0 end,
		RankedWinPercent = function() return winPercent(data, "StatisticRankedDuelsWinPercent", "StatisticRankedDuelsWon", "StatisticRankedDuelsPlayed", "StatisticRankedDuelsLost") end,
		FavoriteWeapons = function() return favoriteWeapons(data) end,
	}
	-- Field by field, so one odd value in a saved profile costs that field, not the whole page.
	for field, read in parts do
		local ok, value = pcall(read)
		if ok then
			card[field] = value
		else
			warn(string.format("[Misc] RequestProfile: %s for %s failed: %s", field, target.Name, tostring(value)))
		end
	end
	return card
end

-- Feature flags the live game switched on and off ("FreeToUse<Status>Weapons"...). None are on.
MiscService.FFlags = {}

function MiscService.SetFFlag(name: string, value: any)
	MiscService.FFlags[name] = value
	Misc.UpdateFFlag:FireAllClients(name, value)
end

function MiscService.Start()
	Misc.RequestFFlags.OnServerInvoke = function()
		return MiscService.FFlags
	end

	Misc.RequestTaskRefreshTimeRemaining.OnServerInvoke = secondsToNextDay
	Misc.RequestAdventCalendarTimeRemaining.OnServerInvoke = secondsToNextDay
	Misc.RequestEventTimer.OnServerInvoke = secondsToNextDay
	Misc.RequestSeasonTimer.OnServerInvoke = seasonSecondsRemaining

	Misc.RequestInviteData.OnServerInvoke = function(player: Player)
		return tostring(player.UserId)
	end
	Remotes.Matchmaking.RequestPartyInviteData.OnServerInvoke = function(player: Player)
		return tostring(player.UserId)
	end

	Misc.RequestGroupMembers.OnServerInvoke = function()
		return {}
	end

	Misc.RequestProfile.OnServerInvoke = function(player: Player, target: any)
		if typeof(target) ~= "Instance" or not target:IsA("Player") then
			target = player
		elseif target.Parent ~= game:GetService("Players") then
			-- They left: nothing to show (the page closes on nil).
			return nil
		end
		local ok, card = pcall(MiscService.GetProfileCard, target)
		if not ok or type(card) ~= "table" then
			warn("[Misc] RequestProfile for " .. target.Name .. " failed: " .. tostring(card))
			return blankCard(target)
		end
		return card
	end


	Misc.ViewedPatchNotes.OnServerEvent:Connect(function(player: Player)
		PlayerDataService.Set(player, "LastPatchNotesVersion", CONSTANTS.GAME_VERSION)
	end)

	Misc.ViewedDailyShop.OnServerEvent:Connect(function(player: Player)
		PlayerDataService.Set(player, "LastDailyShopSeen", os.time() // DAY)
	end)

	Misc.UnderstoodWarning.OnServerEvent:Connect(function(player: Player, warnID: any)
		local warnings = PlayerDataService.Get(player, "ModerationWarningMessages")
		if not warnings then
			return
		end
		for index = #warnings, 1, -1 do
			if type(warnings[index]) == "table" and warnings[index].WarnID == warnID then
				table.remove(warnings, index)
			end
		end
		PlayerDataService.Replicate(player, "ModerationWarningMessages")
	end)

	Remotes.Data.PromptedNotificationPrompt.OnServerEvent:Connect(function(player: Player)
		PlayerDataService.Set(player, "PromptedNotificationPrompt", true)
	end)

	Remotes.Data.UpdateMobileButtonSettings.OnServerEvent:Connect(function(player: Player, profile: any, layout: any)
		profile = tonumber(profile)
		local all = PlayerDataService.Get(player, "MobileButtonSettings")
		if not all or not profile or profile % 1 ~= 0 or profile < 1 or profile > SettingsLibrary.NUM_PROFILES then
			return
		end
		if layout ~= nil and typeof(layout) ~= "table" then
			return
		end
		all[profile] = layout or {}
		PlayerDataService.Replicate(player, "MobileButtonSettings")
	end)
end

MiscService.Remotes = {
	Misc.RequestFFlags,
	Misc.RequestTaskRefreshTimeRemaining,
	Misc.RequestAdventCalendarTimeRemaining,
	Misc.RequestEventTimer,
	Misc.RequestSeasonTimer,
	Misc.RequestInviteData,
	Misc.RequestGroupMembers,
	Misc.RequestProfile,
	Remotes.Matchmaking.RequestPartyInviteData,
	Misc.ViewedPatchNotes,
	Misc.ViewedDailyShop,
	Misc.UnderstoodWarning,
	Remotes.Data.PromptedNotificationPrompt,
	Remotes.Data.UpdateMobileButtonSettings,
}

return MiscService
