-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: DataTemplate, time of decompilation: Sun May  3 10:12:40 2026 ]]
return {
	sessionStart = 0,
	lastLogoutTime = 0,
	coins = 0,
	goop = 0,
	rollCurrency = 0,
	rebirths = 0,
	friendsInServer = 0,
	likeGroupPromptSeen = false,
	likeGroupLuckActive = false,
	maxZone = 1,
	furthestZone = 1,
	zone = 1,
	offlineEarnings = nil,
	craftingMutationRevertV1 = false,
	armedJackpotSpins = 0,
	equipped = {},
	inventory = {},
	upgrades = {},
	craftingRecipes = {},
	activeAutoCrafts = {},
	unlocks = {
		craftingMachine = false,
		xpTransferMachine = false
	},
	tutorial = {
		step = "init",
		completed = false
	},
	boosts = {
		luck = {
			amount = 0,
			timeRemaining = 0,
			expirationTime = 0
		},
		ultraLuck = {
			amount = 0,
			timeRemaining = 0,
			expirationTime = 0
		},
		currency = {
			amount = 0,
			timeRemaining = 0,
			expirationTime = 0
		},
		rollSpeed = {
			amount = 0,
			timeRemaining = 0,
			expirationTime = 0
		}
	},
	items = {},
	armedSpecialDice = {},
	pendingEnemyMutationUnlockRewards = {},
	index = {
		migratedV1 = false,
		categories = {
			basic = {
				counts = {},
				unlocked = {},
				claimedRewards = {}
			},
			big = {
				counts = {},
				unlocked = {},
				claimedRewards = {}
			},
			huge = {
				counts = {},
				unlocked = {},
				claimedRewards = {}
			},
			shiny = {
				counts = {},
				unlocked = {},
				claimedRewards = {}
			},
			inverted = {
				counts = {},
				unlocked = {},
				claimedRewards = {}
			}
		}
	},
	stats = {
		timePlayed = 0,
		kills = 0,
		rolls = 0,
		totalCoins = 0,
		rarestRoll = {
			odds = 1,
			slimeData = {
				id = ""
			}
		},
		dailyRarestRoll = {
			day = 0,
			value = 1
		}
	},
	settings = {
		music = true,
		hitSounds = true,
		rollSounds = true,
		uiSounds = true,
		coinGoopCollectionSounds = true,
		cloverEmitterVfx = true,
		showHealthbars = true,
		showNotificationDots = true,
		rareRollCutscenes = "low",
		playerWalkSpeed = 22,
		enemyLimit = 999999,
		hitSplatVfx = true,
		coinGoopCollectionVfx = true,
		slimeEnemyAnimations = true,
		otherPlayerSlimes = true,
		otherPlayerRareRollVisuals = true,
		autoRoll = false,
		hideRoll = false,
		luckOverrideEnabled = false,
		luckOverrideValue = 1
	},
	specialRollProgression = {
		golden = {
			rollsUntilNext = 10,
			paused = false
		},
		diamond = {
			rollsUntilNext = 100,
			paused = false
		},
		void = {
			rollsUntilNext = 1000,
			paused = false
		}
	}
}
