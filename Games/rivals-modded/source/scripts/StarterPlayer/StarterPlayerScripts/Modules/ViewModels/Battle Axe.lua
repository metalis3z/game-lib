-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc.BattleAxeSpinParticles.Attachment;
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlaySpinParticles(p4) -- Line: 25
    -- upvalues: Attachment (copy), BetterDebris (copy), Utility (copy)
    local v5 = Attachment:Clone();
    v5.Parent = p4.ClientItem.ClientFighter.Entity.RootPart;
    BetterDebris:AddItem(v5, 3);
    Utility:PlayParticles(v5);

    for _, child in pairs(v5:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            child:SetAttribute("IgnoreVisibilityCheck", true);
            Utility:ScaleParticleEmitter(child, p4.ClientItem.Info.SpinRadius / 3);
        end;
    end;
end;

function u1._Init(p6) -- Line: 43
end;

return u1;