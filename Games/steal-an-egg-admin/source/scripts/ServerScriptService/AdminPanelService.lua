--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local ServerScriptService = game:GetService("ServerScriptService")
local TextService = game:GetService("TextService")

local DataService = require(ServerScriptService.DataService)
local MonetizationConfig = require(ReplicatedStorage.Data.MonetizationConfig)
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local Areas = require(ReplicatedStorage.Data.Areas)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Codec = require(ReplicatedStorage.Shared.Utils.Codec)
local AreaEggService = require(ServerScriptService.AreaEggService)
local AreaEggSlotIdentity = require(ReplicatedStorage.Shared.Util.AreaEggSlotIdentity)

local GAMEPASS_IDS = MonetizationConfig.GamepassIds
local TEMPORARY_ADMIN_SECONDS = MonetizationConfig.TemporaryAdminSeconds

-- Limits for admin-supplied values (the client is never trusted).
local MAX_SPEED = 500
local MAX_MONEY = 1e12
local MAX_LEVEL = 100000
local MAX_GIVE_QUANTITY = 100
local MAX_INVENTORY_SIZE = 5000
local MAX_OUTFITS = 50
local MAX_NAME_LENGTH = 50
local ACTION_COOLDOWN = 0.2
local EXPIRY_SWEEP_INTERVAL = 10
local MAX_STORED_RECEIPTS = 50

local AdminPanelService = {}

local adminActionRemote: RemoteEvent? = nil
local adminStatusRemote: RemoteEvent? = nil
local adminMessageRemote: RemoteEvent? = nil
local monetizationRequestRemote: RemoteEvent? = nil

local temporaryAdminExpiry: {[number]: number} = {}
local lastActionTime: {[Player]: number} = {}

-- ------------------------------------------------------------------
-- Validation helpers
-- ------------------------------------------------------------------

local function deepCopy(source: any): any
	if type(source) ~= "table" then
		return source
	end
	local result = {}
	for key, value in pairs(source) do
		result[key] = deepCopy(value)
	end
	return result
end

-- Rejects NaN, infinity, non-numbers and out-of-range values.
local function parseNumber(value: any, min: number, max: number): number?
	local n = tonumber(value)
	if n == nil or n ~= n or n == math.huge or n == -math.huge then
		return nil
	end
	if n < min or n > max then
		return nil
	end
	return n
end

local function parseInteger(value: any, min: number, max: number): number?
	local n = parseNumber(value, min, max)
	if n == nil then
		return nil
	end
	return math.floor(n)
end

local function parseName(value: any, maxLength: number): string?
	if type(value) ~= "string" then
		return nil
	end
	local trimmed = string.match(value, "^%s*(.-)%s*$") or ""
	local length = utf8.len(trimmed)
	if not length or length < 1 or length > maxLength then
		return nil
	end
	return trimmed
end

local function parseUsername(value: any): string?
	if type(value) ~= "string" or #value < 3 or #value > 20 then
		return nil
	end
	if not string.match(value, "^[%w_]+$") then
		return nil
	end
	return value
end

-- Returns the text as filtered for public display, or nil if filtering failed.
local function filterForDisplay(player: Player, text: string): string?
	local ok, filtered = pcall(function()
		local result = TextService:FilterStringAsync(text, player.UserId, Enum.TextFilterContext.PublicChat)
		return result:GetNonChatStringForBroadcastAsync()
	end)
	if ok and type(filtered) == "string" then
		return filtered
	end
	return nil
end

local function rateLimited(player: Player): boolean
	local now = os.clock()
	local last = lastActionTime[player]
	if last and now - last < ACTION_COOLDOWN then
		return true
	end
	lastActionTime[player] = now
	return false
end

-- ------------------------------------------------------------------
-- Messaging helpers
-- ------------------------------------------------------------------

local function sendVerdict(player: Player, success: boolean, message: string)
	local remote = adminActionRemote
	if remote then
		remote:FireClient(player, success, message)
	end
end

local function sendPrompt(player: Player, gamepassId: number)
	local remote = adminActionRemote
	if remote then
		remote:FireClient(player, "prompt", gamepassId)
	end
end

local function broadcastAdminMessage(message: string)
	local remote = adminMessageRemote
	if remote then
		remote:FireAllClients(message)
	end
end

-- ------------------------------------------------------------------
-- Admin access helpers
-- ------------------------------------------------------------------

local function ownsGamepass(player: Player, gamepassId: number): boolean
	for attempt = 1, 3 do
		local ok, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
		end)
		if ok then
			return owns == true
		end
		if attempt < 3 then
			task.wait(1)
		end
	end
	return false
end

