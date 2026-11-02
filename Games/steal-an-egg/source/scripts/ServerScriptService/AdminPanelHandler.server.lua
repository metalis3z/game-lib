--!strict
-- AdminPanelHandler: Server-side handler for the Admin Panel GUI commands.
-- The client Handler (StarterGui.AdminPanel) fires remotes in ReplicatedStorage.exoremotes.
-- This script validates the sender and applies the commands through the game's
-- Core_PlayerData / Core_Assets / Core_Eggs systems.
--
-- Panel access requires the AdminPanel gamepass (PurchaseIdConfig.GamepassIds.AdminPanel).
-- GivePet additionally requires the GivePet gamepass.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Data = require(script.Parent.Core_PlayerData)
local ActiveAssets = require(script.Parent.Core_Assets)
local Eggs = require(script.Parent.Core_Eggs)
local AssetDirectory = require(ReplicatedStorage.Directory.Assets)
local AssetColorUtil = require(ReplicatedStorage.Library.Util.AssetColorUtil)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local MarketplaceService = game:GetService("MarketplaceService")
local PurchaseIds = require(ReplicatedStorage:WaitForChild("PurchaseIdConfig"))

local rng = Random.new()

-- The client Handler waits for this folder, so make sure it exists even if
-- the edit-time setup was skipped.
local folder = ReplicatedStorage:FindFirstChild("exoremotes")
if not folder then
	folder = Instance.new("Folder")
	folder.Name = "exoremotes"
	folder.Parent = ReplicatedStorage
end

local function getRemote(name: string): RemoteEvent
	local remote = folder:FindFirstChild(name)
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = folder
	end
	return remote :: RemoteEvent
end

-- Create the panel-access remotes up front so clients can wait for them.
getRemote("RequestPanel")
getRemote("PanelAccessResult")

local function ownsGamepass(player: Player, key: string): boolean
	local gamepassId = PurchaseIds.GamepassIds[key]
	if not gamepassId then
		warn(("[AdminPanel] %s gamepass is not configured in PurchaseIdConfig.GamepassIds."):format(key))
		return false
	end
	local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, gamepassId)
	if ok and owns then
		return true
	end
	-- Studio testing bypass: gamepasses cannot be owned in Studio sessions.
	return RunService:IsStudio()
end

local function hasPanelAccess(player: Player): boolean
	return ownsGamepass(player, "AdminPanel")
end

local function promptGamepass(player: Player, key: string)
	local gamepassId = PurchaseIds.GamepassIds[key]
	if gamepassId and not RunService:IsStudio() then
		MarketplaceService:PromptGamePassPurchase(player, gamepassId)
	end
end

-- The client asks for permission to open the panel (proximity prompt / Tools button).
getRemote("RequestPanel").OnServerEvent:Connect(function(player: Player)
	if hasPanelAccess(player) then
		getRemote("PanelAccessResult"):FireClient(player, true)
	else
		promptGamepass(player, "AdminPanel")
		getRemote("PanelAccessResult"):FireClient(player, false)
	end
end)

-- Resolve a typed pet/egg name to a real category in the Assets directory.
-- The directory is a strict table, so guard lookups with pcall.
local function resolveCategory(name: any): string?
	if typeof(name) ~= "string" then
		return nil
	end
	local ok, entry = pcall(function()
		return AssetDirectory.Directory[name]
	end)
	if ok and entry then
		return name
	end
	local lower = string.lower(name)
	for category in pairs(AssetDirectory.Directory) do
		if string.lower(category) == lower then
			return category
		end
	end
	return nil
end

-- AddCash: adds money to the player's balance.
getRemote("AddCash").OnServerEvent:Connect(function(player: Player, amount: any)
	if not hasPanelAccess(player) then
		return
	end
	amount = tonumber(amount)
	if not amount or amount <= 0 or amount > 1e15 then
		return
	end
	Data.AddMoney(player, amount)
end)

-- SetCash: sets the player's balance to a specific value.
getRemote("SetCash").OnServerEvent:Connect(function(player: Player, amount: any)
	if not hasPanelAccess(player) then
		return
	end
	amount = tonumber(amount)
	if not amount or amount < 0 or amount > 1e15 then
		return
	end
	Data.Update(player, {Money = amount})
end)

-- SetSpeed: sets the player's SpeedPower. Core_Treadmills listens to
-- Data.Changed and immediately applies the new walk speed to the character.
getRemote("SetSpeed").OnServerEvent:Connect(function(player: Player, amount: any)
	if not hasPanelAccess(player) then
		return
	end
	amount = tonumber(amount)
	if not amount or amount < 10 or amount > 1e18 then
		return
	end
	Data.Update(player, {SpeedPower = amount})
end)

-- Categories that must never be selectable/grantable via GivePet, regardless
-- of gamepass ownership.
local GIVEPET_EXCLUDED_CATEGORIES = {
	["Strawberry Elephant"] = true,
	["Phoenix"] = true,
	["Unicorn"] = true,
}

-- GivePet: grants a pet of the given category with the given scale.
-- Requires both AdminPanel and GivePet gamepasses.
getRemote("GivePet").OnServerEvent:Connect(function(player: Player, categoryName: any, scale: any)
	if not hasPanelAccess(player) then
		return
	end

	if not ownsGamepass(player, "GivePet") then
		promptGamepass(player, "GivePet")
		return
	end

	local category = resolveCategory(categoryName)
	if category and GIVEPET_EXCLUDED_CATEGORIES[category] then
		-- Never grantable, even with the gamepass or in Studio.
		return
	end
	if not category then
		return
	end
	scale = tonumber(scale)
	if not scale or scale <= 0 or scale > 10 then
		scale = 1
	end

	local profile = Data.Get(player)
	if not profile then
		return
	end

	local inventory = {}
	for uid, raw in pairs(profile.Inventory or {}) do
		inventory[uid] = raw
	end
	local colors = AssetColorUtil.RollFields(category, rng)
	local uid = HttpService:GenerateGUID(false)
	inventory[uid] = {
		Category = category,
		Mutations = {},
		Scale = scale,
		Gender = if rng:NextNumber() < 0.5 then "Male" else "Female",
		EyeColor = colors.EyeColor,
		ColorSeed = colors.ColorSeed,
		ColorIndex = colors.ColorIndex,
		Personality = Personalities.Personalities.Normal,
		HasBeenFirstPlaced = false,
		Seed = rng:NextInteger(1, 1_000_000_000),
	}
	Data.Update(player, {Inventory = inventory})
	ActiveAssets.Rebuild(player)
end)

-- GiveEgg: grants eggs of the given category.
getRemote("GiveEgg").OnServerEvent:Connect(function(player: Player, categoryName: any, amount: any)
	if not hasPanelAccess(player) then
		return
	end
	local category = resolveCategory(categoryName)
	if not category then
		return
	end
	amount = tonumber(amount)
	if not amount or amount < 1 or amount > 115 then
		return
	end
	Eggs.GrantEggs(player, amount, false, category)
end)

print("[AdminPanel] Server handler ready (AdminPanel + GivePet gamepass gating")