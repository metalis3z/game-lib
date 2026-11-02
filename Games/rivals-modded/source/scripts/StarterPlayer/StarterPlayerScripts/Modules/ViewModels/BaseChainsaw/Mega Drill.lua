-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseChainsaw = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ViewModels"):WaitForChild("BaseChainsaw"));
local u1 = setmetatable({}, BaseChainsaw);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseChainsaw (copy), u1 (copy)
    local v2 = BaseChainsaw.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.CreateHoldSounds(p4) -- Line: 20
    local v5 = {};
    local v6 = p4:CreateSound("rbxassetid://16359327230", 0.75, 1.25, true);
    local PitchShiftSoundEffect = Instance.new("PitchShiftSoundEffect");
    PitchShiftSoundEffect.Octave = 0.625;
    PitchShiftSoundEffect.Parent = v6;
    table.insert(v5, v6);
    local v7 = p4:CreateSound("rbxassetid://16359327230", 0.5, 1.2, true);
    local PitchShiftSoundEffect2 = Instance.new("PitchShiftSoundEffect");
    PitchShiftSoundEffect2.Octave = 0.5;
    PitchShiftSoundEffect2.Parent = v7;
    table.insert(v5, v7);

    return v5;
end;

function u1.PlayStartingHoldSounds(p8) -- Line: 38
    p8:CreateSound("rbxassetid://18763594759", 0.5, 1, true, 10);
end;

function u1._Init(p9) -- Line: 46
    p9:_RegisterBlade(p9.ItemModel:WaitForChild("Drill"):WaitForChild("Blade"));
end;

return u1;