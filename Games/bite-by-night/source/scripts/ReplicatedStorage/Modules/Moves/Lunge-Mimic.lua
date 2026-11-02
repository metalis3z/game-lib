-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
return {
    ["Activate"] = function(p2)
        local v3, v_u_4, v5 = unpack(p2)
        local Humanoid = v_u_4:FindFirstChildOfClass("Humanoid")
        local v_u_7 = Humanoid:LoadAnimation(v5)
        v_u_7.Priority = Enum.AnimationPriority.Action4
        v_u_7:Play()
        local v8 = {
            ["Default"] = "Concrete",
            ["Concrete"] = {},
            ["Metal"] = {
                Enum.Material.Metal,
                Enum.Material.DiamondPlate,
                Enum.Material.CorrodedMetal,
                Enum.Material.Foil,
                Enum.Material.CeramicTiles
            },
            ["Dirt"] = {
                Enum.Material.Grass,
                Enum.Material.Ground,
                Enum.Material.Ice,
                Enum.Material.LeafyGrass,
                Enum.Material.Mud,
                Enum.Material.Snow,
                Enum.Material.Sand
            }
        }
        local Default = v8.Default
        for v10, v11 in next, v8 do
            if v10 ~= "Default" and table.find(v11, Humanoid.FloorMaterial) then
                Default = v10
                break
            end
        end
        local v12 = script.Materials[Default]
        local v_u_13 = v12["0"]:Clone()
        v_u_13.Parent = v_u_4.RootPart
        local v_u_14 = v12["1"]:Clone()
        v_u_14.Parent = v_u_4.RootPart
        local v15 = v12["2"]:Clone()
        v15.Parent = v_u_4.RootPart
        local v_u_16 = script.pre1:Clone()
        v_u_16.Parent = v_u_4.RootPart
        task.delay(8, v_u_16.Destroy, v_u_16)
        task.delay(8, v_u_13.Destroy, v_u_13)
        task.delay(8, v_u_14.Destroy, v_u_14)
        task.delay(8, v15.Destroy, v15)
        local v17 = {}
        if v3 == game:GetService("Players").LocalPlayer then
            for _, v18 in workspace:GetDescendants() do
                if v18:IsA("BasePart") and (v18.Transparency >= 1 or v18:HasTag("Barrier")) and (not v18:HasTag("TRUE_BARRIER") and (v18.CanCollide and not v_u_4:IsAncestorOf(v18))) then
                    v18.CanCollide = false
                    table.insert(v17, v18)
                end
            end
        end
        local v20 = v_u_4.ChildAdded:Connect(function(p19)
            if p19:IsA("NumberValue") and p19.Name == "Hit" then
                v_u_7:Stop()
            end
        end)
        v_u_7:GetMarkerReachedSignal("StepEffect"):Once(function()
            m_EffectUtility.EmitAttachment(v_u_13)
        end)
        v_u_7:GetMarkerReachedSignal("Jump"):Once(function()
            m_EffectUtility.EmitAttachment(v_u_14)
        end)
        v_u_7:GetMarkerReachedSignal("DashEffect"):Once(function()
            repeat
                local AssemblyLinearVelocity = v_u_4.HumanoidRootPart.AssemblyLinearVelocity
                local v22 = v_u_4.HumanoidRootPart.Position + AssemblyLinearVelocity
                v_u_16.CFrame = CFrame.new(v_u_4.HumanoidRootPart.Position, v22)
                m_EffectUtility.EmitAttachment(v_u_16)
                m_EffectUtility.ToggleAttachment(v_u_16, true)
                task.wait(0.25)
            until Humanoid.AutoRotate == true
            m_EffectUtility.ToggleAttachment(v_u_16, false)
            v_u_7:Stop()
        end)
        v_u_7.Stopped:Wait()
        v20:Disconnect()
        for _, v23 in v17 do
            v23.CanCollide = true
        end
        task.delay(2, v_u_16.Destroy, v_u_16)
        task.delay(2, v_u_13.Destroy, v_u_13)
        task.delay(2, v_u_14.Destroy, v_u_14)
        task.delay(2, v15.Destroy, v15)
    end
}
