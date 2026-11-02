--credit to prince games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	AssetName = "Bunny",
	Big = true,
	Huge = true,
	Pivot = Vector3.new(0, 180, 0),
	HandGrip = Vector3.new(0, 180, 0),
	WanderSpeed = 18,
	FollowSpeed = 18,
	WanderPauseMin = 2,
	WanderPauseMax = 6,
	TurnHopDist = 1.5,
	TurnHopSpeed = 18,
	TurnHopMinGap = 0.6,
	Animations = {
		Idle = "Idle",
		Walk = "Walk"
	},
	TurnHopCountWeights = {
		[0] = 0.45,
		[1] = 0.4,
		[2] = 0.15
	}
}