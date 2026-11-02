-- The in-game admin panel (StarterPlayerScripts.AdminPanel, built with ReplicatedStorage.NovaUI).
--
--   ReplicatedStorage.AdminPanelRemote:InvokeServer(action, a, b)
--     -> { Ok = bool, Message = string?, State = {...}, Catalog = {...}? }
--
-- Everyone can use it. Every command except State/Catalog has a COOLDOWN per player, keyed by
-- the command and its target (so each weapon / crate / currency has its own timer).
--
-- Recorded statistics (win streak, duels / ranked played and won, tasks, eliminations...) are
-- deliberately NOT editable here: they are earned in duels only.
--
-- Grants go through the same data the rest of the server uses:
--   weapons      WeaponInventory (DataTemplate.NewWeapon), levels capped at MAX_WEAPON_LEVEL
--   cosmetics    CosmeticInventory[name] = true (owned on every weapon, like DebugService)
--   crates       RewardService.Grant -> the backpack (UnclaimedRewards)
--   gamepasses   Gamepasses[name] + GamepassBundlesClaimed[name] + the bundle's rewards
--   currency / level: PlayerDataService.Set, Level mirrored to the player attribute

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CosmeticLibrary = require(Modules:WaitForChild("CosmeticLibrary"))
local CurrencyLibrary = require(Modules:WaitForChild("CurrencyLibrary"))
local ItemLibrary = require(Modules:WaitForChild("ItemLibrary"))
local MonetizationLibrary = require(Modules:WaitForChild("MonetizationLibrary"))
local SeasonLibrary = require(Modules:WaitForChild("SeasonLibrary"))
local ShopLibrary = require(Modules:WaitForChild("ShopLibrary"))

local PlayerDataService = require(script.Parent.PlayerDataService)
local DataTemplate = require(script.Parent.DataTemplate)
local RewardService = require(script.Parent.RewardService)

local COOLDOWN = 25
local MAX_WEAPON_LEVEL = 99
local MAX_CRATE_AMOUNT = 1000
local MAX_VALUE = 1e9
local PRIME_PASS_TRACK = 2
local MAX_PASS_LEVEL = 100
local CLASS_ORDER = { "Primary", "Secondary", "Melee", "Utility" }
local COSMETIC_TYPES = { "Skin", "Wrap", "Charm", "Finisher", "Emote" }

local AdminPanelService = {}

local remote: RemoteFunction
local cooldowns: { [Player]: { [string]: number } } = {}
local busy: { [Player]: boolean } = {}

-- catalog ------------------------------------------------------------------------------------

local catalog = nil
local ownableWeapons: { [string]: boolean } = {}
local crateNames: { [string]: boolean } = {}
local cosmeticTotals: { [string]: number } = {}

local function bundleFor(passName: string)
	local pass = MonetizationLibrary.Gamepasses[passName]
	local bundle = pass and pass.BundleName and MonetizationLibrary.Bundles[pass.BundleName]
	if bundle then
		return bundle
	end
	for _, candidate in MonetizationLibrary.Bundles do
		if type(candidate) == "table" and candidate.GamepassName == passName then
			return candidate
		end
	end
	return nil
end

