-- Hands out rewards, the one shape every source uses (login days, tasks, the shop, the
-- season pass, lootboxes):
--
--   { Name = string, Quantity = number?, Weapon = "IsRandom" | "IsUniversal" | <weapon>? }
--
-- Name is looked up the way the client does:
--   CosmeticLibrary.Rewards[Name].Type
--     "Currency"  -> data[DataName] += Quantity        (Key -> WeaponKeys, Glory, Skin Ticket...)
--     "Weapon"    -> the weapon goes into WeaponInventory
--     "Lootbox"   -> into the backpack (UnclaimedRewards), opened later with UseUnclaimedReward
--     "Custom"    -> season pass levels / XP / Prime; the nametags are not rebuilt
--   CosmeticLibrary.Cosmetics[Name] -> CosmeticInventory, per the Weapon field:
--     nil or a skin: true   "IsUniversal": { IsUniversal = true }   a weapon: { [weapon] = true }
--     "IsRandom": a weapon the player owns and lacks it for (LootLibrary:GetRandomUnlockedWeapon)
--
-- Opening a lootbox rolls with the shared LootLibrary (GetContents -> GetLootboxPossibilities ->
-- GetWeightedLootboxOutcome) and plays Functions.LootboxEffect on every client.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))
local CosmeticLibrary = require(Modules:WaitForChild("CosmeticLibrary"))
local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))
local LootLibrary = require(Modules:WaitForChild("LootLibrary"))
local SeasonLibrary = require(Modules:WaitForChild("SeasonLibrary"))

local PlayerDataService = require(script.Parent.PlayerDataService)
local DataTemplate = require(script.Parent.DataTemplate)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local PRIME_PASS_TRACK = 2
local LOOTBOX_STAGGER = 0.35

local RewardService = {}

local function ownedWeapons(data): { [string]: boolean }
	local owned = {}
	for _, entry in data.WeaponInventory do
		owned[entry.Name] = true
	end
	return owned
end

local function notifyCosmetic(data, name: string, weapon: string?)
	local notifications = data.CosmeticNotifications
	if weapon then
		if type(notifications[name]) ~= "table" then
			notifications[name] = {}
		end
		notifications[name][weapon] = true
	else
		notifications[name] = true
	end
end

-- Returns the reward as actually given (IsRandom resolved), or nil if nothing could be given.
local function grantCosmetic(player: Player, data, reward)
	local name = reward.Name
	local cosmetic = CosmeticLibrary.Cosmetics[name]
	local inventory = data.CosmeticInventory
	local weapon = reward.Weapon

	if weapon == "IsRandom" then
		weapon = LootLibrary:GetRandomUnlockedWeapon(data.WeaponInventory, true, name, inventory)
		if not weapon then
			return nil
		end
	end

	if cosmetic.Type == "Skin" or weapon == nil then
		inventory[name] = true
		notifyCosmetic(data, name, nil)
	elseif weapon == "IsUniversal" then
		inventory[name] = { IsUniversal = true }
		notifyCosmetic(data, name, nil)
	elseif inventory[name] ~= true and not (type(inventory[name]) == "table" and inventory[name].IsUniversal) then
		if type(inventory[name]) ~= "table" then
			inventory[name] = {}
		end
		inventory[name][weapon] = true
		notifyCosmetic(data, name, weapon)
	end

	PlayerDataService.Replicate(player, "CosmeticInventory")
	PlayerDataService.Replicate(player, "CosmeticNotifications")
	return { Name = name, Quantity = 1, Weapon = weapon }
end

local function addToBackpack(player: Player, data, reward)
	local quantity = reward.Quantity or 1
	for _, entry in data.UnclaimedRewards do
		if entry.Name == reward.Name and entry.Weapon == reward.Weapon then
			entry.Quantity = (entry.Quantity or 1) + quantity
			PlayerDataService.Replicate(player, "UnclaimedRewards")
			return
		end
	end
	table.insert(data.UnclaimedRewards, { Name = reward.Name, Quantity = quantity, Weapon = reward.Weapon })
	PlayerDataService.Replicate(player, "UnclaimedRewards")
end

local function grantCustom(player: Player, data, reward): boolean
	DataTemplate.EnsureSeason(data)
	local pass = data.Seasons[SeasonLibrary.CurrentSeason.Name].BattlePass
	local quantity = reward.Quantity or 1

	if reward.Name == "Season Pass Level" then
		pass.PassLevel = (pass.PassLevel or 0) + quantity
	elseif reward.Name == "Season Pass XP" then
		pass.PassXP = (pass.PassXP or 0) + quantity
		while pass.PassXP >= SeasonLibrary.PASS_XP_PER_LEVEL_VISUAL do
			pass.PassXP -= SeasonLibrary.PASS_XP_PER_LEVEL_VISUAL
			pass.PassLevel = (pass.PassLevel or 0) + 1
		end
	elseif reward.Name == "Prime Season Pass" then
		pass.MaxPassTrackNum = math.max(pass.MaxPassTrackNum or 1, PRIME_PASS_TRACK)
	else
		return false
	end

	PlayerDataService.Replicate(player, "Seasons")
	return true
