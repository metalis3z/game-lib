-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {};
local v5 = {
    Looped = true, 
    IsPlaying = true, 
    Stopped = {}, 
    Play = function(_)

    end, 
    Stop = function(_)

    end, 
    AdjustSpeed = function(_)

    end
};
v5.Stopped.Connect = function(_, v7)
    v7();
end;
v1.playAnimation = function(v8, v9, _, v11, v12)
    if not v8 or not v8.Parent then
        return v5;
    elseif v8.Parent:FindFirstChild("Ragdoll") and v9 ~= 124917318568144 and not v12 then
        return v5;
    elseif rawget(v0, v9) then
        return v0[v9];
    elseif not v9 then
        return ;
    elseif v11 then
        return ;
    else
        local l_v9_0 = v9;
        if typeof(v9) == "string" and string.find(v9, "rbxassetid") then
            v9 = tonumber((string.gsub(v9, "rbxassetid://", ""):gsub("[^%-%d]", "")));
        end;
        local l_Animation_0 = Instance.new("Animation");
        if typeof(v9) == "string" then
            l_Animation_0.AnimationId = v9;
        elseif typeof(v9) == "number" then
            l_Animation_0.AnimationId = "rbxassetid://" .. v9;
        elseif typeof(v9) == "Instance" and game:GetService("RunService"):IsStudio() then
            l_Animation_0.AnimationId = game:GetService("KeyframeSequenceProvider"):RegisterKeyframeSequence(v9);
        end;
        local v15 = v8:FindFirstChild("Animator") or v8:WaitForChild("Animator", 2);
        if not v15 or not v15.Parent then
            return ;
        else
            local v16 = v15:LoadAnimation(l_Animation_0);
            v0[l_v9_0] = v16;
            v16:AdjustWeight(0.001);
            return v16;
        end;
    end;
end;
v1.GetStorage = function(_)
    return v0;
end;
return v1;