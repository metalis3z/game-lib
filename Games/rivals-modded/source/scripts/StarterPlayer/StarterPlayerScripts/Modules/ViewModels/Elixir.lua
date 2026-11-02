-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ElixirExplosionEffect"):WaitForChild("Attachment");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
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
    Utility:CreateSound("rbxassetid://95384128224111", 1, 1 + 0.25 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://104637136404553", 0.75, 1.5 + 0.5 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://139202431534769", 0.75, 1 + 0.25 * math.random(), Part, true, 10);
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

function u1._Init(p8) -- Line: 57
end;

return u1;