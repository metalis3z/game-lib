-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Flamethrower = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Flamethrower);
local u1 = setmetatable({}, Flamethrower);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Flamethrower (copy), u1 (copy)
    local v2 = Flamethrower.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayAirblastSoundEffect(p4) -- Line: 20
    p4:CreateSound("rbxassetid://17209245422", 1, 1, true, 5);
    p4:CreateSound("rbxassetid://113753648748200", 1.125, 1 + 0.1 * math.random(), true, 10);
end;

function u1._CreateFlameSoundEffects(p5) -- Line: 29
    return { p5:CreateSound("rbxassetid://100941596743597", 1.5, 1, true) };
end;

function u1._Init(p6) -- Line: 33
end;

return u1;