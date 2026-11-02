-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Subspace Tripmine"]);
local HazardSignExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("HazardSignExplosionEffect");
local HazardSignChark = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("HazardSignChark");
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 14
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.ExplosionEffect(p5, u6) -- Line: 26
    -- upvalues: BetterDebris (copy), Utility (copy), HazardSignExplosionEffect (copy), HazardSignChark (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(u6) * CFrame.fromOrientation(1.5707963267948966, 1.5707963267948966, 0);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://17812496122", 1, 0.9 + 0.2 * math.random(), Part, true, 10);

    for _, child in pairs(HazardSignExplosionEffect:GetChildren()) do
        child:Clone().Parent = Part;
    end;

    for _, child in pairs(Part:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p5.ClientItem.Info.ExplosionRadius / 6);
        end;
    end;

    Part.PointLight.Range = p5.ClientItem.Info.ExplosionRadius * 2;
    Utility:PlayParticles(Part);
    task.spawn(function() -- Line: 51
        -- upvalues: HazardSignChark (ref), BetterDebris (ref), u6 (copy), Utility (ref)
        local u7 = HazardSignChark:Clone();
        u7.Parent = workspace;
        BetterDebris:AddItem(u7, 5);
        local u8 = CFrame.new(u6) * CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0) + Vector3.new(0, 5, 0);
        local u9 = u8 - Vector3.new(0, 25, 0);
        Utility:RenderstepForLoop(0, 100, 3, function(p10) -- Line: 59
            -- upvalues: u7 (copy), u8 (copy), u9 (copy)
            u7:PivotTo(u8:Lerp(u9, (p10 / 100) ^ 4));
        end);
        u7:Destroy();
    end);
end;

function u2._Init(p11) -- Line: 73
end;

return u2;