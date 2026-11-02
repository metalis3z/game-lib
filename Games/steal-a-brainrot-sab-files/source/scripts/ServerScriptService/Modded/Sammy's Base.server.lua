local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerStorage       = game:GetService("ServerStorage")
local Players             = game:GetService("Players")
local MarketplaceService  = game:GetService("MarketplaceService")
local TextService         = game:GetService("TextService")

local Net                 = require(ReplicatedStorage.Packages.Net)
local animalData          = require(ReplicatedStorage.Datas.Animals)
local GameData            = require(ReplicatedStorage.GameData)

local blacklisted         = GameData.UnSpawnableBrainrots

local SammyBaseState      = require(game.ServerScriptService.SammyBaseState)
local MAX_ANIMALS         = 27
local EventService        = require(game.ServerScriptService.Services.EventService)

local MAX_DISPLAY_NAME_LENGTH = 32

local ALLOWED_NAME_PATTERN = "^[a-zA-Z0-9 '%-.!?_]+$"

local sammyCooldowns = {}
local SAMMY_COOLDOWN     = 60
local SAMMY_COOLDOWN_VIP = 3
local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local NO_COOLDOWN_GAMEPASS_ID = RobuxShopData.GetId("Cooldown")

local function hasNoCooldownGamepass(player: Player): boolean
	return RobuxShopData.OwnsGamepass(player, "Cooldown")
end

Players.PlayerRemoving:Connect(function(player)
	sammyCooldowns[player.UserId] = nil
end)

local SammyBaseOverrideRemote = Net:RemoteFunction("SammyBaseService/SetSammyBase")

local setItemsBindable: BindableFunction = ServerStorage:WaitForChild("SetSammyBaseItemsBindable")

local function isBlacklisted(name: string): boolean
	if blacklisted[name] then return true end
	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end

local function filterDisplayName(player: Player, displayName: string): (string?, string?)

	if #displayName > MAX_DISPLAY_NAME_LENGTH then
		return nil, ("Display name is too long (max %d characters)."):format(MAX_DISPLAY_NAME_LENGTH)
	end

	if not displayName:match(ALLOWED_NAME_PATTERN) then
		return nil, "Display name contains invalid characters. Only letters, numbers, spaces and basic punctuation are allowed."
	end

	local filterSuccess, filterObject = pcall(function()
		return TextService:FilterStringAsync(
			displayName,
			player.UserId,
			Enum.TextFilterContext.PublicChat
		)
	end)

	if not filterSuccess then
		return nil, "Display name could not be verified right now. Please try again."
	end

	local getSuccess, filteredText = pcall(function()
		return filterObject:GetNonChatStringForBroadcastAsync()
	end)

	if not getSuccess then
		return nil, "Display name could not be verified right now. Please try again."
	end

	return filteredText, nil
end

SammyBaseOverrideRemote.OnServerInvoke = function(requestingPlayer: Player, animals: {string}, skin: string, displayName: string)

	local cooldownTime = hasNoCooldownGamepass(requestingPlayer) and SAMMY_COOLDOWN_VIP or SAMMY_COOLDOWN

	local last = sammyCooldowns[requestingPlayer.UserId]
	if last and (os.time() - last) < cooldownTime then
		local remaining = cooldownTime - (os.time() - last)
		return false, ("Please wait %d seconds before starting another event."):format(remaining)
	end

	local hasAnimals = false

	if animals ~= nil then
		if type(animals) == "table" then
			if #animals > 0 then
				hasAnimals = true
			end
		end
	end

	if hasAnimals then
		if #animals > MAX_ANIMALS then
			return false, ("Maximum %d animals allowed. You provided %d."):format(MAX_ANIMALS, #animals)
		end

		for i, name in ipairs(animals) do
			if type(name) ~= "string" then
				return false, ("Slot %d – entry is not a string."):format(i)
			end
			if not animalData[name] then
				return false, ("Slot %d – Invalid brainrot: '%s'"):format(i, tostring(name))
			end
			if isBlacklisted(name) then
				return false, ("Slot %d – Blacklisted brainrot: '%s'"):format(i, name)
			end
		end
	end

	local hasSkin = false

	if skin ~= nil then
		if type(skin) == "string" then
			if skin ~= "" then
				if not skin:match("^%s*$") then
					hasSkin = true
				end
			end
		end
	end

	local hasDisplayName = false
	local filteredDisplayName = nil

	if displayName ~= nil then
		if type(displayName) == "string" then
			local trimmed = displayName:match("^%s*(.-)%s*$") or ""
			if trimmed ~= "" then
				local filtered, filterErr = filterDisplayName(requestingPlayer, trimmed)
				if not filtered then
					return false, filterErr
				end
				filteredDisplayName = filtered
				hasDisplayName = true
			end
		end
	end

	if not hasAnimals and not hasSkin and not hasDisplayName then
		return false, "Must provide at least one of: animals, skin, or display name."
	end

	if hasAnimals then
		SammyBaseState.pendingOverride = animals
	else
		SammyBaseState.pendingOverride = nil
	end

	if hasSkin then
		SammyBaseState.pendingSkin = skin
	else
		SammyBaseState.pendingSkin = nil
	end

	if hasDisplayName then
		SammyBaseState.pendingName = filteredDisplayName
	else
		SammyBaseState.pendingName = nil
	end

	EventService:ExecuteEvent("Sammy's Base", 180)

	sammyCooldowns[requestingPlayer.UserId] = os.time()

	local parts = {}

	if hasAnimals then
		table.insert(parts, ("%d animals"):format(#animals))
	else
		table.insert(parts, "no animals")
	end

	if hasSkin then
		table.insert(parts, ("skin '%s'"):format(skin))
	else
		table.insert(parts, "no skin override")
	end

	if hasDisplayName then
		table.insert(parts, ("name '%s'"):format(filteredDisplayName))
	else
		table.insert(parts, "no name override")
	end

	return true, ("Override set with %s. Starting event..."):format(table.concat(parts, ", "))
end
