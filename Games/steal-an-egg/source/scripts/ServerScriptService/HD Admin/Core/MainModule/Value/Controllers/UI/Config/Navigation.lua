--!strict

export type NavEntry = {
	id: string,
	children: { NavEntry }?,
}

local Navigation: NavEntry = {
	id = "Menu",
	children = {
		{ id = "Commands" },
		{ id = "Analytics" },
		{ id = "Roles" },
		{ id = "Moderation" },
		{ id = "Tasks" },
		{ id = "Logs" },
		{ id = "Settings" },
		{ id = "About" },
	},
}

return Navigation
