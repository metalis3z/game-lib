local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)

local VALID_SETTINGS = {
	muteSounds = "boolean",
	muteMusic = "boolean",
	hidePopups = "boolean",
	extraHatchingSounds = "boolean",
}

local SettingsService = Knit.CreateService({
	Name = "SettingsService",
	Client = {},
	_ds = nil,
})

function SettingsService.Client:changeSetting(player, settingName, value)
	local expectedType = VALID_SETTINGS[settingName]
	if not expectedType then return "invalid" end
	if typeof(value) ~= expectedType then return "invalidType" end
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	self.Server._ds:Set(player, {"settings", settingName}, value)
	return "success"
end

function SettingsService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function SettingsService:KnitStart()
	print("[SettingsService] Started")
end

return SettingsService