return function(p1)
	wait(8.7)
	
	local PrimaryDoor = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3).DoorEnd_1
	
	PrimaryDoor.Door.Knock:Play()
	p1.camShaker:ShakeOnce(3, 18, 0, 0.7);
	PrimaryDoor.Door.ParticleEmitter.Enabled = true
	task.wait(0.1)
	PrimaryDoor.Door.ParticleEmitter.Enabled = false

	task.wait(1.1)
	PrimaryDoor.Door.Growl:Play()
	--require(game.ServerScriptService.Game.Directory.MainSound):play(PrimaryDoor.CFrame, "rbxassetid://2118376406", 0.5)
	PrimaryDoor.Door.Knock:Play()
	p1.camShaker:ShakeOnce(3, 18, 0, 0.7);
	PrimaryDoor.Door.ParticleEmitter.Enabled = true
	task.wait(0.1)
	PrimaryDoor.Door.ParticleEmitter.Enabled = false

	task.wait(1.1)

	PrimaryDoor.Door.Knock:Play()
	p1.camShaker:ShakeOnce(3, 18, 0, 0.7);
	PrimaryDoor.Door.ParticleEmitter.Enabled = true
	task.wait(0.1)
	PrimaryDoor.Door.ParticleEmitter.Enabled = false
	
end;