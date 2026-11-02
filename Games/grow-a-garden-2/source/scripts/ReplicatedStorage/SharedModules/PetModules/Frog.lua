--credit to quartz games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	AssetName = "Frog",
	Big = true,
	Huge = true,
	Pivot = Vector3.new(0, 180, 0),
	HandGrip = Vector3.new(0, 180, 0),
	WanderSpeed = 5,
	WanderPauseMin = 3,
	WanderPauseMax = 8,
	TurnHopDist = 1.5,
	TurnHopSpeed = 18,
	TurnHopMinGap = 0.6,
	Animations = {
		Idle = "Idle",
		Walk = "Walk"
	},
	TurnHopCountWeights = {
		[0] = 0.3,
		[1] = 0.5,
		[2] = 0.2
	}
}