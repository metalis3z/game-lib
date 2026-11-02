-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local FunctionsController = require(Players.LocalPlayer.PlayerScripts.Controllers.FunctionsController);
local Grenade = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Grenade);
local u1 = setmetatable({}, Grenade);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Grenade (copy), u1 (copy)
    local v2 = Grenade.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 23
    -- upvalues: Utility (copy), FunctionsController (copy)
    Utility:CreateSound("rbxassetid://99261833097954", 0.5, 0.9 + 0.2 * math.random(), p5, true, 10);
    FunctionsController:FireAsync(p4:ToEnum("ExplosionEffect"), p5, p6);
end;

function u1._Init(p7) -- Line: 32
end;

return u1;