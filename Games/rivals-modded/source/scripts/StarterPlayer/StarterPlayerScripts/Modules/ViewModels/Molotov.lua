-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local MolotovExplosionEffects = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("MolotovExplosionEffects");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 26
    -- upvalues: MolotovExplosionEffects (copy), BetterDebris (copy), Utility (copy), WrapController (copy)
    local v7 = (MolotovExplosionEffects:FindFirstChild(p4.Name) or MolotovExplosionEffects.Default):Clone();
    v7.CFrame = CFrame.new(p5, p5 + Vector3.new(0, 1, 0));
    v7.Parent = workspace;
    BetterDebris:AddItem(v7, 5);
    Utility:CreateSound("rbxassetid://17167035482", 0.25, 1.5 + 0.25 * math.random(), v7, true, 10);

    for _, child in pairs(v7.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p6 / 16);
        end;
    end;

    Utility:PlayParticles(v7.Attachment);
    Utility:PlayParticles(v7.Attachment);
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v7), p4.ClientItem:GetWrap(), true);

    return v7;
end;

function u1._Init(p8) -- Line: 51
end;

return u1;