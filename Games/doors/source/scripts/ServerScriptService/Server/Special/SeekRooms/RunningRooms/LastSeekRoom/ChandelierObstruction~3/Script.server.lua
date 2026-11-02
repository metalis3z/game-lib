local d = script.Parent.AnimationController:LoadAnimation(script.Parent.Animation)
wait(5)
d:Play()
wait(0.4)
game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 18, 0, 0.7)
script.Parent.Collision.Fall:Play()
script.Parent.String1.ParticleEmitter1.Enabled = true
script.Parent.String1.ParticleEmitter2.Enabled = true
script.Parent.String1.ParticleEmitter3.Enabled = true
wait(0.5)
script.Parent.Collision.Fire:Play()
while true do
	wait(0.1)
	d.Ended:Connect(function()
		script.Parent.PrimaryPart.CFrame = script.Parent.PrimaryPart.CFrame + Vector3.new(20, 0, 0)
	end)
end