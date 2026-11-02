--credit to prince games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	AssetName = "GoldenDragonfly",
	Big = true,
	Huge = true,
	Pivot = Vector3.new(0, -90, 0),
	HandGrip = Vector3.new(0, 90, 0),
	IsFlying = true,
	AlwaysFlying = true,
	AirHeight = 6,
	FollowAirHeight = 3,
	WanderSpeed = 11.25,
	WanderPauseMin = 0.6,
	WanderPauseMax = 1.4,
	WanderWaypointCountMin = 3,
	WanderWaypointCountMax = 5,
	WanderMinSegmentLength = 10,
	WanderMaxTurnAngleDeg = 130,
	WanderHeightJitter = 6,
	NeverPerch = true,
	HoverChancePerSecond = 0.02,
	HoverDurationMin = 5,
	HoverDurationMax = 12,
	HoverLookChangeMin = 1,
	HoverLookChangeMax = 6,
	OrbitChancePerSecond = 0,
	EatChancePerSecond = 0,
	Animations = {
		Fly = "Fly"
	}
}