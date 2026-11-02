local TweenService = game:GetService("TweenService")
local Info = TweenInfo.new(1.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In)
local Decompose = TweenService:Create(script.Parent,Info,{Transparency = 1})

Decompose:Play()
wait(1.5)
script.Parent:Destroy()