local function buildCatalog()
	if catalog then
		return catalog
	end

	local weapons = {}
	for _, name in ShopLibrary:GetReleasedOwnableWeapons() do
		local item = ItemLibrary.Items[name]
		if item then
			ownableWeapons[name] = true
			table.insert(weapons, {
				Name = name,
				Class = type(item.Class) == "string" and item.Class or "Other",
				Image = type(item.Image) == "string" and item.Image or "",
				Status = type(item.Status) == "string" and item.Status or "Standard",
			})
		end
	end
	table.sort(weapons, function(a, b)
		return a.Name < b.Name
	end)

	for name, cosmetic in CosmeticLibrary.Cosmetics do
		if type(cosmetic) == "table" and type(cosmetic.Type) == "string" then
			cosmeticTotals[cosmetic.Type] = (cosmeticTotals[cosmetic.Type] or 0) + 1
		end
	end

	local crates = {}
	for _, name in CosmeticLibrary.LootboxOrder do
		local info = CosmeticLibrary.Rewards[name]
		if info and info.Type == "Lootbox" then
			crateNames[name] = true
			table.insert(crates, {
				Name = name,
				DisplayName = info.DisplayName or name,
				Image = info.Image or "",
			})
		end
	end

	local cosmeticImages = {}
	for _, kind in COSMETIC_TYPES do
		local info = CosmeticLibrary.Types and CosmeticLibrary.Types[kind]
		cosmeticImages[kind] = info and info.Image or ""
	end

	-- A pass shows the first weapon (or anything with an image) its bundle hands out.
	local function rewardImage(reward): string?
		local item = ItemLibrary.Items[reward.Name]
		if item and type(item.Image) == "string" and item.Image ~= "" then
			return item.Image, true
		end
		local info = CosmeticLibrary.Rewards[reward.Name] or CosmeticLibrary.Cosmetics[reward.Name]
		if info and type(info.Image) == "string" and info.Image ~= "" then
			return info.Image, false
		end
		return nil
	end
	local passes = {}
	for name, pass in MonetizationLibrary.Gamepasses do
		if type(pass) == "table" then
			local bundle = bundleFor(name)
			local image, isWeapon = nil, false
			for _, reward in bundle and bundle.Rewards or {} do
				local found, weapon = rewardImage(reward)
				if found and (weapon or not image) then
					image, isWeapon = found, weapon
					if weapon then
						break
					end
				end
			end
			table.insert(passes, {
				Name = name,
				DisplayName = pass.DisplayName or name,
				Price = pass.StaticRobuxPrice or 0,
				Bubble = bundle and bundle.BubbleText or nil,
				Rewards = bundle and bundle.Rewards and #bundle.Rewards or 0,
				Image = image or "",
				ImageIsWeapon = isWeapon,
			})
		end
	end
	table.sort(passes, function(a, b)
		return a.Price < b.Price
	end)

	local currencies = {}
	for _, name in CurrencyLibrary.Order do
		local info = CurrencyLibrary.Info[name]
		if info and info.DataName then
			table.insert(currencies, {
				Field = info.DataName,
				Name = info.DisplayNamePlural or name,
				Image = info.Image or "",
			})
		end
	end

	catalog = {
		Weapons = weapons,
		Classes = CLASS_ORDER,
		CosmeticTypes = COSMETIC_TYPES,
		CosmeticTotals = cosmeticTotals,
		CosmeticImages = cosmeticImages,
		Crates = crates,
		Gamepasses = passes,
		Currencies = currencies,
		PassImages = SeasonLibrary.PASS_TRACK_IMAGES or {},
		Cooldown = COOLDOWN,
		MaxWeaponLevel = MAX_WEAPON_LEVEL,
		MaxPassLevel = MAX_PASS_LEVEL,
	}
	return catalog
end

local CURRENCY_FIELDS = {}

-- helpers ------------------------------------------------------------------------------------

local function number(value: any, low: number, high: number): number?
	local n = tonumber(value)
	if not n or n ~= n or n == math.huge or n == -math.huge then
		return nil
	end
	return math.clamp(math.floor(n), low, high)
end

local function setField(player: Player, field: string, value: any)
	PlayerDataService.Set(player, field, value)
	if player:GetAttribute(field) ~= nil then
		player:SetAttribute(field, value)
	end
end

local function season(data)
	DataTemplate.EnsureSeason(data)
	return data.Seasons[SeasonLibrary.CurrentSeason.Name]
end

local function weaponEntries(data): { [string]: any }
	local byName = {}
	for _, entry in data.WeaponInventory do
		if type(entry) == "table" and entry.Name then
			byName[entry.Name] = entry
		end
	end
	return byName
end

-- state --------------------------------------------------------------------------------------

