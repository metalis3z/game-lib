-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local BaseRPG = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRPG);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("PumpkinLauncherExplosionEffect"):WaitForChild("Attachment");
local u1 = setmetatable({}, BaseRPG);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: BaseRPG (copy), u1 (copy)
    local v2 = BaseRPG.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 25
    -- upvalues: BetterDebris (copy), Utility (copy), Attachment (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p5);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://13455969017", 0.5, 0.9 + 0.2 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://88695956388556", 1, 1 + 0.25 * math.random(), Part, true, 10);
    local v7 = Attachment:Clone();

    for _, child in pairs(v7:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p6 / 16);
        end;
    end;

    v7.PointLight.Range = p6 * 2;
    v7.Parent = Part;
    Utility:PlayParticles(v7);
end;

function u1._Init(u8) -- Line: 56
    -- upvalues: Utility (copy)
    task.defer(function() -- Line: 57
        -- upvalues: u8 (copy), Utility (ref)
        u8.ClientItem.ProjectileShot:Connect(function(p9, p10) -- Line: 58
            -- upvalues: Utility (ref)
            local v11 = Utility:CreateSound("rbxassetid://140716912879767", 0.25, 1, p10.Pumpkin, true);
            p10:GetAttributeChangedSignal("Destroying"):Wait();
            v11:Destroy();
        end);
    end);
    u8:_RegisterAmmoVisual(u8.ItemModel:WaitForChild("Rocket"):WaitForChild("Neck"));
    u8:_RegisterAmmoVisual(u8.ItemModel:WaitForChild("Rocket"):WaitForChild("Neon"));
    u8:_RegisterAmmoVisual(u8.ItemModel:WaitForChild("Rocket"):WaitForChild("Pumpkin"));
    u8:_RegisterAmmoVisual(u8.ItemModel:WaitForChild("Rocket"):WaitForChild("Stem"));
end;

return u1;