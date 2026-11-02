return {

	-- About
	rank = 4,
	
	-- Display
	color = Color3.fromRGB(239, 68, 68),

	-- Commands
	inheritCommandsWithTags = {"Admin"},
	inheritCommandsFromJuniorRoles = true,

	-- Command Permissions
	permitModifiersAbusive = true,

	-- View Permissions
	mayViewUnavailableCommands = true,
	mayViewPages = {"Commands", "CommandBar", "Bans", "Warns", "Roles", "RoleSettings", "MembersServer", "MembersPermanent", "Tasks", "Logs", "YouSettings", "GameSettings"},

	-- Edit Permissions
	mayEditTasks = true,
	mayEditSettingsYou = true,

	-- Prompt
	promptAll = true,

}
