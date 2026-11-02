-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ScarfAnimation_0 = script.ScarfAnimation;
return {
    CreatedPost = function(_, v2) --[[ Line: 6 ]] --[[ Name: CreatedPost ]]
        -- upvalues: l_ScarfAnimation_0 (copy)
        if game["Run Service"]:IsClient() then
            task.spawn(function() --[[ Line: 8 ]]
                -- upvalues: v2 (copy), l_ScarfAnimation_0 (ref)
                local l_Rig_0 = v2.Rig;
                if l_Rig_0 then
                    local l_ScarfRig_0 = l_Rig_0:FindFirstChild("ScarfRig");
                    if not l_ScarfRig_0 then
                        return;
                    else
                        l_ScarfRig_0:FindFirstChildOfClass("Humanoid").Animator:LoadAnimation(l_ScarfAnimation_0):Play();
                    end;
                end;
            end);
        end;
    end, 
    SubspaceBegin = function(v5) --[[ Line: 22 ]] --[[ Name: SubspaceBegin ]]
        local l_Rig_1 = v5.Rig;
        if not l_Rig_1 then
            return;
        else
            local l_Enable_0 = l_Rig_1.SubspaceTripmine.SubspaceCenter.Enable;
            for _, v9 in pairs(l_Enable_0:GetDescendants()) do
                if v9:IsA("ParticleEmitter") then
                    v9.Enabled = true;
                    task.delay(3, function() --[[ Line: 33 ]]
                        -- upvalues: v9 (copy)
                        v9.Enabled = false;
                    end);
                end;
            end;
            return;
        end;
    end
};