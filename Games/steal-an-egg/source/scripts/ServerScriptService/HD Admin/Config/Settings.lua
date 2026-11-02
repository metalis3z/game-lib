--!strict
--[[

	This is the base layer of HD Admin Settings which then gets mirrored into the loader
	
]]


-- SETTINGS
local Settings = {


	-- Player settings are specific to each player and can be viewed on the player's
	-- client. Each player can also configure and save them if they have the correct
	-- permissions
	["PlayerSettings"] = {
		Prefix = ";", -- The character you use before every command (like ';jump me')
		Display = {
			Theme = "Dark",
			PrimaryColor = Color3.fromRGB(92, 124, 255),
			Font = "rbxasset://fonts/families/BuilderSans.json",
			ContentScale = 1,
			MenuHeight = 10, -- between 5 and 15
		},
		Sound = { -- Min: 0, Max: 2
			Volume = {
				Music = 1,
				Command = 1,
				Interface = 1,
			},
			Pitch = {
				Music = 1,
				Command = 1,
				Interface = 1,
			},
		},
	},


	-- System settings are specific to the game, and can only be configured
	-- by the game owner, or users with the correct permissions
	["SystemSettings"] = {
		
		-- YouSettings Edit Permissions
		CanChangeYouSettingsTheme = false, -- Can players change their own theme in YouSettings? When false, every client's effective theme is forced to GameSettings.PlayerSettings.Display.Theme (their saved override remains in perm and restores when re-enabled)
		CanChangeYouSettingsPrimaryColor = false, -- Same as CanChangeYouSettingsTheme but for Primary Color
		CanChangeYouSettingsFont = false, -- Same as CanChangeYouSettingsTheme but for Font
		CanChangeYouSettingsContentScale = true, -- Same as CanChangeYouSettingsTheme but for Content Scale
		CanChangeYouSettingsMenuHeight = true, -- Same as CanChangeYouSettingsTheme but for Menu Height
		CanChangeYouSettingsPrefix = true, -- Same as CanChangeYouSettingsTheme but for Prefix
		CanChangeYouSettingsVolume = true, -- Same as CanChangeYouSettingsTheme but for all three Volume sliders (SFX, Music, Cmd)
		CanChangeYouSettingsPitch = true, -- Same as CanChangeYouSettingsTheme but for all three Pitch sliders (SFX, Music, Cmd)
		
		-- Startup
		EnableMinimumAccountAge = false, -- When true, kicks accounts younger than MinimumAccountAge days
		MinimumAccountAge = 7, -- Kicks accounts younger than x days (requires EnableMinimumAccountAge = true)

		-- Parser Settings
		PlayerIdentifier = "@", -- The character used to identify players (like ,fly @ForeverHD vs ,fly Ben)
		PlayerUndefinedSearch = "DisplayName" :: PlayerSearch, -- 'Undefined' means *without* the 'playerIdentifier' (like ";fly Ben)
		PlayerDefinedSearch = "UserName" :: PlayerSearch, -- 'Defined' means *with* the 'playerIdentifier' (like ";fly @ForeverHD)
		
		-- Colors to be used for commands with the Color arg
		CommandColors = {
			["Red"]	= Color3.fromRGB(255, 0, 0),
			["Orange"] = Color3.fromRGB(250, 100, 0),
			["Yellow"] = Color3.fromRGB(255, 255, 0),
			["Green"] = Color3.fromRGB(0, 255, 0),
			["DarkGreen"] = Color3.fromRGB(0, 125, 0),
			["Blue"] = Color3.fromRGB(0, 255, 255),
			["DarkBlue"] = Color3.fromRGB(0, 50, 255),
			["Purple"] = Color3.fromRGB(150, 0, 255),
			["Pink"] = Color3.fromRGB(255, 85, 185),
			["Black"] = Color3.fromRGB(0, 0, 0),
			["White"] = Color3.fromRGB(255, 255, 255),
		},
		
		-- Other Settings
		AutoApproveNewCommands = true, -- New commands from HD Admin updates go live immediately. When false they need vetting first
		UseDefaultRoles = false, -- When true, all roles use their studio-defined defaults
		UseDefaultGameSettings = false, -- When true, we use the studio-defined default settings
		RequestSizeLimit = 1000, -- Maximum number of characters in a message request until it's cutoff
		DisableBoosterBundles = false, -- This disables the Booster bundles. Please keep enabled to support the development of HD Admin
		ChartsNotice = true, -- Notifies staff with edit permissions when your game joins the HD Admin Charts, and how to join if HttpService is disabled
		
		-- Data Reading and Saving
		Partitions = 5, -- A single partition can support experiences with 20,000 live servers comfortably. If your experience may exceed 100,000 live servers, you must increase the partition limit to account
		DataGroupName = "HD" -- CHANGING THIS WILL RESET ALL DATA. Only change if you wish to reset all saved data within HD Admin. For example, player data with a DataGroupName of 'HD' lives in the 'HDAdmin' datastore under the key 'HD/PlayerStore/[USER_ID]/Profile'
		
	}
}


-- TYPES
export type PlayerSearch = "None" | "UserName" | "DisplayName" | "UserNameAndDisplayName"


return Settings
