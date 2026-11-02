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
    p4:CreateSound("rbxassetid://17772394926", 1, 1, true);
end;

function u1._CreateFlameSoundEffects(p5) -- Line: 28
    return { p5:CreateSound("rbxassetid://17772394725", 2, 1.25, true) };
end;

function u1._Init(p6) -- Line: 32
end;

return u1;