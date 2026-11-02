-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:25 2025 ]]
local l_ScarfAnimation_0 = script.ScarfAnimation;
return {
    CreatedPost = function(_, v2) --[[ Line: 6 ]] --[[ Name: CreatedPost ]]
        -- upvalues: l_ScarfAnimation_0 (copy)
        if game["Run Service"]:IsClient() then
            task.spawn(function() --[[ Line: 8 ]]
                -- upvalues: v2 (copy), l_ScarfAnimation_0 (ref)
                local l_Rig_0 = v2.Rig;
                if l_Rig_0 then
                    local l_WingsRig_0 = l_Rig_0:FindFirstChild("WingsRig");
                    if not l_WingsRig_0 then
                        return;
                    else
                        l_WingsRig_0:FindFirstChildOfClass("AnimationController").Animator:LoadAnimation(l_ScarfAnimation_0):Play();
                    end;
                end;
            end);
        end;
    end
};