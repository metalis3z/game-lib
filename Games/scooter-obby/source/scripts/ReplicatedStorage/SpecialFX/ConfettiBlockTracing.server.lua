local runs = game:GetService('RunService')
local block = script.Parent.ConfettiBlock:Clone()
block.Parent = workspace.CurrentCamera
local camera = workspace.CurrentCamera

runs.RenderStepped:Connect(function(dt)
	block.Position = camera.CFrame.p + camera.CFrame.LookVector * 3
end)

script.Parent.TriggerConfetti.OnClientEvent:Connect(function()
	script.Parent.Parent.Sounds.Confetti:Play()
	for i = 1, 1 do
		block.Confetti1:Emit(10)
		block.Confetti2:Emit(10)
		block.Confetti3:Emit(10)
		block.Confetti4:Emit(10)
		block.Confetti5:Emit(10)
		block.Confetti6:Emit(10)
		wait(0.5)
	end
end)