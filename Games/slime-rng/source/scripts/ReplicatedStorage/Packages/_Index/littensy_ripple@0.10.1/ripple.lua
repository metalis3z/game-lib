-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ripple, time of decompilation: Sun May  3 10:10:45 2026 ]]
local selfConfig = require("@self/config")
local selfEasing = require("@self/easing")
local selfMotion = require("@self/motion")
local selfSpring = require("@self/spring")
local selfTween = require("@self/tween")

require("@self/types")

return {
	config = selfConfig,
	easing = selfEasing,
	createMotion = selfMotion.createMotion,
	createSpring = selfSpring.createSpring,
	createTween = selfTween.createTween
}
