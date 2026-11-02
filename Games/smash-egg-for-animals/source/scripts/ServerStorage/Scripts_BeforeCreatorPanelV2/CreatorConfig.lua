-- Content Creator Panel : shared settings (read by CreatorPanelServer, CreatorPanelClient and CreatorEffectsClient).
-- Cooldowns and durations of the six troll commands are set HERE only. The server enforces them; the panel only displays them.
local CreatorConfig = {}

-- who can open the panel: players whose tag in ServerScriptService.TagConfig_Old contains this word ("CONTENT CREATOR", "Creator")
CreatorConfig.TagKeyword = "CREATOR"

-- the six troll commands, in panel order. Cooldown = seconds per creator and per command. Duration = seconds of the effect.
CreatorConfig.Commands = {
	{Id = "Ragdoll", Name = "RAGDOLL", Icon = "🫠", Cooldown = 30, Duration = 5,
		Description = "Knocks the player down into a floppy ragdoll for 5 seconds.", Colors = {Color3.fromRGB(170, 120, 255), Color3.fromRGB(90, 50, 210)}},
	{Id = "Rocket", Name = "ROCKET", Icon = "🚀", Cooldown = 180, Duration = 5,
		Description = "Blasts the player into the sky, then a huge explosion and a 5 s ragdoll. Harmless!", Colors = {Color3.fromRGB(255, 160, 90), Color3.fromRGB(220, 60, 90)}},
	{Id = "Freeze", Name = "FREEZE", Icon = "🧊", Cooldown = 60, Duration = 6,
		Description = "Traps the player in a block of ice for 6 seconds.", Colors = {Color3.fromRGB(140, 230, 255), Color3.fromRGB(40, 130, 230)}},
	{Id = "Disco", Name = "DISCO FEVER", Icon = "🪩", Cooldown = 45, Duration = 8,
		Description = "Turns the player into a glowing rainbow disco star for 8 seconds.", Colors = {Color3.fromRGB(255, 130, 230), Color3.fromRGB(120, 90, 255)}},
	{Id = "Jumpscare", Name = "JUMPSCARE", Icon = "🎃", Cooldown = 90, Duration = 2,
		Description = "The Pumpking jumps at the player's screen. Only they see it!", Colors = {Color3.fromRGB(255, 190, 80), Color3.fromRGB(210, 80, 30)}},
	{Id = "Jail", Name = "JAIL", Icon = "⛓️", Cooldown = 60, Duration = 5,
		Description = "Locks the player in a glowing cage sized to their avatar for 5 seconds.", Colors = {Color3.fromRGB(120, 255, 220), Color3.fromRGB(30, 150, 170)}},
}
CreatorConfig.ById = {}
for _, c in CreatorConfig.Commands do CreatorConfig.ById[c.Id] = c end

CreatorConfig.Rocket = {MaxHeight = 70, MinHeight = 14, LaunchTime = 1.3}
CreatorConfig.TeleportCooldown = 1.5 -- seconds between two teleports (anti-spam)

return CreatorConfig
