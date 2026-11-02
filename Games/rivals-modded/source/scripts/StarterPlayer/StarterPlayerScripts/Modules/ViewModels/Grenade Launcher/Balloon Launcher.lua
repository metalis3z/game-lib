-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Grenade Launcher"]);
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

function u3.ExplosionEffect(p6, p7, p8) -- Line: 26
    -- upvalues: BetterDebris (copy), Utility (copy), u2 (copy), Attachment (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p7);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://13455969017", 0.375, 0.75 + 0.15 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://101824947434055", 1.25, 0.9 + 0.2 * math.random(), Part, true, 10);
    local v9 = u2[math.random(#u2)];
    local v10 = Attachment:Clone();
    v10.flash.Color = v9;
    v10.impact1.Color = v9;
    v10.impact2.Color = v9;
    v10.specs2Balloon.Color = v9;
    v10.specs2Balloon2.Color = v9;
    v10.Parent = Part;

    for _, child in pairs(v10:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p8 / 12);
        end;
    end;

    Utility:PlayParticles(v10);
end;

function u3._Init(p11) -- Line: 61
end;

return u3;