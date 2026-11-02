-- The game's own developer menu (Pages.Debug): Remotes.Debug.Command:InvokeServer(name, value)
-- for every entry in DebugLibrary.Order the player is authorised for.
--
-- Authorisation is the shared DebugLibrary:IsAuthorizedToUseCommand(name, PermissionsRoles):
-- everyone in Studio, and on a live server whoever holds a role with those permissions.
-- The experience's owner is given "role_administrator" when their data loads.
--
-- Only the commands that change saved data are here. The combat ones (Octo Mode, infinite
-- ammo, invincibility, OHKO...) wait for the combat rebuild and answer "not available".

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))
local CosmeticLibrary = require(Modules:WaitForChild("CosmeticLibrary"))
local DebugLibrary = require(Modules:WaitForChild("DebugLibrary"))
local ShopLibrary = require(Modules:WaitForChild("ShopLibrary"))
local SeasonLibrary = require(Modules:WaitForChild("SeasonLibrary"))

local PlayerDataService = require(script.Parent.PlayerDataService)
local DataTemplate = require(script.Parent.DataTemplate)
local MiscService = require(script.Parent.MiscService)
local RewardService = require(script.Parent.RewardService)
local TaskService = require(script.Parent.TaskService)

local Command = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Debug"):WaitForChild("Command")

local ADMIN_ROLE = "role_administrator"
local PRIME_PASS_TRACK = 2

local DebugService = {}

local function number(value: any, low: number, high: number): number?
	local n = tonumber(value)
	if not n or n ~= n then
		return nil
	end
	return math.clamp(math.floor(n), low, high)
end

local function season(player: Player)
	local data = PlayerDataService.Get(player)
	DataTemplate.EnsureSeason(data)
	return data.Seasons[SeasonLibrary.CurrentSeason.Name]
end

local function unlockType(player: Player, cosmeticType: string?, share: number?)
	local inventory = PlayerDataService.Get(player, "CosmeticInventory")
	for name, cosmetic in CosmeticLibrary.Cosmetics do
		if type(cosmetic) == "table" and (cosmeticType == nil or cosmetic.Type == cosmeticType) then
			if share == nil or math.random() < share then
				inventory[name] = true
			end
		end
	end
	PlayerDataService.Replicate(player, "CosmeticInventory")
end

-- A saved number that is also mirrored on the Player as an attribute (Level, win streak).
local function setStat(player: Player, field: string, value: number)
	PlayerDataService.Set(player, field, value)
	if player:GetAttribute(field) ~= nil then
		player:SetAttribute(field, value)
	end
end

-- name -> function(player, value)
local Commands = {}

function Commands.SetLevel(player, value)
	local level = number(value, 0, 9999)
	if level then
		setStat(player, "Level", level)
	end
end

function Commands.LevelUp(player)
	setStat(player, "Level", (PlayerDataService.Get(player, "Level") or 1) + 1)
end

for command, field in {
	SetKeys = "WeaponKeys",
	SetUnlockTokens = "UnlockTokens",
	SetGlory = "Glory",
	SetWinStreak = "StatisticDuelsWinStreak",
	SetDuelsPlayed = "StatisticDuelsPlayed",
	SetDuelsWon = "StatisticDuelsWon",
	SetDuelsLost = "StatisticDuelsLost",
} do
	Commands[command] = function(player, value)
		local n = number(value, 0, 1e9)
		if n then
			setStat(player, field, n)
		end
	end
end

function Commands.UnlockWeapons(player)
	local inventory = PlayerDataService.Get(player, "WeaponInventory")
	local owned = {}
	for _, entry in inventory do
		owned[entry.Name] = true
	end
	for _, weapon in ShopLibrary:GetReleasedOwnableWeapons() do
		if not owned[weapon] then
			table.insert(inventory, DataTemplate.NewWeapon(weapon))
		end
	end
	PlayerDataService.Replicate(player, "WeaponInventory")
end

