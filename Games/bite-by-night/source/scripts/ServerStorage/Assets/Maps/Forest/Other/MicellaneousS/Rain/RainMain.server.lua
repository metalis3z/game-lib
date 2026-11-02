
game:GetService("RunService").PreRender:Connect(function()
    if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") ~= "Lobby" then
        script.Parent.Position = workspace.CurrentCamera.CFrame.Position
    end
end)