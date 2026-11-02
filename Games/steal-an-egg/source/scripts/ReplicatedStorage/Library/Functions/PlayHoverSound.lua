-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Hover = game:GetService("SoundService").Hover

return ({
	PlayHoverSound = function() --[[ PlayHoverSound | Line: 6 | Upvalues: Hover (copy) ]]
		Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		Hover.Playing = true
		Hover.Volume = 1
		Hover.TimePosition = 0
	end
}).PlayHoverSound