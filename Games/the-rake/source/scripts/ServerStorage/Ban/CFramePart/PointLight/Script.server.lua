local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(2,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local flash = ts:Create(script.Parent,tweenInfo,{Brightness = 0})

script.Parent.Brightness = 30
flash:Play()