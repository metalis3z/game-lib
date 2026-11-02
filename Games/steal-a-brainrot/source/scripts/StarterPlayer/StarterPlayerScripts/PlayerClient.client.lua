local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local Player = Players.LocalPlayer

local function onCharacterAdded(character)
	local Humanoid = character:WaitForChild("Humanoid")
	task.wait(0.5)
	ProximityPromptService.Enabled = true

	-- Re-enable si Health remonte (après ragdoll/hit)
	Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		if Humanoid.Health > 0 and not ProximityPromptService.Enabled then
			ProximityPromptService.Enabled = true
		end
	end)

	Humanoid.Died:Connect(function()
		ProximityPromptService.Enabled = false
	end)
end

Player.CharacterAdded:Connect(onCharacterAdded)
if Player.Character then
	onCharacterAdded(Player.Character)
end
