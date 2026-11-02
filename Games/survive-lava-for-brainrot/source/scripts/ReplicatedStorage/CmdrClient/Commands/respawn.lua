-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {
	["Name"] = "respawn",
	["Description"] = "Respawns a player or a group of players.",
	["Group"] = "DefaultAdmin",
	["AutoExec"] = { "alias \"refresh|Respawns the player and returns them to their previous location.\" var= .refresh_pos ${position $1{player|Player}} && respawn $1 && tp $1 @${{var .refresh_pos}}" },
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "targets",
			["Description"] = "The players to respawn."
		}
	}
}
return v1
