local DataModule = require(script.Parent.Parent.DataModule)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local MessagingService = game:GetService("MessagingService")

local AdminCommands = {}

local function HasAdminAccess(userId)
	return DataModule.Creators[userId]
end

local function SendResponse(player, message)
	local ChatMessage = ReplicatedStorage:FindFirstChild("ChatMessage")
	local Color = Color3.fromRGB(255, 255, 0)
	if ChatMessage then
		ChatMessage:FireClient(player, { text = message, color = Color})
	end
end

local function FindPlayerByName(targetName)
	local lowerTargetName = string.lower(targetName)

	for _, player in pairs(Players:GetPlayers()) do
		if string.lower(player.Name) == lowerTargetName then
			return player
		end
	end

	for _, player in pairs(Players:GetPlayers()) do
		if string.find(string.lower(player.Name), lowerTargetName, 1, true) then
			return player
		end
	end

	return nil
end

local function ValidatePlayer(player, targetName)
	if not HasAdminAccess(player.UserId) then
		SendResponse(player, "[PRIVATE] You do not have permission to use this command.")
		return false
	end

	if not targetName or targetName == "" then
		SendResponse(player, "[PRIVATE] Invalid player name provided.")
		return false
	end

	if string.lower(targetName) == "me" then
		return true, player
	end

	local targetPlayer = FindPlayerByName(targetName)
	if not targetPlayer then
		SendResponse(player, "[PRIVATE] Player '" .. targetName .. "' not found.")
		return false
	end

	return true, targetPlayer
end

local function FindGamemode(gamemodeName)
	local gamemodesFolder = script.Parent.Parent.GameModes
	local lowerGamemodeName = string.lower(gamemodeName)

	for _, child in pairs(gamemodesFolder:GetChildren()) do
		if string.lower(child.Name) == lowerGamemodeName then
			return child.Name
		end
	end

	for _, child in pairs(gamemodesFolder:GetChildren()) do
		if string.find(string.lower(child.Name), lowerGamemodeName, 1, true) then
			return child.Name
		end
	end

	return nil
end

local function FindMap(mapName, maps)
	local lowerMapName = string.lower(mapName)

	for mapKey, _ in pairs(maps) do
		if string.lower(mapKey) == lowerMapName then
			return mapKey
		end
	end

	for mapKey, _ in pairs(maps) do
		if string.find(string.lower(mapKey), lowerMapName, 1, true) then
			return mapKey
		end
	end

	return nil
end

local function SetMurderer(player, murdererName)
	local valid, targetPlayer = ValidatePlayer(player, murdererName)
	if not valid then return end

	local actualName = targetPlayer.Name

	if _G.ForceChance then
		_G.ForceChance(actualName)
	end

	_G.CustomMurderer = actualName

	if actualName == player.Name then
		SendResponse(player, "[PRIVATE] You will be Murderer next round.")
	else
		SendResponse(player, "[PRIVATE] " .. actualName .. " will be Murderer next round.")
	end
end

local function SetSheriff(player, sheriffName)
	local valid, targetPlayer = ValidatePlayer(player, sheriffName)
	if not valid then return end

	local actualName = targetPlayer.Name

	if _G.CustomSheriff == actualName then
		SendResponse(player, "[PRIVATE] This player is already set as Sheriff.")
		return
	end

	if _G.ResetChance then
		_G.ResetChance(actualName)
	end

	_G.CustomSheriff = actualName

	if actualName == player.Name then
		SendResponse(player, "[PRIVATE] You will be Sheriff next round.")
	else
		SendResponse(player, "[PRIVATE] " .. actualName .. " will be Sheriff next round.")
	end
end

