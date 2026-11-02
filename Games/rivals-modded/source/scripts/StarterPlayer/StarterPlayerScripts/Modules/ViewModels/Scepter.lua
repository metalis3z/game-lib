-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ScepterExplosionParticles"):WaitForChild("Attachment");
local Attachment2 = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ScepterTransformParticles"):WaitForChild("Attachment");
local Attachment3 = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ScepterCastParticles"):WaitForChild("Attachment");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._cast_attachment = v3.ItemModel:FindFirstChild("_scepter_cast", true);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 29
    -- upvalues: BetterDebris (copy), Utility (copy), Attachment (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p5);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://104637136404553", 1, 2 + 0.5 * math.random(), Part, true, 10);
    local v7 = Attachment:Clone();

    for _, child in pairs(v7:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p6 / 4);
        end;
    end;

    v7.PointLight.Range = p6 * 2;
    v7.Parent = Part;
    Utility:PlayParticles(v7);
end;

function u1.PlayCastParticles(p8, p9, p10) -- Line: 56
    -- upvalues: BetterDebris (copy), Attachment3 (copy), Utility (copy)
    local _cast_attachment = p8._cast_attachment;

    if p9 then
        _cast_attachment = Instance.new("Part");
        _cast_attachment.CanCollide = false;
        _cast_attachment.CanQuery = false;
        _cast_attachment.CanTouch = false;
        _cast_attachment.Anchored = true;
        _cast_attachment.Transparency = 1;
        _cast_attachment.CFrame = CFrame.new(p9);
        _cast_attachment.Parent = workspace;
        BetterDebris:AddItem(_cast_attachment, 5);
    end;

    local v11 = Attachment3:Clone();
    v11.Parent = _cast_attachment;
    BetterDebris:AddItem(v11, 5);

    if p10 then
        for _, descendant in pairs(v11:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                Utility:ScaleParticleEmitter(descendant, p10);
            end;
        end;
    end;

    Utility:PlayParticles(v11);
end;

function u1.TransformProjectile(p12, p13, p14) -- Line: 88
    -- upvalues: Utility (copy), Attachment2 (copy)
    if not (p13 and p14) then
        return;
    end;

    Utility:CreateSound("rbxassetid://81429998577064", 1, 1.5 + 0.5 * math.random(), p13, true, 10);
    p14.Part.Normal:Destroy();

    for _, descendant in pairs(p14.Part.Transformed:GetDescendants()) do
        if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    local v15 = Attachment2:Clone();
    v15.Parent = p14.Part;
    Utility:PlayParticles(v15);
end;

function u1._Init(u16) -- Line: 112
    task.defer(function() -- Line: 113
        -- upvalues: u16 (copy)
        u16.ClientItem.ProjectileShot:Connect(function() -- Line: 114
            -- upvalues: u16 (ref)
            u16:PlayCastParticles();
        end);
    end);
end;

return u1;