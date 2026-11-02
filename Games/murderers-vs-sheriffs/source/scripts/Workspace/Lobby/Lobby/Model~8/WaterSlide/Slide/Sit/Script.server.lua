local part = script.Parent
local cooldown = {}

part.Touched:Connect(function(hit)
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	if cooldown[character] then return end
	cooldown[character] = true

	humanoid.Sit = true

	task.delay(1, function()
		cooldown[character] = nil
	end)
end)