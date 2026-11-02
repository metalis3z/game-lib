-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Grappler = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Grappler);
local u1 = setmetatable({}, Grappler);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Grappler (copy), u1 (copy)
    local v2 = Grappler.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayShootSounds(p4) -- Line: 20
    p4:CreateSound("rbxassetid://123453281089594", 1, 0.9 + 0.2 * math.random(), true, 5);
    p4:CreateSound("rbxassetid://88826254536827", 1.25, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1.PlayPullSounds(p5) -- Line: 25
    p5:CreateSound("rbxassetid://119983207340759", 1.25, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1._Init(p6) -- Line: 33
end;

return u1;