-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:11:35 2025 ]]
local l_PigtailsAnimation_0 = script.PigtailsAnimation;
return {
    CreatedPost = function(_, v2) --[[ Line: 6 ]] --[[ Name: CreatedPost ]]
        -- upvalues: l_PigtailsAnimation_0 (copy)
        if game["Run Service"]:IsClient() then
            task.spawn(function() --[[ Line: 8 ]]
                -- upvalues: v2 (copy), l_PigtailsAnimation_0 (ref)
                local l_Rig_0 = v2.Rig;
                if l_Rig_0 then
                    local l_Pigtails_0 = l_Rig_0:FindFirstChild("Pigtails");
                    if not l_Pigtails_0 then
                        return;
                    else
                        l_Pigtails_0:FindFirstChildOfClass("Humanoid").Animator:LoadAnimation(l_PigtailsAnimation_0):Play();
                    end;
                end;
            end);
        end;
    end
};