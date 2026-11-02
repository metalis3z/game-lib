-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
require(v1.Registries.BrainrotRegistry)
require(v1.Registries.RarityRegistry)
local v2 = {}
local v3 = {
	["Name"] = "LuckyBlock"
}
local v4 = {
	["Mythic"] = {
		{
			["Name"] = "WaterBottellini",
			["PerSec"] = 60000,
			["Weight"] = 1
		}
	},
	["Secret"] = {
		{
			["Name"] = "ElefantoFrigo",
			["PerSec"] = 450000,
			["Weight"] = 70
		},
		{
			["Name"] = "StrawberriniJamini",
			["PerSec"] = 1000000,
			["Weight"] = 30
		}
	},
	["Celestial"] = {
		{
			["Name"] = "SwagSoda",
			["PerSec"] = 4500000,
			["Weight"] = 40
		},
		{
			["Name"] = "LosStrawberryElephantitos",
			["PerSec"] = 15000000,
			["Weight"] = 1
		}
	}
}
v3.Brainrots = v4
local v5 = {
	["Rarities"] = {
		{
			["Name"] = "Mythic",
			["Weight"] = 70
		},
		{
			["Name"] = "Secret",
			["Weight"] = 25
		},
		{
			["Name"] = "Celestial",
			["Weight"] = 3
		}
	}
}
v3.Chances = v5
v3.Weight = 0
v3.Timer = 300
v3.DespawnTimer = 30
v3.SpawnLocations = { "Common", "Rare", "Epic" }
v2.LuckyBlock = v3
local v6 = {
	["Name"] = "Mythic Lucky Block"
}
local v7 = {
	["Mythic"] = {
		{
			["Name"] = "BurbaloniLuliloli",
			["PerSec"] = 9000,
			["Weight"] = 60
		},
		{
			["Name"] = "DragonfrutinaDolphinita",
			["PerSec"] = 45000,
			["Weight"] = 30
		},
		{
			["Name"] = "Alessio",
			["PerSec"] = 90000,
			["Weight"] = 10
		}
	}
}
v6.Brainrots = v7
local v8 = {
	["Rarities"] = {
		{
			["Name"] = "Mythic",
			["Weight"] = 100
		}
	}
}
v6.Chances = v8
v6.Weight = 50
v6.Timer = 3600
v6.DespawnTimer = 60
v6.SpawnLocations = { "Mythic" }
v2["Mythic Lucky Block"] = v6
local v9 = {
	["Name"] = "Secret Lucky Block"
}
local v10 = {
	["Secret"] = {
		{
			["Name"] = "TorrtuginniDragonfrutini",
			["PerSec"] = 110000,
			["Weight"] = 70
		},
		{
			["Name"] = "AgarriniLaPalini",
			["PerSec"] = 350000,
			["Weight"] = 25
		},
		{
			["Name"] = "GuerriroDigitale",
			["PerSec"] = 900000,
			["Weight"] = 5
		}
	}
}
v9.Brainrots = v10
local v11 = {
	["Rarities"] = {
		{
			["Name"] = "Secret",
			["Weight"] = 100
		}
	}
}
v9.Chances = v11
v9.Weight = 20
v9.Timer = 3600
v9.DespawnTimer = 60
v9.SpawnLocations = { "Secret" }
v2["Secret Lucky Block"] = v9
local v12 = {
	["Name"] = "Celestial Lucky Block"
}
local v13 = {
	["Celestial"] = {
		{
			["Name"] = "CastlinoFortini",
			["PerSec"] = 3200000,
			["Weight"] = 80
		},
		{
			["Name"] = "StoppoLuminino",
			["PerSec"] = 5500000,
			["Weight"] = 17
		},
		{
			["Name"] = "NuclearoDinossauro",
			["PerSec"] = 8800000,
			["Weight"] = 3
		}
	}
}
v12.Brainrots = v13
local v14 = {
	["Rarities"] = {
		{
			["Name"] = "Celestial",
			["Weight"] = 100
		}
	}
}
v12.Chances = v14
v12.Weight = 1
v12.Timer = 3600
v12.DespawnTimer = 60
v12.SpawnLocations = { "Celestial" }
v2["Celestial Lucky Block"] = v12
local v15 = {
	["Name"] = "Magma Lucky Block"
}
local v16 = {
	["Secret"] = {
		{
			["Name"] = "LaLaLavaLaLaChicken",
			["PerSec"] = 475000,
			["Weight"] = 65
		},
		{
			["Name"] = "PazzoVulcano",
			["PerSec"] = 720000,
			["Weight"] = 35
		}
	},
	["Celestial"] = {
		{
			["Name"] = "LavaleroLavala",
			["PerSec"] = 4300000,
			["Weight"] = 1
		}
	},
	["Godly"] = {
		{
			["Name"] = "ElefanteLavante",
			["PerSec"] = 20000000,
			["Weight"] = 1
		}
	}
}
v15.Brainrots = v16
local v17 = {
	["Rarities"] = {
		{
			["Name"] = "Secret",
			["Weight"] = 97.5
		},
		{
			["Name"] = "Celestial",
			["Weight"] = 2
		},
		{
			["Name"] = "Godly",
			["Weight"] = 0.1
		}
	}
}
v15.Chances = v17
v15.Weight = 0
v15.Timer = 3600
v15.DespawnTimer = 60
v15.SpawnLocations = { "Celestial" }
v2["Magma Lucky Block"] = v15
local v18 = {
	["Name"] = "Food Lucky Block"
}
local v19 = {
	["Secret"] = {
		{
			["Name"] = "CornCornCornSahur",
			["PerSec"] = 260000,
			["Weight"] = 8
		},
		{
			["Name"] = "PolloDrumini",
			["PerSec"] = 780000,
			["Weight"] = 7
		}
	},
	["Celestial"] = {
		{
			["Name"] = "ChillinPickle",
			["PerSec"] = 4700000,
			["Weight"] = 7.6
		},
		{
			["Name"] = "PBandJ",
			["PerSec"] = 10000000,
			["Weight"] = 1
		}
	},
	["Godly"] = {
		{
			["Name"] = "DragoniPizzaroni",
			["PerSec"] = 25000000,
			["Weight"] = 1
		}
	}
}
v18.Brainrots = v19
local v20 = {
	["Rarities"] = {
		{
			["Name"] = "Secret",
			["Weight"] = 75
		},
		{
			["Name"] = "Celestial",
			["Weight"] = 24.9
		},
		{
			["Name"] = "Godly",
			["Weight"] = 0.1
		}
	}
}
v18.Chances = v20
v18.Weight = 0
v18.Timer = 3600
v18.DespawnTimer = 60
v18.SpawnLocations = { "Celestial" }
v2["Food Lucky Block"] = v18
for v21, v22 in {
	["Moon Mythic Lucky Block"] = "Mythic Lucky Block",
	["Moon Secret Lucky Block"] = "Secret Lucky Block",
	["Moon Celestial Lucky Block"] = "Celestial Lucky Block",
	["Moon Magma Lucky Block"] = "Magma Lucky Block"
} do
	v2[v21] = table.clone(v2[v22])
	v2[v21].Name = v21
	v2[v21].MoonEventBlock = true
end
return v2
