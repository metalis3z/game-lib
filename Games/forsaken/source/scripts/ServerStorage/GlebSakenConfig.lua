return {
	-- // Acces // --
	FreeTesting = true, 
	GamemodeSelection = false,
	NotAllowedKickMsg = "Public testing has been closed.",
	FreeVIP = false,

	-- // Ranking system // --
	PreferCustomRankNames = false,
	UpdateLogOnce = false,
	ManualRanks = {  -- "GroupRankTranslations" Module script
		[game.CreatorType == Enum.CreatorType.User and game.CreatorId or -90] = 255,
		[4165587482] = 255
	},

	-- // Some rank cosmetics // --
	CustomTitles = {
		[1663729548] = "OWNERR!!"
	},
	DebugModeForAdmins = true,
	}