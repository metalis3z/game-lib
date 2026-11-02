-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    OnExecution = function(_, _, v2) --[[ Line: 4 ]] --[[ Name: OnExecution ]]
        task.delay(1.75, function() --[[ Line: 8 ]]
            -- upvalues: v2 (copy)
            local l_Torso_0 = v2:FindFirstChild("Torso");
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
        end);
    end
};