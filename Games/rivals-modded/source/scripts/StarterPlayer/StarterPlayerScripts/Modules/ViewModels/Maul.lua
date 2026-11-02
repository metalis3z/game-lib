-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local MaulSlamParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.MaulSlamParticles;
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.SlamSoundEffect(p4, p5, p6) -- Line: 25
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://72483809453170", 1 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5, true, 10);
    Utility:CreateSound("rbxassetid://129922197154277", 1 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5, true, 10);
end;

function u1.SlamEffect(p7, p8, p9) -- Line: 30
    -- upvalues: MaulSlamParticles (copy), BetterDebris (copy), Utility (copy)
    local v10 = MaulSlamParticles:Clone();
    v10.CFrame = CFrame.new(p8) + Vector3.new(0, 0.1, 0);
    v10.Parent = workspace;
    BetterDebris:AddItem(v10, 10);
    Utility:ScaleParticleEmitter(v10, p9 / 32);
    Utility:PlayParticles(v10);
end;

function u1._Init(p11) -- Line: 43
end;

return u1;