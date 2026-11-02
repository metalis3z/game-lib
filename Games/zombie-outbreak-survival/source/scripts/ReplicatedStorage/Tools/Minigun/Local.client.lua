local plr = game.Players.LocalPlayer
local tool = script.Parent
local remote = tool:WaitForChild("Remote")
local mouse = plr:GetMouse()
local shooting = false

mouse.Button1Down:Connect(function()
    shooting = true
end)

mouse.Button1Up:Connect(function()
    shooting = false
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if shooting then
        if tool.Parent == plr.Character then
            if mouse.Hit and mouse.Target ~= plr.Character then
                remote:FireServer(mouse.Hit.p)
            end
        end
    end
end)