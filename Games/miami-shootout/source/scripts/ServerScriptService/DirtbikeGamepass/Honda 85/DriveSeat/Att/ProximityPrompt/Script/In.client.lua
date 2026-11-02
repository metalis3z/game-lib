
local Player = game.Players.LocalPlayer

wait(0.2)
game.Workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid







Player.Character.Humanoid:UnequipTools()

local Gas =	Player.Character:FindFirstChild("Humanoid"):LoadAnimation(script.Gas)


while wait()do	
		
	if script.Audio.Value.Parent.Throttle == 1 then	
	
			Gas:Play()
			
		
		
	elseif script.Audio.Value.Parent.Throttle == 0 then
		Gas:Stop()
	end														
end


Player.PlayerGui:FindFirstChild("Out").Exit.TextButton.MouseButton1Click:Connect(function()

	Gas:Stop() 


end)