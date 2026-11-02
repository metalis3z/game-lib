script.Parent.Changed:Connect(function()
	if script.Parent.Value == true then
		script.Parent.Parent.Door.Knock:Play()
		game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 18, 0, 0.7)
		script.Parent.Parent.Door.ParticleEmitter.Enabled = true
		wait(0.1)
		script.Parent.Parent.Door.ParticleEmitter.Enabled = false

		wait(1.1)

		script.Parent.Parent.Door.Knock:Play()
		game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 18, 0, 0.7)
		script.Parent.Parent.Door.ParticleEmitter.Enabled = true
		wait(0.1)
		script.Parent.Parent.Door.ParticleEmitter.Enabled = false

		wait(1.1)

		script.Parent.Parent.Door.Knock:Play()
		game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 18, 0, 0.7)
		script.Parent.Parent.Door.ParticleEmitter.Enabled = true
		wait(0.1)
		script.Parent.Parent.Door.ParticleEmitter.Enabled = false
	end
end)

script.Parent.Parent.Func_End.Event:Connect(function()
	script.Parent.Parent.Door.Knock:Play()
	game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 18, 0, 0.7)
	script.Parent.Parent.Door.ParticleEmitter.Enabled = true
	wait(0.1)
	script.Parent.Parent.Door.ParticleEmitter.Enabled = false

	wait(1.1)

	script.Parent.Parent.Door.Knock:Play()
	game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 18, 0, 0.7)
	script.Parent.Parent.Door.ParticleEmitter.Enabled = true
	wait(0.1)
	script.Parent.Parent.Door.ParticleEmitter.Enabled = false

	wait(1.1)

	script.Parent.Parent.Door.Knock:Play()
	game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 18, 0, 0.7)
	script.Parent.Parent.Door.ParticleEmitter.Enabled = true
	wait(0.1)
	script.Parent.Parent.Door.ParticleEmitter.Enabled = false
end)