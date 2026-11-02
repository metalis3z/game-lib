-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Freeze Ray"]);
local BubbleRayExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("BubbleRayExplosionEffect");
local u2 = { "rbxassetid://6928709440", "rbxassetid://6928709814", "rbxassetid://6928710129", "rbxassetid://6928710411", "rbxassetid://6928710904", "rbxassetid://6928711244" };
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
    -- upvalues: BubbleRayExplosionEffect (copy), BetterDebris (copy), Utility (copy), u2 (copy)
    local v9 = BubbleRayExplosionEffect:Clone();
    v9.CFrame = CFrame.new(p7);
    v9.Parent = workspace;
    BetterDebris:AddItem(v9, 5);

    for i = 1, 8 do
        Utility:CreateSound(u2[math.random(#u2)], 0.75, 1 + 0.2 * math.random(), v9, true, 10);
        local _ = i;
    end;

    for _, child in pairs(v9.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p8 / 8);
        end;
    end;

    Utility:PlayParticles(v9.Attachment);
end;

function u3._Init(p10) -- Line: 49
end;

return u3;