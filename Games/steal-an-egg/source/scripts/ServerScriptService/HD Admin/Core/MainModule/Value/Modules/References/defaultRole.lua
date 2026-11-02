return {
	
	key = "unnamedrole",
	name = "UnnamedRole",
	color = Color3.fromRGB(255, 255, 255),
	hide = false,
	internal = false,
	useDefaults = false,
	rank = 1, -- only used to generate the default order of roles, not so much after this, as orders are actually determined by a separate array

	giveToEveryone = false,
	giveToPrivateServerOwner = false,
	giveToUsers = {}, -- {type = "UserId", userId = number} or {type = "Preset", preset = string}
	giveToGroups = {}, -- {type = "AnyMember", groupId = number} or {type = "SpecificRoles", groupId = number, roles = {{rank = number, name = string}}}
	giveToProducts = {}, -- {type = "Asset"|"GamePass"|"Bundle"|"Subscription", id = number} or {type = "Preset", preset = string}

	limitCommandsPerMinute = 60, -- Maximum number of commands a player can run per minute
	limitRequestsPerSecond = 10, -- Maximum message requests that can be parsed per second per second. When disabled, this is still capped to 20

	mayEditAll = false, -- DANGEROUS umbrella: edit anything on any role including seniors
	mayEditRoles = false, -- create, edit, delete, reorder roles ranked below this one, but can only grant perms this role already holds
	mayEditSettingsGame = false, -- edit universe-wide game settings (prefix, interface presets, command colours, etc)
	mayEditSettingsYou = false, -- edit own personal settings
	mayEditTasks = false, -- pause / resume / cancel any task within Tasks
	mayVetCommands = false, -- approve, disable and test new commands that arrive from HD Admin updates

	mayPreviewRoles = false, -- DANGEROUS: lets users temporarily "act as" another role (at or below their own rank) to test what that role experiences

	mayViewAll = false,
	mayViewIcon = "Menu", -- which topbarplus icon to display: "Menu", "Commands", or "None"
	mayViewPages = {"Commands", "YouSettings"}, -- array of page keys this role can view
	mayViewUnavailableCommands = false,

	permitAll = false,
	permitBypassLimits = false, -- users can bypass limits across all commands and arguments
	permitModifiersAbusive = false, --users can use potentially abusive modifiers like 'loop' and 'delay'
	permitModifiersGlobal = false, -- users can can broadcast any useable command to all servers with modifiers like 'global' and 'perm'. Be VERY careful about who you permit this to!
	permitMultipleTargets = false, --users can target multiple people at once with commands (like ;kill others)
	permitTargetingOthers = false, -- users can run commands on players other than themselves
	inheritCommandsFromJuniorRoles = false, -- users additionally inherit the command tags of all roles ranked below this role

	inheritCommandsWithTags = {},
	inheritCommandsWithNames = {},

	promptAll = false, -- Displays all prompts
	promptWarnings = false, -- Displays warning notices (such as 'Invalid prefix! Try using [correctPrefix] instead!', '[CommandName] is not a valid command!', 'You do not have permission to use this command', etc)
	promptWelcome = false, -- Displays welcome notices (such as 'You're a [highestRoleName]', etc)
}