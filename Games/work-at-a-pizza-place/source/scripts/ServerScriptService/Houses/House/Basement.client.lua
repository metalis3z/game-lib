local originalTransparency = workspace.BasePlate.Texture.Transparency --UPDATECHANGE
for _,part in ipairs(workspace:GetChildren()) do
	if part.Name == "BasePlate" then
		part.Texture.Transparency = 1  
		part.Transparency = 1
		part.CanCollide = false
	end
end
if workspace:FindFirstChild("OceanWater") then
	workspace.OceanWater.Transparency = 1
end


while script.Parent.HumanoidRootPart.Position.Y < 6.5 and script.Parent.Humanoid.Health > 0 do
	wait(.5)
end




for _,part in ipairs(workspace:GetChildren()) do
	if part.Name == "BasePlate" then
		part.Texture.Transparency = originalTransparency
		part.Transparency = 0
		part.CanCollide = true
	end
end
if workspace:FindFirstChild("OceanWater") then
	workspace.OceanWater.Transparency = 0
end

wait()
script:Destroy()