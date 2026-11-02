local On = false
local Cooldown = false
local Humanoid = game.Players.LocalPlayer.Character:WaitForChild('Humanoid')
local specialanim= Humanoid:LoadAnimation(script.Parent:WaitForChild("special"))

script.Parent.Activated:Connect(function(Player)
	if Cooldown then return end
	Cooldown = true
	specialanim:Play()
	task.wait(.3)
	On = not On
	script.Parent.RemoteEvent:FireServer(On, Humanoid)
	if On then
		script.Parent.Name = 'MASKED'
	else
		script.Parent.Name = 'Balaclava'
	end
	task.wait(1)
	Cooldown = false
end)