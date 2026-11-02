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
    Utility:CreateSound("rbxassetid://72483809453170", 0.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5, true, 10);
    Utility:CreateSound("rbxassetid://129922197154277", 0.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5, true, 10);
    Utility:CreateSound("rbxassetid://10730819", 2 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5, true, 10);
end;

function u1._Init(p7) -- Line: 32
end;

return u1;