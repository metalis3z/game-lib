-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

if script.Parent:WaitForChild("Humanoid", 10) then
    local Humanoid = script.Parent:FindFirstChildOfClass("Humanoid")
    local v_u_2 = 0
    Humanoid:WaitForChild("Animator").AnimationPlayed:Connect(function(p3)
        local v_u_5 = p3:GetMarkerReachedSignal("Step"):Connect(function()
            if not script.Parent:HasTag("UNDETECTABLE") then
                v_u_2 = v_u_2 + 1
                if v_u_2 > 2 then
                    v_u_2 = 1
                end
                local v_u_4 = script.Steps:FindFirstChild(v_u_2):Clone()
                v_u_4.Parent = script.Parent:FindFirstChild("HumanoidRootPart")
                v_u_4.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                if not v_u_4.IsLoaded then
                    v_u_4.Loaded:Wait()
                end
                task.wait(0.1)
                task.delay(v_u_4.TimeLength, function()
                    v_u_4:Destroy()
                end)
            end
        end)
        local v_u_7 = p3:GetMarkerReachedSignal("StepRush"):Connect(function()
            if not script.Parent:HasTag("INVIS") then
                v_u_2 = v_u_2 + 1
                if v_u_2 > 2 then
                    v_u_2 = 1
                end
                local v_u_6 = script.Steps2:FindFirstChild(v_u_2):Clone()
                v_u_6.Parent = script.Parent:FindFirstChild("HumanoidRootPart")
                v_u_6.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                v_u_6:Play()
                if not v_u_6.IsLoaded then
                    v_u_6.Loaded:Wait()
                end
                task.wait(0.1)
                task.delay(v_u_6.TimeLength, function()
                    v_u_6:Destroy()
                end)
            end
        end)
        p3.Stopped:Once(function()
            v_u_5:Disconnect()
            v_u_7:Disconnect()
        end)
    end)
end
