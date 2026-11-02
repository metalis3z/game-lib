local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MutatorsFolder = ReplicatedStorage:WaitForChild("Mutators")
local Seconds = ReplicatedStorage:WaitForChild("Seconds")
local Tower = game.Workspace:WaitForChild("Tower")

Seconds.Changed:Connect(function()
	for i, v in pairs(Tower:GetDescendants()) do
		if v:IsA("BoolValue") and v.Name == "kills" then
			if MutatorsFolder.Invincibility.Value == false then
				v.Parent.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") then
						hit.Parent.Humanoid.MaxHealth = 0
						hit.Parent.Humanoid.Health = 0
					end
				end)
			end
		end
	end
end)