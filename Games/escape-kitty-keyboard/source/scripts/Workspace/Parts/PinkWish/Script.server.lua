local part = script.Parent

local hiddenTime = 2
local visibleTime = 2

local active = false

part.Touched:Connect(function(hit)
	if not active then return end

	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health = 0
	end
end)

while true do
	-- Cachée
	active = false
	part.Transparency = 1
	part.CanCollide = false
	task.wait(hiddenTime)

	-- Visible
	active = true
	part.Transparency = 0
	part.CanCollide = true
	task.wait(visibleTime)
end