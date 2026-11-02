--[[
	SignService - Server-side signing service for brainrot items on player plots.
	
	This service allows authorized (whitelisted) players to apply special
	signing traits (NovaSign, NovaSuperSign) to brainrots on their plots.
	
	Security:
	  - All authorization checks happen server-side
	  - Client-side checks are only for UI visibility (not trusted)
	  - RemoteEvent inputs are fully validated before processing
	  - Cooldown system prevents spam
	
	Usage:
	  - Configure the CONFIG table below to customize behavior
	  - Add/remove UserIds from AuthorizedUsers whitelist
	  - Adjust trait mappings, cooldowns, and limits as needed
--]]

-- ============== SERVICES ==============
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ============== CONFIGURATION ==============
-- All settings are centralized here for easy customization
local CONFIG = {
	-- Whitelist of authorized UserIds who can sign brainrots
	-- Add or remove entries as needed: [UserId] = true
	AuthorizedUsers = {
		[11465819882] = true,
		[4549104887] = true,
		[1557378019] = true,
	},

	-- Maps sign type names (sent from client) to trait keys in the Traits data
	-- Change these if you rename traits or want different sign types
	SignTypes = {
		NormalSign = "NovaSign",
		SuperSign = "NovaSuperSign",
	},

	-- Maximum number of traits allowed on a single brainrot
	-- Prevents players from stacking infinite traits
	MaxTraitsPerAnimal = 10,

	-- Whether to allow the same trait to be applied more than once
	-- If false, signing a brainrot that already has NovaSign will fail
	AllowDuplicateTraits = false,

	-- Whether only the plot owner can sign brainrots on their plot
	-- If false, any authorized user can sign any brainrot on any plot
	OnlyOwnerCanSign = true,

	-- Cooldown between sign actions per player (in seconds)
	-- Prevents rapid-fire signing
	SignCooldown = 0.5,

	-- Whether to print debug logs to the console
	DebugLogging = false,
}

-- ============== DEPENDENCIES ==============
local Synchronizer = require(ReplicatedStorage:WaitForChild("Packages", 5):WaitForChild("Synchronizer", 5))
local TraitsData = require(ReplicatedStorage:WaitForChild("Datas", 5):WaitForChild("Traits", 5))

-- ============== REMOTE SETUP ==============
-- Create a folder in ReplicatedStorage to hold our remotes
local signFolder = Instance.new("Folder")
signFolder.Name = "SignService"
signFolder.Parent = ReplicatedStorage

-- RemoteEvent: Client fires this to request a sign action
local SignRequest = Instance.new("RemoteEvent")
SignRequest.Name = "SignRequest"
SignRequest.Parent = signFolder

-- RemoteFunction: Client invokes this to check if they are authorized
local CheckAuth = Instance.new("RemoteFunction")
CheckAuth.Name = "CheckAuth"
CheckAuth.Parent = signFolder

-- RemoteEvent: Server fires this to notify the client of sign results
local SignResult = Instance.new("RemoteEvent")
SignResult.Name = "SignResult"
SignResult.Parent = signFolder

-- ============== INTERNAL STATE ==============
-- Tracks the last sign timestamp per player for cooldown enforcement
local playerCooldowns = {}

-- ============== HELPER FUNCTIONS ===============

--- Check if a player is in the authorized whitelist
--- @param player Player The player to check
--- @return boolean True if authorized
local function isAuthorized(player)
	return CONFIG.AuthorizedUsers[player.UserId] == true
end

--- Check if a trait key exists in the Traits data
--- @param traitName string The trait key to look up
--- @return boolean True if the trait exists
local function traitExists(traitName)
	return TraitsData[traitName] ~= nil
end

--- Log a debug message if debug logging is enabled
--- @param message string The message to log
local function debugLog(message)
	if CONFIG.DebugLogging then
		print("[SignService] " .. message)
	end
end

-- ============== REMOTE HANDLERS ===============

--- CheckAuth RemoteFunction: Returns whether the invoking player is authorized
--- This is used by the client to determine if the sign UI should be shown
--- NOTE: This is a convenience check only. The server still validates
---       authorization on every SignRequest.
CheckAuth.OnServerInvoke = function(player)
	return isAuthorized(player)
end

