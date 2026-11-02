-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Spring = require(ReplicatedStorage.Modules.Spring);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighterCharacter = p2;
    v3._camera_rotation_spring = Spring.new(Vector2.zero, 1, 50);
    v3._camera_lean_spring = Spring.new(0, 1, 20);
    v3._waist_joint = nil;
    v3._waist_joint_is_motor6d = nil;
    v3._neck_joint = nil;
    v3._neck_joint_is_motor6d = nil;
    v3._root_joint = nil;
    v3._root_joint_is_motor6d = nil;
    v3._root_joint_origin = nil;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6) -- Line: 32
    if not p6.IsAlive or p4.ClientFighterCharacter:IsHidden() then
        return;
    end;

    p4._camera_lean_spring.Target = p6.CameraLean;
    p4._camera_rotation_spring.Target = Vector2.new(p6.CameraRotationRaw.X > 3.141592653589793 and p6.CameraRotationRaw.X - 6.283185307179586 or p6.CameraRotationRaw.X, p6.CameraRotationRaw.Y > 3.141592653589793 and p6.CameraRotationRaw.Y - 6.283185307179586 or p6.CameraRotationRaw.Y);
    local Value = p4._camera_rotation_spring.Value;
    local Value2 = p4._camera_lean_spring.Value;

    if p4._waist_joint then
        local v7 = CFrame.new(p4._waist_joint.C0.Position) * CFrame.Angles(Value.X * 0.25, 0, 0);
        local CFrame_new_ret = CFrame.new(p4._waist_joint.C1.Position);

        if p4._waist_joint_is_motor6d then
            p4._waist_joint.C0 = v7;
            p4._waist_joint.C1 = CFrame_new_ret;
        else
            p4._waist_joint.Attachment0.CFrame = v7;
            p4._waist_joint.Attachment1.CFrame = CFrame_new_ret;
        end;
    end;

    if p4._neck_joint then
        local v8 = CFrame.new(p4._neck_joint.C0.Position) * CFrame.Angles(Value.X * 0.75, 0, 0);
        local CFrame_new_ret = CFrame.new(p4._neck_joint.C1.Position);

        if p4._neck_joint_is_motor6d then
            p4._neck_joint.C0 = v8;
            p4._neck_joint.C1 = CFrame_new_ret;
        else
            p4._neck_joint.Attachment0.CFrame = v8;
            p4._neck_joint.Attachment1.CFrame = CFrame_new_ret;
        end;
    end;

    if p4._root_joint and p4._root_joint_origin then
        local v9 = p4._root_joint_origin * CFrame.new(Value2 * 1.25, 0, 0) * CFrame.Angles(0, 0, Value2 * -0.3490658503988659);

        if p4._root_joint_is_motor6d then
            p4._root_joint.C0 = v9;

            return;
        end;

        p4._root_joint.Attachment0.CFrame = v9;
    end;
end;

function u1.Destroy(p10) -- Line: 83
end;

function u1._SetupAsync(p11) -- Line: 91
    p11.ClientFighterCharacter:WaitUntilIsInWorld();
    p11._waist_joint = p11.ClientFighterCharacter.Model:WaitForChild("UpperTorso"):WaitForChild("Waist");
    p11._waist_joint_is_motor6d = p11._waist_joint:IsA("Motor6D");
    p11._neck_joint = p11.ClientFighterCharacter.Model:WaitForChild("Head"):WaitForChild("Neck");
    p11._neck_joint_is_motor6d = p11._neck_joint:IsA("Motor6D");
    p11._root_joint = p11.ClientFighterCharacter.Model:WaitForChild("LowerTorso"):WaitForChild("Root");
    p11._root_joint_is_motor6d = p11._root_joint:IsA("Motor6D");
    p11._root_joint_origin = p11._root_joint.C0;
end;

function u1._Init(p12) -- Line: 105
    task.spawn(p12._SetupAsync, p12);
end;

return u1;