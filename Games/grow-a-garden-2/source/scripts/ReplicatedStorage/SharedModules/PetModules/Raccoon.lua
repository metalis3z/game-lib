--credit to prince games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	AssetName = "Raccoon",
	Big = true,
	Huge = true,
	Pivot = Vector3.new(0, -90, 90),
	HandGrip = Vector3.new(90, 90, 0),
	WanderSpeed = 8,
	WanderPauseMin = 0.6,
	WanderPauseMax = 1.4,
	Animations = {
		Idle = "Idle",
		Walk = "Walk"
	},
	Behaviors = {
		StealFruit = {
			CheckIntervalMin = 20,
			CheckIntervalMax = 60,
			ChancePerCheck = 0.85,
			Cooldown = 90,
			VictimCooldown = 120,
			TravelSpeed = 20,
			LegTimeout = 20,
			StealDuration = 3,
			DeliveryRadius = 8
		}
	}
}