local function stateFor(player: Player)
	local data = PlayerDataService.Get(player)
	if not data then
		return nil
	end

	local weapons = {}
	for name, entry in weaponEntries(data) do
		weapons[name] = tonumber(entry.Level) or 1
	end

	local cosmetics = {}
	for name, owned in data.CosmeticInventory do
		local cosmetic = CosmeticLibrary.Cosmetics[name]
		if owned and type(cosmetic) == "table" and cosmetic.Type then
			cosmetics[cosmetic.Type] = (cosmetics[cosmetic.Type] or 0) + 1
		end
	end

	local crates = {}
	for _, entry in data.UnclaimedRewards do
		if type(entry) == "table" and crateNames[entry.Name] then
			crates[entry.Name] = (crates[entry.Name] or 0) + (tonumber(entry.Quantity) or 1)
		end
	end

	local passes = {}
	for name, owned in data.Gamepasses do
		if owned then
			passes[name] = true
		end
	end

	local currency = {}
	for field in CURRENCY_FIELDS do
		currency[field] = tonumber(data[field]) or 0
	end

	local record = season(data)
	local pass = record.BattlePass

	local now = os.clock()
	local remaining = {}
	for key, readyAt in cooldowns[player] or {} do
		if readyAt > now then
			remaining[key] = math.ceil(readyAt - now)
		end
	end

	return {
		Weapons = weapons,
		Cosmetics = cosmetics,
		Crates = crates,
		Gamepasses = passes,
		Currency = currency,
		Level = tonumber(data.Level) or 1,
		XP = tonumber(data.XP) or 0,
		PassLevel = tonumber(pass.PassLevel) or 0,
		Prime = (tonumber(pass.MaxPassTrackNum) or 1) >= PRIME_PASS_TRACK,
		Cooldowns = remaining,
	}
end

-- grants -------------------------------------------------------------------------------------

local function unlockWeapon(data, name: string): boolean
	if not ownableWeapons[name] or weaponEntries(data)[name] then
		return false
	end
	table.insert(data.WeaponInventory, DataTemplate.NewWeapon(name))
	return true
end

local function unlockAllWeapons(player: Player, data): number
	local count = 0
	for name in ownableWeapons do
		if unlockWeapon(data, name) then
			count += 1
		end
	end
	PlayerDataService.Replicate(player, "WeaponInventory")
	return count
end

local function maxAllWeapons(player: Player, data): number
	local count = 0
	for _, entry in data.WeaponInventory do
		if type(entry) == "table" and (tonumber(entry.Level) or 1) < MAX_WEAPON_LEVEL then
			entry.Level = MAX_WEAPON_LEVEL
			entry.XP = 0
			count += 1
		end
	end
	PlayerDataService.Replicate(player, "WeaponInventory")
	return count
end

local function unlockCosmetics(player: Player, data, cosmeticType: string?): number
	local inventory = data.CosmeticInventory
	local count = 0
	for name, cosmetic in CosmeticLibrary.Cosmetics do
		if type(cosmetic) == "table" and (cosmeticType == nil or cosmetic.Type == cosmeticType) and inventory[name] ~= true then
			inventory[name] = true
			count += 1
		end
	end
	PlayerDataService.Replicate(player, "CosmeticInventory")
	return count
end

local function giveCrate(player: Player, name: string, amount: number)
	local info = CosmeticLibrary.Rewards[name]
	local weapon = info and info.HasWeaponCosmetics and "IsRandom" or nil
	RewardService.Grant(player, { Name = name, Quantity = amount, Weapon = weapon }, false)
end

local function giveGamepass(player: Player, data, passName: string): boolean
	if type(MonetizationLibrary.Gamepasses[passName]) ~= "table" or data.Gamepasses[passName] then
		return false
	end
	data.Gamepasses[passName] = true
	local claimedBefore = data.GamepassBundlesClaimed[passName]
	data.GamepassBundlesClaimed[passName] = true
	PlayerDataService.Replicate(player, "Gamepasses")
	PlayerDataService.Replicate(player, "GamepassBundlesClaimed")
	local bundle = bundleFor(passName)
	if bundle and not claimedBefore then
		RewardService.GrantAll(player, bundle.Rewards or {}, false)
	end
	return true
end

local function setPrime(player: Player, data, on: boolean)
	season(data).BattlePass.MaxPassTrackNum = on and PRIME_PASS_TRACK or 1
	PlayerDataService.Replicate(player, "Seasons")
end

-- commands: name -> function(player, data, a, b) -> (ok, message, cooldownKey?)
-- cooldownKey defaults to the command name; return false to not start a cooldown.

local Commands = {}

function Commands.UnlockEverything(player, data)
	unlockAllWeapons(player, data)
	maxAllWeapons(player, data)
	unlockCosmetics(player, data, nil)
	for name in MonetizationLibrary.Gamepasses do
		giveGamepass(player, data, name)
	end
	setPrime(player, data, true)
	return true, "Unlocked everything"
