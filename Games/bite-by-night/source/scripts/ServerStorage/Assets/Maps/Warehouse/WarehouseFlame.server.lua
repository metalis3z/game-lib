
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

task.wait(10)
RunService.Heartbeat:Connect(function(deltaTime)
    local atmosphere = game:GetService("Players").LocalPlayer:GetAttribute("TEAM") ~= "Lobby" and (workspace.GAME.TIMER.Value >= 360 and Lighting:FindFirstChild("Atmosphere"))
    if atmosphere then
		atmosphere.Density = atmosphere.Density + (0.676 - atmosphere.Density) * deltaTime
		atmosphere.Offset = atmosphere.Offset + (0.027 - atmosphere.Offset) * deltaTime
		atmosphere.Color = atmosphere.Color:Lerp(Color3.fromRGB(157, 0, 0), deltaTime)
		atmosphere.Decay = atmosphere.Decay:Lerp(Color3.fromRGB(125, 0, 0), deltaTime)
		atmosphere.Glare = atmosphere.Glare + (1.89 - atmosphere.Glare) * deltaTime
		atmosphere.Haze = atmosphere.Haze + (1.39 - atmosphere.Haze) * deltaTime
    end
end)