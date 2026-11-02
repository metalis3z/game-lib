-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Paintball Gun"]);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(253, 234, 141);
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 13
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.GetPaintballColor(p5) -- Line: 25
    -- upvalues: Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    return math.random() < 0.001 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
end;

function u2.PlaySplatSound(p6, p7) -- Line: 29
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://11800684590", 0.5, 0.9 + 0.2 * math.random(), p7, true, 5);
end;

function u2._Init(p8) -- Line: 37
end;

return u2;