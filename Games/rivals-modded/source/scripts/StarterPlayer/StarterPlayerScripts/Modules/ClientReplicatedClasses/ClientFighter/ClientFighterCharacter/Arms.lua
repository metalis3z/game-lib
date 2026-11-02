-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = { "RightShoulderBallSocket", "RightElbowBallSocket", "RightWristBallSocket" };
local u2 = { "LeftShoulderBallSocket", "LeftElbowBallSocket", "LeftWristBallSocket" };
local u3 = {};
u3.__index = u3;

function u3.new(p4) -- Line: 12
    -- upvalues: u3 (copy)
    local v5 = setmetatable({}, u3);
    v5.ClientFighterCharacter = p4;
    v5._destroyed = false;
    v5._right_hand_ik_control = Instance.new("IKControl");
    v5._left_hand_ik_control = Instance.new("IKControl");
    v5._ik_control_target_item = nil;
    v5._ik_arms_disable_hash = 0;
    v5._arm_ball_socket_constraints = {};
    v5:_Init();

    return v5;
end;

function u3.SetIKControlTargetItem(p6, p7) -- Line: 34
    if p7 == p6._ik_control_target_item then
        return;
    end;

    p6._ik_control_target_item = p7;
    p6._right_hand_ik_control.Enabled = false;
    p6._left_hand_ik_control.Enabled = false;
    local v8;

    if p6._ik_control_target_item and not p6._ik_control_target_item.ViewModel.RightArmIKControlDisabled then
        v8 = p6._ik_control_target_item.ViewModel.Model.RightArm.HandAttachment or nil;
    else
        v8 = nil;
    end;

    p6._right_hand_ik_control.Target = v8;
    local v9;

    if p6._ik_control_target_item and not p6._ik_control_target_item.ViewModel.LeftArmIKControlDisabled then
        v9 = p6._ik_control_target_item.ViewModel.Model.LeftArm.HandAttachment or nil;
    else
        v9 = nil;
    end;

    p6._left_hand_ik_control.Target = v9;
    p6:_UpdateArmBallSocketConstraints();
    p6:Update(0, nil);
end;

function u3.DisableIKArms(u10, u11, u12, u13) -- Line: 50
    -- upvalues: RunService (copy)
    u10._ik_arms_disable_hash = u10._ik_arms_disable_hash + 1;
    local _ik_arms_disable_hash = u10._ik_arms_disable_hash;

    local function set(p14) -- Line: 54
        -- upvalues: u12 (copy), u10 (copy), u13 (copy)
        if not u12 then
            u10._right_hand_ik_control.Weight = p14;
        end;

        if not u13 then
            u10._left_hand_ik_control.Weight = p14;
        end;
    end;

    if u11 < (1 / 0) then
        task.spawn(function() -- Line: 69
            -- upvalues: u11 (copy), _ik_arms_disable_hash (copy), u10 (copy), u12 (copy), u13 (copy), RunService (ref)
            local v15 = tick();

            while tick() < v15 + u11 do
                if _ik_arms_disable_hash ~= u10._ik_arms_disable_hash then
                    return;
                end;

                local v16 = (tick() - v15) / u11;
                local v17 = math.clamp(v16, 0, 1) ^ 4;

                if not u12 then
                    u10._right_hand_ik_control.Weight = v17;
                end;

                if not u13 then
                    u10._left_hand_ik_control.Weight = v17;
                end;

                RunService.RenderStepped:Wait();
            end;

            if not u12 then
                u10._right_hand_ik_control.Weight = 1;
            end;

            if not u13 then
                u10._left_hand_ik_control.Weight = 1;
            end;
        end);

        return;
    end;

    if not u12 then
        u10._right_hand_ik_control.Weight = 0;
    end;

    if not u13 then
        u10._left_hand_ik_control.Weight = 0;
    end;
end;

function u3.Update(p18, p19, p20) -- Line: 86
    if p20 and not p20.IsAlive or p18.ClientFighterCharacter:IsHidden() then
        return;
    end;

    local v21 = p18._ik_control_target_item and (p18._ik_control_target_item.ViewModel.Model.HumanoidRootPart.Position - p18.ClientFighterCharacter.RootPart.Position).Magnitude < 16;
    p18._right_hand_ik_control.Enabled = p18._right_hand_ik_control.Target and v21;
    p18._left_hand_ik_control.Enabled = p18._left_hand_ik_control.Target and v21;
    p18:_UpdateArmBallSocketConstraints();
end;

function u3.Destroy(p22) -- Line: 98
    p22._destroyed = true;
    p22._ik_control_target_item = nil;
    p22._ik_arms_disable_hash = p22._ik_arms_disable_hash + 1;
    p22._right_hand_ik_control:Destroy();
    p22._left_hand_ik_control:Destroy();
end;

function u3._UpdateArmBallSocketConstraints(p23) -- Line: 111
    for i, v in pairs(p23._arm_ball_socket_constraints) do
        i.Enabled = not v.Enabled;
    end;
end;

function u3._SetupAsync(p24) -- Line: 117
    -- upvalues: u1 (copy), u2 (copy), Utility (copy)
    p24.ClientFighterCharacter:WaitUntilIsInWorld();

    if p24._destroyed then
        return;
    end;

    p24._right_hand_ik_control.Name = "RightHandIKControl";
    p24._right_hand_ik_control.EndEffector = p24.ClientFighterCharacter.Model:WaitForChild("RightHand");
    p24._right_hand_ik_control.ChainRoot = p24.ClientFighterCharacter.Model:WaitForChild("RightUpperArm");
    p24._right_hand_ik_control.SmoothTime = 0;
    p24._right_hand_ik_control.Enabled = false;
    p24._right_hand_ik_control.Parent = p24.ClientFighterCharacter.Humanoid;
    p24._left_hand_ik_control.Name = "LeftHandIKControl";
    p24._left_hand_ik_control.EndEffector = p24.ClientFighterCharacter.Model:WaitForChild("LeftHand");
    p24._left_hand_ik_control.ChainRoot = p24.ClientFighterCharacter.Model:WaitForChild("LeftUpperArm");
    p24._left_hand_ik_control.SmoothTime = 0;
    p24._left_hand_ik_control.Enabled = false;
    p24._left_hand_ik_control.Parent = p24.ClientFighterCharacter.Humanoid;

    for _, v in pairs({
        { u1, p24._right_hand_ik_control },
        { u2, p24._left_hand_ik_control }
    }) do
        local table_unpack_ret, v25 = table.unpack(v);

        for _, v2 in pairs(table_unpack_ret) do
            local v26 = Utility:WaitForChildRecursive(p24.ClientFighterCharacter.Model, v2);
            p24._arm_ball_socket_constraints[v26] = v25;
        end;
    end;

    p24:Update(0, nil);
    p24:_UpdateArmBallSocketConstraints();
end;

function u3._Init(u27) -- Line: 152
    u27.ClientFighterCharacter.EmoteStatusChanged:Connect(function() -- Line: 153
        -- upvalues: u27 (copy)
        if u27.ClientFighterCharacter:IsEmoting() then
            u27:DisableIKArms((1 / 0));

            return;
        end;

        u27:DisableIKArms(0);
    end);
    u27.ClientFighterCharacter:AddConnection(u27.ClientFighterCharacter.ClientFighter.EquippedItemChanged:Connect(function() -- Line: 161
        -- upvalues: u27 (copy)
        u27:Update(nil, nil);
    end));
    task.defer(u27._SetupAsync, u27);
end;

return u3;