
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

while task.wait(math.random(20, 40)) do
	for num = 1, math.random(1, 3) do
		local Flash = script.Flash.Value
		Flash.Transparency = 0
		Flash.Highlight.FillTransparency = 0
		Lighting.ExposureCompensation = 3
		TweenService:Create(Flash.Highlight, TweenInfo.new(0.5), {FillTransparency = 1}):Play()
		TweenService:Create(Lighting, TweenInfo.new(0.5), {ExposureCompensation = 0}):Play()
		task.delay(0.5, function()
			TweenService:Create(Flash, TweenInfo.new(0.5), {Transparency = 1}):Play()
		end)
		task.wait(Random.new():NextNumber(0.05, 0.3))
	end
	task.delay(1, function()
		script.Parent.Thunder.ThunderSFX:Play()
	end)
end