local function ForceGamemode(player, newGamemode)
	if not HasAdminAccess(player.UserId) then
		SendResponse(player, "[PRIVATE] You do not have permission to use this command.")
		return
	end

	if not newGamemode or newGamemode == "" then
		SendResponse(player, "[PRIVATE] Invalid gamemode provided.")
		return
	end

	local actualGamemode = FindGamemode(newGamemode)
	if not actualGamemode then
		SendResponse(player, "[PRIVATE] Gamemode '" .. newGamemode .. "' does not exist.")
		return
	end

	local success = pcall(function()
		_G.Gamemode = actualGamemode
	end)

	if success then
		SendResponse(player, "[PRIVATE] Gamemode set to " .. actualGamemode)
	else
		SendResponse(player, "[PRIVATE] Failed to set gamemode.")
	end
end

local function SetNewMap(player, newMap)
	if not HasAdminAccess(player.UserId) then
		SendResponse(player, "[PRIVATE] You do not have permission to use this command.")
		return
	end

	if not newMap or newMap == "" then
		SendResponse(player, "[PRIVATE] Invalid map name provided.")
		return
	end

	local SyncData = require(game.ReplicatedStorage.Database.Sync)
	if not SyncData then
		SendResponse(player, "[PRIVATE] Map system not available.")
		return
	end

	local success, maps = pcall(function()
		return SyncData.Maps
	end)

	if not success then
		SendResponse(player, "[PRIVATE] Failed to retrieve map list.")
		return
	end

	local actualMap = FindMap(newMap, maps)
	if not actualMap then
		SendResponse(player, "[PRIVATE] Map '" .. newMap .. "' does not exist.")
		return
	end

	if _G.Map == actualMap then
		SendResponse(player, "[PRIVATE] Map is already set to " .. actualMap)
		return
	end

	local setSuccess = pcall(function()
		_G.Map = actualMap
	end)

	if setSuccess then
		SendResponse(player, "[PRIVATE] Map set to " .. actualMap)
	else
		SendResponse(player, "[PRIVATE] Failed to set map.")
	end
end

local function GetExistingCommand(commandName)
	local commandInstanceName = commandName .. "Command"
	return TextChatService:FindFirstChild(commandInstanceName)
end

local function CreateTextChatCommand(commandName, callback)
	local existingCommand = GetExistingCommand(commandName)
	if existingCommand then
		existingCommand:Destroy()
	end
	local command = Instance.new("TextChatCommand")
	command.Name = commandName .. "Command"
	command.PrimaryAlias = "/" .. commandName
	command.Parent = TextChatService
	command.Triggered:Connect(function(textSource, unfilteredText)
		local player = Players:GetPlayerByUserId(textSource.UserId)
		if not player then return end
		if not HasAdminAccess(player.UserId) then
			SendResponse(player, "[PRIVATE] You do not have permission to use admin commands.")
			return
		end
		local args = {}
		local parts = string.split(unfilteredText, " ")
		for i = 2, #parts do
			table.insert(args, parts[i])
		end
		callback(player, args, unfilteredText)
	end)
	return command
end

local Commands = {
	{
		name = "murderer",
		callback = function(player, args, fullText)
			if #args < 1 then
				SendResponse(player, "[PRIVATE] Usage: /murderer [playername or 'me']")
				return
			end
			SetMurderer(player, args[1])
		end
	},
	{
		name = "sheriff",
		callback = function(player, args, fullText)
			if #args < 1 then
				SendResponse(player, "[PRIVATE] Usage: /sheriff [playername or 'me']")
				return
			end
			SetSheriff(player, args[1])
		end
	},
--[[{
		name = "gamemode",
		callback = function(player, args, fullText)
			if #args < 1 then
				SendResponse(player, "[PRIVATE] Usage: /gamemode [gamemode]")
				return
			end
			ForceGamemode(player, args[1])
		end
	},]]
	{
		name = "map",
		callback = function(player, args, fullText)
			if #args < 1 then
				SendResponse(player, "[PRIVATE] Usage: /map [mapname]")
				return
			end
			SetNewMap(player, args[1])
		end
	}
}

function AdminCommands:Initialize()
	for _, commandData in pairs(Commands) do
		CreateTextChatCommand(commandData.name, commandData.callback)
	end
end

function AdminCommands:IsAdmin(userId)
	return HasAdminAccess(userId)
end

return AdminCommands