local TweenService = game:GetService("TweenService")

local pink = workspace:WaitForChild("PinkPart")
local white = workspace:WaitForChild("WhitePart")

local growTime = 0.15 -- agrandissement rapide
local stayTime = 1.5 -- temps où elles restent grandes
local shrinkTime = 1.5 -- retour lent
local cooldown = 3 -- temps entre chaque activation

local sizes = {
	PinkPart = Vector3.new(0.001, 59, 214.839),
	WhitePart = Vector3.new(0.001, 59, 219.296)
}

local parts = {
	{part = pink, size = sizes.PinkPart},
	{part = white, size = sizes.WhitePart}
}

for _, data in pairs(parts) do
	local part = data.part

	part.Anchored = true

	local originalSize = part.Size
	local originalCFrame = part.CFrame

	part.Touched:Connect(function(hit)
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.Health = 0
		end
	end)

	data.originalSize = originalSize
	data.originalCFrame = originalCFrame
end

while true do
	task.wait(cooldown)

	-- Agrandissement rapide
	for _, data in pairs(parts) do
		TweenService:Create(
			data.part,
			TweenInfo.new(growTime, Enum.EasingStyle.Linear),
			{
				Size = data.size
			}
		):Play()
	end

	task.wait(stayTime)

	-- Réduction lente
	for _, data in pairs(parts) do
		TweenService:Create(
			data.part,
			TweenInfo.new(shrinkTime, Enum.EasingStyle.Linear),
			{
				Size = data.originalSize,
				CFrame = data.originalCFrame
			}
		):Play()
	end
end