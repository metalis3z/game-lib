-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Utility);
local ReplicatedController = require(Players.LocalPlayer.PlayerScripts.Modules.ReplicatedController);
local u1 = setmetatable({}, ReplicatedController);
u1.__index = u1;

function u1._new() -- Line: 11
    -- upvalues: ReplicatedController (copy), u1 (copy)
    local Enemy = ReplicatedController.new("Enemy");
    local v2 = setmetatable(Enemy, u1);
    v2._model_to_enemy = {};
    v2:_Init();

    return v2;
end;

function u1.GetEnemy(p3, p4) -- Line: 26
    local v5 = p3._model_to_enemy[p4];

    if v5 then
        return v5;
    end;

    for _, v in pairs(p3.Objects) do
        if v.Model == p4 then
            return v;
        end;
    end;
end;

function u1.Update(p6, p7) -- Line: 40
    for _, v in pairs(p6.Objects) do
        if v.Update then
            v:Update(p7);
        end;
    end;
end;

function u1._EnemyAdded(p8, p9) -- Line: 52
    if p9.Model then
        p8._model_to_enemy[p9.Model] = p9;
    end;
end;

function u1._Init(u10) -- Line: 58
    -- upvalues: RunService (copy)
    u10.ObjectAdded:Connect(function(p11) -- Line: 59
        -- upvalues: u10 (copy)
        u10:_EnemyAdded(p11);
    end);
    u10.ObjectRemoved:Connect(function(p12) -- Line: 63
        -- upvalues: u10 (copy)
        for i, v in pairs(u10._model_to_enemy) do
            if v == p12 then
                u10._model_to_enemy[i] = nil;
            end;
        end;
    end);
    RunService:BindToRenderStep("EnemyController", Enum.RenderPriority.Camera.Value + 1, function(p13) -- Line: 71
        -- upvalues: u10 (copy)
        u10:Update(p13);
    end);

    for _, v in pairs(u10.Objects) do
        u10:_EnemyAdded(v);
    end;
end;

return u1._new();