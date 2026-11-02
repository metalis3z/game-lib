local d = script.Parent.AnimationController:LoadAnimation(script.Parent.Animation)
wait(5)
d:Play()
wait(0.4)
game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 18, 0, 0.7)
script.Parent.Collision.Fall:Play()
script.Parent.Collision.Sound:Play()
script.Parent.Model.AnimatedBookshelf2.ParticleEmitter.Enabled = true
wait(0.5)
script.Parent.Model.AnimatedBookshelf2.ParticleEmitter.Enabled = false
