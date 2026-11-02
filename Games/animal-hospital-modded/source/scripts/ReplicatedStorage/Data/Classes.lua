local t = {
	HealPatient = "HealPatient",
	CheckInPatient = "CheckInPatient"
}

return {
	Classes = {
		Intern = {
			Desc = "Start with 10 bonus sanity.",
			StartingMoney = 0,
			Tools = {},
			Attributes = {
				BonusSanity = 10
			},
			LevelPerks = {
				[2] = {
					BonusSanity = 15
				},
				[3] = {
					BonusSanity = 20
				}
			}
		},
		Nurse = {
			Desc = "+1 Max inventory capacity",
			StartingMoney = 0,
			Tools = {},
			Attributes = {
				BonusCarryItems = 1
			},
			LevelPerks = {
				[2] = {
					BonusCarryItems = 2
				},
				[3] = {
					BonusCarryItems = 3
				}
			}
		},
		Doctor = {
			Desc = "Recover x2 Sanity when healing patients.",
			StartingMoney = 0,
			Tools = {},
			Attributes = {
				HealingRecovery = 1,
				BonusSanity = 10
			},
			LevelPerks = {
				[2] = {
					BonusSanity = 15
				},
				[3] = {
					BonusSanity = 20
				}
			}
		},
		Secretary = {
			Desc = "Recover x2 Sanity when checking in patients.",
			StartingMoney = 20,
			Tools = {},
			Attributes = {
				CheckInSanityRecovery = 1
			},
			LevelPerks = {
				[2] = {
					BonusSanity = 5
				},
				[3] = {
					BonusSanity = 10
				}
			}
		},
		Paramedic = {
			Desc = "Start with Large Run Cola (6 Uses)",
			StartingMoney = 0,
			Tools = { "Large Run Cola" },
			Attributes = {},
			LevelPerks = {
				[2] = {
					["ExtraChargesLarge Run Cola"] = 3
				},
				[3] = {
					RegenCharges = "Large Run Cola"
				}
			}
		},
		Security = {
			Desc = "Start with X-Taser (5 Uses)",
			StartingMoney = 20,
			Tools = { "X-Taser" },
			Attributes = {},
			LevelPerks = {
				[2] = {
					["ExtraChargesX-Taser"] = 1
				},
				[3] = {
					RegenCharges = "X-Taser"
				}
			}
		},
		Psychologist = {
			Desc = "All sanity effects are doubled (negative and positive)",
			StartingMoney = 0,
			Tools = {},
			Attributes = {
				BonusSanity = 999,
				SanityImpactMultiplier = 2
			},
			LevelPerks = {
				[2] = {
					ResistSanityDamageChance = 0.075
				},
				[3] = {
					ResistSanityDamageChance = 0.15
				}
			}
		},
		["Head Nurse"] = {
			Desc = "+3 Max inventory capacity",
			StartingMoney = 30,
			RobuxOnly = true,
			Tools = {},
			Attributes = {
				BonusCarryItems = 3
			},
			LevelPerks = {
				[2] = {
					BonusSanity = 10
				},
				[3] = {
					PlayerGiveAllItems = true
				}
			}
		},
		Surgeon = {
			Desc = "Get sanity and short speed boost after healing a patient.",
			StartingMoney = 35,
			Tools = {},
			Attributes = {
				SkillEvent = "ApplySpeedEffect",
				EventSpeedBoost = 1.2,
				EventSpeedBoostDuration = 4,
				HealingRecovery = 1,
				EventTrigger = t.HealPatient
			},
			LevelPerks = {
				[2] = {
					EventSpeedBoostDuration = 8
				},
				[3] = {
					HealingRecovery = 2,
					BonusSanity = 10
				}
			}
		},
		["Secret Agent"] = {
			Desc = "Start with a gun (dangerous) (20 uses).",
			StartingMoney = 50,
			RobuxOnly = true,
			Tools = { "Gun" },
			Attributes = {
				BonusCarryItems = 1
			},
			LevelPerks = {
				[2] = {
					ExtraChargesGun = 10,
					BonusSanity = 10
				},
				[3] = {
					RegenCharges = "Gun",
					BonusSanity = 20
				}
			}
		}
	},
	BASE_CLASS = "Intern",
	TRIGGERS = t
}