-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:07 2025 ]]
local v8 = {
    OnExecution = function(_, _, v2) --[[ Line: 4 ]] --[[ Name: OnExecution ]]
        task.delay(4.1, function() --[[ Line: 8 ]]
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
local l_ScarfAnimation_0 = script.ScarfAnimation;
v8.CreatedPost = function(_, v11) --[[ Line: 32 ]] --[[ Name: CreatedPost ]]
    -- upvalues: l_ScarfAnimation_0 (copy)
    if game["Run Service"]:IsClient() then
        task.spawn(function() --[[ Line: 34 ]]
            -- upvalues: v11 (copy), l_ScarfAnimation_0 (ref)
            local l_Spike_0 = v11.Config.Spike;
            if l_Spike_0 then
                local l_SpikeRig_0 = l_Spike_0:FindFirstChild("SpikeRig");
                if not l_SpikeRig_0 then
                    return;
                else
                    l_SpikeRig_0:FindFirstChildOfClass("AnimationController").Animator:LoadAnimation(l_ScarfAnimation_0):Play();
                end;
            end;
        end);
    end;
end;
return v8;