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

function u1._CreateFlameSoundEffects(p4) -- Line: 26
    return { p4:CreateSound("rbxassetid://89834210702442", 0.75, 1, true), p4:CreateSound("rbxassetid://115412300262585", 1, 1, true) };
end;

function u1._Init(p5) -- Line: 30
end;

return u1;