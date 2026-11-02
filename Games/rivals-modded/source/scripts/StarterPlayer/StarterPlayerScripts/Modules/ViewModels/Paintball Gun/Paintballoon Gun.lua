-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Paintball Gun"]);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("BalloonExplosionEffect"):WaitForChild("Attachment");
local u2 = { ColorSequence.new(Color3.fromRGB(61, 90, 255)), ColorSequence.new(Color3.fromRGB(88, 255, 62)), ColorSequence.new(Color3.fromRGB(255, 232, 57)) };
local u3 = setmetatable({}, u1);
u3.__index = u3;

function u3.new(...) -- Line: 14
    -- upvalues: u1 (copy), u3 (copy)
    local v4 = u1.new(...);
    local v5 = setmetatable(v4, u3);
    v5:_Init();

    return v5;
end;

function u3.CustomImpactMarker(p6, p7) -- Line: 26
    -- upvalues: u2 (copy), Attachment (copy), Utility (copy)
    local v8 = u2[math.random(#u2)];
    local v9 = Attachment:Clone();
    v9.flash.Color = v8;
    v9.impact1.Color = v8;
    v9.impact2.Color = v8;
    v9.specs2Balloon.Color = v8;
    v9.specs2Balloon2.Color = v8;
    v9.Parent = p7;

    for _, child in pairs(v9:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, 0.16666666666666666);
        end;
    end;

    Utility:PlayParticles(v9);
end;

function u3._Init(p10) -- Line: 49
end;

return u3;