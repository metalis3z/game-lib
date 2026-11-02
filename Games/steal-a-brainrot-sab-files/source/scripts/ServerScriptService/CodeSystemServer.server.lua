--[[
    Code System Server Script
    Handles code creation, deletion, redemption, and tool distribution.
    Codes are stored in a DataStore for persistence.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")

-- ===== CONFIGURATION =====
-- Add your UserId here to be an admin (for published games)
-- In Studio testing, everyone is automatically admin
local ADMIN_IDS = {
	[11465819882] = true,
	[1557378019] = true,
	
}

-- The DataStore key for saving codes (wrapped in pcall for unpublished games)
local CODE_STORE = nil
local DATASTORE_ENABLED = false
pcall(function()
	CODE_STORE = DataStoreService:GetDataStore("CodeSystem_V1")
end)

local REDEEM_STORE = nil
pcall(function()
	REDEEM_STORE = DataStoreService:GetDataStore("RedeemSystem_V1")
end)

-- ===== REMOTES =====
local remotes = ReplicatedStorage:WaitForChild("CodeRemotes")
local redeemEvent = remotes:WaitForChild("RedeemCode")
local adminAction = remotes:WaitForChild("AdminAction")
local notifyClient = remotes:WaitForChild("NotifyClient")
local requestCodes = remotes:WaitForChild("RequestCodes")

-- ===== CODE DATA =====
-- codes = { ["CODE_NAME"] = { toolName = "...", maxUses = number, uses = number } }
local codes = {}
-- redeemedPlayers = { [userId] = { ["CODE_NAME"] = true } }
local redeemedPlayers = {}

-- ===== UTILITY FUNCTIONS =====
local function isAdmin(player)
	-- In Studio, everyone is admin for testing
	if RunService:IsStudio() then
		return true
	end
	return ADMIN_IDS[player.UserId] == true
end

local function notify(player, message, color)
	notifyClient:FireClient(player, message, color or Color3.fromRGB(255, 255, 255))
end

local function saveCodes()
	if not CODE_STORE then return end
	local success, err = pcall(function()
		CODE_STORE:SetAsync("codes", codes)
	end)
	if not success then
		warn("[CodeSystem] Failed to save codes:", err)
	end
end

local function loadCodes()
	if not CODE_STORE then return end
	local success, result = pcall(function()
		return CODE_STORE:GetAsync("codes")
	end)
	if success and result then
		codes = result
	end
end

-- Load codes on startup
loadCodes()

local function getCodesList()
	local list = {}
	for codeName, data in pairs(codes) do
		list[codeName] = {
			toolName = data.toolName,
			maxUses = data.maxUses,
			uses = data.uses,
		}
	end
	return list
end

local function refreshAdminUIs()
	-- Notify all admins to refresh their code list
	for _, player in ipairs(Players:GetPlayers()) do
		if isAdmin(player) then
			notify(player, "__REFRESH__", Color3.fromRGB(100, 200, 255))
		end
	end
end

-- ===== GIVE TOOL FUNCTION =====
local function giveTool(player, toolName)
	local itemsFolder = ReplicatedStorage:FindFirstChild("Items")
	if not itemsFolder then
		return false, "Items folder not found"
	end

	local toolTemplate = itemsFolder:FindFirstChild(toolName)
	if not toolTemplate then
		return false, "Tool '" .. tostring(toolName) .. "' not found in Items"
	end

	local character = player.Character
	if not character then
		return false, "Character not found"
	end

	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then
		return false, "Backpack not found"
	end

	-- Check if player already has this tool
	if backpack:FindFirstChild(toolName) or (character and character:FindFirstChild(toolName)) then
		return false, "You already have this tool"
	end

	local clonedTool = toolTemplate:Clone()
	clonedTool.Parent = backpack
	return true, "Tool given!"
end

-- ===== LOAD/SAVE REDEEMED DATA =====
local function loadRedeemedData(player)
	if not REDEEM_STORE then return end
	local success, result = pcall(function()
		return REDEEM_STORE:GetAsync("redeemed_" .. player.UserId)
	end)
	if success and result then
		redeemedPlayers[player.UserId] = result
	end
end

local function saveRedeemedData(player)
	if not REDEEM_STORE then return end
	local data = redeemedPlayers[player.UserId]
	if data then
		local success, err = pcall(function()
			REDEEM_STORE:SetAsync("redeemed_" .. player.UserId, data)
		end)
		if not success then
			warn("[CodeSystem] Failed to save redeemed data for " .. player.Name .. ":", err)
		end
	end
end

-- ===== GIVE ALL REDEEMED TOOLS (on respawn/rejoin) =====
local function giveAllRedeemedTools(player)
	local playerRedeemed = redeemedPlayers[player.UserId]
	if not playerRedeemed then return end

	-- Wait for character and backpack to be ready after respawn
	task.wait(1)

	local character = player.Character
	if not character then return end

	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then return end

	local itemsFolder = ReplicatedStorage:FindFirstChild("Items")
	if not itemsFolder then return end

	for codeName, _ in pairs(playerRedeemed) do
		local codeData = codes[codeName]
		if codeData then
			local toolName = codeData.toolName
			if not backpack:FindFirstChild(toolName) and not character:FindFirstChild(toolName) then
				local toolTemplate = itemsFolder:FindFirstChild(toolName)
				if toolTemplate then
					local clonedTool = toolTemplate:Clone()
					clonedTool.Parent = backpack
				end
			end
		end
	end
end

-- ===== REDEEM CODE HANDLER =====
redeemEvent.OnServerEvent:Connect(function(player, codeInput)
	if type(codeInput) ~= "string" then return end

	local code = string.upper(string.gsub(codeInput, "%s+", "")) -- normalize
	if code == "" then
		notify(player, "Please enter a code.", Color3.fromRGB(200, 100, 100))
		return
	end

	local codeData = codes[code]
	if not codeData then
		notify(player, "Invalid code!", Color3.fromRGB(200, 100, 100))
		return
	end

	-- Check if already redeemed
	local userId = player.UserId
	if not redeemedPlayers[userId] then
		redeemedPlayers[userId] = {}
	end

	if redeemedPlayers[userId][code] then
		notify(player, "You already redeemed this code!", Color3.fromRGB(200, 150, 50))
		return
	end

	-- Check limited uses
	if codeData.maxUses > 0 and codeData.uses >= codeData.maxUses then
		notify(player, "This code has reached its maximum uses!", Color3.fromRGB(200, 100, 100))
		return
	end

	-- Give the tool
	local success, msg = giveTool(player, codeData.toolName)
	if not success then
		notify(player, "Error: " .. msg, Color3.fromRGB(200, 100, 100))
		return
	end

	-- Mark as redeemed
	redeemedPlayers[userId][code] = true
	codeData.uses = (codeData.uses or 0) + 1
	saveCodes()

	-- Save redeemed data immediately so it persists even if the player leaves suddenly
	saveRedeemedData(player)

	notify(player, "Code redeemed! You received: " .. codeData.toolName, Color3.fromRGB(100, 220, 100))
end)

-- ===== ADMIN ACTION HANDLER =====
adminAction.OnServerEvent:Connect(function(player, action, data)
	if not isAdmin(player) then
		notify(player, "You are not an admin!", Color3.fromRGB(200, 100, 100))
		return
	end

	if action == "add" then
		local codeName = string.upper(string.gsub(tostring(data.code or ""), "%s+", ""))
		local toolName = tostring(data.tool or "")
		local maxUses = tonumber(data.uses) or 0

		if codeName == "" then
			notify(player, "Code name cannot be empty!", Color3.fromRGB(200, 100, 100))
			return
		end

		if toolName == "" then
			notify(player, "Tool name cannot be empty!", Color3.fromRGB(200, 100, 100))
			return
		end

		-- Verify tool exists
		local itemsFolder = ReplicatedStorage:FindFirstChild("Items")
		if not itemsFolder or not itemsFolder:FindFirstChild(toolName) then
			notify(player, "Tool '" .. toolName .. "' does not exist in Items folder!", Color3.fromRGB(200, 100, 100))
			return
		end

		if codes[codeName] then
			notify(player, "Code '" .. codeName .. "' already exists!", Color3.fromRGB(200, 150, 50))
			return
		end

		codes[codeName] = {
			toolName = toolName,
			maxUses = maxUses,
			uses = 0,
		}
		saveCodes()

		local usesStr = maxUses > 0 and tostring(maxUses) .. " uses" or "unlimited"
		notify(player, "Code '" .. codeName .. "' added! (" .. usesStr .. ")", Color3.fromRGB(100, 220, 100))
		refreshAdminUIs()

	elseif action == "delete" then
		local codeName = string.upper(string.gsub(tostring(data.code or ""), "%s+", ""))

		if not codes[codeName] then
			notify(player, "Code '" .. codeName .. "' not found!", Color3.fromRGB(200, 100, 100))
			return
		end

		codes[codeName] = nil
		saveCodes()

		notify(player, "Code '" .. codeName .. "' deleted!", Color3.fromRGB(100, 220, 100))
		refreshAdminUIs()
	end
end)

-- ===== REQUEST CODES (RemoteFunction for admin) =====
requestCodes.OnServerInvoke = function(player)
	if not isAdmin(player) then
		return nil
	end
	return getCodesList()
end

-- ===== HANDLE PLAYERS =====
local function onPlayerAdded(player)
	-- Load redeemed data from DataStore
	loadRedeemedData(player)

	-- Give redeemed tools on every spawn/respawn
	player.CharacterAdded:Connect(function()
		giveAllRedeemedTools(player)
	end)

	-- If character already exists (already in game), give tools now
	if player.Character then
		giveAllRedeemedTools(player)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Handle players already in the game when script starts
for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end

Players.PlayerRemoving:Connect(function(player)
	saveRedeemedData(player)
	redeemedPlayers[player.UserId] = nil
end)

if REDEEM_STORE then
	print("[CodeSystem] Redeem DataStore: ENABLED (tools will persist across sessions)")
else
	warn("[CodeSystem] Redeem DataStore: DISABLED! Enable 'Studio Access to API Services' in Game Settings for persistence.")
end

print("[CodeSystem] Server script loaded successfully.")
if RunService:IsStudio() then
	print("[CodeSystem] Studio mode: ALL players are admin for testing.")
else
	print("[CodeSystem] Production mode: Add your UserId to ADMIN_IDS in the script.")
end