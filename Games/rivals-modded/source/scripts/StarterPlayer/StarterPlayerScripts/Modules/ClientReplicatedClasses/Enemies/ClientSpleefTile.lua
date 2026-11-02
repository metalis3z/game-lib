-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.Utility);
local ClientDestructable = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientCustomEntity.ClientDestructable);
Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ExplosiveZombieExplosionEffect");
local u1 = setmetatable({}, ClientDestructable);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientDestructable (copy), u1 (copy)
    local v2 = ClientDestructable.new(...);
    local v3 = setmetatable(v2, u1);
    v3._shatter_effect_chance = 0.5;
    v3._colored_tile_part = v3.Model:FindFirstChild("ColoredTile");
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 29
    -- upvalues: RunService (copy), ClientDestructable (copy)
    if p5 == "SpleefTileShake" then
        if not p4:IsRendered() then
            return;
        end;

        if not p4._colored_tile_part then
            return;
        end;

        local Pivot = p4._colored_tile_part:GetPivot();
        local v6 = tick();

        while p4:IsAlive() do
            local v7 = tick() - v6;
            local math_clamp_ret = math.clamp(v7, 0, 1);
            local _colored_tile_part = p4._colored_tile_part;
            local v8 = math.random() - 0.5;
            local v9 = math.random() - 0.5;
            local v10 = math.random() - 0.5;
            _colored_tile_part:PivotTo(Pivot + Vector3.new(v8, v9, v10) * math_clamp_ret * 2);
            RunService.RenderStepped:Wait();
        end;
    else
        ClientDestructable.ReplicateFromServer(p4, p5, ...);
    end;
end;

function u1._Init(u11) -- Line: 59
    u11.ShatterModelAdded:Connect(function(p12) -- Line: 60
        -- upvalues: u11 (copy)
        if not u11._colored_tile_part then
            return;
        end;

        for _, child in pairs(p12:GetChildren()) do
            if child:IsA("BasePart") then
                child.Color = u11._colored_tile_part.Color;
            end;
        end;
    end);
end;

return u1;