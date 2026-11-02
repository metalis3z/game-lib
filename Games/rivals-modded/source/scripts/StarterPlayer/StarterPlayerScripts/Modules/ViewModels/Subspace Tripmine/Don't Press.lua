-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local FunctionsController = require(Players.LocalPlayer.PlayerScripts.Controllers.FunctionsController);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Subspace Tripmine"]);
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 11
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayHideMineSound(p5, p6) -- Line: 23
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://17675605394", 1, 1.25, p6.Hitbox, true, 5);
end;

function u2.ExplosionEffect(p7, p8) -- Line: 27
    -- upvalues: FunctionsController (copy)
    FunctionsController:FireAsync(p7:ToEnum("NukeEffect"), p8, p7.ClientItem.Info.ExplosionRadius * 3, 0.25);
end;

function u2._Init(p9) -- Line: 35
end;

return u2;