-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v4 = {
    Data = {
        Duration = 10, 
        MaxLevel = 3, 
        Description = "Makes you go insane whatever"
    }
};
local v5 = {
    NumberRange.new(0, 1.3), 
    NumberRange.new(1.92, 3.19), 
    NumberRange.new(5.2, 6.314)
};
v4.Applied = function(v6) --[[ Line: 21 ]] --[[ Name: Applied ]]
    -- upvalues: l_RunService_0 (copy), v5 (copy), v3 (copy), l_TweenService_0 (copy)
    local l_Level_0 = v6.Level;
    if l_RunService_0:IsClient() then
        local l_Duration_0 = v6.Data.Duration;
        print(l_Level_0, l_Duration_0);
        if l_Level_0 == 1 then
            local v9 = v5[math.random(1, #v5)];
            script.Footsteps.LoopRegion = v9;
            local v10 = v3:Play(script.Footsteps, {
                Volume = 0
            });
            v10.TimePosition = v9.Min;
            local v11 = l_TweenService_0:Create(v10, TweenInfo.new(l_Duration_0 / 2), {
                Volume = 1
            });
            v11:Play();
            v11.Completed:Once(function(_) --[[ Line: 43 ]]
                -- upvalues: v10 (copy)
                v10:Stop();
                v10:Destroy();
            end);
            return;
        elseif l_Level_0 == 2 then
            local v13 = 0;
            task.spawn(function() --[[ Line: 54 ]]
                -- upvalues: v13 (ref), l_Duration_0 (copy)
                repeat
                    if math.random(1, 10) == 10 then
                        local v14 = math.random(-3, 3);
                        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                        local l_CurrentCamera_0 = workspace.CurrentCamera;
                        l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v14, v14, v14);
                    end;
                    v13 = v13 + task.wait(0.1);
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
                until l_Duration_0 <= v13;
            end);
            return;
        elseif l_Level_0 == 3 then
            local l_Health_0 = v6.Character.Humanoid.Health;
            v6.Character.Humanoid.Health = 2;
            task.delay(0.01, function() --[[ Line: 75 ]]
                -- upvalues: v6 (copy), l_Health_0 (copy)
                v6.Character.Humanoid.Health = l_Health_0;
            end);
        end;
    end;
end;
v4.Removed = function(_) --[[ Line: 84 ]] --[[ Name: Removed ]]

end;
return v4;