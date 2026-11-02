-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local v1 = {};
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v3 = 0;
local v4 = 0;
v1.addTrauma = function(v5) --[[ Line: 15 ]] --[[ Name: addTrauma ]]
    -- upvalues: v3 (ref)
    v3 = math.clamp(v3 + v5, 0, 1);
end;
l_RunService_0.RenderStepped:Connect(function(v6) --[[ Line: 19 ]]
    -- upvalues: v3 (ref), v4 (ref), l_CurrentCamera_0 (copy)
    if v3 > 0 then
        v4 = v4 + v6 * 15;
        local v7 = v3 * v3;
        local v8 = (math.noise(v4, 0, 0) * 2 - 1) * 1.5 * v7;
        local v9 = (math.noise(0, v4, 0) * 2 - 1) * 1.5 * v7;
        local v10 = (math.noise(0, 0, v4) * 2 - 1) * 5 * v7;
        local l_l_CurrentCamera_0_0 = l_CurrentCamera_0;
        l_l_CurrentCamera_0_0.CFrame = l_l_CurrentCamera_0_0.CFrame * (CFrame.new(v8, v9, 0) * CFrame.Angles(0, 0, (math.rad(v10))));
        v3 = math.max(0, v3 - v6 * 1.5);
    end;
end);
return v1;