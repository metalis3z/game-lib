-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ExplosionEffect"):WaitForChild("Attachment");

return function(p1, p2, p3) -- Line: 10
    -- upvalues: BetterDebris (copy), Utility (copy), Attachment (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p1);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://13455969017", 1, p3 or 0.9 + 0.2 * math.random(), Part, true, 10);
    local v4 = Attachment:Clone();

    for _, child in pairs(v4:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p2 / 24);
        end;
    end;

    v4.PointLight.Range = p2 * 2;
    v4.Parent = Part;
    Utility:PlayParticles(v4);
end;