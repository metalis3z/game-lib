-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local BaseWarpstone = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseWarpstone);
local u1 = setmetatable({}, BaseWarpstone);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: BaseWarpstone (copy), u1 (copy)
    local v2 = BaseWarpstone.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(u4) -- Line: 28
    -- upvalues: Utility (copy)
    task.defer(function() -- Line: 29
        -- upvalues: u4 (copy), Utility (ref)
        u4.ClientItem.ProjectileThrown:Connect(function(p5, p6) -- Line: 30
            -- upvalues: u4 (ref), Utility (ref)
            u4:_PlayWarpstoneSounds(Utility:CreateSound("rbxassetid://132455961912409", 0.5, 0.9 + 0.2 * math.random(), p5, true));
        end);
    end);
end;

return u1;