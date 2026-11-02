-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Freeze Ray"]);
local SpiderRayExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("SpiderRayExplosionEffect");
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 13
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.ExplosionEffect(p5, p6, p7) -- Line: 25
    -- upvalues: SpiderRayExplosionEffect (copy), BetterDebris (copy), Utility (copy)
    local v8 = SpiderRayExplosionEffect:Clone();
    v8.CFrame = CFrame.new(p6);
    v8.Parent = workspace;
    BetterDebris:AddItem(v8, 5);
    Utility:CreateSound("rbxassetid://97679859406914", 0.75, 1 + 0.2 * math.random(), v8, true, 10);

    for _, child in pairs(v8.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p7 / 8);
        end;
    end;

    Utility:PlayParticles(v8.Attachment);
end;

function u2._Init(p9) -- Line: 46
end;

return u2;