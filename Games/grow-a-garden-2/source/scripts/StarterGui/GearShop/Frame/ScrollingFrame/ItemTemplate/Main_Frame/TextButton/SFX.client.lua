--credit to leon games studio
local Hover = game.SoundService.SFX.Hover
local Click = game.SoundService.SFX.Click

if game:GetService("UserInputService").TouchEnabled ~= false then
	game:GetService("TweenService")
	TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
	script.Parent.MouseButton1Click:Connect(function() --[[ Line: 13 | Upvalues: Click (copy) ]]
		Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		Click.TimePosition = 0
		Click.Playing = true
	end)

	return
end

script.Parent.MouseEnter:Connect(function() --[[ Line: 5 | Upvalues: Hover (copy) ]]
	Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Hover.TimePosition = 0
	Hover.Playing = true
end)
game:GetService("TweenService")
TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
script.Parent.MouseButton1Click:Connect(function() --[[ Line: 13 | Upvalues: Click (copy) ]]
	Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Click.TimePosition = 0
	Click.Playing = true
end)