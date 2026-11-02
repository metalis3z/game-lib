local NightDayFunction = script.Parent.On
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
		PlaybackSpeedOff:Play()
		LightOff:Play()
		BrightnessOff:Play()
		script.Parent.DamageDisabler.Disabled = false
		
	end
end)

NightDayFunction.Changed:Connect(function()
	if NightDayFunction.Value == 1 then
local Anim = script.Parent:WaitForChild("Use")
local human = script.Parent.Parent:FindFirstChild("Humanoid")
local LoadAnim = human:LoadAnimation(Anim)
		LoadAnim:Play()
		script.Parent.DamageDisabler.Disabled = true
		wait(0.4)
		script.Parent.UsePower.Disabled=false
script.Parent.Handle.Sound:Play()
		PlaybackSpeedOn:Play()
		LightOn:Play()
		BrightnessOn:Play()
		wait(0.7)
		script.Parent.Damage.Disabled = false
		
		elseif NightDayFunction.Value == 0 then	
		
local human = script.Parent.Parent:FindFirstChild("Humanoid")		
local Anim = script.Parent:WaitForChild("Use")	
local LoadAnim = human:LoadAnimation(Anim)		
		LoadAnim:Play()
		wait(0.4)
		script.Parent.UsePower.Disabled=true
		PlaybackSpeedOff:Play()
		LightOff:Play()
		BrightnessOff:Play()
		script.Parent.DamageDisabler.Disabled = false
		

	elseif NightDayFunction.Value == 3 then	
		
		script.Parent.UsePower.Disabled = true
		script.Parent.PowerEnabler.Disabled = true
		PlaybackSpeedOff:Play()
		LightOff:Play()
		BrightnessOff:Play()
		script.Parent.DamageDisabler.Disabled = false
			
		end
	end)