-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Click = game:GetService("SoundService").Click

return function() --[[ PlayClickSound | Line: 4 | Upvalues: Click (copy) ]]
	Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Click.Playing = true
	Click.TimePosition = 0
end