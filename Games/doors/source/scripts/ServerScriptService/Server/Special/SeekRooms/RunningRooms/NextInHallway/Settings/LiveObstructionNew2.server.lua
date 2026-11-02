local hum = script.Parent.Parent.Assets.NextInHallwayLiveObstructionNew2:WaitForChild("AnimationController")

local humanim = hum:LoadAnimation(script.Parent.Parent.Assets.NextInHallwayLiveObstructionNew2:FindFirstChildOfClass("Animation"))

function playanim()
	humanim:Play()
	humanim:AdjustSpeed(1)
	wait(0.3)
	script.Parent.Parent.Assets.NextInHallwayLiveObstructionNew2.Collision.Sound:Play()
	script.Parent.Parent.Assets.NextInHallwayLiveObstructionNew2.Model.AnimatedBookshelf2.ParticleEmitter.Enabled = true
	script.Parent.Parent.Assets.NextInHallwayLiveObstructionNew2.Model.AnimatedBookshelf1.ParticleEmitter.Enabled = true
	wait(0.8)
	script.Parent.Parent.Assets.NextInHallwayLiveObstructionNew2.Model.AnimatedBookshelf2.ParticleEmitter.Enabled = false
	script.Parent.Parent.Assets.NextInHallwayLiveObstructionNew2.Model.AnimatedBookshelf1.ParticleEmitter.Enabled = false
end

script.Parent.Parent.Animated.LiveObstructionNew2.Touched:Connect(function()
	script.Parent.Parent.Animated.LiveObstructionNew2.CanTouch = false
	playanim()
end)
