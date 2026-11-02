-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ExtinguishParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ExtinguishParticles");

return function(p1) -- Line: 9
    -- upvalues: ExtinguishParticles (copy), BetterDebris (copy), Utility (copy)
    local v2 = ExtinguishParticles:Clone();
    v2.CFrame = p1;
    v2.Parent = workspace;
    BetterDebris:AddItem(v2, 10);
    Utility:CreateSound("rbxassetid://16812185839", 0.75, 1.3 + 0.2 * math.random(), v2, true);
    Utility:CreateSound("rbxassetid://16812389263", 0.75, 1.3 + 0.2 * math.random(), v2, true);
    Utility:PlayParticles(v2.Attachment);
end;