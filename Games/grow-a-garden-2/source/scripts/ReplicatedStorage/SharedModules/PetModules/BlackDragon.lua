--credit to quartz games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	AssetName = "BlackDragon",
	Big = true,
	Huge = true,
	Pivot = Vector3.new(0, 0, 0),
	HandGrip = Vector3.new(0, 0, 0),
	IsFlying = true,
	AirHeight = 8,
	FollowAirHeight = 4,
	PerchHoverHeight = 3,
	LandDelay = 1,
	LandDuration = 0.8,
	TakeoffDuration = 0.8,
	WanderSpeed = 9,
	WanderPauseMin = 0.6,
	WanderPauseMax = 1.4,
	WanderWaypointCountMin = 3,
	WanderWaypointCountMax = 5,
	WanderMinSegmentLength = 10,
	WanderMaxTurnAngleDeg = 70,
	WanderHeightJitter = 2,
	FullOrientation = true,
	NeverPerch = true,
	EatChancePerSecond = 0,
	OrbitChancePerSecond = 0,
	Animations = {
		Fly = "Fly",
		Land = "Land",
		GroundIdle = "GroundIdle",
		FireBreath = "FireBreath"
	},
	Behaviors = {
		BlackDragonDefend = {
			CheckIntervalMin = 0.25,
			CheckIntervalMax = 0.5,
			ChancePerCheck = 1,
			Cooldown = 0,
			ApproachSpeed = 22,
			BreathDuration = 1.5,
			BreathCooldown = 8,
			ApproachLegTimeout = 8
		}
	}
}