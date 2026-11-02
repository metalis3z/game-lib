--!strict

export type UpdateEntry = {
	Title: string,
	Banner: string?,
	Date: string,
	Image: string?,
	Body: string,
	AuthorName: string?,
	AuthorUserId: number?,
}

local UpdateLog: {UpdateEntry} = {
	{
		Title = "So it's finally happening...",
		Banner = "v2 is here! See whats new",
		Date = "22 August 2026",
		Image = "rbxassetid://81295885304989",
		AuthorName = "Ben (@ForeverHD)",
		AuthorUserId = 82347291,
		Body = table.concat({
			"v2 Beta is here! 🥳",
			"",
			"<b>What's new in v2</b>",
			"- <b>A ground-up redesign</b> with 20+ themes, reactive panel and a much smoother mobile experience",
			"- <b>Live editing</b>. Configure everything in-game with changes syncing to every server within seconds",
			"- <b>A new roles system</b> with a live editor, drag-to-reorder and per-role permissions",
			"- <b>UI-driven commands</b>. Customise and run all 200+ commands from the panel, no chat needed",
			"- <b>New command bar</b> with live suggestions, autocompletes and run history, press ' or ; to open",
			"- <b>Modifiers</b> to supercharge commands, like ;globalMessage to broadcast to every server",
			"- <b>A tasks page</b> to view, edit and end every command running in your experience",
			"- <b>A new moderation page</b> to ban players globally, even when they're offline",
			"",
			"<b>As a heads up</b>",
			"- <b>This is a Beta release</b>. We've been privately testing for months, but bugs may still pop up",
			"- <b>Fixes, improvements and new features</b> are happening weekly behind the scenes",
			"- <b>Please report bugs and suggestions</b> on our communication server",
			"",
			"This has been over 5 years in the making. v2 is something I started after RDC 2019, worked fulltime on-and-off for many years, so we're over the moon to finally have this ready.",
			"",
			"A mega thanks to <b>@ImAvafe</b>. Their frontend design expertise has really made this what we always dreamed of creating.",
			"",
			"Thanks for all your support ❤️",
			"",
			"~Ben",
		}, "\n"),
	},
}


return UpdateLog