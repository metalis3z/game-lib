--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local UI = modules.Parent.Controllers.UI
local Fonts = require(script.Parent.Fonts)
local InputObjects = require(UI.Config.InputObjects)
local Verifiers = require(modules.VerifyUtil.settingVerifiers)
local isNumberSafe = require(modules.VerifyUtil.isNumberSafe)
local themesContainer = script:FindFirstAncestor("HD Admin").Config.Themes
local booleanVerifier = Verifiers.boolean()


-- TYPES
type InputType = InputObjects.InputType
type InputConfig = InputObjects.InputConfig


-- CONFIG
local DATA_KEY = "GameSettings"
local PLAYER_SETTINGS = "PlayerSettings"
local SYSTEM_SETTINGS = "SystemSettings"
local SOUND_INPUT: InputConfig = {
	inputType = "NumberInput",
	default = 1,
	min = 0,
	max = 2,
	step = 0.1,
}
local SOUND_VERIFIER = function(inputObject: any, value: unknown)
	if typeof(value) ~= "number" or not isNumberSafe(value) then
		return true, inputObject.default
	end
	return true, math.clamp(value, inputObject.min, inputObject.max)
end


-- LOCAL FUNCTIONS
-- The theme selector hides when only one theme is available, same as SettingsYou
local function countEnabledThemes(): number
	local count = 0
	for _, child in themesContainer:GetChildren() do
		if child:IsA("ModuleScript") then
			local ok, themeData = pcall(require, child)
			if ok and typeof(themeData) == "table" then
				local settings = (themeData :: any).Settings
				local enabled = if settings and settings.ShowInYouSettings ~= nil then settings.ShowInYouSettings else true
				if enabled then
					count += 1
				end
			end
		end
	end
	return count
end


