local Power = script.Parent.Power
local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(1.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut)
local PlaybackSpeedOn = tweenService:Create(script.Parent.Handle.Sound,TweenInfoo,{PlaybackSpeed = 1.5})
local PlaybackSpeedOff = tweenService:Create(script.Parent.Handle.Sound,TweenInfoo,{PlaybackSpeed = 0})
local LightOn = tweenService:Create(script.Parent.Light,TweenInfoo,{Color = Color3.fromRGB(180, 128, 255)})
local LightOff = tweenService:Create(script.Parent.Light,TweenInfoo,{Color = Color3.fromRGB(0, 0, 0)})
local BrightnessOn = tweenService:Create(script.Parent.Light.Light,TweenInfoo,{Brightness = 240})
local BrightnessOff = tweenService:Create(script.Parent.Light.Light,TweenInfoo,{Brightness = 0})

Power.Changed:Connect(function()
	if Power.Value == 0 then
		
		
		script.Parent.PowerEnabler.Disabled = true
		script.Parent.MainScript.Disabled=true
		script.Parent.OnScript.Disabled=true
		PlaybackSpeedOff:Play()
		LightOff:Play()
		BrightnessOff:Play()
		wait(0.2)
		script.Parent.DamageDisabler.Disabled = true
		
		wait(2)
		
		repeat
			wait(0.07)
			Power.Value = Power.Value + 0.5
		until Power.Value == 200
		
		elseif Power.Value == 200 then
		
		--script.Parent.MainScript.Disabled=false
		--script.Parent.OnScript.Disabled=false
		--script.Parent.On.Value = 0
		
	end
end)