-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Medkit = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Medkit);
local u1 = setmetatable({}, Medkit);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Medkit (copy), u1 (copy)
    local v2 = Medkit.new(...);
    local v3 = setmetatable(v2, u1);
    v3.PlayEquipAnimationOnHeal = false;
    v3._heal_particles_attachment = v3.ItemModel:WaitForChild("Head"):WaitForChild("Head"):WaitForChild("_medkitty_heal");
    v3:_Init();

    return v3;
end;

function u1._Init(u4) -- Line: 32
    -- upvalues: Utility (copy)
    task.defer(function() -- Line: 33
        -- upvalues: u4 (copy), Utility (ref)
        table.insert(u4._connections, u4.ClientItem.AnimationReachedHealTimestamp:Connect(function() -- Line: 34
            -- upvalues: Utility (ref), u4 (ref)
            Utility:PlayParticles(u4._heal_particles_attachment);
        end));
    end);
end;

return u1;