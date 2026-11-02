-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._UpdateAnimationState(p4) -- Line: 26
    local v5 = p4.ClientItem:Get("NumReloadsSoFar") % 2 + 1;
    p4:ChangeEquipAnimation(v5 == 1 and "Equip" or "State2Equip");
    p4:ChangeIdleAnimation(v5 == 1 and "Idle" or "State2Idle");
    p4:ChangeSprintAnimation(v5 == 1 and "Sprint" or "State2Sprint");
    p4:ChangeInspectAnimation(v5 == 1 and "Inspect" or "State2Inspect");
    p4.ClientItem:ChangeShootAnimationNamePrefix(v5 == 1 and "Shoot" or "State2Shoot");
end;

function u1._Init(u6) -- Line: 41
    u6.ClientItem:GetDataChangedSignal("NumReloadsSoFar"):Connect(function() -- Line: 42
        -- upvalues: u6 (copy)
        u6:_UpdateAnimationState();
    end);
    task.defer(u6._UpdateAnimationState, u6);
end;

return u1;