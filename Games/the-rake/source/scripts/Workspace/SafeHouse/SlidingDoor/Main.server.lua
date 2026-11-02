local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(0.8,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out)
local Close = tweenService:Create(script.Parent.Door,TweenInfoo,{CFrame = script.Parent.ClosePos.CFrame})
local Open = tweenService:Create(script.Parent.Door,TweenInfoo,{CFrame = script.Parent.OpenPos.CFrame})

while true do
	wait()
	if script.Parent.Open.Value == false then
		script.Parent.Knock.ProximityPrompt.MaxActivationDistance = 3
	Close:Play()
			
    elseif script.Parent.Open.Value == true then
		script.Parent.Knock.ProximityPrompt.MaxActivationDistance = 0
	Open:Play()
	end
	end


