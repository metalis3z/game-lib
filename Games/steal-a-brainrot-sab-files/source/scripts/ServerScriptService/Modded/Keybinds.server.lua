local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindStore = DataStoreService:GetDataStore("PlayerKeybinds_v1")
local Net = require(ReplicatedStorage.Packages.Net)
local saveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local keybindCache = {}
local saveTokens = {}

local function loadKeybinds(player)
	local success, data = pcall(function()
		return KeybindStore:GetAsync(tostring(player.UserId))
	end)
	if success then
		if type(data) == "table" then
			return data
		end
	else
		warn("[KeybindService] loadKeybinds FAILED for", player.Name, "| error:", data)
	end
	return {}
end

local function saveKeybinds(player)
	local data = keybindCache[player]
	if not data then
		warn("[KeybindService] saveKeybinds: no cache entry for", player.Name, "— skipping")
		return
	end
	local success, err = pcall(function()
		KeybindStore:SetAsync(tostring(player.UserId), data)
	end)
	if not success then
		warn("[KeybindService] saveKeybinds FAILED for", player.Name, "| error:", err)
	end
end

Players.PlayerAdded:Connect(function(player)
	local saved = loadKeybinds(player)
	keybindCache[player] = saved

	local channel = Synchronizer:Create(player.UserId, {
		keybinds = saved
	})
	channel:AddListener(player)
end)

Players.PlayerRemoving:Connect(function(player)
	saveTokens[player] = nil
	saveKeybinds(player)
	keybindCache[player] = nil
	Synchronizer:Destroy(player.UserId)
end)

game:BindToClose(function()
	for player in pairs(keybindCache) do
		saveKeybinds(player)
	end
end)

saveKeyRemote.OnServerEvent:Connect(function(player, actionName, keyCodeName)

	if type(actionName) ~= "string" then
		warn("[KeybindService] Rejected: actionName is not a string, got:", type(actionName))
		return
	end
	if keyCodeName ~= nil and type(keyCodeName) ~= "string" then
		warn("[KeybindService] Rejected: keyCodeName is not nil/string, got:", type(keyCodeName))
		return
	end
	if keyCodeName ~= nil then
		local ok, result = pcall(function()
			return Enum.KeyCode[keyCodeName]
		end)
		if not ok or result == nil then
			warn("[KeybindService] Rejected: invalid KeyCode name:", keyCodeName)
			return
		end
	end

	local data = keybindCache[player]
	if not data then
		warn("[KeybindService] OnServerEvent: no cache entry for", player.Name, "— cannot save")
		return
	end
	
	data[actionName] = keyCodeName

	local channel = Synchronizer:Get(player.UserId)
	if channel then
		channel:Set("keybinds", data)
	else
		warn("[KeybindService] No channel found for userId:", player.UserId)
	end

	local token = {}
	saveTokens[player] = token
	task.delay(3, function()
		if saveTokens[player] == token then
			saveTokens[player] = nil
			saveKeybinds(player)
		end
	end)
end)