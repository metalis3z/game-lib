-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PatchNotes, time of decompilation: Sun May  3 10:12:21 2026 ]]
return {
	["1.0.0"] = {
		title = "Release!",
		date = "April 11",
		notes = {
			"Initial release of Slime RNG!",
			"Use code: 'Release!'"
		}
	},
	["1.1.0"] = {
		title = "3 New Zones!",
		date = "April 12",
		notes = {
			"Added 3 new zones!",
			"Added an additional coin income upgrade",
			"Added this update log menu",
			"Enabled Private Servers",
			"All slimes in the index are now rollable",
			"Fixed a bug where mutated slimes don't show mutations for other players",
			"(Hopefully) fixed a bug where other players' slimes could persist without their character",
			"Fixed a bug where messages could be sent in Global chat (was never actually global)",
			"Fixed an error in offline earnings calculation if ur slime DPS was much higher than the enemy's health",
			"Fixed a bug where tons of luck could cause jackpot rolls to give incorrect slimes",
			"Fixed a bug where equip best wouldn't cause the inventory UI to update until a new slime was rolled",
			"Fixed a bug where the daily leaderboard wouldn't update",
			"Use code: 'spin2WIN'"
		}
	},
	["1.2.0"] = {
		title = "Slimes/Zones!",
		date = "April 14",
		notes = {
			"Added 4 new slimes!",
			"Added 2 new zones!",
			"Added new player upgrades subtree to the upgrade menu",
			"Added magnet upgrades that can attract nearby loot (much worse than pass)",
			"Added walkspeed upgrades",
			"Added sliders to settings for Rare Roll Cutscenes and Walkspeed",
			"Added multiple new coin income upgrades, and reduced the cost of previous income upgrades",
			"Added console support",
			"Adjusted slime stat scaling from Guest and beyond (buffs)",
			"Buffed loot drop chance 1% -> 1.5%",
			"Reduced Loot timeout delay between loot drops",
			"Use code: 'stonks'"
		}
	},
	["1.3.0"] = {
		title = "Inverted, 10 Slimes, 4 Zones!",
		date = "April 17",
		notes = {
			"Added 10 new slimes!",
			"Added 4 new zones!",
			"Added the ultra rare Inverted Mutation!",
			"Slime health is now abbreviated in the health bar",
			"Adjusted enemy health/damage scaling past zone 8 (enemies were way too weak)",
			"Goop rewards buffed past zone 7. (+1 per zone -> 1.135x per zone) This is a drastic buff for late game players, and a slight bump for mid game, early game is unchanged.",
			"Added setting to disable clover VFX",
			"Added Extra Roll upgrades to the upgrade tree",
			"Added 2 more coin income upgrades",
			"Added more luck upgrades, and updated the luck upgrade icons",
			"Reduced cost of Void Rolls to a more reasonable amount",
			"The roll reveal sequence now scales with roll speed",
			"Double rolls pass (and now extra rolls) now count as more roll currency",
			"Fixed a bug where slime KO sound would still play if hit sounds were disabled",
			"Use code: 'semils'"
		}
	},
	["1.4.0"] = {
		title = "Crafting!",
		date = "April 22",
		notes = {
			"[UPDATE 1.4.1] Nerfed mutation chances for crafting, reverted crafted slimes with multiple mutations to reroll their mutations",
			"Added the crafting system! Find recipes around the world and craft new slimes! (First available in Heaven zone)",
			"Added 11 new slimes! (7 craftable, 4 rollable)",
			"Added 2 new zones!",
			"Added more luck boosts to the upgrade tree",
			"Added more coin income upgrades to the upgrade tree",
			"Added more goop chance upgrades to the upgrade tree",
			"Added more roll speed upgrades to the upgrade tree",
			"Added more friend luck upgrades to the upgrade tree",
			"Added more clover chance upgrades to the upgrade tree",
			"Added more offline earnings upgrades to the upgrade tree",
			"Enemy health scaling from zone 14 and beyond nerfed from 1.6x per zone to 1.5x",
			"Buying server luck now sends a chat message",
			"Increased max server luck tier to 16,384x",
			"The level of a slime will now be shown on the equipped slot",
			"'Equip Best' will now choose based on stats, rather than rarity",
			"Fixed a bug where slimes were not sorted in the correct order above 1/2B",
			"Use code: 'craftAway'"
		}
	},
	["1.5.0"] = {
		title = "Index Rewards + Zones!",
		date = "April 25",
		notes = {
			"Complete overhaul to the slime index, earn rewards for filling out the index!",
			"Added an XP transfer machine, allowing you to transfer XP from one slime to another",
			"Added 2 new zones!",
			"Added 2 new slimes!",
			"Added a setting to limit the number of enemies that can spawn",
			"Added a setting to limit your luck (useful for trying to get mutated low tier slimes)",
			"Added mutated dice items, awarded through index rewards",
			"Use code: 'time2Grind'"
		}
	},
	["1.5.1"] = {
		title = "More Luck!",
		date = "April 28",
		notes = {
			"Buffed luck gained from rebirthing from 1.5x to 1.7x per rebirth",
			"Jackpots are now much more likely to contain mutations",
			"Updated Index rewards so that every reward gives at least some luck, and added additional coin income upgrades",
			"Added Overkill upgrades to the upgrade tree",
			"Special dice can now be canceled, and returned to inventory, by clicking them on the bottom bar",
			"Use code: '2muchluck'"
		}
	},
	["1.6.0"] = {
		title = "MEGA UPDATE!",
		date = "May 1",
		notes = {
			"Added 5 new zones!",
			"Added 10 new slimes!",
			"Replaced Boss enemies with mutated enemies! Super rare chance to drop mutated dice!",
			"Added the ability to auto craft",
			"Buffed luck gained from rebirthing from 1.7x to 1.82x per rebirth",
			"Buffed goop rewards past zone 13 significantly",
			"Buffed the base stats/rarity of crafted slimes",
			"Added a notification button in the top right to join any active events",
			"Double rolled jackpot spins now show both jackpots at the same time",
			"AutoRoll can now be turned off when viewing a jackpot with multiple jackpot dice queued",
			"Fixed a bug where the rebirth UI animation would show incorrect luck values",
			"Raised requirement for a global roll announcement",
			"Use code: 'giveMeLuckNOW'"
		}
	}
}
