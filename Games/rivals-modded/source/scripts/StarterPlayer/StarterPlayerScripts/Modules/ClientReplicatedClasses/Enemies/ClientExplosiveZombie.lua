-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local ExplosiveZombieExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ExplosiveZombieExplosionEffect");
local u1 = setmetatable({}, ClientEnemy);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: ClientEnemy (copy), u1 (copy)
    local v2 = ClientEnemy.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 25
    -- upvalues: ExplosiveZombieExplosionEffect (copy), BetterDebris (copy), Utility (copy), ClientEnemy (copy)
    if p5 ~= "ZombieExplosionEffect" then
        ClientEnemy.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    if not p4:IsRendered() then
        return;
    end;

    local v6, v7 = ...;
    local v8 = ExplosiveZombieExplosionEffect:Clone();
    v8.CFrame = CFrame.new(v6);
    v8.Parent = p4.Model;
    BetterDebris:AddItem(v8, 10);
    Utility:CreateSound("rbxassetid://13455969017", 0.5, 0.75, v8, true, 10);
    Utility:CreateSound("rbxassetid://103343386215625", 1, 0.95 + 0.1 * math.random(), v8, true, 10);

    for _, descendant in pairs(v8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(descendant, v7 / 3);
        end;
    end;

    Utility:PlayParticles(v8);
end;

function u1._Init(p9) -- Line: 57
end;

return u1;