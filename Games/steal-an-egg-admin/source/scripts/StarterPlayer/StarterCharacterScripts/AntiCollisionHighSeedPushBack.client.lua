-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Parent = script.Parent
local Humanoid = Parent:WaitForChild("Humanoid")
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
Humanoid.AutoJumpEnabled = false

local HumanoidRootPart = Parent:WaitForChild("HumanoidRootPart")
local v1 = RunService.PostSimulation:Connect(function(v2) -- line 13 | captures: Humanoid, HumanoidRootPart
    local v3 = Humanoid:GetState()
    if v3 == Enum.HumanoidStateType.Running then
        if Humanoid.WalkSpeed >= 50 and HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 10 then
            local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
            local v4 = -50 * v2
            HumanoidRootPart.AssemblyLinearVelocity = AssemblyLinearVelocity + Vector3.new(0, v4, 0)
        end
    elseif v3 == Enum.HumanoidStateType.RunningNoPhysics and Humanoid.WalkSpeed >= 50 and HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 10 then
        local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
        local v5 = -50 * v2
        HumanoidRootPart.AssemblyLinearVelocity = AssemblyLinearVelocity + Vector3.new(0, v5, 0)
    end
end)
Humanoid.Died:Connect(function() -- line 23 | captures: v1
    v1:Disconnect()
end)
