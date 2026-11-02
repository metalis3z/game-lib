local button = script.Parent
local Lighting = game:GetService("Lighting")
local SkyId = "rbxassetid://158118263"

local isSkyboxCreated = false  -- Track whether the custom skybox has been created

local function changeSky()
	if isSkyboxCreated then
		print("Custom sky already exists!")
		return
	end

	local customSky = Instance.new("Sky")
	customSky.SkyboxBk = SkyId
	customSky.SkyboxDn = SkyId
	customSky.SkyboxFt = SkyId
	customSky.SkyboxLf = SkyId
	customSky.SkyboxRt = SkyId
	customSky.SkyboxUp = SkyId
	customSky.CelestialBodiesShown = false
	customSky.Parent = Lighting

	isSkyboxCreated = true  -- Update the flag to indicate that the skybox has been created
end

button.MouseButton1Click:Connect(changeSky)
