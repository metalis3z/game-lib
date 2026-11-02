local RunService = game:GetService("RunService")

return {
	DataStoreName = "AuraSimulatorProfilesV1",
	AutoSaveInterval = 60,
	SessionLeaseSeconds = 180,
	TimePlayedStepSeconds = 5,
	TrainingTickSeconds = 0.8,
	LegacyCompatibility = {
		Enabled = true,
		CharacterFolderName = "Characters",
	},
	AFK = {
		ReturnTeleportEnabled = true,
	},
	Chest = {
		CooldownSeconds = 300,
		BaseAuraReward = 5000,
		BonusGroupMultiplier = 2,
		BonusRebirthReward = 1,
	},
	Rebirth = {
		ChunkSize = 1000,
		MaxChunksPerRequest = 0,
		-- Reconstructed from live-game behavior: 118 Qa rebirths at the Superior rank
		-- should land around 664T aura per 0.5s tick before other situational boosts.
		MultiplierScale = 1.8042,
		MultiplierExponent = 1 / 3,
	},
	KOTH = {
		AuraPerSecond = 3500,
		-- The original multiplier value is not recoverable from the decompiled server.
		-- Keeping it explicit here makes the passive gain behavior easy to tune.
		AuraMultiplier = 2,
		WinThresholdSeconds = 60,
	},
	CursedZone = {
		InactiveDurationSeconds = 900,
		ActiveDurationSeconds = 300,
		ValidMultipliers = { 2, 3, 4, 5 },
		ZoneName = "Cursed Zone",
		AssetFolderName = "MultiZones",
		AssetName = "Cursed Zone",
		SpawnNodeFolderName = "SpawnNodes",
		RequiresActiveForTraining = false,
		ShakeDurationSeconds = 3,
		HiddenPosition = Vector3.new(0, -2000, 0),
		RuntimeFolderName = "MultiZonesRuntime",
	},
	Matchmaking = {
		TeleportCooldownSeconds = 10,
		Queues = {
			Duel = {
				MinPlayers = 2,
				MaxPlayers = 8,
				TargetPlaceId = 0,
			},
			Raid = {
				MinPlayers = 4,
				MaxPlayers = 12,
				TargetPlaceId = 0,
			},
		},
	},
	RateLimits = {
		Default = 0.25,
		RequestRebirth = 1,
		ChestClaim = 1,
		PosePurchase = 0.75,
		PackPurchase = 0.75,
		AdminCommand = 1.5,
		QueueAction = 0.5,
	},
}
