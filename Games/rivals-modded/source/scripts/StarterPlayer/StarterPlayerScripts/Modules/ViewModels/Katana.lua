-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("WrapController"));
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local DeflectActiveEffects = Players.LocalPlayer.PlayerScripts.Assets.Misc.DeflectActiveEffects;
local DeflectHitEffects = Players.LocalPlayer.PlayerScripts.Assets.Misc.DeflectHitEffects;
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._deflect_hit_attachment = nil;
    v3._deflect_active_attachment = nil;
    v3._deflect_active_attachment_not_local = nil;
    v3:_Init();

    return v3;
end;

function u1.PlayDeflectActiveParticles(p4) -- Line: 30
    -- upvalues: Utility (copy)
    Utility:PlayParticles(p4._deflect_active_attachment);

    if not p4.ClientItem.ClientFighter:Get("IsSpectating") then
        local v5;

        if p4.ClientItem.ClientFighter.Entity then
            v5 = p4.ClientItem.ClientFighter.Entity.RootPart or nil;
        else
            v5 = nil;
        end;

        p4._deflect_active_attachment_not_local.Parent = v5;
        Utility:PlayParticles(p4._deflect_active_attachment_not_local);
    end;
end;

function u1.PlayDeflectHitParticles(p6) -- Line: 39
    -- upvalues: Utility (copy)
    Utility:PlayParticles(p6._deflect_hit_attachment);
end;

function u1.PlayDeflectHitSounds(p7) -- Line: 43
    p7:CreateSound("rbxassetid://14776414133", 1.25, 1.5 + 0.5 * math.random(), true, 5);
    p7:CreateSound("rbxassetid://14776437962", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1.ClearDeflectActiveParticles(p8) -- Line: 48
    for _, descendant in pairs(p8._deflect_active_attachment_not_local:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Clear();
        end;
    end;
end;

function u1.Destroy(p9) -- Line: 56
    -- upvalues: ClientViewModel (copy)
    p9._deflect_active_attachment_not_local:Destroy();
    ClientViewModel.Destroy(p9);
end;

function u1._Setup(p10) -- Line: 65
    -- upvalues: DeflectHitEffects (copy), DeflectActiveEffects (copy), WrapController (copy)
    p10._deflect_hit_attachment = p10.ItemModel:FindFirstChild("_katana_deflect_hit", true);
    p10._deflect_active_attachment = p10.ItemModel:FindFirstChild("_katana_deflect_active", true);
    local v11 = {};

    if p10._deflect_hit_attachment then
        for _, child in pairs((DeflectHitEffects:FindFirstChild(p10.Name) or DeflectHitEffects.Default).Attachment:GetChildren()) do
            local v12 = child:Clone();
            v12.Parent = p10._deflect_hit_attachment;
            table.insert(v11, v12);
        end;
    end;

    if p10._deflect_active_attachment then
        local v13 = DeflectActiveEffects:FindFirstChild(p10.Name) or DeflectActiveEffects.Default;

        for _, child in pairs(v13.Attachment:GetChildren()) do
            local v14 = child:Clone();
            v14.Parent = p10._deflect_active_attachment;
            table.insert(v11, v14);
        end;

        p10._deflect_active_attachment_not_local = Instance.new("Attachment");
        p10._deflect_active_attachment_not_local.Name = "_katana_deflect_active_not_local";

        for _, child in pairs(v13.NotLocal:GetChildren()) do
            local v15 = child:Clone();
            v15.Parent = p10._deflect_active_attachment_not_local;
            table.insert(v11, v15);
        end;
    end;

    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v11), p10.ClientItem:GetWrap(), true);
end;

function u1._Init(p16) -- Line: 101
    p16:_Setup();
end;

return u1;