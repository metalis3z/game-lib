-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local ExogunExplosionParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ExogunExplosionParticles");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(131, 255, 117));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._reload_attachment = v3.Model:FindFirstChild("_exogun_reload", true);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 28
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, p6, p7, p8, p9) -- Line: 32
    -- upvalues: ExogunExplosionParticles (copy), BetterDebris (copy), Utility (copy)
    local v10 = (p8 or ExogunExplosionParticles):Clone();
    v10.CFrame = CFrame.new(p6);
    v10.Parent = workspace;
    BetterDebris:AddItem(v10, 5);
    Utility:CreateSound("rbxassetid://17245106793", 0.375, 1 + 0.5 * math.random(), v10, true, 10);

    for _, child in pairs(v10.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p7 / 8);
        end;
    end;

    Utility:PlayParticles(v10.Attachment);
end;

function u1.PlayReloadParticles(p11) -- Line: 49
    for _, child in pairs(p11._reload_attachment:GetChildren()) do
        child:Emit(20);
    end;
end;

function u1._Init(p12) -- Line: 59
end;

return u1;