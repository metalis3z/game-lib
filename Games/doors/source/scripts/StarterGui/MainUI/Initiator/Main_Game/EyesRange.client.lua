local Player = game.Players.LocalPlayer

local v1 = Player:GetMouse()
local v2 = false

while true do
	wait()
	if v1.Target ~= nil then
		if v1.Target.Parent:FindFirstChild("Range") then
			if v2 == false then
				v2 = true
				if Player.Character:GetAttribute("CrucifixEnabled", true) then
					game.ReplicatedStorage.ClientBricks.Entities.EyesCrucifix:FireServer(game.Workspace:FindFirstChild("EffectsLookman", true))
					game.Workspace:FindFirstChild("EffectsLookman", true).Parent.Range.Name = "Crucifixed"
				else
					if Player.Character:FindFirstChild("Humanoid").Health > 0 then
						if game.Workspace:FindFirstChild("EffectsLookman", true) then
							if game.Workspace:FindFirstChild("EffectsLookman", true).Attack.IsPlaying == false then
								game.Workspace:FindFirstChild("EffectsLookman", true).Attack:Play()
							end
						end
						if Player.Character:WaitForChild("Humanoid").Health > -1 then
							game.ReplicatedStorage.EntityInfo.EyesLook:FireServer()
							game.ReplicatedStorage.EntityInfo.SetEyesDeath:FireServer()
							game.ReplicatedStorage.Bricks.FireCamera:FireServer(12, 26, 0, 0.7)
						end
						wait(0.3)
						v2 = false
					else
						return
					end
				end
			end
		end
	end
end