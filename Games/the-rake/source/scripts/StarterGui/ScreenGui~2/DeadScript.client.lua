local TextLabel = script.Parent.Text.TextLabel
local Death1 = script.Parent.Death1
local Death2 = script.Parent.Death2
local Death3 = script.Parent.Death3
local RandomSound = math.random(1,3)

game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:connect(function()
	if RandomSound == 1 then
		TextLabel.Visible = true
		Death1:Play()
		TextLabel.TextTransparency = 0
		TextLabel.TextStrokeTransparency = 0
		wait(5)
		repeat
			wait()
			TextLabel.TextTransparency = TextLabel.TextTransparency + 0.1
			TextLabel.TextStrokeTransparency = TextLabel.TextStrokeTransparency + 0.1
		until TextLabel.TextTransparency == 1 and  TextLabel.TextStrokeTransparency == 1
	elseif RandomSound == 2 then
		TextLabel.Visible = true
		Death2:Play()	
		TextLabel.TextTransparency = 0
		TextLabel.TextStrokeTransparency = 0
		wait(5)
		repeat
			wait()
			TextLabel.TextTransparency = TextLabel.TextTransparency + 0.1
			TextLabel.TextStrokeTransparency = TextLabel.TextStrokeTransparency + 0.1
		until TextLabel.TextTransparency == 1 and  TextLabel.TextStrokeTransparency == 1
	elseif RandomSound == 3 then
		TextLabel.Visible = true
		Death3:Play()
		TextLabel.TextTransparency = 0
		TextLabel.TextStrokeTransparency = 0
		wait(5)
		repeat
			wait()
			TextLabel.TextTransparency = TextLabel.TextTransparency + 0.1
			TextLabel.TextStrokeTransparency = TextLabel.TextStrokeTransparency + 0.1
		until TextLabel.TextTransparency == 1 and  TextLabel.TextStrokeTransparency == 1		
   end
end)