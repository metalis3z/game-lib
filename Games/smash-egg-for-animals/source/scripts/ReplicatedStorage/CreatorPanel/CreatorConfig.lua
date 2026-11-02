-- Content Creator Panel : shared settings (read by CreatorPanelServer, CreatorPanelClient and CreatorEffectsClient).
-- Cooldowns and durations of the six troll commands are set HERE only. The server enforces them; the panel only displays them.
local CreatorConfig = {}

-- who can open the panel: players whose tag in ServerScriptService.TagConfig_Old contains this word ("CONTENT CREATOR", "Creator")
CreatorConfig.TagKeyword = "CREATOR"

-- the six troll commands, in panel order. Cooldown = seconds per creator and per command. Duration = seconds of the effect.
CreatorConfig.Commands = {
	{Id = "Ragdoll", Name = "RAGDOLL", Icon = "🫠", Cooldown = 180, Duration = 5,
		Description = "Knocks the player down into a floppy ragdoll for 5 seconds.", Colors = {Color3.fromRGB(170, 120, 255), Color3.fromRGB(90, 50, 210)}},
	{Id = "Rocket", Name = "ROCKET", Icon = "🚀", Cooldown = 180, Duration = 5,
		Description = "Blasts the player into the sky, then a huge explosion and a 5 s ragdoll. Harmless!", Colors = {Color3.fromRGB(255, 160, 90), Color3.fromRGB(220, 60, 90)}},
	{Id = "Freeze", Name = "FREEZE", Icon = "🧊", Cooldown = 180, Duration = 6,
		Description = "Traps the player in a block of ice for 6 seconds.", Colors = {Color3.fromRGB(140, 230, 255), Color3.fromRGB(40, 130, 230)}},
	{Id = "Disco", Name = "DISCO FEVER", Icon = "🪩", Cooldown = 180, Duration = 8,
		Description = "Turns the player into a glowing rainbow disco star for 8 seconds.", Colors = {Color3.fromRGB(255, 130, 230), Color3.fromRGB(120, 90, 255)}},
	{Id = "Jumpscare", Name = "JUMPSCARE", Icon = "🎃", Cooldown = 180, Duration = 2,
		Description = "The Pumpking jumps at the player's screen. Only they see it!", Colors = {Color3.fromRGB(255, 190, 80), Color3.fromRGB(210, 80, 30)}},
	{Id = "Jail", Name = "JAIL", Icon = "⛓️", Cooldown = 180, Duration = 5,
		Description = "Locks the player in a glowing cage sized to their avatar for 5 seconds.", Colors = {Color3.fromRGB(120, 255, 220), Color3.fromRGB(30, 150, 170)}},
}
CreatorConfig.ById = {}
for _, c in CreatorConfig.Commands do CreatorConfig.ById[c.Id] = c end

-- emotes du panneau : de vrais emotes du catalogue Roblox (les danses à la mode). Le serveur les donne à chaque créateur
-- (HumanoidDescription), qu'il les possède ou non. Icon = petit symbole de la carte.
CreatorConfig.Emotes = {
	{Name = "Griddy", Id = 129149402922241, Icon = "🕺"},
	{Name = "Chinese Dance", Id = 120605439830304, Icon = "🐉"},
	{Name = "Moon Walk", Id = 79127989560307, Icon = "🌙"},
	{Name = "Monkey Dance", Id = 3716636630, Icon = "🐒"},
	{Name = "Happier Jump", Id = 15610015346, Icon = "🤸"},
	{Name = "Bouncy Twirl", Id = 14353423348, Icon = "💃"},
	{Name = "Jumping Edit", Id = 113702736944973, Icon = "⚡"},
	{Name = "Summon", Id = 3307604888, Icon = "🔮"},
	{Name = "Applaud", Id = 5915779043, Icon = "👏"},
	{Name = "Hello", Id = 3576686446, Icon = "👋"},
	{Name = "Salute", Id = 3360689775, Icon = "🫡"},
	{Name = "Stadium", Id = 3360686498, Icon = "🙌"},
	{Name = "Tilt", Id = 3360692915, Icon = "🤪"},
	{Name = "Point", Id = 3576823880, Icon = "👉"},
	{Name = "Shrug", Id = 3576968026, Icon = "🤷"},
	{Name = "Agree", Id = 4849487550, Icon = "👍"},
	{Name = "Disagree", Id = 4849495710, Icon = "👎"},
}

CreatorConfig.Rocket = {MaxHeight = 70, MinHeight = 14, LaunchTime = 1.3}
CreatorConfig.TeleportCooldown = 1.5 -- seconds between two teleports (anti-spam)

return CreatorConfig
