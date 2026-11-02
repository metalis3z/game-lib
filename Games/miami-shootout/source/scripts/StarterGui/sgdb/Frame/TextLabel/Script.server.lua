local tween = game.TweenService:Create(script.Parent,TweenInfo.new(1),{TextTransparency = 1, TextStrokeTransparency = 0.65})

task.wait(1)

tween:Play()

task.wait(1)

script.Parent:Destroy()