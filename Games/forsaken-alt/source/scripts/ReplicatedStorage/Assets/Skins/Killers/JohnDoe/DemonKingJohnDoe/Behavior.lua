-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreatedPost = function(_, v1) --[[ Line: 4 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local l_Highlight_0 = Instance.new("Highlight");
            l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_0.FillColor = Color3.fromRGB(0, 255, 225);
            l_Highlight_0.FillTransparency = 3;
            l_Highlight_0.OutlineColor = Color3.fromRGB(102, 0, 2);
            l_Highlight_0.OutlineTransparency = 0.95;
            l_Highlight_0.Parent = v1.Rig;
        end;
    end, 
    OnExecution = function(_, _, v5) --[[ Line: 16 ]] --[[ Name: OnExecution ]]
        task.delay(1.75, function() --[[ Line: 20 ]]
            -- upvalues: v5 (copy)
            local l_Torso_0 = v5:FindFirstChild("Torso");
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
            local l_PrimaryPart_0 = v5.PrimaryPart;
            if l_PrimaryPart_0 then
                l_PrimaryPart_0.Anchored = false;
            end;
            local l_Humanoid_0 = v5:FindFirstChild("Humanoid");
            if l_Humanoid_0 then
                l_Humanoid_0.Health = 0;
            end;
        end);
    end
};