--!strict
local Icons = require(script.Parent.Icons)

export type Page = {
	Id: string,
	Name: string?,
	Icon: string?,
	NavigationLocked: boolean?,
	FullBleed: boolean?, -- page skips the panel inset and draws to the edges
}

return {
	Menu = {
		Id = "Menu",
	} :: Page,
	Commands = {
		Id = "Commands",
		Icon = Icons.Pages.Commands,
	} :: Page,
	CommandsFiltered = {
		Id = "Commands",
	} :: Page,
	VetCommands = {
		Id = "Vet Commands",
	} :: Page,
	Run = {
		Id = "Run",
	} :: Page,
	Moderation = {
		Id = "Moderation",
		Icon = Icons.Pages.Moderation,
	} :: Page,
	Bans = {
		Id = "Bans",
	} :: Page,
	Settings = {
		Id = "Settings",
		Icon = Icons.Pages.Settings,
	} :: Page,
	About = {
		Id = "About",
		Icon = Icons.Pages.About,
		FullBleed = true,
	} :: Page,
	Analytics = {
		Id = "Analytics",
		Icon = Icons.Pages.Analytics,
	} :: Page,
	Roles = {
		Id = "Roles",
		Icon = Icons.Pages.Roles,
	} :: Page,
	RoleSettings = {
		Id = "RoleSettings",
	} :: Page,
	RoleCreate = {
		Id = "Create Role",
	} :: Page,
	Tasks = {
		Id = "Tasks",
		Icon = Icons.Pages.Tasks,
	} :: Page,
	Profile = {
		Id = "Profile",
	} :: Page,
	Users = {
		Id = "Select Users",
	} :: Page,
	ConfigureGroupRoles = {
		Id = "Configure Roles",
	} :: Page,
	Cosmetics = {
		Id = "Cosmetics",
	} :: Page,
	Booster = {
		Id = "Unlock",
	} :: Page,
	Logs = {
		Id = "Logs",
		Icon = Icons.Pages.Logs,
	} :: Page,
}
