repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Lit = script.parent.parent.Humanoid:LoadAnimation(script.parent.Lit)
local Clicked = false

script.Parent.Activated:Connect(function()
if Clicked == false then
Clicked = true
		Lit:Play()
		wait(0.4)
		Tool.Handle.Sound:Play()
		Tool.LightPart.Transparency = 0
		Tool.Handle.Light1.Range = 15
		Tool.Particles.ParticleEmitter.Enabled = false
		Tool.Particles.ParticleEmitter2.Enabled = false
		wait()
		Tool.LightPart.Transparency = 0.1
		Tool.Handle.Light1.Range = 14
		wait()
		Tool.LightPart.Transparency = 0.2
		Tool.Handle.Light1.Range = 13
		wait()
		Tool.LightPart.Transparency = 0.3
		Tool.Handle.Light1.Range = 12
		wait()
		Tool.LightPart.Transparency = 0.4
		Tool.Handle.Light1.Range = 11
		wait()
		Tool.LightPart.Transparency = 0.5
		Tool.Handle.Light1.Range = 10
		wait()
		Tool.LightPart.Transparency = 0.6
		Tool.Handle.Light1.Range = 9
		wait()
		Tool.LightPart.Transparency = 0.7
		Tool.Handle.Light1.Range = 8
		wait()
		Tool.LightPart.Transparency = 0.8
		Tool.Handle.Light1.Range = 7
		wait()
		Tool.LightPart.Transparency = 0.9
		Tool.Handle.Light1.Range = 6
		wait()
		Tool.Handle.Light1.Range = 5
		Tool.Handle.Light1.Enabled = false
		Tool.LightPart.Transparency = 1
		Tool.Handle.Light1.Range = 4
		wait()
		Tool.Handle.Light1.Range = 3
		wait()
		Tool.Handle.Light1.Range = 2
		wait()
		Tool.Handle.Light1.Range = 1
		wait()
		Tool.Handle.Light1.Range = 0
wait(1)
script.Parent.ToggleScript.Disabled = false
wait()
script.Disabled = true
Clicked = false
end
end)