local p1 = require(script.Parent.Parent.Parent.Parent)

local PrimaryDoor = game.Workspace:FindFirstChild("DoorEnd_1", true)

script.Parent.Event.Event:Connect(function()
	print("DDDDDDDDDDD")

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
end)