-- SETTINGS
return
{
	--------------------------------------
	{
		heading = "Display",
		objects = { -- no onChanged / updateThemeValues / lockSetting here: these are the GAME defaults, and touching local Theme would flip every admin's view
			{
				title = "CanChangeYouSettingsTheme",
				label = "Edit Theme",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "CanChangeYouSettingsTheme"},
				description = "Can users change Theme in their YouSettings?",
				lockedDisplayValue = "none", -- under USD show the real template value; the default Toggle->true display would mislead the admin
				verifier = booleanVerifier,
			},
			{
				title = "CanChangeYouSettingsPrimaryColor",
				label = "Edit Primary Color",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "CanChangeYouSettingsPrimaryColor"},
				description = "Can users change Primary Color in their YouSettings?",
				lockedDisplayValue = "none",
				verifier = booleanVerifier,
			},
			{
				title = "CanChangeYouSettingsFont",
				label = "Edit Font",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "CanChangeYouSettingsFont"},
				description = "Can users change Font in their YouSettings?",
				lockedDisplayValue = "none",
				verifier = booleanVerifier,
			},
			{
				title = "CanChangeYouSettingsContentScale",
				label = "Edit Content Scale",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "CanChangeYouSettingsContentScale"},
				description = "Can users change Content Scale in their YouSettings?",
				lockedDisplayValue = "none",
				verifier = booleanVerifier,
			},
			{
				title = "CanChangeYouSettingsMenuHeight",
				label = "Edit Menu Height",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "CanChangeYouSettingsMenuHeight"},
				description = "Can users change Menu Height in their YouSettings?",
				lockedDisplayValue = "none",
				verifier = booleanVerifier,
			},
			{
				title = "Theme",
				inputType = "ItemSelector" :: InputType,
				hidden = countEnabledThemes() <= 1,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Display", "Theme"},
				inputObject = {
					limitPickerToOneItem = true,
					pickerGetter = function()
						local BaseTheme = require(UI.Util.Theme.BaseTheme)
						local items = {}
						for _, child in themesContainer:GetChildren() do
							if child:IsA("ModuleScript") then
								local themeData = require(child) :: any
								local themeEnabled = if themeData.Settings and themeData.Settings.ShowInYouSettings ~= nil
									then themeData.Settings.ShowInYouSettings
									else true
								if not themeEnabled then
									continue
								end
								local fontFamily = if themeData.Font and themeData.Font.Body
									then themeData.Font.Body
									else BaseTheme.Font.Body
								local layoutOrder = if themeData.Settings and themeData.Settings.LayoutOrder then themeData.Settings.LayoutOrder else 999
								table.insert(items, {
									key = child.Name,
									label = child.Name,
									header = child.Name,
									rawValue = child.Name,
									category = "qualifier",
									fontFamily = fontFamily,
									displayOrder = layoutOrder,
								})
							end
						end
						table.sort(items, function(itemA: any, itemB: any)
							return itemA.displayOrder < itemB.displayOrder
						end)
						return items
					end,
				},
				verifier = function(inputObject: any, value: unknown): (boolean, string?)
					local themeName = value
					if typeof(themeName) == "table" and #(themeName :: {any}) == 1 then
						themeName = (themeName :: {any})[1]
					end
					if typeof(themeName) == "string" then
						local themeModule = themesContainer:FindFirstChild(themeName :: string)
						if themeModule and themeModule:IsA("ModuleScript") then
							return true, themeName :: string
						end
					end
					return false, "Invalid theme"
				end,
			},
			{
				title = "Primary Color",
				inputType = "ColorPicker" :: InputType,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Display", "PrimaryColor"},
				verifier = function(inputObject: any, value: unknown): (boolean, Color3? | string)
					if typeof(value) == "Color3" then
						return true, value
					end
					return false, "Invalid color value"
				end,
			},
			{
				title = "Font",
				inputType = "ItemSelector" :: InputType,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Display", "Font"},
				inputObject = {
					limitPickerToOneItem = true,
					pickerGetter = function()
						local items = {}
						for _, font in Fonts do
							table.insert(items, {
								key = font.family,
								label = font.name,
								header = font.name,
								rawValue = font.family,
								category = "qualifier",
								fontFamily = font.family,
							})
						end
						return items
					end,
				},
				verifier = function(inputObject: any, value: unknown): (boolean, string?)
					local fontFamily = value
					if typeof(fontFamily) == "table" and #(fontFamily :: {any}) == 1 then
						fontFamily = (fontFamily :: {any})[1]
					end
					if typeof(fontFamily) == "string" and (fontFamily :: string):find("^rbxasset://fonts/families/") then
						return true, fontFamily :: string
					end
					return false, "Invalid font value"
				end,
			},
			{
				title = "Content Scale",
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Display", "ContentScale"},
				inputType = "NumberInput" :: InputType,
				inputObject = {
					default = 1,
					min = 0.5,
					max = 1.5,
					step = 0.1,
				},
				verifier = function(inputObject: any, value: unknown): (boolean, number? | string)
					if typeof(value) ~= "number" or not isNumberSafe(value) then
						return false, "Invalid number value"
					end
					return true, math.clamp(value, inputObject.min, inputObject.max)
				end,
			},
			{
				title = "Menu Height",
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Display", "MenuHeight"},
				inputType = "NumberInput" :: InputType,
				inputObject = {
					default = 10,
					min = 5,
					max = 15,
					step = 1,
				},
				verifier = function(inputObject: any, value: unknown): (boolean, number? | string)
					if typeof(value) ~= "number" or not isNumberSafe(value) then
						return false, "Invalid number value"
					end
					return true, math.clamp(math.round(value), inputObject.min, inputObject.max)
				end,
			},
		},
	},


	--------------------------------------
	{
		heading = "Command",
		objects = {
			{
				title = "AutoApproveNewCommands",
				label = "Auto Approve New",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "AutoApproveNewCommands"},
				description = "New commands from HD Admin updates go live immediately. When off they need vetting first (the engine itself always stays up to date)",
				verifier = booleanVerifier,
			},
			{
				title = "CanChangeYouSettingsPrefix",
				label = "Edit Prefix",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "CanChangeYouSettingsPrefix"},
				description = "Can users change Prefix in their YouSettings?",
				lockedDisplayValue = "none",
				verifier = booleanVerifier,
			},
			{
				title = "Prefix",
				inputType = "TextInput" :: InputType,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Prefix"},
				inputObject = {
					limitTextLength = 1,
					clearTextOnFocus = true,
				},
				verifier = function(inputObject: any, value: unknown): (boolean, string?)
					local isValidPrefix = require(modules.CommandUtil.isValidPrefix)
					if typeof(value) == "string" and isValidPrefix(value) then
						return true, value
					end
					return false, "Invalid prefix. Must be a special character such as ;, :, >, !, @, #, etc"
				end,
			},
		},
	},


	--------------------------------------
	{
		heading = "Sound",
		objects = {
			{
				title = "CanChangeYouSettingsVolume",
				label = "Edit Volume",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "CanChangeYouSettingsVolume"},
				description = "Can users change the Volume sliders in their YouSettings?",
				lockedDisplayValue = "none",
				verifier = booleanVerifier,
			},
			{
				title = "CanChangeYouSettingsPitch",
				label = "Edit Pitch",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "CanChangeYouSettingsPitch"},
				description = "Can users change the Pitch sliders in their YouSettings?",
				lockedDisplayValue = "none",
				verifier = booleanVerifier,
			},
			{
				title = "SFX Volume",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Sound", "Volume", "Interface"},
				verifier = SOUND_VERIFIER,
			},
			{
				title = "SFX Pitch",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Sound", "Pitch", "Interface"},
				verifier = SOUND_VERIFIER,
			},

			{
				title = "Music Volume",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Sound", "Volume", "Music"},
				verifier = SOUND_VERIFIER,
			},
			{
				title = "Music Pitch",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Sound", "Pitch", "Music"},
				verifier = SOUND_VERIFIER,
			},

			{
				title = "Cmd Volume",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Sound", "Volume", "Command"},
				verifier = SOUND_VERIFIER,
			},
			{
				title = "Cmd Pitch",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, PLAYER_SETTINGS, "Sound", "Pitch", "Command"},
				verifier = SOUND_VERIFIER,
			},
		},
	},


	--------------------------------------
	{
		heading = "Joining",
		objects = {
			{
				title = "EnableMinimumAccountAge",
				label = "Enable Minimum Age",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "EnableMinimumAccountAge"},
				description = "Kicks players with an account age below Minimum Age",
				verifier = booleanVerifier,
			},
			{
				title = "MinimumAccountAge",
				label = "Minimum Age",
				inputType = "NumberInput" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "MinimumAccountAge"},
				description = "The minimum account age in days",
				inputObject = {
					default = 0,
					min = 0,
					max = 365,
					step = 1,
					useSlider = false,
				},
				verifier = function(inputObject: any, value: unknown): (boolean, number? | string)
					if typeof(value) ~= "number" or not isNumberSafe(value) then
						return false, "Invalid number value"
					end
					return true, math.clamp(math.round(value), inputObject.min, inputObject.max)
				end,
			},
		},
	},


	--------------------------------------
	{
		heading = "Use Studio Defaults", -- backs the USD banner toggles (RolesPage / SettingsPage Game tab); both call ChangeGameSetting so the rows must exist for the server's findRowByPath / verifier, and hiddenByTitle keeps them off the Game-tab list
		objects = {
			{
				title = "UseDefaultRoles",
				label = "Use Default Roles",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "UseDefaultRoles"},
				verifier = booleanVerifier,
			},
			{
				title = "UseDefaultGameSettings",
				label = "Use Default Game Settings",
				inputType = "Toggle" :: InputType,
				settingPath = {DATA_KEY, SYSTEM_SETTINGS, "UseDefaultGameSettings"},
				verifier = booleanVerifier,
			},
		},
	},


	--------------------------------------
}