-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Minigun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Minigun);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 0, 0));
local u1 = setmetatable({}, Minigun);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Minigun (copy), u1 (copy)
    local v2 = Minigun.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 22
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1._CreateMinigunShootingSounds(p5) -- Line: 30
    local v6 = p5:CreateSound("rbxassetid://17722581026", 0.75, 1, true);
    v6.TimePosition = 0.5 * math.random();
    v6.Looped = true;
    local v7 = p5:CreateSound("rbxassetid://17722580791", 0.75, 1, true);
    v7.TimePosition = 0.5 * math.random();
    v7.Looped = true;
    local v8 = p5:CreateSound("rbxassetid://17722580585", 0.75, 1, true);
    v8.TimePosition = 0.5 * math.random();
    v8.Looped = true;

    return { v6, v7, v8 };
end;

function u1._CreateMinigunWindingSounds(p9) -- Line: 50
    local v10 = p9:CreateSound("rbxassetid://17722633119", 0.25, 1, true);
    v10.Looped = true;

    return { v10 };
end;

function u1._Init(p11) -- Line: 57
end;

return u1;