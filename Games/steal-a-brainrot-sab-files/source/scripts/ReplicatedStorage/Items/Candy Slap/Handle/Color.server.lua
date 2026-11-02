local l_SurfaceAppearance_0 = script.Parent:FindFirstChildOfClass("SurfaceAppearance")
local tool = script:FindFirstAncestorOfClass("Tool")

local color1 = Color3.fromRGB(255, 0, 136)
local color2 = Color3.fromRGB(255, 53, 178)
local timeCounter = 0
local running = false

local function startPulsing()
	if running then return end
	running = true

	task.spawn(function()
		while running and l_SurfaceAppearance_0 do
			timeCounter = timeCounter + 0.05
			local alpha = (math.sin(timeCounter * 3) + 1) / 2
			l_SurfaceAppearance_0.Color = color1:Lerp(color2, alpha)

			task.wait(0.02)
		end
	end)
end

local function stopPulsing()
	running = false
end

tool.Equipped:Connect(startPulsing)
tool.Unequipped:Connect(stopPulsing)

tool.AncestryChanged:Connect(function()
	if tool:IsDescendantOf(workspace) then
		startPulsing()
	else
		stopPulsing()
	end
end)

if tool:IsDescendantOf(workspace) then
	startPulsing()
end