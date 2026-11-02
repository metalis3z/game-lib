


local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
require(v1.Updates)
local v2 = {}
local v3 = {
	["Name"] = "Rebirth 1",
	["RebirthNumber"] = 1,
	["Rewards"] = {
		["Cash"] = 5000,
		["Multiplier"] = 0.5,
		["AdditionalLockTime"] = 10,
		["FriendController"] = true,
		["Items"] = { "Iron Slap", "Gravity Coil", "Bee Launcher" }
	},
	["Requirements"] = {
		["Cash"] = 1000000,
		["RequiredCharacters"] = { "Trippi Troppi", "Gangster Footera" }
	}
}
v2[1] = v3
local v4 = {
	["Name"] = "Rebirth 2",
	["RebirthNumber"] = 2,
	["Rewards"] = {
		["Cash"] = 10000,
		["Multiplier"] = 1,
		["AdditionalLockTime"] = 20,
		["AnimalSlot"] = 1,
		["Items"] = { "Gold Slap", "Coil Combo", "Rage Table" }
	},
	["Requirements"] = {
		["Cash"] = 3000000,
		["RequiredCharacters"] = { "Boneca Ambalabu", "Brr Brr Patapim" }
	}
}
v2[2] = v4
local v5 = {
	["Name"] = "Rebirth 3",
	["RebirthNumber"] = 3,
	["Rewards"] = {
		["Cash"] = 25000,
		["Multiplier"] = 2,
		["AdditionalLockTime"] = 30,
		["AnimalSlot"] = 1,
		["Items"] = { "Diamond Slap", "Grapple Hook", "Taser Gun" }
	},
	["Requirements"] = {
		["Cash"] = 12500000,
		["RequiredCharacters"] = { "Trulimero Trulicina", "Chimpanzini Bananini" }
	}
}
v2[3] = v5
local v6 = {
	["Name"] = "Rebirth 4",
	["RebirthNumber"] = 4,
	["Rewards"] = {
		["Cash"] = 50000,
		["Multiplier"] = 3,
		["AdditionalLockTime"] = 40,
		["AnimalSlot"] = 1,
		["Items"] = { "Emerald Slap", "Invisibility Cloak", "Boogie Bomb" }
	},
	["Requirements"] = {
		["Cash"] = 35000000,
		["RequiredCharacters"] = { "Chef Crabracadabra", "Glorbo Fruttodrillo" }
	}
}
v2[4] = v6
local v7 = {
	["Name"] = "Rebirth 5",
	["RebirthNumber"] = 5,
	["Rewards"] = {
		["Cash"] = 100000,
		["Multiplier"] = 4,
		["AdditionalLockTime"] = 50,
		["AnimalSlot"] = 1,
		["Items"] = { "Ruby Slap", "Medusa\'s Head" }
	},
	["Requirements"] = {
		["Cash"] = 100000000,
		["RequiredCharacters"] = { "Frigo Camelo", "Orangutini Ananassini" }
	}
}
v2[5] = v7
local v8 = {
	["Name"] = "Rebirth 6",
	["RebirthNumber"] = 6,
	["Rewards"] = {
		["Cash"] = 250000,
		["Multiplier"] = 5,
		["AdditionalLockTime"] = 60,
		["AnimalSlot"] = 1,
		["Items"] = { "Dark Matter Slap", "Web Slinger" }
	},
	["Requirements"] = {
		["Cash"] = 350000000,
		["RequiredCharacters"] = { "Bombardiro Crocodilo" }
	}
}
v2[6] = v8
local v9 = {
	["Name"] = "Rebirth 7",
	["RebirthNumber"] = 7,
	["Rewards"] = {
		["Cash"] = 500000,
		["Multiplier"] = 6,
		["AdditionalLockTime"] = 70,
		["AnimalSlot"] = 1,
		["Items"] = { "Flame Slap", "Quantum Cloner", "All Seeing Sentry" }
	},
	["Requirements"] = {
		["Cash"] = 1000000000,
		["RequiredCharacters"] = { "Bombombini Gusini" }
	}
}
v2[7] = v9
local v10 = {
	["Name"] = "Rebirth 8",
	["RebirthNumber"] = 8,
	["Rewards"] = {
		["Cash"] = 1000000,
		["Multiplier"] = 7,
		["AdditionalLockTime"] = 80,
		["AnimalSlot"] = 1,
		["Items"] = { "Nuclear Slap", "Rainbowrath Sword" }
	},
	["Requirements"] = {
		["Cash"] = 5000000000,
		["RequiredCharacters"] = { "Te Te Te Sahur" }
	}
}
v2[8] = v10
local v11 = {
	["Name"] = "Rebirth 9",
	["RebirthNumber"] = 9,
	["Rewards"] = {
		["Cash"] = 5000000,
		["Multiplier"] = 8,
		["AdditionalLockTime"] = 90,
		["AnimalSlot"] = 1,
		["Items"] = { "Galaxy Slap", "Laser Cape" }
	},
	["Requirements"] = {
		["Cash"] = 25000000000,
		["RequiredCharacters"] = { "Cocofanto Elefanto" }
	}
}
v2[9] = v11
local v12 = {
	["Name"] = "Rebirth 10",
	["RebirthNumber"] = 10,
	["Rewards"] = {
		["Cash"] = 25000000,
		["Multiplier"] = 9,
		["AdditionalLockTime"] = 100,
		["AnimalSlot"] = 1,
		["Items"] = { "Glitched Slap", "Body Swap Potion" }
	},
	["Requirements"] = {
		["Cash"] = 250000000000,
		["RequiredCharacters"] = { "Girafa Celestre" }
	}
}
v2[10] = v12
local v13 = {
	["Name"] = "Rebirth 11",
	["RebirthNumber"] = 11,
	["Rewards"] = {
		["Cash"] = 100000000,
		["Multiplier"] = 10,
		["AdditionalLockTime"] = 110,
		["AnimalSlot"] = 1,
		["Items"] = { "Splatter Slap", "Paintball Gun" }
	},
	["Requirements"] = {
		["Cash"] = 1000000000000,
		["RequiredCharacters"] = { "Tralalero Tralala" }
	}
}
v2[11] = v13
local v14 = {
	["Name"] = "Rebirth 12",
	["RebirthNumber"] = 12,
	["Rewards"] = {
		["Cash"] = 500000000,
		["Multiplier"] = 11,
		["AdditionalLockTime"] = 120,
		["AnimalSlot"] = 1,
		["Items"] = { "Heart Balloon", "Magnet" }
	},
	["Requirements"] = {
		["Cash"] = 7000000000000,
		["RequiredCharacters"] = { "Odin Din Din Dun" }
	}
}
v2[12] = v14
local v15 = {
	["Name"] = "Rebirth 13",
	["RebirthNumber"] = 13,
	["Rewards"] = {
		["Cash"] = 1000000000,
		["Multiplier"] = 12,
		["AdditionalLockTime"] = 130,
		["AnimalSlot"] = 1,
		["Items"] = { "Megaphone", "BeeHive" }
	},
	["Requirements"] = {
		["Cash"] = 35000000000000,
		["RequiredCharacters"] = { "Trenostruzzo Turbo 3000" }
	}
}
v2[13] = v15
local v16 = {
	["Name"] = "Rebirth 14",
	["RebirthNumber"] = 14,
	["Rewards"] = {
		["Cash"] = 2500000000000,
		["Multiplier"] = 13,
		["AdditionalLockTime"] = 140,
		["AnimalSlot"] = 1,
		["Items"] = { "Gummy Bear", "Subspace Mine" }
	},
	["Requirements"] = {
		["Cash"] = 100000000000000,
		["RequiredCharacters"] = { "Trippi Troppi Troppa Trippa" }
	}
}
v2[14] = v16
local v17 = {
	["Name"] = "Rebirth 15",
	["RebirthNumber"] = 15,
	["Rewards"] = {
		["Cash"] = 10000000000000,
		["Multiplier"] = 15,
		["AdditionalLockTime"] = 150,
		["AnimalSlot"] = 1,
		["Items"] = { "Heatseeker" }
	},
	["Requirements"] = {
		["Cash"] = 500000000000000,
		["RequiredCharacters"] = { "Pakrahmatmamat" }
	}
}
v2[15] = v17
local v18 = {
	["Name"] = "Rebirth 16",
	["RebirthNumber"] = 16,
	["Rewards"] = {
		["Cash"] = 25000000000000,
		["Multiplier"] = 16,
		["AdditionalLockTime"] = 160,
		["AnimalSlot"] = 1,
		["Items"] = { "Attack Doge" }
	},
	["Requirements"] = {
		["Cash"] = 1000000000000000,
		["RequiredCharacters"] = { "Los Tralaleritos" }
	}
}
v2[16] = v18
local v19 = {
	["Name"] = "Rebirth 17",
	["RebirthNumber"] = 17,
	["Rewards"] = {
		["Cash"] = 50000000000000,
		["Multiplier"] = 17,
		["AdditionalLockTime"] = 170,
		["AnimalSlot"] = 1,
		["Items"] = { "Giant Potion" }
	},
	["Requirements"] = {
		["Cash"] = 2000000000000000,
		["RequiredCharacters"] = { "Job Job Job Sahur", "Chicleteira Bicicleteira" }
	}
}
v2[17] = v19
local v20 = {
	["Name"] = "Rebirth 18",
	["RebirthNumber"] = 18,
	["Rewards"] = {
		["Cash"] = 100000000000000,
		["Multiplier"] = 18,
		["AdditionalLockTime"] = 180,
		["AnimalSlot"] = 1,
		["Items"] = { "Flash Teleport" }
	},
	["Requirements"] = {
		["Cash"] = 1e16,
		["RequiredCharacters"] = { "Graipuss Medussi" }
	}
}
v2[18] = v20
return v2