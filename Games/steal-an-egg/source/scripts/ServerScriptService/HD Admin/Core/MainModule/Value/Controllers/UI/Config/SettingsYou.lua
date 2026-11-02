--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local isNumberSafe = require(modules.VerifyUtil.isNumberSafe)
local UI = modules.Parent.Controllers.UI
local Workspace = game:GetService("Workspace")
local Fonts = require(script.Parent.Fonts)
local InputObjects = require(UI.Config.InputObjects)
local themesContainer = script:FindFirstAncestor("HD Admin").Config.Themes


-- TYPES
type InputType = InputObjects.InputType
type InputConfig = InputObjects.InputConfig


-- CONFIG
local DATA_KEY = "YouSettings"
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
-- The theme selector hides when only one theme is available
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
		objects = {
			{
				title = "Theme",
				inputType = "ItemSelector" :: InputType,
				hidden = countEnabledThemes() <= 1,
				settingPath = {DATA_KEY, "Display", "Theme"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Display", "Theme"}, -- perm.YouSettings is partial; seeds from the game default (ItemSelector auto-wraps strings)
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
				settingPath = {DATA_KEY, "Display", "PrimaryColor"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Display", "PrimaryColor"},
				updateThemeValues = {{"Color", "Primary"}},
				lockSetting = {"Settings", "LockPrimaryColor"},
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
				settingPath = {DATA_KEY, "Display", "Font"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Display", "Font"},
				updateThemeValues = {{"Font", "Heading"}, {"Font", "Body"}},
				lockSetting = {"Settings", "LockFont"},
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
				updateThemeValues = {{"Layout", "ContentScale"}},
				lockSetting = {"Settings", "LockContentScale"},
				settingPath = {DATA_KEY, "Display", "ContentScale"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Display", "ContentScale"},
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
				settingPath = {DATA_KEY, "Display", "MenuHeight"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Display", "MenuHeight"},
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
				title = "Prefix",
				inputType = "TextInput" :: InputType,
				settingPath = {DATA_KEY, "Prefix"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Prefix"},
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
				title = "SFX Volume",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, "Sound", "Volume", "Interface"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Sound", "Volume", "Interface"},
				verifier = SOUND_VERIFIER,
			},
			{
				title = "SFX Pitch",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, "Sound", "Pitch", "Interface"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Sound", "Pitch", "Interface"},
				verifier = SOUND_VERIFIER,
			},

			{
				title = "Music Volume",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, "Sound", "Volume", "Music"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Sound", "Volume", "Music"},
				verifier = SOUND_VERIFIER,
			},
			{
				title = "Music Pitch",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, "Sound", "Pitch", "Music"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Sound", "Pitch", "Music"},
				verifier = SOUND_VERIFIER,
			},

			{
				title = "Cmd Volume",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, "Sound", "Volume", "Command"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Sound", "Volume", "Command"},
				verifier = SOUND_VERIFIER,
			},
			{
				title = "Cmd Pitch",
				inputType = "NumberInput" :: InputType,
				inputObject = SOUND_INPUT,
				settingPath = {DATA_KEY, "Sound", "Pitch", "Command"},
				defaultFromEveryone = {"GameSettings", "PlayerSettings", "Sound", "Pitch", "Command"},
				verifier = SOUND_VERIFIER,
			},
		},
	},


	--------------------------------------
}