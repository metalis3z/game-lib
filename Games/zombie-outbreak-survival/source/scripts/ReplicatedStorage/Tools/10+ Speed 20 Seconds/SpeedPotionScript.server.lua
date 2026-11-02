local tool = script.Parent

tool.Activated:Connect(function()
    local player = game.Players:GetPlayerFromCharacter(tool.Parent)
    if not player then return end

    local character = tool.Parent
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local originalSpeed = humanoid.WalkSpeed
    local speedBoost = 25
    local duration = 20

    humanoid.WalkSpeed = speedBoost

    tool:Destroy()

    task.spawn(function()
        task.wait(duration)
        -- Only reset speed if the humanoid still exists and hasn't been changed by another effect
        if humanoid and humanoid.Parent and humanoid.WalkSpeed == speedBoost then
            humanoid.WalkSpeed = originalSpeed
        end
    end)
end)