local function hasTemporaryAdmin(player: Player): boolean
	local expiry = temporaryAdminExpiry[player.UserId]
	return expiry ~= nil and os.time() < expiry
end

-- Source of truth for authorization: computed on every action, so temporary admin really expires.
local function checkAdminAccess(player: Player): boolean
	return player:GetAttribute("HasPermanentAdmin") == true or hasTemporaryAdmin(player)
end

-- Recomputes attributes from current state and tells the client. No marketplace calls.
local function pushStatus(player: Player)
	local permanent = player:GetAttribute("HasPermanentAdmin") == true
	local access = permanent or hasTemporaryAdmin(player)
	player:SetAttribute("HasPermanentAdmin", permanent)
	player:SetAttribute("HasAdminAccess", access)

	local remote = adminStatusRemote
	if remote then
		remote:FireClient(player, {
			HasAdminAccess = access,
			HasPermanentAdmin = permanent,
		})
	end
end

local function refreshAdminStatus(player: Player)
	local owns = ownsGamepass(player, GAMEPASS_IDS.AdminPermanent)
	-- Never downgrade here: ownership checks can lag right after a purchase.
	if owns then
		player:SetAttribute("HasPermanentAdmin", true)
	end
	pushStatus(player)
end

-- ------------------------------------------------------------------
-- Action handlers
-- ------------------------------------------------------------------

type Action = {[string]: any}
type Handler = (Player, Action) -> ()

local ActionHandlers: {[string]: Handler} = {}

local function requireData(player: Player): any?
	local data = DataService.Get(player)
	if not data then
		sendVerdict(player, false, "Data still loading.")
	end
	return data
end

local function getHumanoid(player: Player): Humanoid?
	local character = player.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

ActionHandlers.SetSpeed = function(player, action)
	local value = parseNumber(action.value, 0, MAX_SPEED)
	if not value then return sendVerdict(player, false, `Speed must be between 0 and {MAX_SPEED}.`) end
	local humanoid = getHumanoid(player)
	if humanoid then humanoid.WalkSpeed = value end
	sendVerdict(player, true, `WalkSpeed set to {value}.`)
end

ActionHandlers.AddSpeed = function(player, action)
	local value = parseNumber(action.value, -MAX_SPEED, MAX_SPEED)
	if not value then return sendVerdict(player, false, "Invalid speed value.") end
	local humanoid = getHumanoid(player)
	if humanoid then
		humanoid.WalkSpeed = math.clamp(humanoid.WalkSpeed + value, 0, MAX_SPEED)
	end
	sendVerdict(player, true, `Added {value} to WalkSpeed.`)
end

ActionHandlers.SetMoney = function(player, action)
	local value = parseNumber(action.value, 0, MAX_MONEY)
	if not value then return sendVerdict(player, false, "Invalid money value.") end
	if not requireData(player) then return end
	DataService.SetMoney(player, value) -- clamps, floors and updates leaderstats
	sendVerdict(player, true, `Money set to {math.floor(value)}.`)
end

ActionHandlers.AddMoney = function(player, action)
	local value = parseNumber(action.value, -MAX_MONEY, MAX_MONEY)
	if not value then return sendVerdict(player, false, "Invalid money value.") end
	if not requireData(player) then return end
	DataService.AddMoney(player, value)
	sendVerdict(player, true, `Added {math.floor(value)} money.`)
end

ActionHandlers.SetBaseLevel = function(player, action)
	local value = parseInteger(action.value, 0, MAX_LEVEL)
	if not value then return sendVerdict(player, false, "Invalid level value.") end
	DataService.SetField(player, "BaseUpgradeLevel", value)
	sendVerdict(player, true, `Base level set to {value}.`)
end

ActionHandlers.AddBaseLevel = function(player, action)
	local value = parseInteger(action.value, -MAX_LEVEL, MAX_LEVEL)
	if not value then return sendVerdict(player, false, "Invalid level value.") end
	local current = DataService.GetField(player, "BaseUpgradeLevel", 0)
	DataService.SetField(player, "BaseUpgradeLevel", math.clamp(current + value, 0, MAX_LEVEL))
	sendVerdict(player, true, `Base level adjusted by {value}.`)
end

ActionHandlers.SetTreadmillLevel = function(player, action)
	local value = parseInteger(action.value, 1, MAX_LEVEL)
	if not value then return sendVerdict(player, false, "Invalid level value.") end
	DataService.SetField(player, "TreadmillUpgradeLevel", value)
	sendVerdict(player, true, `Treadmill level set to {value}.`)
end

