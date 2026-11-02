return {
	RefreshIntervalSeconds = 60,
	PublishIntervalSeconds = 60,
	MaxEntries = 100,
	Boards = {
		Aura = {
			Key = "Aura",
			OrderedStoreName = "GlobalAura_V1",
			BoardModelName = "AuraLB",
			SurfaceGuiName = "AuraFarmed",
			StatPath = { "Stats", "TotalAuraEarned" },
			ValueFormat = "number",
		},
		Rebirths = {
			Key = "Rebirths",
			OrderedStoreName = "GlobalRebirths_V1",
			BoardModelName = "RebirthsLB",
			SurfaceGuiName = "TopRebirthFrame",
			StatPath = { "Stats", "Rebirths" },
			ValueFormat = "number",
		},
		PlayTime = {
			Key = "PlayTime",
			OrderedStoreName = "GlobalPlayTime_V1",
			BoardModelName = "PlayTimeLB",
			SurfaceGuiName = "TopTime",
			StatPath = { "Stats", "TimePlayed" },
			ValueFormat = "duration",
		},
		KOTH = {
			Key = "KOTH",
			OrderedStoreName = "GlobalKOTHDuration_v1",
			BoardModelName = "KothLB",
			SurfaceGuiName = "KothTime",
			StatPath = { "Stats", "KOTHSeconds" },
			ValueFormat = "duration",
		},
	},
}