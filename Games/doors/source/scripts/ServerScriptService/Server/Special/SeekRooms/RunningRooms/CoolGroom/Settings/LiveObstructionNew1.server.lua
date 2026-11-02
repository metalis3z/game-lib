local hum = script.Parent.Parent.Assets.CoolGroomLiveObstructionNew1:WaitForChild("AnimationController")

local humanim = hum:LoadAnimation(script.Parent.Parent.Assets.CoolGroomLiveObstructionNew1:FindFirstChildOfClass("Animation"))

function playanim()
	humanim:Play()
	humanim:AdjustSpeed(1)
	wait(0.3)
	script.Parent.Parent.Assets.CoolGroomLiveObstructionNew1.Collision.Sound:Play()
	script.Parent.Parent.Assets.CoolGroomLiveObstructionNew1.Model.AnimatedBookshelf2.ParticleEmitter.Enabled = true
	script.Parent.Parent.Assets.CoolGroomLiveObstructionNew1.Model.AnimatedBookshelf1.ParticleEmitter.Enabled = true
	wait(0.8)
	script.Parent.Parent.Assets.CoolGroomLiveObstructionNew1.Model.AnimatedBookshelf2.ParticleEmitter.Enabled = false
	script.Parent.Parent.Assets.CoolGroomLiveObstructionNew1.Model.AnimatedBookshelf1.ParticleEmitter.Enabled = false
end

script.Parent.Parent.Animated.CoolGroom_LiveObstructionNew1.Touched:Connect(function()
	script.Parent.Parent.Animated.CoolGroom_LiveObstructionNew1.CanTouch = false
	playanim()
end)
