local ts = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local tweeninfo2 = TweenInfo.new(25,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local shocklight = ts:Create(script.Parent.Parent.PointLight,tweeninfo,{Brightness = 0})
local powerLight = ts:Create(script.Parent.Parent.Parent.Light.PointLight,tweeninfo2,{Brightness = 2.42})
local powerLightpart = ts:Create(script.Parent.Parent.Parent.Light,tweeninfo2,{Color = Color3.fromRGB(255, 255, 255)})
local greenLightpartOn = ts:Create(script.Parent.Parent.Parent.Button,tweeninfo2,{Color = Color3.fromRGB(0, 255, 0)})
local greenLightpartOff = ts:Create(script.Parent.Parent.Parent.Button,tweeninfo,{Color = Color3.fromRGB(0, 0, 0)})
local OffpowerLight = ts:Create(script.Parent.Parent.Parent.Light.PointLight,tweeninfo,{Brightness = 0})
local OffpowerLightpart = ts:Create(script.Parent.Parent.Parent.Light,tweeninfo,{Color = Color3.fromRGB(83, 83, 83)})
local RestoringFail = false
local RestoringTrue = false

script.Parent.PromptButtonHoldBegan:Connect(function(Player)
	if Player.Character.Humanoid.Health > 0 then
		RestoringTrue = false
		Player.Character.Restorer.Value=true
	script.Parent.Parent.Parent.Sound2.Humming.Playing = false
	script.Parent.Parent.Power:Play()
	script.Parent.Parent.Power.Volume = 0.7
	script.Parent.Parent.Power.PlaybackSpeed = 0
	Player.Character.Server.Play.Value = 1
	script.Parent.Parent.Restoring.Value = true
		wait(6)
		powerLight:Play()
		powerLightpart:Play()
		greenLightpartOn:Play()
		if RestoringTrue == false then
			RestoringFail = true
		end
		wait(3)
		script.Parent.Parent.PipeSound:Play()
	end
end)

script.Parent.PromptButtonHoldEnded:Connect(function(Player)
	wait()
	RestoringTrue = true
	script.Parent.Parent.Power:Stop()
	script.Parent.Parent.Power.Volume = 0
	Player.Character.Server.Play.Value = 0
	script.Parent.Parent.Restoring.Value = false
	script.Parent.Parent.Powering.Value = 0
	Player.Character.Restorer.Value=false
	if script.Parent.Parent.Restored.Value == false then
		OffpowerLight:Play()
		OffpowerLightpart:Play()
		greenLightpartOff:Play()
	end
	if script.Parent.Parent.Restored.Value == false and RestoringFail == true then
		script.Parent.Parent.PipeSound:Stop()
		OffpowerLight:Play()
		OffpowerLightpart:Play()
		greenLightpartOff:Play()
		script.Parent.Parent.GoingOffline:Play()
		Player.Character:FindFirstChildOfClass("Humanoid"):TakeDamage(40)
		script.Parent.Parent.Zap:Play()
		script.Parent.Parent.PointLight.Brightness = 400
		shocklight:Play()
		RestoringFail = false
		script.Parent.MaxActivationDistance = 0
		wait(2)
		script.Parent.MaxActivationDistance = 5
	end
end)

script.Parent.Triggered:Connect(function(Player)
	Player.Character.Restorer.Value=false
	workspace.PowerOutValue.Value = 0
	script.Parent.Parent.GoingOffline.Volume = 0
	script.Parent.Parent.Power:Stop()
	script.Parent.Parent.Power.Volume = 0
	script.Parent.Parent.ComingOnline:Play()
	script.Parent.Parent.Parent.Sound2.Humming.Playing = true
	script.Parent.Parent.Power.PlaybackSpeed = 0
	script.Parent.MaxActivationDistance = 0
	script.Parent.Parent.Restored.Value = true
end)

while wait() do
	if script.Parent.Parent.Restoring.Value == true then
		repeat wait(0.017)
			script.Parent.Parent.Powering.Value = script.Parent.Parent.Powering.Value + 0.0015
		until script.Parent.Parent.Restoring.Value == false
	end
end