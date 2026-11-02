local Stage4 = workspace:WaitForChild("Map")
	:WaitForChild("ObbyStuff")
	:WaitForChild("Stage4")

local TitleLabel = Stage4.Timer.GUI.Timer.Title
local ColorLabel = TitleLabel.Color

local OriginalTransparency = {}
local Platforms = {}

-- Find all platform models and save original transparency
for _, Child in ipairs(Stage4:GetChildren()) do
	if Child:IsA("Model") then
		table.insert(Platforms, Child)

		for _, Descendant in ipairs(Child:GetDescendants()) do
			if Descendant:IsA("BasePart") then
				OriginalTransparency[Descendant] = Descendant.Transparency
			end
		end
	end
end

while true do
	-- Countdown 3 -> 0
	for i = 3, 0, -1 do
		local Text = tostring(i)

		TitleLabel.Text = Text
		ColorLabel.Text = Text

		task.wait(1)
	end

	-- Hide all platforms
	for _, Platform in ipairs(Platforms) do
		for _, Part in ipairs(Platform:GetDescendants()) do
			if Part:IsA("BasePart") then
				Part.Transparency = 1
				Part.CanCollide = false
			end
		end
	end

	TitleLabel.Text = "GO!"
	ColorLabel.Text = "GO!"

	task.wait(3)

	-- Show all platforms again
	for _, Platform in ipairs(Platforms) do
		for _, Part in ipairs(Platform:GetDescendants()) do
			if Part:IsA("BasePart") then
				Part.Transparency = OriginalTransparency[Part] or 0
				Part.CanCollide = true
			end
		end
	end

	TitleLabel.Text = "3"
	ColorLabel.Text = "3"

	task.wait(0.1)
end