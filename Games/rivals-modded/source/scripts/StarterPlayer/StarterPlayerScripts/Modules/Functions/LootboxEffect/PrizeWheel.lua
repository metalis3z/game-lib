-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = { 6.15, 6.35, 6.6, 6.8, 7.15, 7.45, 7.8, 8.25, 8.8, 9.6, 11.05 };

return function(p2) -- Line: 8
    -- upvalues: Utility (copy), RunService (copy), u1 (copy)
    local v3 = p2:FindFirstChild("HumanoidRootPart") or p2:FindFirstChild("RootPart");
    Utility:CreateSound("rbxassetid://97748906880096", 1, 1, v3, true);
    wait(1.45);
    Utility:CreateSound("rbxassetid://103519956736851", 1, 1.25, v3, true);
    wait(0.6);
    local u4 = tick();

    local function get_pitch() -- Line: 24
        -- upvalues: u4 (copy)
        return (1.5 + -0.3999999999999999 * ((tick() - u4) / 9) ^ 2) * (0.975 + 0.05 * math.random());
    end;

    local v5 = tick() + 4;
    local v6 = 0;

    while tick() < v5 do
        if v6 < tick() then
            Utility:CreateSound("rbxassetid://103519956736851", 0.8, (1.5 + -0.3999999999999999 * ((tick() - u4) / 9) ^ 2) * (0.975 + 0.05 * math.random()), v3, true);
            v6 = tick() + 0.08;
        end;

        RunService.RenderStepped:Wait();
    end;

    for i, v in pairs(u1) do
        wait(v - (u1[i - 1] or 6.05));
        Utility:CreateSound("rbxassetid://103519956736851", 0.8, (1.5 + -0.3999999999999999 * ((tick() - u4) / 9) ^ 2) * (0.975 + 0.05 * math.random()), v3, true);
    end;

    wait(3.95);
end;