local map = workspace.Multiplayer:WaitForChild("Map")
local player = game.Players.LocalPlayer
local hum = player.Character:WaitForChild("Humanoid")

function exproshun()
	spawn(function()
		local duration = 2
		local intensity = 0.1
		local snd = Instance.new("Sound")
		local vol = .75
		snd.SoundId = "rbxassetid://153274423"
		snd.Pitch = math.random(90,110) * .01
		snd.Volume = vol
		snd.Parent = script
		game.Debris:AddItem(snd, 3)
		snd:Play()
		local fin = tick() + duration
		while game:GetService("RunService").RenderStepped:wait() and (fin-tick() > 0) and hum.Health > 0 do
			snd.Volume = vol * (fin-tick())
			hum.CameraOffset = Vector3.new( ((math.random(-5,5)*.05) * (fin-tick())),
				((math.random(-5,5)*.05) * (fin-tick())),
				((math.random(-5,5)*.05) * (fin-tick()))
			)
		end
	end)
end

hum.Died:connect(function() hum.CameraOffset = Vector3.new() end)

spawn(function()
   while task.wait(6) do exproshun() end
end)

spawn(function()
	task.wait(1)
	task.wait(23)
	task.wait(5)
	task.wait(7.5)
	task.wait(8)
	task.wait(22)
	task.wait(14)
	task.wait(7)
	task.wait(1.83)
	task.wait(5.25)
	task.wait(1.75)
	task.wait(0.25)
	task.wait(5)
	do exproshun() task.wait(7.5) end
end)
