local part = workspace.TeleportPart -- Name of part you want to teleport to
local plr = game.Players.LocalPlayer

script.Parent.MouseButton1Click:Connect(function()
    local humanoidrootpart = plr.Character:FindFirstChild("HumanoidRootPart")
     if humanoidrootpart then
        humanoidrootpart.CFrame = CFrame.new(part.CFrame.p) + Vector3.new(0,5,0)
    end
end)

