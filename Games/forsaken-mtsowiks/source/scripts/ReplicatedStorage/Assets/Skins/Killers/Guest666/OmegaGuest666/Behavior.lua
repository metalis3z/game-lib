-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:24 2025 ]]
local l_ScarfAnimation_0 = script.ScarfAnimation;
return {
    CreatedPost = function(_, v2) --[[ Line: 7 ]] --[[ Name: CreatedPost ]]
        -- upvalues: l_ScarfAnimation_0 (copy)
        if game["Run Service"]:IsClient() then
            task.spawn(function() --[[ Line: 9 ]]
                -- upvalues: v2 (copy), l_ScarfAnimation_0 (ref)
                local l_Rig_0 = v2.Rig;
                if l_Rig_0 then
                    local l_EVILFACERIG_0 = l_Rig_0:FindFirstChild("EVILFACERIG");
                    if not l_EVILFACERIG_0 then
                        return;
                    else
                        l_EVILFACERIG_0:FindFirstChildOfClass("AnimationController").Animator:LoadAnimation(l_ScarfAnimation_0):Play();
                    end;
                end;
            end);
        end;
    end
};