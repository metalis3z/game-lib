local part = script.Parent
local terrain = workspace.Terrain

-- Force la couleur et la transparence de l'eau
terrain.WaterColor = Color3.fromRGB(255, 0, 255) -- rose
terrain.WaterTransparency = 0.5
terrain.WaterReflectance = 0.1
terrain.WaterWaveSize = 0.2
terrain.WaterWaveSpeed = 10

-- Crée la vraie eau
terrain:FillBlock(part.CFrame, part.Size, Enum.Material.Water)

-- Supprime la Part de base
task.wait(0.1)
part:Destroy()