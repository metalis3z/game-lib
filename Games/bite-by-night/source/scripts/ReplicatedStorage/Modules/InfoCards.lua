local Characters = {}

Characters.Springtrap = {
	Name = "Springtrap",
	Description = "\"I always come back\"",
	Origin = "",
	Render = "rbxassetid://138239393863043",
	MapRender = "rbxassetid://90561092354212",
	InfoCardColor = Color3.fromRGB(184, 198, 151),
	RenderSize = UDim2.new(0.457, 0, 1.359, 0),
	RenderAnchor = Vector2.new(0.5, 0.5),
	Summary = "A mix of a rush and trapper type animatronic.",

	SkinRenders = {
		Hoax = {
			RenderSize = UDim2.new(0.457, 0, 1.359, 0),
			RenderAnchor = Vector2.new(0.6, 0.5),
		},
		Toon = {
			RenderSize = UDim2.new(0.457, 0, 1.359, 0),
			RenderAnchor = Vector2.new(0.65, 0.5),
		},
	},

	Moves = {
		{
			Name = "Swing",
			Icon = "rbxassetid://110217065523263",
			Desc = "Swing your axe/fist. Deals <d>Swing<> damage, <d>SwingAxeless<> in axeless.",
		},
		{
			Name = "Remnant Cleaver",
			Icon = "rbxassetid://95425215651890",
			Desc = "Throw your axe. Changes your moves and stats and applies bleeding for 15 seconds if landed.",
		},
		{
			Name = "Beartrap",
			Icon = "rbxassetid://108954887271695",
			Desc = "Place down a trap that stuns people. Can only place <c>MaxTraps<> traps at a time and stuns for <c>BeartrapStun<> seconds.",
		},
		{
			Name = "Scream",
			Icon = "rbxassetid://92250777173241",
			Desc = "Reveal all survivor locations and regen 25 stamina. Changes move into Charge.",
		},
		{
			Name = "Charge",
			Icon = "rbxassetid://103514330953345",
			Desc = "Rush forward and grab any survivor in front of you. Deals <p>Grab<>% of their current HP.",
		},
	},
}

Characters.Mimic = {
	Name = "Mimic",
	Description = "\"Why don't you trust me?\"",
	Origin = "",
	Render = "rbxassetid://79386508788500",
	MapRender = "rbxassetid://111429889332214",
	InfoCardColor = Color3.fromRGB(204, 34, 34),
	RenderSize = UDim2.new(0.5, 0, 1.6, 0),
	RenderAnchor = Vector2.new(0.5, 0.5),
	Summary = "Multiple modes to adapt to the current situation.",

	Moves = {
		{
			Name = "Swing",
			Icon = "rbxassetid://121140210476271",
			Desc = "Swing your fist. Deals <d>Swing<> damage in base.",
		},
		{
			Name = "Mode Switch",
			Icon = "rbxassetid://102430427976347",
			CustomIconPlacement = UDim2.new(0.11, 0, 0.458, 0),
			Desc = "Switch modes between Strength, Speed, and Stealth.",
		},
		{
			Name = "Mode: Strength",
			Icon = "rbxassetid://110261018237522",
			CustomIconPlacement = UDim2.new(0.11, 0, 0.458, 0),
			Desc = "Base stats.",
		},
		{
			Name = "Mode: Speed",
			Icon = "rbxassetid://107856551357803",
			CustomIconPlacement = UDim2.new(0.11, 0, 0.458, 0),
			Desc = "-75% Damage, +15% Speed, -50% Stamina Regen, -50% Stamina. Unlocks Leap.",
		},
		{
			Name = "Mode: Stealth",
			Icon = "rbxassetid://109565493151508",
			CustomIconPlacement = UDim2.new(0.11, 0, 0.458, 0),
			Desc = "-25% Damage. Become undetectable. Unlocks Grab and Drill Stab.",
		},
		{
			Name = "Leap: Speed",
			Icon = "rbxassetid://132453323762610",
			Desc = "Leap forward, dealing <d>Jump<> AOE damage.",
		},
		{
			Name = "Grab: Stealth",
			Icon = "rbxassetid://100390450105159",
			Desc = "Grab players in front of you (hits 1 target).",
		},
		{
			Name = "Drill Stab: Stealth",
			Icon = "rbxassetid://100925649621183",
			Desc = "Follow-up after grab. Stab players in the chest, dealing <d>Grab<> damage.",
		},
		{
			Name = "Drill: Stealth",
			Icon = "rbxassetid://114987723529699",
			Desc = "Dig into the floor, becoming invisible and revealing players. Deals <d>DigOut<> damage upon exit.",
		},
	},
}

Characters.Ennard = {
	Name = "Ennard",
	Description = "\"You won't die\"",
	Origin = "",
	Render = "rbxassetid://123183821976849",
	MapRender = "rbxassetid://130075428404967",
	InfoCardColor = Color3.fromRGB(80, 80, 80),
	RenderSize = UDim2.new(0.6, 0, 1.6, 0),
	RenderAnchor = Vector2.new(0.5, 0.55),
	Summary = "A trapper and impersonator.",

	Moves = {
		{
			Name = "Swing",
			Icon = "rbxassetid://130543632464859",
			Desc = "Swing your fist. Deals <d>Swing<> damage.",
		},
		{
			Name = "Wire Eyes",
			Icon = "rbxassetid://119688260563893",
			Desc = "Summon two minions that roam and reveal players.",
		},
		{
			Name = "Grab",
			Icon = "rbxassetid://102518719944520",
			Desc = "Extend wires from your hand that grab players and pull them to you.",
		},
		{
			Name = "Skin Stealer",
			Icon = "rbxassetid://140711940929283",
			Desc = "Eject a dead player and take their appearance.",
		},
		{
			Name = "Skin Stealer: Explode",
			Icon = "rbxassetid://74080595631104",
			Desc = "Do an AOE explosion that deals <d>Explode<> damage.",
		},
		{
			Name = "Skin Stealer: Throw",
			Icon = "rbxassetid://134072846911662",
			Desc = "Throw a Minion. Explodes if it hits a player. Spawn a minion if it misses."
		},
		{
			Name = "Skin Stealer: Stab",
			Icon = "rbxassetid://130148632396358",
			Desc = "Lunge forward and stab players. Deals 45 damage and lowers the time limit in Skin Stealer upon use.",
		},
	},
}

