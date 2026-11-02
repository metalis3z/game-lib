-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Molotov = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Molotov);
local u1 = setmetatable({}, Molotov);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Molotov (copy), u1 (copy)
    local v2 = Molotov.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 22
    -- upvalues: Molotov (copy), Utility (copy)
    local v7 = Molotov.ExplosionEffect(p4, p5, p6);
    Utility:CreateSound("rbxassetid://100889848836357", 1, 1 + 0.25 * math.random(), v7, true, 10);
end;

function u1._Init(p8) -- Line: 31
end;

return u1;