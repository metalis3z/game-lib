-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Created = function(_, v1) --[[ Line: 4 ]] --[[ Name: Created ]]
        if game["Run Service"]:IsServer() then
            task.spawn(function() --[[ Line: 6 ]]
                -- upvalues: v1 (copy)
                local l_Humanoid_0 = v1.Rig.Humanoid;
                local l_Health_0 = l_Humanoid_0.Health;
                local v4 = nil;
                v1.Rig.HumanoidRootPart.crying:Play();
                v1.Rig.HumanoidRootPart.crying.Volume = 0;
                l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 17 ]]
                    -- upvalues: l_Humanoid_0 (copy), l_Health_0 (ref), v4 (ref), v1 (ref)
                    if l_Humanoid_0.Health < l_Health_0 then
                        if v4 then
                            task.cancel(v4);
                        end;
                        v4 = task.delay(0.8, function() --[[ Line: 20 ]]
                            -- upvalues: l_Humanoid_0 (ref), v1 (ref)
                            if l_Humanoid_0.Health > l_Humanoid_0.MaxHealth / 2 then
                                game.TweenService:Create(v1.Rig.HumanoidRootPart.crying, TweenInfo.new(0.2), {
                                    Volume = 0
                                }):Play();
                            end;
                        end);
                        game.TweenService:Create(v1.Rig.HumanoidRootPart.crying, TweenInfo.new(0.1), {
                            Volume = 0.5
                        }):Play();
                    elseif l_Humanoid_0.Health >= l_Humanoid_0.MaxHealth / 2 then
                        game.TweenService:Create(v1.Rig.HumanoidRootPart.crying, TweenInfo.new(0.1), {
                            Volume = 0
                        }):Play();
                    end;
                    l_Health_0 = l_Humanoid_0.Health;
                end);
            end);
        end;
    end
};