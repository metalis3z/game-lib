-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local SmokeCloud = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SmokeCloud"));
local u1 = setmetatable({}, SmokeCloud);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: SmokeCloud (copy), u1 (copy)
    local v2 = SmokeCloud.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 22
    -- upvalues: SmokeCloud (copy)
    if SmokeCloud.Update(p4, p5) then
        return;
    end;

    p4.Model:PivotTo(CFrame.new(p4._position_spring.Value, workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(-p4._spin, 0, 0));
end;

function u1._CreateIdleSound(p6) -- Line: 34
    -- upvalues: Utility (copy)
    return Utility:CreateSound("rbxassetid://94857514154727", 2, 1, nil, true);
end;

function u1._Init(p7) -- Line: 38
end;

return u1;