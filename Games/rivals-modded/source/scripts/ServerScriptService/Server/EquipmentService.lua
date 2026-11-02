-- The Equipment page and the emote wheel: cosmetics, emotes, favourites, unlocking and
-- levelling weapons. Every rule is the client's own shared library, so both sides agree.
--
--   Data.EquipCosmetic(weapon, type, name | nil, { IsInverted })   type Skin/Wrap/Charm/Finisher
--        -> WeaponInventory[i][type] = { Name, Inverted? }
--   Data.EquipEmote(slot, name | nil)       -> EquippedEmotes[slot] = { Name }   (sparse, see SparseCodec)
--   Data.FavoriteCosmetic(weapon, name, on, type?)
--        -> FavoritedCosmetics[weapon][CosmeticLibrary:GetNoneSpecificCosmeticName(name, type)] = true
--   Data.FavoriteWeapon(weapon)             -> toggles WeaponInventory[i].IsFavorited
--   Data.UnlockWeapon(weapon)               ShopLibrary:GetWeaponKeyPriceInfo (keys, an unlock token, or free)
--   Data.LevelUpWeapon(weapon)              LootLibrary:GetCostToLevelUp(level, xp) keys, Level + 1, XP 0
--   Data.SilenceCosmeticNotification(name?, weapon?)   nil, nil clears them all
--
-- Ownership: CosmeticInventory[name] is true, { IsUniversal = true } or { [weapon] = true }
-- (CosmeticLibrary:OwnsCosmetic).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))
local CosmeticLibrary = require(Modules:WaitForChild("CosmeticLibrary"))
local ItemLibrary = require(Modules:WaitForChild("ItemLibrary"))
local ShopLibrary = require(Modules:WaitForChild("ShopLibrary"))
local LootLibrary = require(Modules:WaitForChild("LootLibrary"))

local PlayerDataService = require(script.Parent.PlayerDataService)
local DataTemplate = require(script.Parent.DataTemplate)

local Data = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Data")

local WEAPON_COSMETIC_TYPES = { Skin = true, Wrap = true, Charm = true, Finisher = true }
local MAX_WEAPON_LEVEL = 99

local EquipmentService = {}

local function weaponData(player: Player, weapon: any)
	if typeof(weapon) ~= "string" then
		return nil
	end
	for _, entry in PlayerDataService.Get(player, "WeaponInventory") or {} do
		if entry.Name == weapon then
			return entry
		end
	end
	return nil
end

local function owns(player: Player, name: string, weapon: string?): boolean
	return CosmeticLibrary:OwnsCosmetic(PlayerDataService.Get(player, "CosmeticInventory"), name, weapon) and true or false
end

local function equipCosmetic(player: Player, weapon: any, cosmeticType: any, name: any, options: any)
	local entry = weaponData(player, weapon)
	if not entry or not WEAPON_COSMETIC_TYPES[cosmeticType] then
		return
	end

	if name == nil then
		entry[cosmeticType] = nil
		PlayerDataService.Replicate(player, "WeaponInventory")
		return
	end

	local cosmetic = typeof(name) == "string" and CosmeticLibrary.Cosmetics[name]
	if not cosmetic or cosmetic.Type ~= cosmeticType or not owns(player, name, weapon) then
		return
	end
	-- A skin is made for one weapon.
	if cosmeticType == "Skin" and cosmetic.ItemName and cosmetic.ItemName ~= weapon then
		return
	end

	entry[cosmeticType] = {
		Name = name,
		Inverted = cosmeticType == "Wrap" and typeof(options) == "table" and options.IsInverted == true or nil,
	}
	PlayerDataService.Replicate(player, "WeaponInventory")
end

local function equipEmote(player: Player, slot: any, name: any)
	slot = tonumber(slot)
	if not slot or slot % 1 ~= 0 or slot < 1 or slot > CONSTANTS.MAX_EQUIPPABLE_EMOTES then
		return
	end

	local emotes = PlayerDataService.Get(player, "EquippedEmotes")
	if not emotes then
		return
	end

	if name == nil then
		emotes[slot] = nil
	else
		local cosmetic = typeof(name) == "string" and CosmeticLibrary.Cosmetics[name]
		if not cosmetic or cosmetic.Type ~= "Emote" or not owns(player, name) then
			return
		end
		-- One emote sits in one slot: equipping it again moves it.
		for otherSlot, other in emotes do
			if other.Name == name then
				emotes[otherSlot] = nil
			end
		end
		emotes[slot] = { Name = name }
	end

	PlayerDataService.Replicate(player, "EquippedEmotes")
