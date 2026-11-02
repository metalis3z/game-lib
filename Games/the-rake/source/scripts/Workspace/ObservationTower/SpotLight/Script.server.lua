local AlreadyOn = false
local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(3,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local TweenInfoo2 = TweenInfo.new(20,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out)
local TweenInfoo3 = TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local TweenInfoo4 = TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local PlaybackSpeedOn = tweenService:Create(script.Parent.Body.Sound,TweenInfoo2,{PlaybackSpeed = 1})
local PlaybackSpeedOff = tweenService:Create(script.Parent.Body.Sound,TweenInfoo,{PlaybackSpeed = 0})
local BrightnessOn = tweenService:Create(script.Parent.Light.SpotLight,TweenInfoo,{Brightness = 10})
local BrightnessOff = tweenService:Create(script.Parent.Light.SpotLight,TweenInfoo,{Brightness = 0})
local LightOn = tweenService:Create(script.Parent.Glass,TweenInfoo4,{Color = Color3.fromRGB(255, 255, 255)})
local LightOff = tweenService:Create(script.Parent.Glass,TweenInfoo3,{Color = Color3.fromRGB(0, 0, 0)})
while true do
wait()
	if script.Parent.Parent.Open.Value == 1 and AlreadyOn == false then
		PlaybackSpeedOn:Play()
		BrightnessOn:Play()
		LightOn:Play()
		wait()
AlreadyOn = true
elseif  script.Parent.Parent.Open.Value == 0 and AlreadyOn == true then	
		PlaybackSpeedOff:Play()
		BrightnessOff:Play()
		LightOff:Play()
AlreadyOn = false
end
end