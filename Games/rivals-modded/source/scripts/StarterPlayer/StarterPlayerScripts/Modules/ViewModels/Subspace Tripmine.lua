-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local SubspaceTripmineExplosion = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("SubspaceTripmineExplosion");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayHideMineSound(p4, p5) -- Line: 25
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://11956590", 1, 1, p5.Hitbox, true, 5);
end;

function u1.ExplosionEffect(p6, p7) -- Line: 29
    -- upvalues: Utility (copy), SubspaceTripmineExplosion (copy), BetterDebris (copy)
    Utility:CreateSound("rbxassetid://11984351", 0.5, 1, p7, true, 10);
    Utility:CreateSound("rbxassetid://11984254", 1, 0.75, p7, true, 10);
    local v8 = SubspaceTripmineExplosion:Clone();
    v8.CFrame = CFrame.new(p7);
    v8.PointLight.Range = p6.ClientItem.Info.ExplosionRadius * 3;
    v8.Parent = workspace;
    BetterDebris:AddItem(v8, 5);
    wait(1);
    v8.Sparkles.Enabled = false;
    local PointLight = v8.PointLight;
    Utility:RenderstepForLoop(0, 100, 1, function(p9) -- Line: 45
        -- upvalues: PointLight (copy)
        PointLight.Brightness = 40 * (1 - (p9 / 100) ^ 4);
    end);
end;

function u1._Init(p10) -- Line: 56
end;

return u1;