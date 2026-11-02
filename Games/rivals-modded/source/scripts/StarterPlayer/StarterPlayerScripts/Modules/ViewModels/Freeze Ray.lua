-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local FreezeRayExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("FreezeRayExplosionEffect");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 25
    -- upvalues: FreezeRayExplosionEffect (copy), BetterDebris (copy), Utility (copy)
    local v7 = FreezeRayExplosionEffect:Clone();
    v7.CFrame = CFrame.new(p5);
    v7.Parent = workspace;
    BetterDebris:AddItem(v7, 5);
    Utility:CreateSound("rbxassetid://18429092842", 0.4, 1 + 0.2 * math.random(), v7, true, 10);

    for _, child in pairs(v7.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p6 / 4);
        end;
    end;

    Utility:PlayParticles(v7.Attachment);
end;

function u1._Init(p8) -- Line: 46
end;

return u1;