-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local DistortionExplosionParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("DistortionExplosionParticles");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(0, 255, 149));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 26
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, u6, u7, u8) -- Line: 30
    -- upvalues: DistortionExplosionParticles (copy), BetterDebris (copy), Utility (copy)
    task.delay(math.random() * 0.2, function() -- Line: 31
        -- upvalues: u8 (copy), DistortionExplosionParticles (ref), u6 (copy), BetterDebris (ref), Utility (ref), u7 (copy)
        local v9 = (u8 or DistortionExplosionParticles):Clone();
        v9.CFrame = CFrame.new(u6);
        v9.Parent = workspace;
        BetterDebris:AddItem(v9, 5);
        Utility:CreateSound("rbxassetid://97822830667649", 0.375, 0.75 + 1.25 * math.random(), v9, true, 10);

        for _, child in pairs(v9.Attachment:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                Utility:ScaleParticleEmitter(child, u7 / 4);
            end;
        end;

        Utility:PlayParticles(v9.Attachment);
    end);
end;

function u1._Init(p10) -- Line: 53
end;

return u1;