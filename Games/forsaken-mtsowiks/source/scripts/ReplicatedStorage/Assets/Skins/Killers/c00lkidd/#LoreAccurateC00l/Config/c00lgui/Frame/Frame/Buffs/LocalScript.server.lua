local player = script.Parent.Parent.Parent.Parent.Parent.Parent
local button = script.Parent

local speedMultiplier = 2 -- Change this value to adjust the speed increase

button.MouseButton1Click:Connect(function()
	-- Check if the player's character exists and is humanoid
	local character = player.Character
	if character and character:FindFirstChild("Humanoid") then
		local humanoid = character.Humanoid

		-- Increase the player's speed
		require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(player, "Speed", {
			Level = 4, 
			Duration = 9999999
		});
		require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(player, "Strength", {
			Level = 20, 
			Duration = 9999999
		});
	end
end)
