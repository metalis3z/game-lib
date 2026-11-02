-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Wario", 
    Description = "'Wario, I gonna win!'", 
	RenderImage = "rbxassetid://11539195", 
	Price = 385375,
	Exlusive = true,
	Animations = {
		Idle = "rbxassetid://117807508802948", 
		Walk = "rbxassetid://113592425280147", 
		Run = "rbxassetid://110615273403463", 
		Stunned = {
			Start = "rbxassetid://132146352398445", 
			Loop = "rbxassetid://86201758065405", 
			End = "rbxassetid://127246288642904"
		}, 
		Introduction = {
			KillerRig = "rbxassetid://131829861438441", 
			CameraRig = "rbxassetid://100312850969513"
		}, 
		Victory = {
			KillerRig = "rbxassetid://131829861438441", 
			CameraRig = "rbxassetid://77422987647257"
		}, 
		Execution = {
			KillerRig = "rbxassetid://130376096010370", 
			PlayerRig = "rbxassetid://92795727462138"
		}, 
		["Execution007n7"] = false,
		Attack = "rbxassetid://88097244859675", 
		CorruptNature = "rbxassetid://77953222960296", 
		SummonPizzaDelivery = "rbxassetid://131260840748404", 
		WalkspeedOverrideStart = "rbxassetid://71479453006282", 
		WalkspeedOverrideLoop = "rbxassetid://109863321821960", 
		WalkspeedOverrideHit = "rbxassetid://115275264499186", 
		WalkspeedOverrideMiss = "rbxassetid://118681590615472"
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