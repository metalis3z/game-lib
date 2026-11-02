-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

if script.Parent:WaitForChild("Humanoid", 10) then
    local Humanoid = script.Parent:FindFirstChildOfClass("Humanoid")
    local v_u_2 = 0
    Humanoid:WaitForChild("Animator").AnimationPlayed:Connect(function(p3)
        local v_u_10 = p3:GetMarkerReachedSignal("Step"):Connect(function()
            if script.Parent:HasTag("TRUE_UNDETECTABLE") then
                return
            elseif script.Parent:HasTag("UNDETECTABLE") then
                if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial ~= Enum.Material.Air then
                    if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Carpet then
                        local v_u_4 = script.StepsHidden:FindFirstChild("carpet"):GetChildren()[math.random(1, #script.StepsHidden:FindFirstChild("carpet"):GetChildren())]:Clone()
                        v_u_4.Parent = script.Parent:FindFirstChild("RootPart")
                        v_u_4.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        if not v_u_4.IsLoaded then
                            v_u_4.Loaded:Wait()
                        end
                        v_u_4:Play()
                        task.wait(0.1)
                        task.delay(v_u_4.TimeLength, function()
                            v_u_4:Destroy()
                        end)
                        return
                    end
                    if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Foil then
                        local v_u_5 = script.StepsHidden:FindFirstChild("inflatable"):GetChildren()[math.random(1, #script.StepsHidden:FindFirstChild("inflatable"):GetChildren())]:Clone()
                        v_u_5.Parent = script.Parent:FindFirstChild("RootPart")
                        v_u_5.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        if not v_u_5.IsLoaded then
                            v_u_5.Loaded:Wait()
                        end
                        v_u_5:Play()
                        task.wait(0.1)
                        task.delay(v_u_5.TimeLength, function()
                            v_u_5:Destroy()
                        end)
                        return
                    end
                    if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.DiamondPlate or (script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Metal or script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.CorrodedMetal) then
                        local v_u_6 = script.StepsHidden:FindFirstChild("metal"):GetChildren()[math.random(1, #script.StepsHidden:FindFirstChild("metal"):GetChildren())]:Clone()
                        v_u_6.Parent = script.Parent:FindFirstChild("Torso")
                        v_u_6.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        if script.Parent:GetAttribute("Crouching") == true then
                            v_u_6.Volume = v_u_6.Volume / 2
                        end
                        if not v_u_6.IsLoaded then
                            v_u_6.Loaded:Wait()
                        end
                        v_u_6:Play()
                        task.wait(0.1)
                        task.delay(v_u_6.TimeLength, function()
                            v_u_6:Destroy()
                        end)
                        return
                    end
                    if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Concrete then
                        local v_u_7 = script.StepsHidden:FindFirstChild("metal"):GetChildren()[math.random(1, #script.StepsHidden:FindFirstChild("metal"):GetChildren())]:Clone()
                        v_u_7.Parent = script.Parent:FindFirstChild("Torso")
                        v_u_7.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        if script.Parent:GetAttribute("Crouching") == true then
                            v_u_7.Volume = v_u_7.Volume / 2
                        end
                        if not v_u_7.IsLoaded then
                            v_u_7.Loaded:Wait()
                        end
                        v_u_7:Play()
                        task.wait(0.1)
                        task.delay(v_u_7.TimeLength, function()
                            v_u_7:Destroy()
                        end)
                        return
                    end
                    if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Grass or (script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Ground or (script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.LeafyGrass or script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Mud)) then
                        local v_u_8 = script.StepsHidden:FindFirstChild("grass").walking:GetChildren()[math.random(1, #script.StepsHidden:FindFirstChild("grass").walking:GetChildren())]:Clone()
                        v_u_8.Parent = script.Parent:FindFirstChild("Torso")
                        v_u_8.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        if script.Parent:GetAttribute("Crouching") == true then
                            v_u_8.Volume = v_u_8.Volume / 2
                        end
                        if not v_u_8.IsLoaded then
                            v_u_8.Loaded:Wait()
                        end
                        v_u_8:Play()
                        task.delay(v_u_8.TimeLength, function()
                            v_u_8:Destroy()
                        end)
                        return
                    end
                end
            else
                v_u_2 = v_u_2 + 1
                if v_u_2 > 4 then
                    v_u_2 = 1
                end
                local v_u_9 = script.Steps:FindFirstChild(v_u_2):Clone()
                v_u_9.Parent = script.Parent:FindFirstChild("HumanoidRootPart")
                v_u_9.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                if not v_u_9.IsLoaded then
                    v_u_9.Loaded:Wait()
                end
                v_u_9:Play()
                task.wait(0.1)
                task.delay(v_u_9.TimeLength, function()
                    v_u_9:Destroy()
                end)
            end
        end)
        p3.Stopped:Once(function()
            v_u_10:Disconnect()
        end)
    end)
end
