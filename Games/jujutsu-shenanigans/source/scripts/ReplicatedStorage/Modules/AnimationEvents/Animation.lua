-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ReplicatedFirst");			
local _ = game:GetService("ReplicatedStorage");
local v14 = {
    Load = function(_, v3, v4, v5, v6, v7, v8) --[[ Line: 7 ]] --[[ Name: Load ]]
        if v4 == nil then
            return;
        elseif v3 == nil then
            return;
        else
            v5 = v5 or 0;
            v8 = v8 or 1;
            local l_Humanoid_0 = v3:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_0 == nil then
                local l_AnimationController_0 = v3:FindFirstChildOfClass("AnimationController");
                if l_AnimationController_0 then
                    l_Humanoid_0 = l_AnimationController_0;
                else
                    return;
                end;
            end;
            if l_Humanoid_0 then
                local _ = nil;
                local v12 = (if not l_Humanoid_0:FindFirstChildOfClass("Animator") then Instance.new("Animator", l_Humanoid_0) else l_Humanoid_0:FindFirstChildOfClass("Animator")):LoadAnimation(v4);
                local l_Action_0 = Enum.AnimationPriority.Action;
                l_Action_0 = if v6 == nil then v12.Priority or l_Action_0 else v6;
                if v7 == nil then
                    v7 = v12.Looped;
                end;
                v12.Looped = v7;
                v12.Priority = l_Action_0;
                v12:AdjustSpeed(v8);
                v12.Stopped:Once(function() --[[ Line: 48 ]]
                    v12:Destroy();
                end);
                return v12;
            else
                return;
            end;
        end;
    end
};
v14.loadAnimation = function(_, v16, v17, v18, v19, v20, v21) --[[ Line: 55 ]] --[[ Name: loadAnimation ]]
    local v22 = v14:Load(v16, v17, v18, v19, v20, v21);
    if not v22 then
        return;
    else
        return v22;
    end;
end;
return v14;