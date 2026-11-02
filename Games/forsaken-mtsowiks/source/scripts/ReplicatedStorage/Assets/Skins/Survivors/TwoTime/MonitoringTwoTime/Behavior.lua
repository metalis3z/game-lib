-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:10:12 2025 ]]
local l_BowAnimation_0 = script.BowAnimation;
return {
    CreatedPost = function(_, v2) --[[ Line: 6 ]] --[[ Name: CreatedPost ]]
        -- upvalues: l_BowAnimation_0 (copy)
        if game["Run Service"]:IsClient() then
            v2.Rig.ChildAdded:Connect(function(v3) --[[ Line: 8 ]]
                -- upvalues: l_BowAnimation_0 (ref)
                if v3.Name == "Life2" then
                    local l_Wings_0 = v3:FindFirstChild("Wings");
                    if not l_Wings_0 then
                        return;
                    else
                        l_Wings_0:FindFirstChildOfClass("Humanoid").Animator:LoadAnimation(l_BowAnimation_0):Play();
                    end;
                end;
            end);
        end;
    end
};