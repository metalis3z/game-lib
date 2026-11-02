-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = CONSTANTS.IS_SERVER and require(ServerStorage.Services.CollisionsService);
local u2 = setmetatable({}, Ragdoll);
u2.__index = u2;

function u2.new(...) -- Line: 11
    -- upvalues: Ragdoll (copy), u2 (copy)
    local v3 = Ragdoll.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayServer(p5, ...) -- Line: 23
    -- upvalues: Ragdoll (copy), u1 (copy)
    Ragdoll.PlayServer(p5, ...);
    p5:_AnchorModel(0, false);

    if not p5._is_humanoid then
        return;
    end;

    local v6 = script.Model:Clone();
    v6.Hitbox.CanCollide = false;
    v6.Hitbox.Anchored = true;
    v6:PivotTo(p5._subject.RootPart.CFrame * CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2));
    v6.Parent = p5._subject;
    table.insert(p5._destroy_these, v6);

    for _, v in pairs({ "RightHand", "RightFoot", "LeftHand", "LeftFoot" }) do
        local v7 = p5._subject.Parent and p5._subject.Parent:FindFirstChild(v);

        if v7 then
            local Attachment = Instance.new("Attachment");
            Attachment.Parent = v7;
            local AlignPosition = Instance.new("AlignPosition");
            AlignPosition.MaxForce = 100000;
            AlignPosition.Responsiveness = 25;
            AlignPosition.Attachment0 = Attachment;
            AlignPosition.Attachment1 = v6.Hitbox[v];
            AlignPosition.Parent = Attachment;
            local AlignOrientation = Instance.new("AlignOrientation");
            AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
            AlignOrientation.Attachment0 = Attachment;
            AlignOrientation.CFrame = v7.CFrame;
            AlignOrientation.Parent = Attachment;
        end;
    end;

    u1:SetDescendants(p5._subject.Parent, "OnlyMap");
    v6.Hitbox.CanCollide = true;
    v6.Hitbox.Anchored = false;
    v6.Hitbox:SetNetworkOwner(nil);
    v6.Hitbox.AssemblyLinearVelocity = Random.new():NextUnitVector() * (24 + 8 * math.random());
end;

function u2.PlayClient(p8, ...) -- Line: 69
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayClient(p8, ...);
    p8:CreateSound("rbxassetid://70645035845566", 1, 1 + 0.1 * math.random(), p8._is_humanoid and p8._subject.RootPart or p8._subject, true, 10);
end;

function u2._Init(p9) -- Line: 78
end;

return u2;