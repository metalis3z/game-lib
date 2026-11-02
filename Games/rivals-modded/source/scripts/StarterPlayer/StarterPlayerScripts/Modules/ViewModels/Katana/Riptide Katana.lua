-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Katana = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Katana);
local u1 = { "rbxassetid://78366036290786", "rbxassetid://94469349981552" };
local u2 = setmetatable({}, Katana);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: Katana (copy), u2 (copy)
    local v3 = Katana.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayDeflectHitSounds(p5) -- Line: 22
    -- upvalues: u1 (copy)
    p5:CreateSound("rbxassetid://14776414133", 1, 1.5 + 0.5 * math.random(), true, 5);
    p5:CreateSound("rbxassetid://14776437962", 0.75, 0.9 + 0.2 * math.random(), true, 5);
    p5:CreateSound(u1[math.random(#u1)], 1.25, 1 + 0.25 * math.random(), true, 5);
end;

function u2._Init(p6) -- Line: 32
end;

return u2;