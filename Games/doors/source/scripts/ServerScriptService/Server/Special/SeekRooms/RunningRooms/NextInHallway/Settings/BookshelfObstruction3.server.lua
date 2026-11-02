local hum = script.Parent.Parent.Assets.BookshelfObstruction:WaitForChild("AnimationController")

local humanim = hum:LoadAnimation(script.Parent.Parent.Assets.BookshelfObstruction:FindFirstChildOfClass("Animation"))

function playanim()
	humanim:Play()
	humanim:AdjustSpeed(1)
	wait(0.3)
	script.Parent.Parent.Assets.BookshelfObstruction.Model.AnimatedBookshelf2.ParticleEmitter.Enabled = true
	wait(0.8)
	script.Parent.Parent.Assets.BookshelfObstruction.Model.AnimatedBookshelf2.ParticleEmitter.Enabled = false
	script.Parent.Parent.Assets.BookshelfObstruction.Collision.Sound:Play()
end

script.Parent.Parent.Animated.NextInHallway_BookshelfObstruction3.Touched:Connect(function()
	script.Parent.Parent.Animated.NextInHallway_BookshelfObstruction3.CanTouch = false
	playanim()
end)