return {

	-- About
	rank = 6,
	
	-- Display
	color = Color3.fromRGB(255, 215, 0),

	-- Give To
	giveToUsers = {
		{type = "Preset", preset = "Creator"},
	},

	-- Commands
	inheritCommandsWithTags = {"Owner"},
	inheritCommandsFromJuniorRoles = true,

	-- Command Permissions
	permitAll = true,

	-- View Permissions
	mayViewAll = true,

	-- Edit Permissions
	mayEditAll = true,

	-- Role Permissions
	mayPreviewRoles = true,

	-- Prompt
	promptAll = true,

}
