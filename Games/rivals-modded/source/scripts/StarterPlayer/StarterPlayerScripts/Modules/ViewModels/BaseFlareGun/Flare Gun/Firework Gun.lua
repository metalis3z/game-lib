-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseFlareGun["Flare Gun"]);
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 11
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2._Init(u5) -- Line: 29
    -- upvalues: Utility (copy), RunService (copy)
    task.defer(function() -- Line: 30
        -- upvalues: u5 (copy), Utility (ref), RunService (ref)
        u5.ClientItem.ProjectileShot:Connect(function(p6, p7) -- Line: 31
            -- upvalues: Utility (ref), u5 (ref), RunService (ref)
            local Primary = p7.Primary;
            local explode = p7.Primary.explode;
            Utility:CreateSound("rbxassetid://17684836623", 1.25, 1, Primary, true, 5);
            local v8 = tick() + 0.5;

            while not u5._destroyed and (p7:IsDescendantOf(workspace) and (tick() < v8 or p6.Velocity.Y >= 0)) do
                RunService.RenderStepped:Wait();
            end;

            Utility:PlayParticles(explode);
            Utility:CreateSound("rbxassetid://17684836889", 1.25, 1, Primary, true, 5);
        end);
    end);
end;

return u2;