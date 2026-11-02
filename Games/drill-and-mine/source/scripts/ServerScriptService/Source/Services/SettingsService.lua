local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)

local SettingsService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SettingsRemotes = Remotes:WaitForChild("SettingsService")
local UpdateSettingFunc = SettingsRemotes:WaitForChild("UpdateSetting")
local RequestSettingsFunc = SettingsRemotes:WaitForChild("RequestSettings")
local SettingsUpdateEvent = SettingsRemotes:WaitForChild("SettingsUpdate")

local VALID_KEYS = {
	MusicVolume = "number",
	SoundsVolume = "number",
	BrainrotVfx = "boolean",
}

local DEFAULTS = {
	MusicVolume = 0.1,
	SoundsVolume = 0.5,
	BrainrotVfx = true,
}

local function getSettings(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then return nil end

	if not data.Settings then
		data.Settings = {}
		for key, val in pairs(DEFAULTS) do
			data.Settings[key] = val
		end
	end

	return data.Settings
end

local function buildSettingsPayload(player)
	local settings = getSettings(player)
	if not settings then return DEFAULTS end

	local payload = {}
	for key, default in pairs(DEFAULTS) do
		payload[key] = if settings[key] ~= nil then settings[key] else default
	end
	return payload
end

local function onUpdateSetting(player, key, value)
	if type(key) ~= "string" then return false end

	local expectedType = VALID_KEYS[key]
	if not expectedType then return false end
	if type(value) ~= expectedType then return false end

	if expectedType == "number" then
		value = math.clamp(value, 0, 1)
	end

	local settings = getSettings(player)
	if not settings then return false end

	settings[key] = value
	PlayerDataService.DataChanged:Fire(player, "Settings", settings)

	return true
end

local function onRequestSettings(player)
	return buildSettingsPayload(player)
end

function SettingsService.GetPlayerSettings(player)
	return buildSettingsPayload(player)
end

function SettingsService.IsVfxEnabled(player)
	local settings = getSettings(player)
	if not settings then return true end
	return settings.BrainrotVfx ~= false
end

function SettingsService.Init()
	UpdateSettingFunc.OnServerInvoke = onUpdateSetting
	RequestSettingsFunc.OnServerInvoke = onRequestSettings

	PlayerDataService.ProfileLoaded.Event:Connect(function(player, data)
		if not data.Settings then
			data.Settings = {}
			for key, val in pairs(DEFAULTS) do
				data.Settings[key] = val
			end
		end
		task.defer(function()
			SettingsUpdateEvent:FireClient(player, buildSettingsPayload(player))
		end)
	end)
end

return SettingsService