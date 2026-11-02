-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local u1 = { "rbxassetid://95537657751620", "rbxassetid://79660414273289" };
local u2 = setmetatable({}, ClientEnemy);
u2.__index = u2;

function u2.new(...) -- Line: 12
    -- upvalues: ClientEnemy (copy), u2 (copy)
    local v3 = ClientEnemy.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.ReplicateFromServer(p5, p6, ...) -- Line: 24
    -- upvalues: Utility (copy), u1 (copy), ClientEnemy (copy)
    if p6 ~= "DinkEffect" then
        ClientEnemy.ReplicateFromServer(p5, p6, ...);

        return;
    end;

    if not p5:IsRendered() then
        return;
    end;

    Utility:CreateSound(u1[math.random(1, #u1)], 0.625 + 0.25 * math.random(), 1 + 0.5 * math.random(), p5.RootPart, true, 10);
    local v7 = p5.Model:FindFirstChild("Head") and p5.Model.Head:FindFirstChild("DinkVFX");
    Utility:PlayParticles(v7);
end;

function u2._Init(p8) -- Line: 41
end;

return u2;