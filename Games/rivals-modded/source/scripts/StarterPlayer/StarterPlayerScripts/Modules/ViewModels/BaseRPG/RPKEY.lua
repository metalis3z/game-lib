-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local BaseRPG = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRPG);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("RPKEYExplosionEffect"):WaitForChild("Attachment");
local u1 = setmetatable({}, BaseRPG);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: BaseRPG (copy), u1 (copy)
    local v2 = BaseRPG.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayAimSound(p4, p5) -- Line: 26
    p4:CreateSound("rbxassetid://96253147006478", 0.375, 2 + (p5 and 0.1 or 0), true, 5);
end;

function u1.ExplosionEffect(p6, p7, p8) -- Line: 30
    -- upvalues: BetterDebris (copy), Utility (copy), Attachment (copy), WrapController (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p7);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://13455969017", 0.5, 0.9 + 0.2 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://18179281854", 2, 0.9 + 0.2 * math.random(), Part, true, 10);
    local v9 = Attachment:Clone();

    for _, child in pairs(v9:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p8 / 20);
        end;
    end;

    v9.PointLight.Range = p8 * 2;
    v9.Parent = Part;
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v9), p6.ClientItem:GetWrap(), true);
    Utility:PlayParticles(v9);
end;

function u1._Init(p10) -- Line: 62
    p10:_RegisterAmmoVisual(p10.ItemModel:WaitForChild("Rocket"):WaitForChild("Head"));
end;

return u1;