end

-- Gives one reward. Returns what was given, or nil. notify = show the in-game notification.
function RewardService.Grant(player: Player, reward, notify: boolean?)
	local data = PlayerDataService.Get(player)
	if not data or type(reward) ~= "table" or type(reward.Name) ~= "string" then
		return nil
	end

	local given = nil
	local info = CosmeticLibrary.Rewards[reward.Name]

	if CosmeticLibrary.Cosmetics[reward.Name] then
		given = grantCosmetic(player, data, reward)
	elseif info and info.Type == "Currency" then
		local field = info.DataName
		PlayerDataService.Set(player, field, (tonumber(data[field]) or 0) + (reward.Quantity or 1))
		given = reward
	elseif info and info.Type == "Weapon" then
		if not ownedWeapons(data)[reward.Name] then
			table.insert(data.WeaponInventory, DataTemplate.NewWeapon(reward.Name))
			PlayerDataService.Replicate(player, "WeaponInventory")
			given = reward
		end
	elseif info and info.Type == "Lootbox" then
		addToBackpack(player, data, reward)
		given = reward
	elseif info and info.Type == "Custom" then
		given = grantCustom(player, data, reward) and reward or nil
	else
		warn(string.format("[Rewards] unknown reward %q for %s", tostring(reward.Name), player.Name))
	end

	if given and notify then
		Remotes.Data.PlayNotification:FireClient(player, "Reward", "", nil, given)
	end
	return given
end

function RewardService.GrantAll(player: Player, rewards, notify: boolean?)
	local given = {}
	for _, reward in rewards or {} do
		local result = RewardService.Grant(player, reward, notify)
		if result then
			table.insert(given, result)
		end
	end
	return given
end

-- Rolls one lootbox for the player. Returns the reward it gave, or nil when every possible
-- outcome is already owned.
function RewardService.RollLootbox(player: Player, boxName: string, weapon: string?)
	local data = PlayerDataService.Get(player)
	local info = CosmeticLibrary.Rewards[boxName]
	if not data or not info or info.Type ~= "Lootbox" then
		return nil
	end

	local chosen = weapon ~= "IsRandom" and weapon or nil
	local contents = info.GetContents(chosen)
	local possible = LootLibrary:GetLootboxPossibilities(
		info.SmartRestrictionsEnabled,
		contents,
		data.CosmeticInventory,
		ownedWeapons(data),
		weapon
	)
	if not possible or #possible == 0 then
		return nil
	end

	local outcome = LootLibrary:GetWeightedLootboxOutcome(possible)
	return outcome and RewardService.Grant(player, outcome, false) or nil
end

local function playLootbox(player: Player, boxName: string, given, index: number)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then
		return
	end

	local position = root.Position + root.CFrame.LookVector * 6
	Remotes.Misc.Functions:FireAllClients(
		EnumLibrary:ToEnum("LootboxEffect"),
		position,
		boxName,
		{ { RewardData = given } },
		(index - 1) * LOOTBOX_STAGGER,
		root,
		player,
		nil,
		math.random(1, 2 ^ 30)
	)
end

-- Remotes.Data.UseUnclaimedReward(index, quantity) -> "Success" | nil
local function useUnclaimed(player: Player, index: any, quantity: any)
	local data = PlayerDataService.Get(player)
	index = tonumber(index)
	local entry = data and index and data.UnclaimedRewards[index]
	if not entry then
		return nil
	end

	local info = CosmeticLibrary.Rewards[entry.Name]
	local count = math.clamp(math.floor(tonumber(quantity) or 1), 1, math.min(entry.Quantity or 1, CONSTANTS.MAX_BACKPACK_USE_QUANTITY))
	local used = 0

	for opened = 1, count do
		local given
		if info and info.Type == "Lootbox" then
			given = RewardService.RollLootbox(player, entry.Name, entry.Weapon)
			-- Only boxes with a SoundProfile have a model in PlayerScripts.Assets.Lootboxes to
			-- animate; the rest (Goodie Bags) just show what came out.
			if given and info.SoundProfile then
				playLootbox(player, entry.Name, given, opened)
			elseif given then
				Remotes.Data.PlayNotification:FireClient(player, entry.Name, "", nil, given)
			end
		else
			given = RewardService.Grant(player, { Name = entry.Name, Quantity = 1, Weapon = entry.Weapon }, true)
		end

		if not given then
			break
		end
		used += 1
	end

	if used == 0 then
		return nil
	end

	entry.Quantity = (entry.Quantity or 1) - used
	if entry.Quantity <= 0 then
		table.remove(data.UnclaimedRewards, index)
	end
	PlayerDataService.Replicate(player, "UnclaimedRewards")
	return "Success"
end

function RewardService.Start()
	Remotes.Data.UseUnclaimedReward.OnServerInvoke = useUnclaimed
end

RewardService.Remotes = { Remotes.Data.UseUnclaimedReward }

return RewardService
