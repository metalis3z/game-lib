local button = script.Parent:WaitForChild("ToggleButton")

-- Tracks which lights we turned shadows OFF on, so we can restore them.
local toggledLights = {}
local shadowsOff = false

-- Gather every light in the game that can cast shadows
local function getAllLights()
	local lights = {}
	for _, desc in game:GetDescendants() do
		if desc:IsA("PointLight") or desc:IsA("SpotLight") or desc:IsA("SurfaceLight") then
			table.insert(lights, desc)
		end
	end
	return lights
end

-- Turn shadows back ON for the lights we previously disabled
local function restoreShadows()
	for light in pairs(toggledLights) do
		if light and light.Parent then
			light.Shadows = true
		end
	end
	toggledLights = {}
	button.Text = "Shadows: ON"
end

-- Turn shadows OFF for every shadowcasting light
local function disableShadows()
	for _, light in getAllLights() do
		if light.Shadows then
			light.Shadows = false
			toggledLights[light] = true
		end
	end
	button.Text = "Shadows: OFF"
end

button.Activated:Connect(function()
	if shadowsOff then
		restoreShadows()
	else
		disableShadows()
	end
	shadowsOff = not shadowsOff
end)