ActionHandlers.AddTreadmillLevel = function(player, action)
	local value = parseInteger(action.value, -MAX_LEVEL, MAX_LEVEL)
	if not value then return sendVerdict(player, false, "Invalid level value.") end
	local current = DataService.GetField(player, "TreadmillUpgradeLevel", 1)
	DataService.SetField(player, "TreadmillUpgradeLevel", math.clamp(current + value, 1, MAX_LEVEL))
	sendVerdict(player, true, `Treadmill level adjusted by {value}.`)
end

ActionHandlers.ResetAllData = function(player)
	local data = requireData(player)
	if not data then return end
	DataService.SetMoney(player, 0)
	data.SpeedPower = 0
	data.BaseUpgradeLevel = 0
	data.TreadmillUpgradeLevel = 1
	data.Inventory = {}
	data.EquippedAssets = {}
	data.EggInventory = {}
	data.GearInventory = {}
	-- Gamepasses / Products are purchase records, not progress, so they are intentionally kept.
	DataService.SyncChanges(player, {
		Money = 0,
		SpeedPower = 0,
		BaseUpgradeLevel = 0,
		TreadmillUpgradeLevel = 1,
		Inventory = data.Inventory,
		EquippedAssets = data.EquippedAssets,
		EggInventory = data.EggInventory,
		GearInventory = data.GearInventory,
	})
	sendVerdict(player, true, "All data has been reset.")
end

ActionHandlers.SetDisplayName = function(player, action)
	local name = parseName(action.value, 20)
	if not name then
		return sendVerdict(player, false, "Display name must be 1-20 characters.")
	end
	local filtered = filterForDisplay(player, name)
	if filtered == nil then
		return sendVerdict(player, false, "Could not verify that name right now. Try again.")
	end
	if filtered ~= name then
		return sendVerdict(player, false, "That name was blocked by the filter.")
	end
	DataService.SetField(player, "AdminDisplayName", name)
	sendVerdict(player, true, `Display name set to '{name}'.`)
end

ActionHandlers.ResetDisplayName = function(player)
	DataService.SetField(player, "AdminDisplayName", nil)
	sendVerdict(player, true, "Display name reset.")
end

ActionHandlers.SetSize = function(player, action)
	local value = parseNumber(action.value, 0.1, 50)
	if not value then
		return sendVerdict(player, false, "Size must be between 0.1 and 50.")
	end
	DataService.SetField(player, "AdminSize", value)
	local character = player.Character
	if character then
		pcall(function()
			character:ScaleTo(value)
		end)
	end
	sendVerdict(player, true, `Size set to {value}.`)
end

ActionHandlers.ResetSize = function(player)
	DataService.SetField(player, "AdminSize", nil)
	local character = player.Character
	if character then
		pcall(function()
			character:ScaleTo(1)
		end)
	end
	sendVerdict(player, true, "Size reset to default.")
end

local EggModels = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("Eggs")
local MORPH_ATTR = "AdminMorphAttached"
-- Player attributes can't store tables, so the saved body-transparency map
-- lives in this server-side table keyed by player instead.
local morphSavedTransparency: {[Player]: {[string]: number}} = {}

-- Attaches a model template (egg/mob) to the character and hides the body.
-- Returns true on success.
local function attachMorphModel(player: Player, template: Instance): boolean
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then
		return false
	end

	-- Remove a previous morph model first.
	local existing = character:FindFirstChild("AdminMorphModel")
	if existing then
		existing:Destroy()
	end

	local model = template:Clone()
	model.Name = "AdminMorphModel"

	-- Ensure the clone has a PrimaryPart so we can pivot it onto the character.
	if not model.PrimaryPart then
		model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
	end

	if model.PrimaryPart then
		model:PivotTo(root.CFrame)
	end

	-- Weld the morph's parts to the root so they follow the player.
	-- PivotTo above already laid the model out; WeldConstraint keeps
	-- each part's current offset, so do NOT reset part.CFrame here
	-- (that collapsed the whole model onto a single point).
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
			part.CanCollide = false
			part.Massless = true
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = root
			weld.Part1 = part
			weld.Parent = root
		end
	end

	model.Parent = character

	-- Hide the body parts, remembering their original transparency.
	local saved = {}
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part ~= root and not part:IsDescendantOf(model) then
			saved[tostring(part:GetFullName())] = part.Transparency
			part.Transparency = 1
		end
	end
	morphSavedTransparency[player] = saved
	player:SetAttribute(MORPH_ATTR, true)
	return true
end

local function detachMorphModel(player: Player)
	local character = player.Character
	if character then
		local model = character:FindFirstChild("AdminMorphModel")
		if model then
			model:Destroy()
		end
		-- Restore body transparency.
		local saved = morphSavedTransparency[player]
		if type(saved) == "table" then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					local original = saved[tostring(part:GetFullName())]
					if type(original) == "number" then
						part.Transparency = original
					end
				end
			end
		end
	end
	morphSavedTransparency[player] = nil
	player:SetAttribute(MORPH_ATTR, nil)
