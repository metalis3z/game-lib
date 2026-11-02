-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("CollectEffect"):WaitForChild("Attachment");

return function(p1, p2, p3, p4) -- Line: 9
    -- upvalues: BetterDebris (copy), Attachment (copy), Utility (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p1);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    local v5 = Attachment:Clone();
    v5.Parent = Part;
    BetterDebris:AddItem(v5, 5);
    local v6 = p4 or 1;

    for _, descendant in pairs(v5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(descendant, 3 * v6);
            descendant.Color = p2 and ColorSequence.new(p2) or descendant.Color;
        end;
    end;

    Utility:PlayParticles(v5);

    if p3 then
        Utility:CreateSound(p3, 1.5, 1, Part, true, 10);
    end;
end;