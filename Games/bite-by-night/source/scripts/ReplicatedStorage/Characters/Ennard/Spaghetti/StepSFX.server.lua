-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

if script.Parent:WaitForChild("Humanoid", 10) then
    script.Parent:FindFirstChildOfClass("Humanoid"):WaitForChild("Animator").AnimationPlayed:Connect(function(p1)
        local v_u_3 = p1:GetMarkerReachedSignal("Step"):Connect(function()
            if not script.Parent:HasTag("UNDETECTABLE") then
                local v_u_2 = script.Steps:GetChildren()[math.random(1, #script.Steps:GetChildren())]:Clone()
                v_u_2.Parent = script.Parent:FindFirstChild("HumanoidRootPart")
                v_u_2.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                if not v_u_2.IsLoaded then
                    v_u_2.Loaded:Wait()
                end
                v_u_2:Play()
                task.wait(0.1)
                task.delay(v_u_2.TimeLength, function()
                    v_u_2:Destroy()
                end)
            end
        end)
        p1.Stopped:Once(function()
            v_u_3:Disconnect()
        end)
    end)
end
