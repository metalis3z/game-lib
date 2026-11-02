-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Wario", 
    Description = "'Wario, I gonna win!'", 
	RenderImage = "rbxassetid://11539195", 
	Price = 385375,
	Exlusive = true,
	Animations = {
		Idle = "rbxassetid://82459317350674", 
		Walk = "rbxassetid://77847037025107", 
		Run = "rbxassetid://79522896848444", 
		Stunned = {
			Start = "rbxassetid://86820113575109", 
			Loop = "rbxassetid://101701993866612", 
			End = "rbxassetid://95891040978311"
		}, 
		Introduction = {
			KillerRig = "rbxassetid://128573358452131", 
			CameraRig = "rbxassetid://83808377319495"
		}, 
		Victory = {
			KillerRig = "rbxassetid://128573358452131", 
			CameraRig = "rbxassetid://121159096428519"
		}, 
		Execution = {
			KillerRig = "rbxassetid://84286950660551", 
			PlayerRig = "rbxassetid://86470739857452"
		}, 
		["Execution007n7"] = false,
		Attack = "rbxassetid://119823158967794", 
		CorruptNature = "rbxassetid://88257171112556", 
		SummonPizzaDelivery = "rbxassetid://130624856942490", 
		WalkspeedOverrideStart = "rbxassetid://96521363190789", 
		WalkspeedOverrideLoop = "rbxassetid://114203505102833", 
		WalkspeedOverrideHit = "rbxassetid://131476412510148", 
		WalkspeedOverrideMiss = "rbxassetid://137752772132716"
	}, 
	Sounds = {
		TerrorRadiusThemes = {
			[6] = {
				ID = "rbxassetid://125805079138521", 
				BPM = 81, 
				Chase = true
				}
				}
			},
	Voicelines = {
		Idle = {
			"rbxassetid://71893589942323",
			"rbxassetid://90373739157806"
		}, 
		Kill = {
			"rbxassetid://93325587343702",
			"rbxassetid://103989008150889",
			"rbxassetid://71137739058524"
		}, 
		Stunned = {
			"rbxassetid://120532725590068", 
			"rbxassetid://77129397343788"
		}, 
		CorruptNature = {
			"rbxassetid://127740004867998"
		}, 
		PizzaDelivery = {
			"rbxassetid://104526672209151"
		}, 
		PizzaDeliveryHit = {
			"rbxassetid://104526672209151", 
			"rbxassetid://115476331903507"
		}, 
		WalkspeedOverride = {
			"rbxassetid://127588718124484", 
			"rbxassetid://88594015166647"
		}, 
		WalkspeedOverrideHit = {
			"rbxassetid://113795377366608"
		}, 
		WalkspeedOverrideCollide = {
			"rbxassetid://133564777131483"
		}, 
		WalkspeedOverrideTimeout = {
			"rbxassetid://134973085112081"
        }
    }
};