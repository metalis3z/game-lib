-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Grappler = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Grappler);
local u1 = setmetatable({}, Grappler);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Grappler (copy), u1 (copy)
    local v2 = Grappler.new(...);
    local v3 = setmetatable(v2, u1);
    v3._shoot_particles_attachment = v3.ItemModel:WaitForChild("Body"):WaitForChild("Black"):WaitForChild("ShootParticles");
    v3:_Init();

    return v3;
end;

function u1.PlayShootSounds(p4) -- Line: 24
    -- upvalues: Utility (copy)
    p4:CreateSound("rbxassetid://139881930563519", 1.5, 1 + 0.1 * math.random(), true, 5);
    p4:CreateSound("rbxassetid://119208207944073", 0.875, 1 + 0.1 * math.random(), true, 5);
    Utility:PlayParticles(p4._shoot_particles_attachment);
end;

function u1.PlayPullSounds(p5) -- Line: 30
    p5:CreateSound("rbxassetid://80351710007259", 1.5, 1 + 0.1 * math.random(), true, 5);
end;

function u1._Init(p6) -- Line: 38
end;

return u1;