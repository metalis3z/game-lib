local part = script.Parent

local disappearTime = 0.2 -- temps avant de disparaître
local respawnTime = 1 -- temps avant de revenir

part.Touched:Connect(function(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")

	if humanoid then
		humanoid.Health = 0

		part.Transparency = 1
		part.CanCollide = false

		task.wait(respawnTime)

		part.Transparency = 0
		part.CanCollide = true
	end
end)