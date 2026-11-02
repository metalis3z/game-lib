return {
	FreeTesting = true, -- if set to false, only testers will be able to join your game
	GamemodeSelection = false, -- random selection of gamemodes
	NotAllowedKickMsg = "Not allowed.", -- kick message players get if they are below tester rank and FreeTesting is set to false
	FreeVIP = false, -- gives everyone vip priveledges without buying the gamepass\
	PreferCustomRankNames = false, -- if set to true, the game will pair your rank with a title from game.ServerScriptService.Server.Modules.RankNames, if set to false, it will use the name of your role in the group
	UpdateLogOnce = true, -- if set to true, a player will only see the latest update log once ingame.
	ManualRanks = { -- purpose of this is to ensure the file will work even if not owned by a group
		[game.CreatorType == Enum.CreatorType.User and game.CreatorId or -90] = 255,
		[9548988574] = 255,
		--[[ 
		EXAMPLE:
		[12345] = 200
		(go to game.ServerScriptService.Server.Modules.RankNames or game.ReplicatedStorage.Modules.Schematics.GroupRankTranslations to see what rank you wanna give)
		]]
	},
	CustomTitles = { -- custom chat tags
		--[[ 
		EXAMPLE:
		[12345] = "MANGOS MANGOS"
		]]
	},
}