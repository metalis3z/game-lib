
local Lighting = game:GetService("Lighting")
local mapLighting = Lighting:WaitForChild("Lighting", 12)
local Flash = game:GetService("ReplicatedStorage"):WaitForChild("VFX"):WaitForChild("Flash"):Clone()
Flash.Color = Color3.fromRGB(255, 0, 4)
Flash.Transparency = 1
Flash.Parent = script.Parent
task.wait(4)
local v4 = {
	Ambient = Color3.fromRGB(207, 0, 3),
	ColorShift_Top = Color3.fromRGB(203, 0, 0),
	OutdoorAmbient = Color3.fromRGB(126, 0, 0)
}
local Atmosphere = Lighting:WaitForChild("Atmosphere", 2)
local v6 = {Decay = Atmosphere and Atmosphere.Decay or Atmosphere}
local v8 = {
	Density = 0.325,
	Offset = 0.821,
	Color = Color3.fromRGB(255, 21, 25),
	Decay = Color3.fromRGB(176, 18, 18)
}
local v9 = {
	Ambient = mapLighting and mapLighting:WaitForChild("Ambient", 2) and mapLighting.Ambient.Value or Lighting.Ambient,
	ColorShift_Top = mapLighting and mapLighting:WaitForChild("ColorShift_Top", 2) and mapLighting.ColorShift_Top.Value or Lighting.ColorShift_Top,
	OutdoorAmbient = mapLighting and (mapLighting:WaitForChild("OutdoorAmbient", 2) and mapLighting.OutdoorAmbient.Value) or Lighting.OutdoorAmbient
}

while task.wait(0.5) do
    if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") ~= "Lobby" then
		local skyFade = math.clamp(workspace.GAME.TIMER.Value / 390, 0, 1)
		--warn(skyFade)
		
		Flash.Transparency = 1 - skyFade / 2
		
        Lighting.Ambient = v9.Ambient:Lerp(v4.Ambient, skyFade)
        Lighting.ColorShift_Top = v9.ColorShift_Top:Lerp(v4.ColorShift_Top, skyFade)
		Lighting.OutdoorAmbient = v9.OutdoorAmbient:Lerp(v4.OutdoorAmbient, skyFade)
		
        if Atmosphere and v6.Decay then
            Atmosphere.Decay = v6.Decay:Lerp(v8.Decay, skyFade)
		end
		
        if Atmosphere and v6.Color then
            Atmosphere.Color = v6.Color:Lerp(v8.Color, skyFade)
		end
		
        if Atmosphere and v6.Density then
            Atmosphere.Density = v6.Density:Lerp(v8.Density, skyFade)
		end
		
        if Atmosphere and v6.Offset then
            Atmosphere.Offset = v6.Offset:Lerp(v8.Offset, skyFade)
        end
    end
end
