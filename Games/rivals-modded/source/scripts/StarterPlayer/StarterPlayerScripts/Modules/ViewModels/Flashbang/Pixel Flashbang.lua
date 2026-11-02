-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Flashbang = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Flashbang);
local u1 = setmetatable({}, Flashbang);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Flashbang (copy), u1 (copy)
    local v2 = Flashbang.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayFlashSound(p4, p5) -- Line: 22
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://94088948330527", 1, 1, p5, true, 10);
end;

function u1._Init(p6) -- Line: 30
end;

return u1;