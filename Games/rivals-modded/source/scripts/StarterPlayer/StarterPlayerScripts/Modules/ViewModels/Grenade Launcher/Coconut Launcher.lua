-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Grenade Launcher"]);
local CoconutExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("CoconutExplosionEffect");
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
    -- upvalues: BetterDebris (copy), Utility (copy), CoconutExplosionEffect (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p6) * CFrame.fromOrientation(1.5707963267948966, 1.5707963267948966, 0);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://13455969017", 0.375, 0.75 + 0.15 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://109294645108023", 1.25, 0.9 + 0.2 * math.random(), Part, true, 10);

    for _, child in pairs(CoconutExplosionEffect:GetChildren()) do
        child:Clone().Parent = Part;
    end;

    for _, descendant in pairs(Part:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(descendant, p7 / 12);
        end;
    end;

    Utility:PlayParticles(Part);
end;

function u2._Init(p8) -- Line: 55
end;

return u2;