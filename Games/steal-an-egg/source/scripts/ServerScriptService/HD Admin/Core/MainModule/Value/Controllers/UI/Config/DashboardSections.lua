--!strict

return {
	Commands   = { "Commands" },
	Analytics  = { "Analytics" },
	Moderation = { "Bans", "Warns" },
	Roles      = { "Roles", "RoleSettings", "MembersServer", "MembersPermanent" },
	Tasks      = { "Tasks" },
	Logs       = { "Logs" },
	Settings   = { "YouSettings", "GameSettings" },
	About      = {}, -- always viewable
} :: { [string]: { string } }
