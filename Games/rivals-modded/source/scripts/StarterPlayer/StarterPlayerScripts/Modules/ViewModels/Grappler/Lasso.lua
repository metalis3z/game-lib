-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Grappler = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Grappler);
local u1 = setmetatable({}, Grappler);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Grappler (copy), u1 (copy)
    local v2 = Grappler.new(...);
    local v3 = setmetatable(v2, u1);
    v3._rope_constraint = v3.ItemModel:WaitForChild("Rope 2"):WaitForChild("Part3"):WaitForChild("Attachment"):WaitForChild("RopeConstraint");
    v3._hook_submodel_hidden_until = 0;
    v3:_Init();

    return v3;
end;

function u1.HideHookSubModel(p4, p5) -- Line: 23
    p4:HideSubModel("Rope 2", p5);
    p4._hook_submodel_hidden_until = tick() + p5;
    p4:_UpdateRopeEnabled();
    task.delay(p5, p4._UpdateRopeEnabled, p4);
end;

function u1.PlayShootSounds(p6) -- Line: 30
    p6:CreateSound("rbxassetid://125047201358688", 1.25, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1.PlayPullSounds(p7) -- Line: 34
    p7:CreateSound("rbxassetid://125047201358688", 1.25, 1.4 + 0.2 * math.random(), true, 5);
end;

function u1._UpdateRopeEnabled(p8) -- Line: 42
    local _rope_constraint = p8._rope_constraint;
    local v9;

    if tick() > p8._hook_submodel_hidden_until then
        v9 = not p8.Animator:IsAnimationPlaying("Shoot") and not p8.Animator:IsAnimationPlaying("ShootWaiting");
    else
        v9 = false;
    end;

    _rope_constraint.Visible = v9;
end;

function u1._Init(u10) -- Line: 46
    u10.AnimationPlayed:Connect(function() -- Line: 47
        -- upvalues: u10 (copy)
        u10:_UpdateRopeEnabled();
    end);
    u10.AnimationStopped:Connect(function() -- Line: 51
        -- upvalues: u10 (copy)
        u10:_UpdateRopeEnabled();
    end);
    u10:_UpdateRopeEnabled();
end;

return u1;