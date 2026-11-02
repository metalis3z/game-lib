--credit to quartz games studio
local Dice_Roll = game.SoundService.SFX.Dice_Roll

script.Parent.MouseButton1Click:Connect(function() --[[ Line: 3 | Upvalues: Dice_Roll (copy) ]]
	Dice_Roll.TimePosition = 0
	Dice_Roll.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Dice_Roll.Playing = true
end)