Characters.Bear5 = {
	Name = "bear5",
	Description = "\"what the hell is this\"",
	Origin = "",
	Render = "rbxassetid://12382855836",
	MapRender = "rbxassetid://0",
	InfoCardColor = Color3.fromRGB(133, 182, 255),
	RenderSize = UDim2.new(0.457, 0, 1.359, 0),
	RenderAnchor = Vector2.new(0.5, 0.5),
	Summary = "what is this thing.",
	Moves = {},
}

Characters.Survivor = {
	Lobby = {
		Name = "Lobby",
		Description = "\"Lobby Survivor real\"",
		Origin = "",
		Render = "rbxassetid://0",
		MapRender = "rbxassetid://80072702227046",
		InfoCardColor = Color3.fromRGB(156, 156, 156),
		RenderSize = UDim2.new(0.37, 0, 1.359, 0),
		RenderAnchor = Vector2.new(0.5, 0.5),
		Summary = "Lobby Survivor.",
		Moves = {},
	},

	Customer = {
		Name = "Customer",
		Description = "\"Eat pizza\"",
		Origin = "",
		Render = "rbxassetid://134093083745243",
		MapRender = "rbxassetid://80072702227046",
		InfoCardColor = Color3.fromRGB(156, 156, 156),
		RenderSize = UDim2.new(0.37, 0, 1.359, 0),
		RenderAnchor = Vector2.new(0.55, 0.6),
		Summary = "Survivalist.",

		Moves = {
			{
				Name = "Pizza",
				Icon = "rbxassetid://71369875967101",
				Desc = "Heal <q>HealPercentage<>% of your current HP",
			},
			{
				Name = "Drink",
				Icon = "rbxassetid://98879642304716",
				Desc = "Gain speed for a short amount of time. Slowness debuff when it ends.",
			},
		},
	},

	Fighter = {
		Name = "Fighter",
		Description = "\"Wait, you can fight back?\"",
		Origin = "",
		Render = "rbxassetid://74320330061847",
		MapRender = "rbxassetid://122820960637353",
		InfoCardColor = Color3.fromRGB(156, 156, 156),
		RenderSize = UDim2.new(0.275, 0, 1.359, 0),
		RenderAnchor = Vector2.new(0.55, 0.5),
		Summary = "The main stunner of the group.",

		Moves = {
			{
				Name = "Swing",
				ImageRectSize = Vector2.new(150, 150),
				ImageRectOffset = Vector2.new(0, 45),
				Icon = "rbxassetid://140250835142787",
				Desc = "Swing your axe, dealing <c>SwingStun<> seconds of stun and applying 3 different effects depending on the parry charges.",
			},
			{
				Name = "Parry",
				ImageRectSize = Vector2.new(150, 150),
				ImageRectOffset = Vector2.new(10, 15),
				Icon = "rbxassetid://92408284858967",
				Desc = "Parry the animatronic to deal <c>ParryStun<> seconds of stun and add one charge.",
			},
		},
	},

	Medic = {
		Name = "Medic",
		Description = "\"Get back on your feet!\"",
		Origin = "",
		Render = "rbxassetid://136110992535820",
		MapRender = "rbxassetid://108343017668586",
		InfoCardColor = Color3.fromRGB(156, 156, 156),
		RenderSize = UDim2.new(0.275, 0, 1.359, 0),
		RenderAnchor = Vector2.new(0.6, 0.5),
		Summary = "Help people live longer.",

		Moves = {
			{
				Name = "Heal",
				ImageRectSize = Vector2.new(250, 250),
				ImageRectOffset = Vector2.new(35, 35),
				Icon = "rbxassetid://93969211635312",
				CustomIconPlacement = UDim2.new(0.14, 0, 0.458, 0),
				Desc = "Heal other players. Heal <c>Heal<> HP every <c>Rate<> seconds.",
			},
			{
				Name = "Self Heal",
				Icon = "rbxassetid://87787207332114",
				Desc = "Heal yourself. Heal <c>SelfHeal<> HP every <c>SelfHealRate<> seconds.",
			},
		},
	},

	["Security Guard"] = {
		Name = "Security Guard",
		Description = "\"Stay back!\"",
		Origin = "",
		Render = "rbxassetid://77716016031725",
		MapRender = "rbxassetid://102941654107525",
		InfoCardColor = Color3.fromRGB(156, 156, 156),
		RenderSize = UDim2.new(0.275, 0, 1.359, 0),
		RenderAnchor = Vector2.new(0.6, 0.5),
		Summary = "The support.",

		Moves = {
			{
				Name = "Taser",
				Icon = "rbxassetid://127894319632762",
				CustomIconPlacement = UDim2.new(0.125, 0, 0.458, 0),
				Desc = "Charge and fire your taser. Gets stronger the longer you charge it.",
			},
			{
				Name = "Cams",
				Icon = "rbxassetid://75371709991725",
				CustomIconPlacement = UDim2.new(0.125, 0, 0.458, 0),
				Desc = "Look through cameras around the map.",
			},
		},
	},
}

return Characters