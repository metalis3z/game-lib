--- Created XsanyaYT ---

--- subscribe the YouTube - PRO100zola 3k
local l__TweenService__1 = game:GetService("TweenService");

function croarfigure(figure)
	l__TweenService__1:Create(figure.Head.AttachmentLight.BlisterLight, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Brightness = 6
	}):Play();
	l__TweenService__1:Create(figure.Head.AttachmentLight.BlisterLight2, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Brightness = 4
	}):Play();
end

function playholddown()
	wait(8.7)
	script.Parent.Parent.Parent.PartC.HitLow:Play()
	script.Parent.Parent.Parent.PartC.Hit:Play()
	game.ReplicatedStorage.Bricks.FigureFall:FireAllClients()
end

local hum = script.Parent:WaitForChild("Humanoid")
local anim = hum:LoadAnimation(script:FindFirstChildOfClass("Animation"))
anim:Play()
script.Parent.Head.Click:Play()
playholddown()
wait(0.4)
script.Parent.Parent.Parent.PartC.Transparency = 1 
script.Parent.Parent.Parent.AnimatedFenceBroken.Par1t.ParticleEmitter.Enabled = true
script.Parent.Parent.Parent.AnimatedFenceBroken.Par1t.ParticleEmitter1.Enabled = true
script.Parent.Parent.Parent.AnimatedFenceBroken:PivotTo(script.Parent.Parent.Parent.AnimatedFence.Par1t.CFrame)
script.Parent.Parent.Parent.AnimatedFence:PivotTo(script.Parent.Parent.Parent.gedbooe.CFrame)
wait(0.5)
croarfigure(script.Parent)
script.Parent.Head.Growl:Play()
script.Parent.Parent.Parent.AnimatedFenceBroken.Par1t.ParticleEmitter.Enabled = false
script.Parent.Parent.Parent.AnimatedFenceBroken.Par1t.ParticleEmitter1.Enabled = false
local anem = script.Parent.Parent.Parent.AnimatedShelf.AnimationController
local d = anem:LoadAnimation(script.Parent.Parent.Parent.AnimatedShelf.Animation)
d:Play()
wait(0.7)
script.Parent.Parent.Parent.AnimatedShelf:Destroy()