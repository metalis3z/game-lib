-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
return {
    ["Activate"] = function(p2)
        local _, v3, v4 = unpack(p2)
        local Humanoid = v3:FindFirstChildOfClass("Humanoid")
        local v6 = Humanoid:LoadAnimation(v4)
        v6.Priority = Enum.AnimationPriority.Action4
        v6:Play()
        local v7 = {
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
        local Default = v7.Default
        for v9, v10 in next, v7 do
            if v9 ~= "Default" and table.find(v10, Humanoid.FloorMaterial) then
                Default = v9
                break
            end
        end
        local v11 = script.Materials[Default]
        local v12 = v11["0"]:Clone()
        v12.Parent = v3.RootPart
        local v13 = v11["1"]:Clone()
        v13.Parent = v3.RootPart
        local v14 = v11["2"]:Clone()
        v14.Parent = v3.RootPart
        m_EffectUtility.EmitAttachment(v14)
        m_EffectUtility.TweenBeamTransparency(v14, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
        v6.Stopped:Wait()
        task.delay(2, v12.Destroy, v12)
        task.delay(2, v13.Destroy, v13)
        task.delay(2, v14.Destroy, v14)
    end
}