end

local function applyStoredMorphModel(player: Player)
	local data = DataService.Get(player)
	if not data then
		return
	end
	local eggCategory = data.AdminMorphEgg
	if type(eggCategory) == "string" and eggCategory ~= "" then
		local template = EggModels:FindFirstChild(eggCategory)
		if template then
			attachMorphModel(player, template)
		end
	end
end

ActionHandlers.MorphEgg = function(player, action)
	local name = parseName(action.value, MAX_NAME_LENGTH)
	if not name then return sendVerdict(player, false, "Invalid egg name.") end
	local template = EggModels:FindFirstChild(name)
	if not template then return sendVerdict(player, false, "Unknown egg model.") end
	if not player.Character then return sendVerdict(player, false, "No character to morph.") end
	if not attachMorphModel(player, template) then
		return sendVerdict(player, false, "Could not morph into that egg.")
	end
	DataService.SetField(player, "AdminMorphEgg", name)
	sendVerdict(player, true, `Morphed into egg: {name}.`)
end

ActionHandlers.UnmorphEgg = function(player)
	DataService.SetField(player, "AdminMorphEgg", nil)
	detachMorphModel(player)
	sendVerdict(player, true, "Egg morph removed.")
end

-- Mob morph uses the same egg-model catalogue (every creature template lives under
-- Assets.Models.Eggs in this game), so it resolves against the same folder.
ActionHandlers.MorphMob = function(player, action)
	local name = parseName(action.value, MAX_NAME_LENGTH)
	if not name then return sendVerdict(player, false, "Invalid mob name.") end
	local template = EggModels:FindFirstChild(name)
	if not template then return sendVerdict(player, false, "Unknown mob model.") end
	if not player.Character then return sendVerdict(player, false, "No character to morph.") end
	if not attachMorphModel(player, template) then
		return sendVerdict(player, false, "Could not morph into that mob.")
	end
	DataService.SetField(player, "AdminMorphMob", name)
	sendVerdict(player, true, `Morphed into {name}.`)
end

ActionHandlers.UnmorphMob = function(player)
	DataService.SetField(player, "AdminMorphMob", nil)
	detachMorphModel(player)
	sendVerdict(player, true, "Mob morph removed.")
end

-- Applies a player's appearance to another player's character using a HumanoidDescription.
-- Returns true on success.
local function applyAppearance(player: Player, username: string): boolean
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return false
	end
	local ok, userId = pcall(function()
		return Players:GetUserIdFromNameAsync(username)
	end)
	if not ok or not userId then
		return false
	end
	local descOk, description = pcall(function()
		return Players:GetHumanoidDescriptionFromUserId(userId)
	end)
	if not descOk or not description then
		return false
	end
	local applyOk = pcall(function()
		humanoid:ApplyDescription(description)
	end)
	return applyOk
end

ActionHandlers.MorphAppearance = function(player, action)
	local username = parseUsername(action.value)
	if not username then return sendVerdict(player, false, "Invalid username.") end
	if not player.Character then return sendVerdict(player, false, "No character to morph.") end
	if not applyAppearance(player, username) then
		return sendVerdict(player, false, "Could not morph into that user.")
	end
	DataService.SetField(player, "AdminMorphAppearance", username)
	sendVerdict(player, true, `Appearance morphed to {username}.`)
end

ActionHandlers.Unmorph = function(player)
	DataService.SetField(player, "AdminMorphAppearance", nil)
	local profileOk, desc = pcall(function()
		return Players:GetHumanoidDescriptionFromUserId(player.UserId)
	end)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if profileOk and desc and humanoid then
		pcall(function()
			humanoid:ApplyDescription(desc)
		end)
	end
	sendVerdict(player, true, "Appearance morph removed.")
end

-- Re-apply a stored appearance morph whenever the character respawns.
local function reapplyStoredMorphs(player: Player)
	local data = DataService.Get(player)
	if not data then
		return
	end
	local username = data.AdminMorphAppearance
	if type(username) == "string" and username ~= "" then
		applyAppearance(player, username)
	end
	applyStoredMorphModel(player)
end

