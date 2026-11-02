-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Grenade = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Grenade);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("SoulGrenadeExplosionEffect"):WaitForChild("Attachment");
local u1 = setmetatable({}, Grenade);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Grenade (copy), u1 (copy)
    local v2 = Grenade.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 25
    -- upvalues: BetterDebris (copy), Utility (copy), Attachment (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p5);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://13455969017", 0.5, 0.9 + 0.2 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://127850886014523", 1, 1 + 0.2 * math.random(), Part, true, 10);
    local v7 = Attachment:Clone();

    for _, child in pairs(v7:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p6 / 24);
        end;
    end;

    v7.PointLight.Range = p6 * 2;
    v7.Parent = Part;
    Utility:PlayParticles(v7);
end;

function u1._Init(p8) -- Line: 56
end;

return u1;