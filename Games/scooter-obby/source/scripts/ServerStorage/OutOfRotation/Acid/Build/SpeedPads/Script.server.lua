local debounce = script.Parent:WaitForChild("Debounce")
local player = game.Players.LocalPlayer

for i, v in pairs(script.Parent:GetChildren()) do
	if v:IsA("Model") and v.Name == "SpeedPad" then
		local collider = v:WaitForChild("Collider")
		collider.Touched:Connect(function(otherPart)
			if otherPart.Parent == workspace.Ignore and not debounce.Value and otherPart.Name == player.Name then
				game.ReplicatedStorage.SpeedTimer.Value = 5
				otherPart.Velocity += -collider.CFrame.LookVector * 70
				for i, v in pairs(script.Parent:GetChildren()) do
					if v:IsA("Model") and v.Name == "SpeedPad" then
						v.ParticleHost.ParticleEmitter:Emit(1)
					end
				end
				debounce.Value = true
				wait(.5)
				debounce.Value = false
			end
		end)
	end
end