-- TODO: SpawnEgg only validates and reports success; the actual spawn isn't implemented here.
ActionHandlers.SpawnEgg = function(player, action)
	local biome = action.biome
	if type(biome) ~= "string" or not Areas.Directory[biome] then
		return sendVerdict(player, false, "Invalid biome.")
	end
	local ok, spawned = pcall(function()
		return AreaEggService.SpawnInArea(biome, action.egg)
	end)
	if not ok then
		warn("[AdminPanelService] SpawnEgg failed: " .. tostring(spawned))
		return sendVerdict(player, false, "Could not spawn an egg there.")
	end
	if not spawned then
		return sendVerdict(player, false, `No free nest in {biome}.`)
	end
	sendVerdict(player, true, `Spawned egg in {biome}.`)
end

-- Inventories in this game are maps keyed by a generated uid (uid -> record), not
-- arrays. Inserting with table.insert would give numeric keys the backpack never
-- reads, so every item is stored under its own uid.
local function countEntries(map: any): number
	local n = 0
	if type(map) == "table" then
		for _ in pairs(map) do
			n += 1
		end
	end
	return n
end

local function giveItems(player: Player, fieldName: string, item: any, quantity: number): boolean
	local data = DataService.Get(player)
	if not data then
		sendVerdict(player, false, "Data still loading.")
		return false
	end
	local inventory = data[fieldName]
	if type(inventory) ~= "table" then
		inventory = {}
	end
	if countEntries(inventory) + quantity > MAX_INVENTORY_SIZE then
		sendVerdict(player, false, "Inventory is full.")
		return false
	end
	for _ = 1, quantity do
		inventory[Codec.NewUid()] = deepCopy(item)
	end
	data[fieldName] = inventory
	DataService.SyncChange(player, fieldName, inventory)
	return true
end

-- Builds a proper SavedEgg record (the shape the backpack and egg tools expect).
local function buildEggRecord(category: string, size: number?): any?
	local ok, egg = pcall(EggRecords.NewEgg, category)
	if not ok then
		return nil
	end
	if size ~= nil then
		egg.AssetScale = size
	end
	local encoded = EggRecords.Encode(egg)
	return encoded
end

local function parseQuantity(value: any): number?
	if value == nil then
		return 1
	end
	return parseInteger(value, 1, MAX_GIVE_QUANTITY)
end

ActionHandlers.GiveEgg = function(player, action)
	local egg = parseName(action.egg, MAX_NAME_LENGTH)
	if not egg then return sendVerdict(player, false, "Invalid egg name.") end
	local quantity = parseQuantity(action.quantity)
	if not quantity then
		return sendVerdict(player, false, `Quantity must be 1-{MAX_GIVE_QUANTITY}.`)
	end
	local item = buildEggRecord(egg, action.size)
	if not item then return sendVerdict(player, false, "Unknown egg.") end
	if giveItems(player, "EggInventory", item, quantity) then
		sendVerdict(player, true, `Gave {quantity}x {egg}.`)
	end
end

ActionHandlers.GiveMob = function(player, action)
	local pet = parseName(action.pet, MAX_NAME_LENGTH)
	if not pet then return sendVerdict(player, false, "Invalid pet name.") end
	local quantity = parseQuantity(action.quantity)
	if not quantity then
		return sendVerdict(player, false, `Quantity must be 1-{MAX_GIVE_QUANTITY}.`)
	end
	local item = { Category = pet, Mutations = {}, Scale = action.size or 1 }
	if giveItems(player, "Inventory", item, quantity) then
		sendVerdict(player, true, `Gave {quantity}x {pet}.`)
	end
end

ActionHandlers.GiveCustomEgg = function(player, action)
	local egg = parseName(action.egg, MAX_NAME_LENGTH)
	local pet = parseName(action.pet, MAX_NAME_LENGTH)
	if not egg or not pet then
		return sendVerdict(player, false, "Invalid egg or pet name.")
	end
	local size = 1
	if action.size ~= nil then
		local parsed = parseNumber(action.size, 0.1, 50)
		if not parsed then return sendVerdict(player, false, "Size must be between 0.1 and 50.") end
		size = parsed
	end
	local item = buildEggRecord(pet, size)
	if not item then return sendVerdict(player, false, "Unknown egg.") end
	if giveItems(player, "EggInventory", item, 1) then
		sendVerdict(player, true, `Gave custom egg with {pet}.`)
	end
end

ActionHandlers.SaveOutfit = function(player)
	local data = requireData(player)
	if not data then return end
	local outfits = data.AdminOutfits or {}
	if #outfits >= MAX_OUTFITS then
		return sendVerdict(player, false, `You can only save {MAX_OUTFITS} outfits.`)
	end
	table.insert(outfits, {
		EquippedAssets = deepCopy(data.EquippedAssets or {}), -- copy, so later changes don't alter the saved outfit
	})
	data.AdminOutfits = outfits
	sendVerdict(player, true, `Outfit saved (#{#outfits}).`)
