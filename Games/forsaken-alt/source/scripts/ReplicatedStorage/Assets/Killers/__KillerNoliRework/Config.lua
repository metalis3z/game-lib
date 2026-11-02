-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	DisplayName = "Noli (Rework)", 
	Quote = "\"And so darkness decends.\"", 
	Credits = "By: c2o & Marcy", 
	RenderImage = "rbxassetid://113686001078195", 
	Price = 1100, 
	Exclusive = true, 
	Health = 1111, 
	Speed = 24, 
	SprintSpeed = 28, 
	StaminaLoss = 10, 
	StaminaGain = 10, 
	MaxStamina = 60, 
	MinStamina = -30, 
	MovementAnimSpeed = 1.5, 
	AttackDamage = 40, 
	StabDamage = 25, 
	StabCooldown = 2, 
	StunTimeAfterLosingStamina = 1.25, 
	SpeedTimeAfterStaminaLossStun = 2, 
	StardrivenTokenData = {
		[2] = {
			Distance = 75, 
			Lifetime = 0.4, 
			Damage = 15
		}, 
		[1] = {
			Distance = 75, 
			Lifetime = 0.625, 
			Damage = 35
		}
	}, 
	StardrivenHallucinationDuration = 7, 
	StardrivenCooldown = 15, 
	ImplantBaseDamage = 55, 
	ImplantBombThrowBaseRange = 30, 
	ImplantKnockback = 2, 
	ImplantCooldown = 15, 
	ImplantDecayTime = 30, 
	HallucinationCooldown = 1, 
	HallucinationDuration = 5, 
	HallucinationAuraRevealDuration = 3, 
	HallucinationMaxDistance = 45, 
	IntroLighting = script.IntroLighting, 
	Animations = {
		Idle = "rbxassetid://133688711615523", 
		Walk = "rbxassetid://107435624432994", 
		Run = "rbxassetid://107435624432994", 
		Stab = "rbxassetid://93257278452441", 
		StardrivenTendrilStart = "rbxassetid://110186066239539", 
		StardrivenTendrilLoop = "rbxassetid://82137910232457", 
		StardrivenCharge1Start = "rbxassetid://117170985464699", 
		StardrivenCharge1Loop = "rbxassetid://112933985862312", 
		StardrivenCharge1Hit = "rbxassetid://76572050273114", 
		StardrivenCharge2Start = "rbxassetid://82971532570177", 
		StardrivenCharge2Loop = "rbxassetid://114653179302649", 
		StardrivenCharge2HitNoli = "rbxassetid://88122016747586", 
		StardrivenCharge2HitVictim = "rbxassetid://122924133305747", 
		StardrivenChargeMiss = "rbxassetid://70479642599233", 
		Implant = "rbxassetid://71140715979821", 
		ImplantDash = "rbxassetid://86991201643962", 
		ImplantAttackNoli = "rbxassetid://101618000381780", 
		ImplantAttackVictim = "rbxassetid://109411322637067", 
		Hallucination = "rbxassetid://87258493647077", 
		Introduction = {
			KillerRig = "rbxassetid://127898112040291", 
			CameraRig = "rbxassetid://81341466298616"
		}, 
		Execution = {
			KillerRig = "rbxassetid://123839714260466", 
			PlayerRig = "rbxassetid://116544958644813", 
			PlayerCFrameOffset = CFrame.new(0, 0, -6)
		}, 
		Stunned = {
			Start = "rbxassetid://77502998111999", 
			Loop = "rbxassetid://104650727275694", 
			End = "rbxassetid://79338401693761"
		}
	}, 
	Sounds = {
		Idle = "rbxassetid://73235255020546", 
		Footsteps = {
			"rbxassetid://99809965759734", 
			"rbxassetid://79222929114377"
		}, 
		Execution = "rbxassetid://91549814855829", 
		Swing = "rbxassetid://118208498013260", 
		Hit = "rbxassetid://110759725172567", 
		Implant = "rbxassetid://90768093259753", 
		ImplantInject = "rbxassetid://114767134633867", 
		Explosion = "rbxassetid://99558901806521", 
		Hallucination = "rbxassetid://113926551867193", 
		TerrorRadiusThemes = {
			[60] = {
				ID = "rbxassetid://137984398736588", 
				BPM = 81
			}, 
			[40] = {
				ID = "rbxassetid://101639399549593", 
				BPM = 81
			}, 
			[20] = {
				ID = "rbxassetid://139278573219074", 
				BPM = 81
			}, 
			[6] = {
				ID = "rbxassetid://79001697227075", 
				BPM = 81, 
				Chase = true
			}
		}, 
		Introduction = "rbxassetid://97041392946745"
	}, 
	Assets = {
		DecayCC = script.Decay
	}
};