end

function Commands.UnlockAllWeapons(player, data)
	local count = unlockAllWeapons(player, data)
	return true, count > 0 and string.format("Unlocked %d weapons", count) or "You already own every weapon"
end

function Commands.MaxAllWeapons(player, data)
	local count = maxAllWeapons(player, data)
	return true, count > 0 and string.format("Maxed %d weapons", count) or "Every weapon you own is maxed"
end

-- Tap a weapon: unlock it, or max it if it is already owned.
function Commands.Weapon(player, data, name)
	if typeof(name) ~= "string" or not ownableWeapons[name] then
		return false, "Unknown weapon"
	end
	local entry = weaponEntries(data)[name]
	if not entry then
		unlockWeapon(data, name)
		PlayerDataService.Replicate(player, "WeaponInventory")
		return true, "Unlocked " .. name, "Weapon:" .. name
	end
	if (tonumber(entry.Level) or 1) >= MAX_WEAPON_LEVEL then
		return false, name .. " is already maxed"
	end
	entry.Level = MAX_WEAPON_LEVEL
	entry.XP = 0
	PlayerDataService.Replicate(player, "WeaponInventory")
	return true, name .. " is now level " .. MAX_WEAPON_LEVEL, "Weapon:" .. name
end

function Commands.UnlockCosmetics(player, data, cosmeticType)
	if typeof(cosmeticType) ~= "string" or not table.find(COSMETIC_TYPES, cosmeticType) then
		return false, "Unknown cosmetic type"
	end
	local count = unlockCosmetics(player, data, cosmeticType)
	return true, string.format("Unlocked %d %ss", count, string.lower(cosmeticType)), "Cosmetics:" .. cosmeticType
end

function Commands.UnlockAllCosmetics(player, data)
	local count = unlockCosmetics(player, data, nil)
	return true, string.format("Unlocked %d cosmetics", count)
end

function Commands.GiveCrate(player, data, name, amount)
	if typeof(name) ~= "string" or not crateNames[name] then
		return false, "Unknown crate"
	end
	local n = number(amount, 1, MAX_CRATE_AMOUNT) or 1
	giveCrate(player, name, n)
	return true, string.format("Gave %dx %s", n, name), "Crate:" .. name
end

function Commands.GiveAllCrates(player, data, amount)
	local n = number(amount, 1, MAX_CRATE_AMOUNT) or 1
	local count = 0
	for _, name in CosmeticLibrary.LootboxOrder do
		if crateNames[name] then
			giveCrate(player, name, n)
			count += 1
		end
	end
	return true, string.format("Gave %dx of all %d crates", n, count)
end

-- Takes up to `amount` of that crate out of the backpack (every weapon variant of it).
function Commands.RemoveCrate(player, data, name, amount)
	if typeof(name) ~= "string" or not crateNames[name] then
		return false, "Unknown crate"
	end
	local left = number(amount, 1, 1e6) or 1
	local removed = 0
	for index = #data.UnclaimedRewards, 1, -1 do
		local entry = data.UnclaimedRewards[index]
		if left > 0 and type(entry) == "table" and entry.Name == name then
			local have = tonumber(entry.Quantity) or 1
			local take = math.min(have, left)
			left -= take
			removed += take
			if take >= have then
				table.remove(data.UnclaimedRewards, index)
			else
				entry.Quantity = have - take
			end
		end
	end
	if removed == 0 then
		return false, "No " .. name .. " in your backpack"
	end
	PlayerDataService.Replicate(player, "UnclaimedRewards")
	return true, string.format("Removed %dx %s", removed, name)
end

-- Empties the whole backpack (crates and anything else waiting in it).
function Commands.ClearBackpack(player, data)
	local count = 0
	for _, entry in data.UnclaimedRewards do
		count += type(entry) == "table" and (tonumber(entry.Quantity) or 1) or 0
	end
	if count == 0 then
		return false, "Your backpack is already empty"
	end
	PlayerDataService.Set(player, "UnclaimedRewards", {})
	return true, string.format("Removed %d items from your backpack", count)
end

