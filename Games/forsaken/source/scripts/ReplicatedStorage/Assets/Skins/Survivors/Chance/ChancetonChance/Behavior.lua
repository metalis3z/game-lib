-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local v1 = TweenInfo.new(30, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0);
local v2 = nil;
return {
    CreatedPost = function(_, v4) --[[ Line: 20 ]] --[[ Name: CreatedPost ]]
        -- upvalues: v2 (ref), l_TweenService_0 (copy), v1 (copy)
        local l_Humanoid_0 = v4.Rig:FindFirstChildOfClass("Humanoid");
        if l_Humanoid_0 then
            local l_Static_0 = v4.Rig.Head.Glasses.Lens.Static;
            l_Humanoid_0.HealthChanged:Connect(function(v7) --[[ Line: 24 ]]
                -- upvalues: l_Static_0 (copy), l_Humanoid_0 (copy), v2 (ref), l_TweenService_0 (ref), v1 (ref)
                if not l_Static_0 then
                    return;
                else
                    local v8 = v7 <= l_Humanoid_0.MaxHealth / 2;
                    l_Static_0.Transparency = v8 and 0 or 1;
                    if v8 and not v2 then
                        v2 = l_TweenService_0:Create(l_Static_0, v1, {
                            OffsetStudsU = 50, 
                            OffsetStudsV = 50
                        }):Play();
                        return;
                    else
                        if v8 and v2 then
                            v2:Destroy();
                            l_Static_0.OffsetStudsU = 0;
                            l_Static_0.OffsetStudsV = 0;
                            v2 = nil;
                        end;
                        return;
                    end;
                end;
            end);
        end;
    end
};