local debounce = script.Parent:WaitForChild("Debounce")
local player = game.Players.LocalPlayer

for i, v in pairs(script.Parent:GetChildren()) do
	if v:IsA("Model") and v.Name == "BouncePad" then
		local collider = v:WaitForChild("Collider")
		collider.Touched:Connect(function(otherPart)
			if otherPart.Parent == workspace.Ignore and not debounce.Value and otherPart.Name == player.Name then
				otherPart.Velocity = Vector3.new(otherPart.Velocity.X,0,otherPart.Velocity.Z)
				otherPart.Velocity += Vector3.new(0,120,0)
				script.Sound:Play()
				task.wait(0.05)
				otherPart:FindFirstChild("WindForce").Force = Vector3.new(0,0,0)
				for i, v in pairs(script.Parent:GetChildren()) do
					if v:IsA("Model") and v.Name == "BouncePad" then
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