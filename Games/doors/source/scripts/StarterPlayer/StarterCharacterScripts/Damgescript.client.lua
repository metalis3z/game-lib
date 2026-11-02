local mosue = game.Players.LocalPlayer:GetMouse()

while wait() do
	wait(1)
	--If You Change The Eye Like Add It In another folder make sure to change the script below
	if (mosue.Hit.Position - workspace.Eye.PrimaryPart.LookDetector.CFrame.Position).Magnitude < 7 then
		script.RemoteEvent:FireServer()
		game.Workspace.EyeHallway.Eye.Attack.Attack:Play()
	end
end