end

ActionHandlers.EquipOutfit = function(player, action)
	local data = requireData(player)
	if not data then return end
	local outfits = data.AdminOutfits or {}
	local index = parseInteger(action.value, 1, math.max(#outfits, 1))
	if not index or not outfits[index] then
		return sendVerdict(player, false, "Outfit not found.")
	end
	data.EquippedAssets = deepCopy(outfits[index].EquippedAssets or {})
	DataService.SyncChange(player, "EquippedAssets", data.EquippedAssets)
	sendVerdict(player, true, "Outfit equipped.")
end

ActionHandlers.DeleteOutfit = function(player, action)
	local data = requireData(player)
	if not data then return end
	local outfits = data.AdminOutfits or {}
	local index = parseInteger(action.value, 1, math.max(#outfits, 1))
	if index and outfits[index] then
		table.remove(outfits, index)
		data.AdminOutfits = outfits
		sendVerdict(player, true, "Outfit deleted.")
	else
		sendVerdict(player, false, "Outfit not found.")
	end
end

ActionHandlers.SetGuardAppearance = function(player, action)
	local biome = action.biome
	if type(biome) ~= "string" or not Areas.Directory[biome] then
		return sendVerdict(player, false, "Invalid biome.")
	end
	local username = nil
	if action.username ~= nil then
		username = parseUsername(action.username)
		if not username then return sendVerdict(player, false, "Invalid username.") end
	end
	local size = 1
	if action.size ~= nil then
		local parsed = parseNumber(action.size, 0.1, 50)
		if not parsed then return sendVerdict(player, false, "Size must be between 0.1 and 50.") end
		size = parsed
	end

	-- Stored per biome in one table so Reset below finds what Set wrote.
	local appearances = deepCopy(DataService.GetField(player, "AdminGuardAppearances", {}))
	appearances[biome] = { Username = username, Size = size }
	DataService.SetField(player, "AdminGuardAppearances", appearances)
	sendVerdict(player, true, `Guard appearance set for {biome}.`)
end

ActionHandlers.ResetGuardAppearance = function(player, action)
	local biome = action.biome
	if type(biome) ~= "string" or not Areas.Directory[biome] then
		return sendVerdict(player, false, "Invalid biome.")
	end
	local appearances = deepCopy(DataService.GetField(player, "AdminGuardAppearances", {}))
	appearances[biome] = nil
	DataService.SetField(player, "AdminGuardAppearances", appearances)
	sendVerdict(player, true, `Guard appearance reset for {biome}.`)
end

-- TODO: SpawnNPC / DespawnNPC only report success; the actual spawning isn't implemented here.
ActionHandlers.SpawnNPC = function(player, action)
	local displayName = parseName(action.displayName, 30)
	if not displayName then
		return sendVerdict(player, false, "Invalid display name.")
	end
	sendVerdict(player, true, `NPC '{displayName}' spawned.`)
end

ActionHandlers.DespawnNPC = function(player)
	sendVerdict(player, true, "NPCs despawned.")
end

-- BTools (Clone/Move/Rotate/Delete) don't exist anywhere in the place, so create
-- the standard set in the player's backpack and tag it so Hide can find it again.
local BTOOL_NAMES = { "Clone", "Move", "Rotate", "Delete" }
local BTOOL_ICONS = {
	Clone = "rbxasset://textures/ui/Buttons/Clone.png",
	Move = "rbxasset://textures/ui/Buttons/Move.png",
	Rotate = "rbxasset://textures/ui/Buttons/Rotate.png",
	Delete = "rbxasset://textures/ui/Buttons/Delete.png",
}
local BTOOL_SOURCE = [[
local tool = script.Parent
local name = tool.Name
tool.Activated:Connect(function()
	if name == "Delete" then
		local mouse = game.Players.LocalPlayer:GetMouse()
		if mouse.Target then
			mouse.Target:Destroy()
		end
	end
end)
]]

local function removeBTools(player: Player)
	local character = player.Character
	local backpack = player:FindFirstChildOfClass("Backpack")
	for _, container in ipairs({ character, backpack }) do
		if container then
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("Tool") and child:GetAttribute("AdminBTool") == true then
					child:Destroy()
				end
			end
		end
	end
end

local function giveBTools(player: Player)
	removeBTools(player)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then
		return
	end
	for _, name in ipairs(BTOOL_NAMES) do
		local tool = Instance.new("Tool")
		tool.Name = name
		tool.RequiresHandle = false
		tool.CanBeDropped = false
		tool.TextureId = BTOOL_ICONS[name] or ""
		tool:SetAttribute("AdminBTool", true)
		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Transparency = 1
		handle.CanCollide = false
		handle.Massless = true
		handle.Size = Vector3.new(0.5, 0.5, 0.5)
		handle.Parent = tool
		local toolScript = Instance.new("LocalScript")
		toolScript.Source = BTOOL_SOURCE
		toolScript.Parent = tool
		tool.Parent = backpack
	end
end

ActionHandlers.BToolsShow = function(player)
	giveBTools(player)
	DataService.SetField(player, "AdminBToolsVisible", true)
	sendVerdict(player, true, "BTools enabled.")
end

ActionHandlers.BToolsHide = function(player)
	removeBTools(player)
	DataService.SetField(player, "AdminBToolsVisible", false)
	sendVerdict(player, true, "BTools disabled.")
end

ActionHandlers.PromptBeOwner = function(player)
	sendPrompt(player, GAMEPASS_IDS.BeOwner)
end

ActionHandlers.PromptAdminPlus = function(player)
	sendPrompt(player, GAMEPASS_IDS.AdminPlus)
end

ActionHandlers.PromptHDAdmin = function(player)
	sendPrompt(player, GAMEPASS_IDS.HDAdmin)
end

ActionHandlers.PromptNoCooldowns = function(player)
	sendPrompt(player, GAMEPASS_IDS.NoCooldowns)
end

-- ------------------------------------------------------------------
-- Action dispatch
-- ------------------------------------------------------------------

local function handleAdminAction(player: Player, action: any)
	if type(action) ~= "table" then
		return sendVerdict(player, false, "Invalid action format.")
	end

	local kind = action.kind
	if type(kind) ~= "string" then
		return sendVerdict(player, false, "Missing action kind.")
	end

	if rateLimited(player) then
		return sendVerdict(player, false, "Slow down.")
	end

	if not checkAdminAccess(player) then
		return sendVerdict(player, false, "You do not have admin access.")
	end

	local handler = ActionHandlers[kind]
	if not handler then
		return sendVerdict(player, false, `Unknown action: {kind}`)
	end

	local ok, err = pcall(handler, player, action)
	if not ok then
		warn(`[AdminPanelService] Error handling '{kind}' for {player.Name}: {err}`)
		sendVerdict(player, false, "Internal error occurred.")
	end
end

-- ------------------------------------------------------------------
-- Monetization
-- ------------------------------------------------------------------

local function handleMonetizationRequest(player: Player, request: any)
	if type(request) ~= "string" then return end
	if rateLimited(player) then return end

	if request == "AdminPermanent" then
		MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_IDS.AdminPermanent)
	elseif request == "AdminTemporary" then
		local productId = MonetizationConfig.ProductIds.AdminTemporary
		if productId then
			MarketplaceService:PromptProductPurchase(player, productId)
		end
	elseif request == "AdminBoosts" then
		-- Global server effect: admins only (previously any client could fire this).
		if not checkAdminAccess(player) then return end
		local current = AdminBoosts.ReadMultiplier("EggSpawnLuck")
		if current > 1 then
			AdminBoosts.Assign("EggSpawnLuck", nil)
			broadcastAdminMessage("Egg Spawn Luck boost disabled.")
		else
			AdminBoosts.Assign("EggSpawnLuck", 5)
			broadcastAdminMessage("Egg Spawn Luck boost x5 enabled.")
		end
	elseif request == "BeOwner" then
		MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_IDS.BeOwner)
	elseif request == "AdminPlus" then
		MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_IDS.AdminPlus)
	end
end

local function onGamepassPurchaseFinished(player: Player, gamepassId: number, wasPurchased: boolean)
	if not wasPurchased then return end

	if gamepassId == GAMEPASS_IDS.AdminPermanent then
		-- Set directly: UserOwnsGamePassAsync can lag right after a purchase.
		player:SetAttribute("HasPermanentAdmin", true)
		pushStatus(player)
		broadcastAdminMessage(`{player.DisplayName} now has permanent admin!`)
	elseif gamepassId == GAMEPASS_IDS.BeOwner
		or gamepassId == GAMEPASS_IDS.AdminPlus
		or gamepassId == GAMEPASS_IDS.HDAdmin
		or gamepassId == GAMEPASS_IDS.NoCooldowns then
		local data = DataService.Get(player)
		if data then
			local gamepasses = data.Gamepasses or {}
			for name, id in GAMEPASS_IDS do
				if id == gamepassId then
					gamepasses[name] = true
					break
				end
			end
			data.Gamepasses = gamepasses
		end
		sendVerdict(player, true, "Gamepass purchase processed.")
	end
end

-- Grants (or extends) temporary admin. Safe against receipt re-delivery. Persisted, so leaving doesn't forfeit it.
local function grantTemporaryAdmin(player: Player, data: any, purchaseId: string): boolean
	local receipts = data.AdminReceipts or {}
	if table.find(receipts, purchaseId) then
		DataService.ForceSave(player) -- already granted; just make sure it's saved
		return true
	end

	local current = temporaryAdminExpiry[player.UserId] or 0
	local expiry = math.max(os.time(), current) + TEMPORARY_ADMIN_SECONDS
	temporaryAdminExpiry[player.UserId] = expiry
	data.AdminTempExpiry = expiry

	table.insert(receipts, purchaseId)
	if #receipts > MAX_STORED_RECEIPTS then
		table.remove(receipts, 1)
	end
	data.AdminReceipts = receipts

	DataService.ForceSave(player)
	return true
end

-- Returns nil when the receipt isn't for one of this service's products.
function AdminPanelService.HandleReceipt(receiptInfo: any): Enum.ProductPurchaseDecision?
	if receiptInfo.ProductId ~= MonetizationConfig.ProductIds.AdminTemporary then
		return nil
	end

	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet -- re-delivered when they rejoin
	end
	local data = DataService.Get(player)
	if not data then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	if not grantTemporaryAdmin(player, data, tostring(receiptInfo.PurchaseId)) then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	pushStatus(player)
	sendVerdict(player, true, "Temporary admin activated for 1 hour.")
	broadcastAdminMessage(`{player.DisplayName} activated temporary admin.`)
	return Enum.ProductPurchaseDecision.PurchaseGranted
end

-- ------------------------------------------------------------------
-- Service lifecycle
-- ------------------------------------------------------------------

local function findRemote(parent: Instance?, name: string): RemoteEvent?
	local instance = parent and parent:FindFirstChild(name)
	if instance and instance:IsA("RemoteEvent") then
		return instance
	end
	return nil
end

function AdminPanelService.Init()
	local networkFolder = ReplicatedStorage:FindFirstChild("Network")
	adminActionRemote = findRemote(networkFolder, "AdminPanelAction")
	adminStatusRemote = findRemote(networkFolder, "AdminStatusResponse")
	adminMessageRemote = findRemote(networkFolder, "AdminShowMessage")
	monetizationRequestRemote = findRemote(ReplicatedStorage, "MonetizationRequest")

	local actionRemote = adminActionRemote
	if actionRemote then
		actionRemote.OnServerEvent:Connect(handleAdminAction)
	else
		warn("[AdminPanelService] AdminPanelAction remote not found.")
	end

	local monetizationRemote = monetizationRequestRemote
	if monetizationRemote then
		monetizationRemote.OnServerEvent:Connect(handleMonetizationRequest)
	else
		warn("[AdminPanelService] MonetizationRequest remote not found.")
	end

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(onGamepassPurchaseFinished)

	-- MarketplaceService.ProcessReceipt is owned by Workspace/OfferPodiums/OfferServer,
	-- which calls AdminPanelService.HandleReceipt for the AdminTemporary product first.
end

function AdminPanelService.Start()
	local function setupPlayer(player: Player)
		task.spawn(function()
			-- Restore a temporary admin purchase that was saved in a previous session.
			local data = DataService.WaitForProfile(player, 30)
			if data and type(data.AdminTempExpiry) == "number" and data.AdminTempExpiry > os.time() then
				temporaryAdminExpiry[player.UserId] = data.AdminTempExpiry
			end
			if player.Parent ~= nil then
				refreshAdminStatus(player)
			end
		end)
	end

	Players.PlayerAdded:Connect(setupPlayer)
	for _, player in Players:GetPlayers() do
		setupPlayer(player)
	end

	-- Keep a stored appearance morph applied across respawns.
	local function bindCharacter(player: Player)
		player.CharacterAdded:Connect(function()
			task.wait(0.5)
			reapplyStoredMorphs(player)
		end)
	end
	Players.PlayerAdded:Connect(bindCharacter)
	for _, player in Players:GetPlayers() do
		bindCharacter(player)
	end

	Players.PlayerRemoving:Connect(function(player: Player)
		temporaryAdminExpiry[player.UserId] = nil
		lastActionTime[player] = nil
		morphSavedTransparency[player] = nil
	end)

	-- Flip temporary admins off (and update their UI) when their time runs out.
	task.spawn(function()
		while true do
			task.wait(EXPIRY_SWEEP_INTERVAL)
			for _, player in Players:GetPlayers() do
				if player:GetAttribute("HasAdminAccess") == true and not checkAdminAccess(player) then
					pushStatus(player)
				end
			end
		end
	end)
end

return AdminPanelService