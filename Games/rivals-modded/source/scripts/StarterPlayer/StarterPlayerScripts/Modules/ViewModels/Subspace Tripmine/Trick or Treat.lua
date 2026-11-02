-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Utility);
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

function u2.ExplosionEffect(p5, p6) -- Line: 23
    -- upvalues: FunctionsController (copy)
    for i = 1, 3 do
        local v7 = 10 * (math.random() - 0.5);
        local v8 = 10 * (math.random() - 0.5);
        local v9 = p6 + Vector3.new(v7, i ^ 2, v8);
        local v10 = p5.ClientItem.Info.ExplosionRadius * (1 + 1 * math.random());
        FunctionsController:FireAsync(p5:ToEnum("ExplosionEffect"), v9, v10, (i - 1) * 0.25 + 1);
        wait(0.1);
        local _ = i;
    end;
end;

function u2._Init(p11) -- Line: 38
end;

return u2;