function Commands.GiveGamepass(player, data, name)
	if typeof(name) ~= "string" or type(MonetizationLibrary.Gamepasses[name]) ~= "table" then
		return false, "Unknown game pass"
	end
	if not giveGamepass(player, data, name) then
		return false, "You already own that game pass"
	end
	return true, "Gave " .. (MonetizationLibrary.Gamepasses[name].DisplayName or name), "Gamepass:" .. name
end

function Commands.GiveAllGamepasses(player, data)
	local count = 0
	for name in MonetizationLibrary.Gamepasses do
		if giveGamepass(player, data, name) then
			count += 1
		end
	end
	return true, count > 0 and string.format("Gave %d game passes", count) or "You already own every game pass"
end

function Commands.SetCurrency(player, data, field, value)
	if typeof(field) ~= "string" or not CURRENCY_FIELDS[field] then
		return false, "Unknown currency"
	end
	local n = number(value, 0, MAX_VALUE)
	if not n then
		return false, "Enter a number"
	end
	PlayerDataService.Set(player, field, n)
	return true, CURRENCY_FIELDS[field] .. " set to " .. n, "Currency:" .. field
end

function Commands.SetLevel(player, data, value)
	local n = number(value, 1, 9999)
	if not n then
		return false, "Enter a number"
	end
	setField(player, "Level", n)
	PlayerDataService.Set(player, "XP", 0)
	return true, "Level set to " .. n
end

function Commands.SetPassLevel(player, data, value)
	local n = number(value, 0, MAX_PASS_LEVEL)
	if not n then
		return false, "Enter a number"
	end
	local pass = season(data).BattlePass
	pass.PassLevel = n
	pass.PassXP = 0
	PlayerDataService.Replicate(player, "Seasons")
	return true, "Season pass level set to " .. n
end

function Commands.SetPrime(player, data, value)
	setPrime(player, data, value == true)
	return true, value == true and "Prime pass on" or "Prime pass off"
end

