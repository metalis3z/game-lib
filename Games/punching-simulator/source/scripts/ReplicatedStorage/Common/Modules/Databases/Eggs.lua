--> Variables
local _L = _G._L

--> Constants

---------->
local Eggs

Eggs = {
	{
		name = "Farm_Egg",
		display_name = "Farm Egg",
		
		pets = {
			{name = "Cat", chance = 58},
			{name = "Dog", chance = 29},
			{name = "Cow", chance = 12},
			{name = "Mouse", chance = 1}
		},
		
		price = 100,
		
		luck = 0.1
	},
	
	{
		name = "Desert_Egg",
		display_name = "Desert Egg",

		pets = {
			{name = "Desert Fox", chance = 58},
			{name = "Cactus Boi", chance = 29},
			{name = "Desert Creature", chance = 12},
			{name = "Desert Dragon", chance = 1}
		},

		price = 750*5,
		
		luck = 0.1
	},
	
	{
		name = "Void_Egg",
		display_name = "Void Egg",

		pets = {
			{name = "Void Bull", chance = 45},
			{name = "Void Spike", chance = 35},
			{name = "Void Angel", chance = 16},
			{name = "Void Dragon", chance = 3.5},
			{name = "Void Dominus", chance = 0.5}
		},

		price = 3500*25,
		
		luck = 0.1
	},
	
	{
		name = "Dragon_Egg",
		display_name = "Dragon Egg",
		
		is_exclusive = true,
		
		pets = {
			{name = "Magma Demon", chance = 45},
			{name = "Magma Crystalite", chance = 35},
			{name = "Magma Cube", chance = 16},
			{name = "Magma Hellfire", chance = 3.5},
			{name = "Magma Hydra", chance = 0.5}
		},
		
		luck = 0.1
	},
	
	{
		name = "Galaxy_Egg",
		display_name = "Galaxy Egg",
		
		is_exclusive = true,
		
		pets = {
			{name = "Galaxy Cat", chance = 45},
			{name = "Galaxy Dragon", chance = 35},
			{name = "Galactic Alien", chance = 16},
			{name = "Cosmic Cyborg", chance = 3.5},
			{name = "Galaxy Beast", chance = 0.5}
		},
		
		luck = 0.1
	},
	{
		name = "Jungle_Egg",
		display_name = "Jungle Egg",

		pets = {
			{name = "Jungle Bunny", chance = 45},
			{name = "Parrot", chance = 35},
			{name = "Monkey", chance = 16},
			{name = "Elephant", chance = 3.5},
			{name = "Lion", chance = 0.5}
		},

		price = 1500*10,
		luck = 0.1
	},
	--{
	--	name = "250K_Event_Egg",
	--	display_name = "250K Event Egg",

	--	pets = {
	--		{name = "250k Dragon", chance = 45},
	--		{name = "Dark Spirit", chance = 35},
	--		{name = "Wisp Dragon", chance = 16},
	--		{name = "Raged Beast", chance = 3.5},
	--		{name = "Holy Dominus", chance = 0.5}
	--	},

	--	price = 1500
	--},
	--{
	--	name = "500K_Event",
	--	display_name = "500k Event Egg",
	--
	--	pets = {
	--		{name = "500k Bull", chance = 45},
	--		{name = "Hell Wisp", chance = 35},
	--		{name = "Deadly Dominus", chance = 16},
	--		{name = "Holy Kraken", chance = 3.5},
	--		{name = "Dark Dominus", chance = 0.5}
	--	},

	--	price = 750000,
	--	luck = 0.1
	--},
	--{
	--	name = "1M_Event",
	--	display_name = "1M Event Egg",
	--	
	--	pets = {
	--		{name = "1M Lion", chance = 45},
	--		{name = "Lava Angel", chance = 35},
	--		{name = "Lava Dragon", chance = 16},
	--		{name = "Storm Wyvern", chance = 3.5},
	--		{name = "Storm Dragon", chance = 0.5}
	--	},

	--	price = 250000,
	--	luck = 0.01
	--},
	{
		name = "Toxic_Egg",
		display_name = "Toxic Egg",

		pets = {
			{name = "Radioactive Cat", chance = 45},
			{name = "Toxic Cactus Boi", chance = 35},
			{name = "Toxic Dragon", chance = 19},	
			{name = "Toxic Phoenix", chance = 0.9945},
			{name = "Toxic Alien", chance = 0.005},
			{name = "SLIME BOY", chance = 0.0005}
		},

		price = 350000,
		
		luck = 0.001
	},
	{
		name = "2M_Event",
		display_name = "2M Event Egg",

		pets = {
			{name = "Gift", chance = 60},
			{name = "Bat", chance = 25},
			{name = "Bee", chance = 14.5},	
			{name = "Ice Scorpion", chance = 0.4978},
			{name = "Evil Spirit", chance = 0.001},
			{name = "2M Serpent", chance = 0.0001}
		},

		price = 500000,

		luck = 0.001
	},
	{
		name = "3M_Event",
		display_name = "3M Event Egg",

		pets = {
			{name = "Molten Creature", chance = 60},
			{name = "Molten Scorpion", chance = 30},
			{name = "Molten Wyvern", chance = 9.5},	
			{name = "Molten Wisp", chance = 0.4999},
			{name = "Molten Alien", chance = 0.0001}
		},

		price = 750000,

		luck = 0.001
	},
	{
		name = "Midnight_Egg",
		display_name = "Midnight Egg",

		is_exclusive = true,

		pets = {
			{name = "Midnight Monkey", chance = 45},
			{name = "Midnight Bee", chance = 35},
			{name = "Midnight Dominus", chance = 16},
			{name = "Midnight Spirit", chance = 3.5},
			{name = "Midnight Serpent", chance = 0.5}
		},

		luck = 0.1
	},

}

return Eggs