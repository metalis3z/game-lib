local Music = game.SoundService.Main:WaitForChild("ChaseInSession")
local l__TweenService__1 = game:GetService("TweenService");

Music.TimePosition = 92.5
script.Parent.Parent.Door.LightAttach:Destroy()
game.ReplicatedStorage.Bricks.ChangeModuleVariable:FireAllClients("hideplayers", 0)
game.ReplicatedStorage.Bricks.ChangeModuleVariable:FireAllClients("chase", false)
script.Parent.CanTouch = false
	if v.Character then
for i, v in pairs(game.Players:GetPlayers()) do
		if v.Character:FindFirstChild("Humanoid") then
			v.Character.Humanoid:SetAttribute("SpeedBoostBehind", 0)
			v.Character.Humanoid:SetAttribute("SpeedBoost", 0)
			v.Character.Humanoid:SetAttribute("SpeedBoostExtra", 0)
		end
	end ---0.05
end
while true do
	wait(0.1)
	if game.ReplicatedStorage.GameData.SeekInLastHallway.Value == true then
		l__TweenService__1:Create(game:GetService("Lighting").Sanity, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			Brightness = -0.1
		}):Play();
		wait(0.1)
		l__TweenService__1:Create(game:GetService("Lighting").Sanity, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			Brightness = 0
		}):Play();
		wait(5.5)
		script.Parent.Parent.HingeConstraint.ServoMaxTorque = 7000
		script.Parent.Parent.HingeConstraint.TargetAngle = 0
		wait(3)
		script.Parent.Parent.Door.Anchored = true
		--script.Parent.Parent.HingeConstraint:Destroy()
		script.Parent.Parent.Door.CanCollide = true
		l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			Ambient = Color3.new(0, 0, 0)
		}):Play();
		wait(3)
		game.Workspace.SeekMoving:Destroy()
	end
end