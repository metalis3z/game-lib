-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Flashbang = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Flashbang);
local u1 = setmetatable({}, Flashbang);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Flashbang (copy), u1 (copy)
    local v2 = Flashbang.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayFlashSound(p4, p5) -- Line: 23
    -- upvalues: Flashbang (copy), Utility (copy)
    Flashbang.PlayFlashSound(p4, p5);
    Utility:CreateSound("rbxassetid://137109782386847", 2, 1, p5, true, 10);
end;

function u1._Init(u6) -- Line: 32
    -- upvalues: RunService (copy)
    task.defer(function() -- Line: 33
        -- upvalues: u6 (copy), RunService (ref)
        table.insert(u6._connections, u6.ClientItem.ProjectileThrown:Connect(function(p7, p8) -- Line: 34
            -- upvalues: u6 (ref), RunService (ref)
            local Neon = p8.Neon;
            local v9 = tick();

            while p7:IsDescendantOf(workspace) do
                local v10 = (tick() - v9) / u6.ClientItem.Info.DetonateDelay;
                Neon.Transparency = 1 - math.min(1, v10) ^ 4;
                RunService.RenderStepped:Wait();
            end;
        end));
    end);
end;

return u1;