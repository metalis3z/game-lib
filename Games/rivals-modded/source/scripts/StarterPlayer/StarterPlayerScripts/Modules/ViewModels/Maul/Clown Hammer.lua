-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Maul = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ViewModels"):WaitForChild("Maul"));
local u1 = setmetatable({}, Maul);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Maul (copy), u1 (copy)
    local v2 = Maul.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.SlamSoundEffect(p4, p5, p6) -- Line: 22
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://72483809453170", 1 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5, true, 10);
    Utility:CreateSound("rbxassetid://129922197154277", 1 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5, true, 10);
    Utility:CreateSound("rbxassetid://84868739299715", 1.25 + 0.25 * math.random(), 0.75 + 0.125 * math.random(), p5, true, 10);
end;

function u1.PlayHitmarkerSound(p7, p8, p9) -- Line: 28
    -- upvalues: Maul (copy)
    Maul.PlayHitmarkerSound(p7, p8, p9);
    p7:_CreateHitmarkerSound("rbxassetid://84868739299715", 1.25 / p9, 1 + 0.25 * math.random(), script, true, 2);
end;

function u1._Init(p10) -- Line: 37
end;

return u1;