local tool = script.Parent

tool.Activated:Connect(function()
    local player = game.Players:GetPlayerFromCharacter(tool.Parent)
    if not player then return end

    local character = tool.Parent
    if not character then return end

    -- Check if character already has a ForceField
    if character:FindFirstChildOfClass("ForceField") then
        return
    end

    -- Create and parent the ForceField
    local forcefield = Instance.new("ForceField")
    forcefield.Parent = character

    tool:Destroy()

    task.spawn(function()
        task.wait(20)
        if forcefield and forcefield.Parent then
            forcefield:Destroy()
        end
    end)
end)

