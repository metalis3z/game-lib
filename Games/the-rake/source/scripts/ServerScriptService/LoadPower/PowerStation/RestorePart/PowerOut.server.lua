local ts = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local tweeninfo2 = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local shocklight = ts:Create(script.Parent.PointLight,tweeninfo,{Brightness = 0})
local powerLight = ts:Create(script.Parent.Parent.Light.PointLight,tweeninfo2,{Brightness = 2.42})
local powerLightpart = ts:Create(script.Parent.Parent.Light,tweeninfo2,{Color = Color3.fromRGB(255, 255, 255)})
local greenLightpartOn = ts:Create(script.Parent.Parent.Button,tweeninfo2,{Color = Color3.fromRGB(0, 255, 0)})
local greenLightpartOff = ts:Create(script.Parent.Parent.Button,tweeninfo,{Color = Color3.fromRGB(0, 0, 0)})
local OffpowerLight = ts:Create(script.Parent.Parent.Light.PointLight,tweeninfo,{Brightness = 0})
local OffpowerLightpart = ts:Create(script.Parent.Parent.Light,tweeninfo,{Color = Color3.fromRGB(83, 83, 83)})

local Shock = script.Parent.Parent.Shock

local Info1 = TweenInfo.new(1,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local DeactiveTween = ts:Create(Shock,Info1,{Color = Color3.fromRGB(91, 93, 105)})

workspace.PowerOutValue.Changed:Connect(function()
	if script.Parent.Restored.Value == true and workspace.PowerOutValue.Value == 1 then
		DeactiveTween:Play()
		workspace.NearMode.ModeStarted.Value = false
		script.Parent.Parent.Shock.DamageScript.Disabled = true
		script.Parent.Parent.Shock.ZapParticle.Enabled = false
		script.Parent.Parent.Shock.ZapParticle2.Enabled = false
		OffpowerLight:Play()
		OffpowerLightpart:Play()
		greenLightpartOff:Play()
		script.Parent.GoingOffline.Volume = 1
		script.Parent.Restored.Value = false
		script.Parent.GoingOffline:Play()
		workspace.PowerOut:Play()
		script.Parent.Parent.Sound2.Humming:Stop()
		script.Parent.PipeSound:Stop()
		local Explosion1 = Instance.new("Explosion",script.Parent)
		Explosion1.DestroyJointRadiusPercent = 0
		Explosion1.BlastRadius = 0
		Explosion1.BlastPressure = 0
		Explosion1.ExplosionType = "NoCraters"
		Explosion1.Position = script.Parent.Parent.ExplosionParts.ExplosionPart1.Position
		local Explosion2 = Instance.new("Explosion",script.Parent)
		Explosion2.DestroyJointRadiusPercent = 0
		Explosion2.BlastRadius = 0
		Explosion2.BlastPressure = 0
		Explosion2.ExplosionType = "NoCraters"
		Explosion2.Position = script.Parent.Parent.ExplosionParts.ExplosionPart2.Position
		wait(3)
		if workspace.Values.DuringMode.Value == false then
			script.Parent.ProximityPrompt.MaxActivationDistance = 5
		end	
	end
end)

workspace.PowerOutValue.Changed:Connect(function()
	if workspace.PowerOutValue.Value == 0 and workspace.Values.DuringMode.Value == false then
		script.Parent.Parent.Shock.DamageScript.Disabled = false
		powerLight:Play()
		powerLightpart:Play()
		greenLightpartOn:Play()
		script.Parent.Power:Stop()
		script.Parent.Power.Volume = 0
		script.Parent.Restoring.Value = false
		script.Parent.Powering.Value = 0
		workspace.PowerOutValue.Value = 0
		script.Parent.GoingOffline.Volume = 0
		script.Parent.Power:Stop()
		script.Parent.Power.Volume = 0
		script.Parent.ComingOnline:Play()
		script.Parent.Parent.Sound2.Humming.Playing = true
		script.Parent.Power.PlaybackSpeed = 0
		script.Parent.ProximityPrompt.MaxActivationDistance = 0
		script.Parent.Restored.Value = true
	end
end)