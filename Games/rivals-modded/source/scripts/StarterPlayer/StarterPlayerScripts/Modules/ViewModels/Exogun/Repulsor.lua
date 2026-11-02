-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Exogun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Exogun);
local RepulsorExplosionParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("RepulsorExplosionParticles");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(55, 218, 255));
local u1 = setmetatable({}, Exogun);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Exogun (copy), u1 (copy)
    local v2 = Exogun.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 26
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, p6, p7) -- Line: 30
    -- upvalues: RepulsorExplosionParticles (copy), BetterDebris (copy), Utility (copy)
    local v8 = RepulsorExplosionParticles:Clone();
    v8.CFrame = CFrame.new(p6);
    v8.Parent = workspace;
    BetterDebris:AddItem(v8, 5);
    Utility:CreateSound("rbxassetid://17245106793", 0.125, 1 + 0.5 * math.random(), v8, true, 10);
    Utility:CreateSound("rbxassetid://103974521039631", 0.375, 1 + 0.25 * math.random(), v8, true, 10);

    for _, child in pairs(v8.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p7 / 6);
        end;
    end;

    Utility:PlayParticles(v8.Attachment);
end;

function u1.PlayReloadParticles(p9) -- Line: 48
end;

function u1._Init(u10) -- Line: 56
    -- upvalues: Utility (copy)
    u10.AnimationPlayed:Connect(function(p11) -- Line: 57
        -- upvalues: Utility (ref), u10 (copy)
        if p11 == "Reload" then
            Utility:PlayParticles(u10._reload_attachment.Parent);
        end;
    end);
end;

return u1;