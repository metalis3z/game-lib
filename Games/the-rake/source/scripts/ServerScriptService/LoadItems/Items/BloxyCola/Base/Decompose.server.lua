local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut)
local Decompose = tweenService:Create(script.Parent,TweenInfoo,{Transparency = 1})

wait(1)
Decompose:Play()
wait(5)
script.Parent:Destroy()