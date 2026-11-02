-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.BetterDebris);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ViewModels"):WaitForChild("Riot Shield"));
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.AbsorbedHit(p5) -- Line: 22
    p5:CreateSound("rbxassetid://110086876051279", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u2.ShieldBroken(p6) -- Line: 26
    p6:CreateSound("rbxassetid://127379863706205", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u2._Init(p7) -- Line: 34
end;

return u2;