	local Items = {} do

	Items.Collectors = {
		["Shovel"] = {
			Name = "Shovel",
			Description = "Collects 1 Pollen from 2 flowers \n\n Cooldown: 0.75s",

			Cooldown = 0.75,

			StatsModule = {
				AnimTools = "rbxassetid://18236324502",
				Collecting = 2,
				Power = 0.2,
				
				Tool = true,
				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Scooper",
			Ability = "None",
		},
		["Pitchfork"] = {
			Name = "Pitchfork",
			Description = "Collects 3 Pollen from 6 flowers. \n\n Cooldown: 0.6s",

			Cooldown = 0.6,

			StatsModule = {
				AnimTools = "rbxassetid://18236453715",
				Collecting = 4,
				Power = 0.5,

				Tool = true,

				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "pitchfork",
			Ability = "None",
		},
		["Magnet"] = {
			Name = "Magnet",
			Description = "Collecting 10 Pollen from 12 Flowers \n\n Cooldown: 0.8s",

			Cooldown = 0.8,

			StatsModule = {
				AnimTools = "rbxassetid://18236990704", -- 18236689244
				Collecting = 8,
				Power = 0.5,

				Tool = true,

				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Magnet",
			Ability = "None",
		},
		["Scissors"] = {
			Name = "Scissors",
			Description = "Collecting 65 Pollen from 2 Flowers \n\n Cooldown: 0.55s",

			Cooldown = 0.55,

			StatsModule = {
				AnimTools = "rbxassetid://18237170753",
				Collecting = 15,
				Power = 0.5,

				Tool = true,
				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Scissors",
			Ability = "None",
		},
		["Balalaika"] = {
			Name = "Balalaika",
			Description = "some text idk \nx1.1 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 0.7,

			StatsModule = {
				AnimTools = "rbxassetid://18237568444",
				Collecting = 25,
				Power = 0.3,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.1,
			},

			Stamp = "balalaika",
			Ability = "None",
		},
		["Honey Dipper"] = {
			Name = "Honey Dipper",
			Description = "some text idk \nx1.1 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 1.3,

			StatsModule = {
				AnimTools = "rbxassetid://18612367170",
				Collecting = 40,
				Power = 0.3,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.1,
			},

			Stamp = "HoneySpoon",
			Ability = "None",
		},
		["Scythe"] = {
			Name = "Scythe",
			Description = "some text idk \nx1.1 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 1.1,

			StatsModule = {
				AnimTools = "rbxassetid://18612094385",
				Collecting = 80,
				Power = 0.75,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.5,
			},

			Stamp = "Scythe",
			Ability = "None",
		},
		["Magic Wand"] = {
			Name = "Magic Wand",
			Description = "",

			Cooldown = 0.9,

			StatsModule = {
				AnimTools = "rbxassetid://18238095304",
				Collecting = 140,
				Power = 0.5,

				Tool = true,
				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Magic Wand",
			Ability = "None",
		},
		["Axe"] = {
			Name = "Axe",
			Description = "",

			Cooldown = 0.9,

			StatsModule = {
				AnimTools = "rbxassetid://18720292374",
				Collecting = 220,
				Power = 0.5,

				Tool = true,
				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Axe",
			Ability = "None",
		},
		["Grand Hammer"] = {
			Name = "Grand Hammer",
			Description = "some text idk \nx1.1 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 1.5,

			StatsModule = {
				AnimTools = "rbxassetid://18612893519",
				Collecting = 350,
				Power = 1.15,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.5,
			},

			Stamp = "Hammer",
			Ability = "None",
		},
		

		["Flaming Scythe"] = {
			Name = "Flaming Scythe",
			Description = "some text idk \nx1.1 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 1,

			StatsModule = {
				AnimTools = "rbxassetid://18686638148",
				Collecting = 2500,
				Power = 0.75,

				Tool = true,
				Color = "Red",
				ColorMutltiplier = 1.5,
			},

			Stamp = "Scythe",
			Ability = "None",
		},
		["Frozen Shovel"] = {
			Name = "Frozen Shovel",
			Description = "some text idk \nx1.1 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 0.9,

			StatsModule = {
				AnimTools = "rbxassetid://18657127602",
				Collecting = 2450,
				Power = 0.75,

				Tool = true,
				Color = "Blue",
				ColorMutltiplier = 1.5,
			},

			Stamp = "FrozenShovel",
			Ability = "None",
		},
	}
end

return Items