function Commands.LockWeapons(player)
	local kept = {}
	for _, entry in PlayerDataService.Get(player, "WeaponInventory") do
		if table.find(CONSTANTS.DEFAULT_WEAPONS, entry.Name) then
			table.insert(kept, entry)
		end
	end
	PlayerDataService.Set(player, "WeaponInventory", kept)
end

for command, cosmeticType in {
	UnlockSkins = "Skin",
	UnlockWraps = "Wrap",
	UnlockCharms = "Charm",
	UnlockFinishers = "Finisher",
	UnlockEmotes = "Emote",
} do
	Commands[command] = function(player)
		unlockType(player, cosmeticType)
	end
end

function Commands.UnlockCosmeticsPartially(player)
	unlockType(player, nil, 0.5)
end

function Commands.LockCosmetics(player)
	PlayerDataService.Set(player, "CosmeticInventory", {})
	for _, entry in PlayerDataService.Get(player, "WeaponInventory") do
		entry.Skin, entry.Wrap, entry.Charm, entry.Finisher = nil, nil, nil, nil
	end
	PlayerDataService.Replicate(player, "WeaponInventory")
	PlayerDataService.Set(player, "EquippedEmotes", {})
end

function Commands.SetBattlePassLevel(player, value)
	local level = number(value, 0, 100)
	if level then
		season(player).BattlePass.PassLevel = level
		PlayerDataService.Replicate(player, "Seasons")
	end
end

function Commands.SetBattlePassPrime(player, value)
	season(player).BattlePass.MaxPassTrackNum = value == true and PRIME_PASS_TRACK or 1
	PlayerDataService.Replicate(player, "Seasons")
end

function Commands.ResetSeasonData(player)
	local data = PlayerDataService.Get(player)
	data.Seasons[SeasonLibrary.CurrentSeason.Name] = nil
	DataTemplate.EnsureSeason(data)
	PlayerDataService.Replicate(player, "Seasons")
end

for _, status in { "Standard", "Prime", "Contraband" } do
	Commands["SetFreeToUse" .. status .. "Weapons"] = function(_player, value)
		MiscService.SetFFlag("FreeToUse" .. status .. "Weapons", value == true)
	end
end

function Commands.IncrementTasks(player)
	TaskService.IncrementAll(player)
end

function Commands.RefreshDailyTasks(player)
	TaskService.NewDay(player, false)
end

function Commands.GiveLootboxes(player)
	for _, boxName in CosmeticLibrary.LootboxOrder do
		local info = CosmeticLibrary.Rewards[boxName]
		local weapon = info and info.HasWeaponCosmetics and "IsRandom" or nil
		RewardService.Grant(player, { Name = boxName, Quantity = 1, Weapon = weapon }, false)
	end
end

function Commands.ClearBackpack(player)
	PlayerDataService.Set(player, "UnclaimedRewards", {})
end

function Commands.ShutdownServer(player)
	for _, other in Players:GetPlayers() do
		other:Kick(string.format("The server was shut down by %s", player.Name))
	end
end

function DebugService.Start()
	Command.OnServerInvoke = function(player: Player, name: any, value: any)
		if typeof(name) ~= "string" then
			return false, "No command"
		end

		local roles = PlayerDataService.Get(player, "PermissionsRoles") or {}
		if not DebugLibrary:IsAuthorizedToUseCommand(name, roles) then
			return false, "Not authorised"
		end

		local handler = Commands[name]
		if not handler then
			return false, name .. " is not available yet"
		end

		local ok, err = pcall(handler, player, value)
		if not ok then
			warn(string.format("[Debug] %s failed: %s", name, tostring(err)))
			return false, "Failed"
		end
		return true
	end

	-- On a live server the menu is gated by roles; the owner gets the administrator one.
	PlayerDataService.Loaded:Connect(function(player: Player, data)
		local isOwner = game.CreatorType == Enum.CreatorType.User and player.UserId == game.CreatorId
		if isOwner and not table.find(data.PermissionsRoles, ADMIN_ROLE) then
			table.insert(data.PermissionsRoles, ADMIN_ROLE)
		end
	end)
end

DebugService.Remotes = { Command }

return DebugService
