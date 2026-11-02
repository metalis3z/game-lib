-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:04 2025 ]]
return {
    OnExecution = function(_, _, v2) --[[ Line: 4 ]] --[[ Name: OnExecution ]]
        task.delay(1.75, function() --[[ Line: 8 ]]
            -- upvalues: v2 (copy)
            local l_Torso_0 = v2:FindFirstChild("Torso");
            local l_Darkness_0 = script.Darkness;
            if l_Torso_0 then
                local l_l_Torso_0_FirstChild_0 = l_Torso_0:FindFirstChild("Left Hip");
                local l_l_Torso_0_FirstChild_1 = l_Torso_0:FindFirstChild("Right Hip");
                if l_l_Torso_0_FirstChild_0 then
                    l_l_Torso_0_FirstChild_0:Destroy();
                end;
                if l_l_Torso_0_FirstChild_1 then
                    l_l_Torso_0_FirstChild_1:Destroy();
                end;
            end;
            local l_PrimaryPart_0 = v2.PrimaryPart;
            if l_PrimaryPart_0 then
                l_PrimaryPart_0.Anchored = false;
            end;
            local l_Humanoid_0 = v2:FindFirstChild("Humanoid");
            if l_Humanoid_0 then
                l_Humanoid_0.Health = 0;
            end;
            l_Darkness_0:Clone().Parent = v2:FindFirstChild("Torso");
            local v9 = l_Darkness_0:Clone();
            v9.Parent = v2:FindFirstChild("Left Leg");
            local _ = l_Darkness_0:Clone();
            v9.Parent = v2:FindFirstChild("Right Leg");
            local _ = l_Darkness_0:Clone();
            v9.Parent = v2:FindFirstChild("Head");
            local _ = l_Darkness_0:Clone();
            v9.Parent = v2:FindFirstChild("Left Arm");
            local _ = l_Darkness_0:Clone();
            v9.Parent = v2:FindFirstChild("Right Arm");
            local l_v2_FirstChild_0 = v2:FindFirstChild("Body Colors");
            l_v2_FirstChild_0.HeadColor3 = Color3.new(0, 0, 0);
            l_v2_FirstChild_0.LeftArmColor3 = Color3.new(0, 0, 0);
            l_v2_FirstChild_0.RightArmColor3 = Color3.new(0, 0, 0);
            l_v2_FirstChild_0.LeftLegColor3 = Color3.new(0, 0, 0);
            l_v2_FirstChild_0.RightLegColor3 = Color3.new(0, 0, 0);
            l_v2_FirstChild_0.TorsoColor3 = Color3.new(0, 0, 0);
        end);
    end
};