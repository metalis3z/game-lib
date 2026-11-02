local On = true
local Cooldown = false
local Humanoid = game.Players.LocalPlayer.Character:WaitForChild('Humanoid')
local specialanim= Humanoid:LoadAnimation(script.Parent:WaitForChild("special"))
specialanim:AdjustSpeed(3)

script.Parent.Activated:Connect(function(Player)
	if Cooldown then return end
	Cooldown = true
	specialanim:Play()
	task.wait(.6)
	script.Parent.RemoteEvent:FireServer(On, Humanoid)
	On = not On
	task.wait(1)
	Cooldown = false
end)