-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Subspace Tripmine"]);
local SpringExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("SpringExplosionEffect");
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 13
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.ExplosionEffect(p5, p6) -- Line: 25
    -- upvalues: Utility (copy), SpringExplosionEffect (copy), BetterDebris (copy)
    Utility:CreateSound("rbxassetid://18763806953", 1.75, 0.9 + 0.2 * math.random(), p6, true, 10);
    Utility:CreateSound("rbxassetid://105724753475729", 1.5, 0.9 + 0.2 * math.random(), p6, true, 10);
    local v7 = SpringExplosionEffect:Clone();
    v7.CFrame = CFrame.new(p6);
    v7.Parent = workspace;
    BetterDebris:AddItem(v7, 5);
    Utility:PlayParticles(v7);
end;

function u2._Init(p8) -- Line: 40
end;

return u2;