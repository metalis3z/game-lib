-- Reference copy for study. Game: Aura Ascension (UPD 3) (aura-ascension)
-- Original: ServerScriptService/GameServer/Data/ProfileTemplate.lua  (65 lines)
-- What it does: Data template grouped by purpose (Stats, Progression, Inventory, Monetization, Cooldowns, Admin audit trail) with a _Meta block holding version and session lease.

return {
	_Meta = {
		Version = 3,
		FirstJoinAt = 0,
		LastJoinAt = 0,
		LastSaveAt = 0,
		Session = {
			JobId = "",
			ExpiresAt = 0,
		},
	},
	Stats = {
		Aura = 0,
		Rebirths = 0,
		PeakAura = 0,
		TimePlayed = 0,
		TotalAuraEarned = 0,
		TotalChestClaims = 0,
		KOTHWins = 0,
		KOTHSeconds = 0,
	},
	Progression = {
		UnlockedAreas = {},
		CurrentArea = "",
		Tutorial = {
			GotRebirth = false,
			ClaimedFirstChest = false,
			Zones = {
				FireBath = false,
				LavaHeaven = false,
				DarkLava = false,
				StoneHeads = false,
				AncientRuins = false,
				ElectraField = false,
				DivineRealm = false,
				FrostcoreShards = false,
				FrozenArtifact = false,
				FallenStar = false,
			},
		},
	},
	Inventory = {
		OwnedPoses = {},
		EquippedPose = "",
		OwnedPacks = {},
		OwnedPackTitles = {},
		EquippedPackTitle = "",
		EquippedRankIndex = 0,
	},
	Monetization = {
		AuraBoost = 1,
		RebirthPackBuys = {},
	},
	Cooldowns = {
		ChestClaimAt = 0,
		FirstFreeRebirthPackReadyAtPlaytime = 45 * 60,
	},
	Matchmaking = {
		QueueId = "",
		JoinedAt = 0,
	},
	Admin = {
		AuditTrail = {},
	},
}