-- read-only profile (the panel's profile card) ------------------------------------------------
-- Statistics are shown, never edited: they are earned in duels.

local function stat(data, field: string): number
	return tonumber(data[field]) or 0
end

local function ratio(a: number, b: number): string
	if b <= 0 then
		return a > 0 and string.format("%.2f", a) or "-"
	end
	return string.format("%.2f", a / b)
end

local function percent(won: number, played: number): string
	if played <= 0 then
		return "-"
	end
	return string.format("%d%%", math.floor(won / played * 100 + 0.5))
end

local function hours(seconds: number): string
	if seconds < 3600 then
		return string.format("%dm", math.floor(seconds / 60))
	end
	return string.format("%.1fh", seconds / 3600)
end

local function profileFor(_player: Player, data)
	local played = stat(data, "StatisticDuelsPlayed")
	local won = stat(data, "StatisticDuelsWon")
	local lost = stat(data, "StatisticDuelsLost")
	if played <= 0 then
		played = won + lost
	end
	local rankedPlayed = stat(data, "StatisticRankedDuelsPlayed")
	local rankedWon = stat(data, "StatisticRankedDuelsWon")
	local elims, deaths = stat(data, "StatisticEliminations"), stat(data, "StatisticDeaths")
	local owned = 0
	for _ in weaponEntries(data) do
		owned += 1
	end
	return {
		Level = tonumber(data.Level) or 1,
		Weapons = owned,
		Groups = {
			{
				Title = "Duels",
				Color = "Green",
				Stats = {
					{ "Win Streak", tostring(stat(data, "StatisticDuelsWinStreak")), "\u{1F525}" },
					{ "Best Win Streak", tostring(stat(data, "StatisticDuelsWinStreakHighest")), "\u{1F3C6}" },
					{ "Duels Won", tostring(won), "\u{2705}" },
					{ "Duels Played", tostring(played), "\u{2694}\u{FE0F}" },
					{ "Duels Lost", tostring(lost), "\u{274C}" },
					{ "Win Rate", percent(won, played), "\u{1F4C8}" },
				},
			},
			{
				Title = "Ranked",
				Color = "Purple",
				Stats = {
					{ "Ranked Won", tostring(rankedWon), "\u{1F947}" },
					{ "Ranked Played", tostring(rankedPlayed), "\u{1F3AF}" },
					{ "Ranked Win Rate", percent(rankedWon, rankedPlayed), "\u{1F4CA}" },
				},
			},
			{
				Title = "Combat",
				Color = "Red",
				Stats = {
					{ "Eliminations", tostring(elims), "\u{1F480}" },
					{ "Deaths", tostring(deaths), "\u{26B0}\u{FE0F}" },
					{ "K/D", ratio(elims, deaths), "\u{2696}\u{FE0F}" },
					{ "Assists", tostring(stat(data, "StatisticAssists")), "\u{1F91D}" },
					{ "Damage Dealt", tostring(stat(data, "StatisticDamageDealt")), "\u{1F4A5}" },
					{ "MVPs", tostring(stat(data, "StatisticDuelsMVPs")), "\u{2B50}" },
				},
			},
			{
				Title = "Other",
				Color = "Blue",
				Stats = {
					{ "Tasks Completed", tostring(stat(data, "StatisticTasksCompleted")), "\u{1F4CB}" },
					{ "Rounds Won", tostring(stat(data, "StatisticRoundsWon")), "\u{1F3C1}" },
					{ "Playtime", hours(stat(data, "StatisticPlaytime")), "\u{23F1}\u{FE0F}" },
				},
			},
		},
	}
end

-- remote -------------------------------------------------------------------------------------

local function onInvoke(player: Player, action: any, a: any, b: any)
	if typeof(action) ~= "string" then
		return { Ok = false, Message = "No command" }
	end

	local data = PlayerDataService.IsLoaded(player) and PlayerDataService.Get(player)
	if not data then
		return { Ok = false, Message = "Your data is still loading" }
	end

	if action == "Profile" then
		return { Ok = true, Profile = profileFor(player, data) }
	elseif action == "Catalog" then
		return { Ok = true, Catalog = buildCatalog(), State = stateFor(player) }
	elseif action == "State" then
		return { Ok = true, State = stateFor(player) }
	end

	local handler = Commands[action]
	if not handler then
		return { Ok = false, Message = "Unknown command", State = stateFor(player) }
	end
	if busy[player] then
		return { Ok = false, Message = "Slow down", State = stateFor(player) }
	end

	-- The key is known before running for the per-target commands; check it first.
	local key = action
	if typeof(a) == "string" and (action == "Weapon" or action == "GiveCrate" or action == "GiveGamepass" or action == "RemoveCrate") then
		local prefix = ({ GiveCrate = "Crate", GiveGamepass = "Gamepass", RemoveCrate = "RemoveCrate" })[action] or "Weapon"
		key = prefix .. ":" .. a
	elseif typeof(a) == "string" and action == "UnlockCosmetics" then
		key = "Cosmetics:" .. a
	elseif typeof(a) == "string" and action == "SetCurrency" then
		key = "Currency:" .. a
	end

	local timers = cooldowns[player]
	if not timers then
		timers = {}
		cooldowns[player] = timers
	end
	local now = os.clock()
	if timers[key] and timers[key] > now then
		return { Ok = false, Message = string.format("On cooldown for %ds", math.ceil(timers[key] - now)), State = stateFor(player) }
	end

	busy[player] = true
	local ok, success, message = pcall(handler, player, data, a, b)
	busy[player] = nil
	if not ok then
		warn(string.format("[AdminPanel] %s failed for %s: %s", action, player.Name, tostring(success)))
		return { Ok = false, Message = "Something went wrong", State = stateFor(player) }
	end

	if success then
		timers[key] = os.clock() + COOLDOWN
	end
	return { Ok = success == true, Message = message, State = stateFor(player) }
end

function AdminPanelService.Start()
	for _, name in CurrencyLibrary.Order do
		local info = CurrencyLibrary.Info[name]
		if info and info.DataName then
			CURRENCY_FIELDS[info.DataName] = info.DisplayNamePlural or name
		end
	end
	buildCatalog()

	remote = ReplicatedStorage:FindFirstChild("AdminPanelRemote") :: RemoteFunction
	if not remote then
		remote = Instance.new("RemoteFunction")
		remote.Name = "AdminPanelRemote"
		remote.Parent = ReplicatedStorage
	end
	remote.OnServerInvoke = onInvoke

	Players.PlayerRemoving:Connect(function(player: Player)
		cooldowns[player] = nil
		busy[player] = nil
	end)
end

return AdminPanelService
