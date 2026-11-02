-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Constants = require(script.Parent.Constants)

return {
	run = {
		Speed = Constants.BASE_RUN_SPEED,
		Velocity = Vector2.yAxis * Constants.BASE_RUN_SPEED
	},
	walk = {
		Speed = Constants.BASE_WALK_SPEED,
		Velocity = Vector2.yAxis * Constants.BASE_WALK_SPEED
	}
}