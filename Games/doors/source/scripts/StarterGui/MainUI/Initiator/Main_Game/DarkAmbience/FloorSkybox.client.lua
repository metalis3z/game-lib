local player = game.Players.LocalPlayer

if player then
	if player.PlayerStats then
		if player.PlayerStats.TypeRun.Value == "Hunt" then
			local sb = script.SkyboxPart:Clone()
			
			sb.Parent = game.Workspace.CurrentCamera
			
			for i, v in pairs(script:GetChildren()) do
				if v:IsA("ParticleEmitter") then
					v.Parent = sb
				end
				if v:IsA("Light") then
					v.Parent = sb
				end
			end
			
			game.Workspace.CurrentRooms.CurrentRoom.Changed:Connect(function()
				local PlayerRoom = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)

				if PlayerRoom then
					sb:PivotTo(PlayerRoom.RoomEntrance.CFrame)
				end
			end)
		end
	end
end