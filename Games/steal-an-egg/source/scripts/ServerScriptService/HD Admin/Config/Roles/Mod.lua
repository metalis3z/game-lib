return {

	-- About
	rank = 3,
	-- Display
	color = Color3.fromRGB(59, 130, 246),

	-- Give To
	giveToProducts = {},

	-- Commands
	inheritCommandsWithTags = {"Mod"},
	inheritCommandsFromJuniorRoles = true,

	-- View Permissions
	mayViewUnavailableCommands = true,
	mayViewPages = {"Commands", "CommandBar", "Bans", "Warns", "Roles", "RoleSettings", "MembersServer", "MembersPermanent", "Tasks", "Logs", "YouSettings"},

	-- Edit Permissions
	mayEditSettingsYou = true,

	-- Prompt
	promptAll = true,

}