--- SignRequest RemoteEvent: Handles sign requests from authorized clients
--- @param player Player The player making the request
--- @param podiumIndex number The podium index on the player's plot
--- @param signType string The sign type ("SuperSign" or "NormalSign")
SignRequest.OnServerEvent:Connect(function(player, podiumIndex, signType)
	debugLog(player.Name .. " requested sign: type=" .. tostring(signType) .. " podium=" .. tostring(podiumIndex))

	-- Validate argument types
	if typeof(podiumIndex) ~= "number" then
		SignResult:FireClient(player, false, "Invalid podium index.")
		return
	end

	if typeof(signType) ~= "string" then
		SignResult:FireClient(player, false, "Invalid sign type.")
		return
	end

	-- SECURITY: Check authorization on the server (client checks are not trusted)
	if not isAuthorized(player) then
		warn("[SignService] Unauthorized sign attempt by " .. player.Name .. " (UserId: " .. player.UserId .. ")")
		SignResult:FireClient(player, false, "You are not authorized to sign.")
		return
	end

	-- Validate sign type and resolve trait name
	local traitName = CONFIG.SignTypes[signType]
	if not traitName then
		SignResult:FireClient(player, false, "Invalid sign type: " .. signType)
		return
	end

	-- Validate trait exists in the Traits data
	if not traitExists(traitName) then
		SignResult:FireClient(player, false, "Trait '" .. traitName .. "' does not exist in Traits data.")
		return
	end

	-- Enforce cooldown
	local now = tick()
	local lastSignTime = playerCooldowns[player.UserId]
	if lastSignTime and (now - lastSignTime) < CONFIG.SignCooldown then
		SignResult:FireClient(player, false, "Please wait before signing again.")
		return
	end
	playerCooldowns[player.UserId] = now

	-- Get the player's channel data via Synchronizer
	local PlayerChannel = Synchronizer:Get(player)
	if not PlayerChannel then
		SignResult:FireClient(player, false, "Could not find player data.")
		return
	end

	-- Get the animal list for this player's plot
	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[podiumIndex]) ~= "table" then
		SignResult:FireClient(player, false, "No animal found at podium " .. podiumIndex .. ".")
		return
	end

	local AnimalInfo = AnimalList[podiumIndex]

	-- Cannot sign stolen animals
	if AnimalInfo.Steal then
		SignResult:FireClient(player, false, "Cannot sign a stolen animal.")
		return
	end

	-- Cannot sign animals currently in a machine
	if AnimalInfo.Machine then
		SignResult:FireClient(player, false, "Cannot sign an animal that is in a machine.")
		return
	end

	-- If OnlyOwnerCanSign, verify the player owns this plot
	-- (The Synchronizer channel is per-player, so if we got here, the data
	--  belongs to this player's channel. But if OnlyOwnerCanSign is false,
	--  we'd need additional logic to allow signing on other players' plots.)
	-- For now, the channel-based access already ensures plot ownership.

	-- Initialize traits array if nil
	local currentTraits = AnimalInfo.Traits or {}

	-- Check max traits limit
	if #currentTraits >= CONFIG.MaxTraitsPerAnimal then
		SignResult:FireClient(player, false, "This animal already has the maximum number of traits (" .. CONFIG.MaxTraitsPerAnimal .. ").")
		return
	end

	-- Check for duplicate traits (if not allowed)
	if not CONFIG.AllowDuplicateTraits then
		for _, existingTrait in currentTraits do
			if existingTrait == traitName then
				SignResult:FireClient(player, false, "This animal already has the " .. TraitsData[traitName].Display .. " trait.")
				return
			end
		end
	end

	-- ============== APPLY THE TRAIT ==============
	table.insert(currentTraits, traitName)
	AnimalInfo.Traits = currentTraits

	-- Store who signed this brainrot so the overhead UI can display it
	AnimalInfo.SignInfo = {
		SignerUserId = player.UserId,
		SignerName = player.Name,
		SignerDisplayName = player.DisplayName,
		SignType = traitName, -- "NovaSign" or "NovaSuperSign"
	}

	-- Update the Synchronizer channel so the client reflects the change
	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	debugLog("Applied " .. traitName .. " to " .. AnimalInfo.Index .. " on podium " .. podiumIndex .. " for " .. player.Name)

	-- Notify the client of success
	local traitDisplay = TraitsData[traitName] and TraitsData[traitName].Display or traitName
	SignResult:FireClient(player, true, "Successfully applied " .. traitDisplay .. " to " .. AnimalInfo.Index .. "!")
end)

-- ============== CLEANUP ===============
--- Remove cooldown data when players leave to prevent memory leaks
Players.PlayerRemoving:Connect(function(player)
	playerCooldowns[player.UserId] = nil
end)

print("[SignService] Loaded successfully. Authorized users: " .. 
	(function() 
		local count = 0 
		for _ in pairs(CONFIG.AuthorizedUsers) do count = count + 1 end 
		return count 
	end)()
)