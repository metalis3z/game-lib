-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TutorialSteps, time of decompilation: Sun May  3 10:12:00 2026 ]]
local t1 = {
	init = {
		nextStep = "firstRoll"
	},
	firstRoll = {
		nextStep = "rollCompleted"
	},
	rollCompleted = {
		nextStep = "enemySpawned"
	},
	enemySpawned = {
		nextStep = "enemyKilled"
	},
	enemyKilled = {
		nextStep = "secondRoll"
	},
	secondRoll = {
		nextStep = "secondRollCompleted"
	},
	secondRollCompleted = {
		nextStep = "thirdRoll"
	},
	thirdRoll = {
		nextStep = "thirdRollCompleted"
	},
	thirdRollCompleted = {
		nextStep = "openUpgrades"
	},
	openUpgrades = {
		nextStep = "buyBackpackUpgrade"
	},
	buyBackpackUpgrade = {
		nextStep = "closeUpgrades"
	},
	closeUpgrades = {
		nextStep = "openBackpack"
	},
	openBackpack = {
		nextStep = "equipBetterSlime"
	},
	equipBetterSlime = {
		nextStep = "closeBackpack"
	},
	closeBackpack = {
		nextStep = "earnCoins200"
	},
	earnCoins200 = {
		nextStep = "openUpgradeForAuto"
	},
	openUpgradeForAuto = {
		nextStep = "buyAutoUpgrade"
	},
	buyAutoUpgrade = {
		nextStep = "closeUpgradeForAuto"
	},
	closeUpgradeForAuto = {
		nextStep = "earnCoins400"
	},
	earnCoins400 = {
		nextStep = "unlockZone2"
	},
	unlockZone2 = {
		nextStep = "complete"
	},
	complete = {}
}
local s1 = "init"
local n1 = 1

while s1 do
	t1[s1].num = n1
	s1 = t1[s1].nextStep
	n1 += 1
end

return t1
