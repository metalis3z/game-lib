local t = game:GetService("TweenService")
local info = TweenInfo.new(1.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In)
local light = t:Create(script.Parent.PointLight,info,{Brightness = 0})

script.Parent.Burning.Changed:Connect(function()
	if script.Parent.Burning.Value == true then
		script.Parent.Burning.Value = false
		script.Parent.CandleLight.Enabled = true
		script.Parent.Fire1.Enabled = true
		script.Parent.Fire2.Enabled = true
		script.Parent.Fire3.Enabled = true
		script.Parent.Smoke.Enabled = true
		script.Parent.PointLight.Brightness = 90
		wait(6)
		light:Play()
		script.Parent.CandleLight.Enabled = false
		script.Parent.Fire1.Enabled = false
		script.Parent.Fire2.Enabled = false
		script.Parent.Fire3.Enabled = false
		script.Parent.Smoke.Enabled = false
	end
end)

script.Parent.ParticleEmitter.Changed:Connect(function()
	if script.Parent.ParticleEmitter.Enabled == true then
		wait(0.07)
		script.Parent.ParticleEmitter.Enabled = false
	end
end)