end

local function favoriteCosmetic(player: Player, weapon: any, name: any, on: any, cosmeticType: any)
	if typeof(weapon) ~= "string" or typeof(name) ~= "string" then
		return
	end
	if not ItemLibrary.Items[weapon] then
		return
	end

	local ok, key = pcall(CosmeticLibrary.GetNoneSpecificCosmeticName, CosmeticLibrary, name, cosmeticType)
	if not ok or typeof(key) ~= "string" then
		return
	end

	local favorites = PlayerDataService.Get(player, "FavoritedCosmetics")
	favorites[weapon] = favorites[weapon] or {}
	favorites[weapon][key] = on == true or nil
	if next(favorites[weapon]) == nil then
		favorites[weapon] = nil
	end
	PlayerDataService.Replicate(player, "FavoritedCosmetics")
end

local function favoriteWeapon(player: Player, weapon: any)
	local entry = weaponData(player, weapon)
	if entry then
		entry.IsFavorited = not entry.IsFavorited
		PlayerDataService.Replicate(player, "WeaponInventory")
	end
end

local function unlockWeapon(player: Player, weapon: any)
	if typeof(weapon) ~= "string" or weaponData(player, weapon) or not ShopLibrary.Weapons[weapon] then
		return
	end

	local data = PlayerDataService.Get(player)
	local price, byToken, freeCheck = ShopLibrary:GetWeaponKeyPriceInfo(weapon, data.UnlockTokens, data.FreeWeaponUnlockCheck)

	if not (freeCheck or ShopLibrary:IsWeaponReleased(weapon)) then
		return
	end
	if not byToken and data.WeaponKeys < price then
		return
	end

	if freeCheck then
		data.FreeWeaponUnlockCheck[weapon] = nil
		PlayerDataService.Replicate(player, "FreeWeaponUnlockCheck")
	elseif byToken then
		PlayerDataService.Set(player, "UnlockTokens", data.UnlockTokens - 1)
	else
		PlayerDataService.Set(player, "WeaponKeys", data.WeaponKeys - price)
	end

	table.insert(data.WeaponInventory, DataTemplate.NewWeapon(weapon))
	PlayerDataService.Replicate(player, "WeaponInventory")
end

local function levelUpWeapon(player: Player, weapon: any)
	local entry = weaponData(player, weapon)
	if not entry or entry.Level >= MAX_WEAPON_LEVEL then
		return
	end

	local keys = PlayerDataService.Get(player, "WeaponKeys") or 0
	local cost = LootLibrary:GetCostToLevelUp(entry.Level, entry.XP)
	if keys < cost then
		return
	end

	PlayerDataService.Set(player, "WeaponKeys", keys - cost)
	entry.Level += 1
	entry.XP = 0
	PlayerDataService.Replicate(player, "WeaponInventory")
end

local function silenceNotification(player: Player, name: any, weapon: any)
	local notifications = PlayerDataService.Get(player, "CosmeticNotifications")
	if not notifications then
		return
	end

	if name == nil then
		table.clear(notifications)
	elseif typeof(name) == "string" then
		if weapon ~= nil and type(notifications[name]) == "table" then
			notifications[name][weapon] = nil
		else
			notifications[name] = nil
		end
	end
	-- The client already changed its own copy; nothing to send back.
end

function EquipmentService.Start()
	Data.EquipCosmetic.OnServerEvent:Connect(equipCosmetic)
	Data.EquipEmote.OnServerEvent:Connect(equipEmote)
	Data.FavoriteCosmetic.OnServerEvent:Connect(favoriteCosmetic)
	Data.FavoriteWeapon.OnServerEvent:Connect(favoriteWeapon)
	Data.UnlockWeapon.OnServerEvent:Connect(unlockWeapon)
	Data.LevelUpWeapon.OnServerEvent:Connect(levelUpWeapon)
	Data.SilenceCosmeticNotification.OnServerEvent:Connect(silenceNotification)
end

EquipmentService.Remotes = {
	Data.EquipCosmetic,
	Data.EquipEmote,
	Data.FavoriteCosmetic,
	Data.FavoriteWeapon,
	Data.UnlockWeapon,
	Data.LevelUpWeapon,
	Data.SilenceCosmeticNotification,
}

return EquipmentService
