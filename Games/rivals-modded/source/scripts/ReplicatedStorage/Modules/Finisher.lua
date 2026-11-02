-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local TestLibrary = require(ReplicatedStorage.Modules.TestLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = CONSTANTS.IS_SERVER and require(ServerStorage.Services.CollisionsService);

if CONSTANTS.IS_CLIENT then
    require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
end;

local u2 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local TestAttribute = TestLibrary:GetTestAttribute("StudioPing");
local IS_STUDIO = CONSTANTS.IS_STUDIO;
local u3 = {};
u3.__index = u3;

function u3.new(p4, p5, p6) -- Line: 21
    -- upvalues: u3 (copy)
    local v7;

    if typeof(p4) == "Instance" then
        v7 = p4:IsA("Humanoid") or p4:IsA("BasePart");
    else
        v7 = false;
    end;

    assert(v7, "Argument 1 invalid, expected a Humanoid or BasePart");
    local v8 = setmetatable({}, u3);
    v8._subject = p4;
    v8._is_humanoid = v8._subject:IsA("Humanoid");
    v8._is_final_finisher = p5;
    v8._eliminator = p6;
    v8._anchor_model_hash = 0;
    v8._destroy_these = {};
    v8._connections = {};
    v8._threads = {};
    v8._destroyed = false;
    v8._serial = nil;
    v8._seed = math.random(1, 1000000);
    v8._original_collision_groups = {};
    v8._ragdolled = false;
    v8:_Init();

    return v8;
end;

function u3.CreateSound(p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19) -- Line: 49
    -- upvalues: Utility (copy)
    if not p13 then
        p13 = p9._is_humanoid and p9._subject.RootPart;
    end;

    local v20 = Utility:CreateSound(p10, p11, p12, p13, p14, p15, p16, p17, p9:_GetSoundGroup(), p19);
    table.insert(p9._destroy_these, v20);

    return v20;
end;

function u3.Simulate(u21, u22) -- Line: 58
    -- upvalues: IS_STUDIO (copy), TestAttribute (copy)
    local BindableEvent = Instance.new("BindableEvent");
    table.insert(u21._destroy_these, BindableEvent);
    local u23 = 0;
    task.spawn(function() -- Line: 64
        -- upvalues: u21 (copy), u22 (copy), IS_STUDIO (ref), u23 (ref), BindableEvent (copy)
        local success, result = pcall(u21.PlayServer, u21, true);

        if not success and u22 then
            u22(result);
        end;

        if not success and IS_STUDIO then
            error(result);
        end;

        u23 = u23 + 1;
        BindableEvent:Fire();
    end);
    task.spawn(function() -- Line: 79
        -- upvalues: TestAttribute (ref), u21 (copy), u22 (copy), IS_STUDIO (ref), u23 (ref), BindableEvent (copy)
        if TestAttribute and TestAttribute > 0 then
            wait(TestAttribute / 1000);
        end;

        local success, result = pcall(u21.PlayClient, u21, true);

        if not success and u22 then
            u22(result);
        end;

        if not success and IS_STUDIO then
            error(result);
        end;

        u23 = u23 + 1;
        BindableEvent:Fire();
    end);

    while u23 < 2 do
        BindableEvent.Event:Wait();
    end;
end;

function u3.PlayServer(p24, p25) -- Line: 103
end;

function u3.PlayClient(p26, p27) -- Line: 107
end;

function u3.SetSerial(p28, p29) -- Line: 111
    p28._serial = p29;
end;

function u3.Serialize(p30) -- Line: 115
    return {
        Seed = p30._seed
    };
end;

function u3.Destroy(p31) -- Line: 123
    p31._destroyed = true;

    for _, v in pairs(p31._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p31._destroy_these) do
        v:Destroy();
    end;

    for _, v in pairs(p31._threads) do
        pcall(task.cancel, v);
    end;
end;

function u3._GetSoundGroup(p32) -- Line: 143
    -- upvalues: u2 (copy)
    local v33;

    if typeof(p32._eliminator) == "Instance" then
        v33 = p32._eliminator;
    else
        v33 = false;
    end;

    return v33 and v33 ~= (u2 and u2.CurrentSubject and u2.CurrentSubject.Player) and "FinisherFromOthers" or "Finisher";
end;

function u3._GetGroundPosition(p34, p35, p36) -- Line: 150
    -- upvalues: Utility (copy)
    return Utility:Raycast(p35, p35 + Vector3.new(0, -100, 0), 100, p36, Enum.RaycastFilterType.Exclude).Position;
end;

function u3._HideBody(p37, p38) -- Line: 154
    for _, v in pairs(p37:_GetObjects(true)) do
        if not (p38 and table.find(p38, v)) then
            if v:IsA("BasePart") then
                v.Transparency = 1;
                v.Size = Vector3.new(0, 0, 0);
            elseif v ~= p37._subject then
                v:Destroy();
            end;
        end;
    end;
end;

function u3._GetObjects(p39, p40) -- Line: 169
    return p39._is_humanoid and (not p39._subject.Parent and {} or p39._subject.Parent[p40 and "GetDescendants" or "GetChildren"](p39._subject.Parent)) or { p39._subject };
end;

function u3._BreakJoints(p41) -- Line: 173
    if not (p41._is_humanoid and p41._subject.Parent) then
        return;
    end;

    for _, descendant in pairs(p41._subject.Parent:GetDescendants()) do
        if descendant:IsA("Motor6D") then
            descendant.Part0 = nil;
            descendant.Part1 = nil;
            descendant:Destroy();
        elseif descendant:IsA("MeshPart") then
            descendant.AssemblyLinearVelocity = p41._subject.RootPart.AssemblyLinearVelocity;
            descendant.AssemblyAngularVelocity = p41._subject.RootPart.AssemblyAngularVelocity;

            if descendant.Name == "Head" and descendant.Parent == p41._subject.Parent then
                descendant.CanCollide = true;
            end;
        end;
    end;

    p41._subject.Parent.DescendantAdded:Connect(function(p42) -- Line: 193
        if not p42:IsA("Motor6D") then
            return;
        end;

        p42.Part0 = nil;
        p42.Part1 = nil;
        task.defer(p42.Destroy, p42);
    end);
end;

function u3._AnchorModel(u43, p44, p45) -- Line: 204
    -- upvalues: u1 (copy)
    u43._anchor_model_hash = u43._anchor_model_hash + 1;
    local _anchor_model_hash = u43._anchor_model_hash;

    if not u43._is_humanoid then
        return;
    end;

    local v46 = p44 or 3;
    local u47 = p45 == nil and true or p45;

    local function anchor() -- Line: 215
        -- upvalues: u43 (copy), _anchor_model_hash (copy), u1 (ref), u47 (copy)
        if not u43._subject.Parent or _anchor_model_hash ~= u43._anchor_model_hash then
            return;
        end;

        for _, descendant in pairs(u43._subject.Parent:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if u1 then
                    u1:ClearSetDescendantsLogic(descendant, true);
                end;

                u43._original_collision_groups[descendant] = u43._original_collision_groups[descendant] or descendant.CollisionGroup;
                descendant.CollisionGroup = u47 and "Noclip" or (u43._original_collision_groups[descendant] or descendant.CollisionGroup);
                descendant.Anchored = u47;
            end;
        end;
    end;

    if v46 <= 0 then
        task.spawn(anchor);

        return;
    end;

    task.delay(v46 or 3, anchor);
end;

function u3._Ragdoll(p48) -- Line: 242
    if not (p48._is_humanoid and p48._subject.Parent) then
        return;
    end;

    p48._ragdolled = true;

    for _, descendant in pairs(p48._subject.Parent:GetDescendants()) do
        if descendant:IsA("AnimationConstraint") then
            descendant.Enabled = false;
        elseif descendant:IsA("Motor6D") then
            local Attachment = Instance.new("Attachment");
            Attachment.CFrame = descendant.C0;
            Attachment.Name = descendant.Name .. " - A0";
            Attachment.Parent = descendant.Part0;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.CFrame = descendant.C1;
            Attachment2.Name = descendant.Name .. " - A1";
            Attachment2.Parent = descendant.Part1;
            local BallSocketConstraint = Instance.new("BallSocketConstraint");
            BallSocketConstraint.Attachment0 = Attachment;
            BallSocketConstraint.Attachment1 = Attachment2;
            BallSocketConstraint.Name = "RagdollBSC";
            BallSocketConstraint.LimitsEnabled = true;
            BallSocketConstraint.TwistLimitsEnabled = true;
            BallSocketConstraint.MaxFrictionTorque = 10;
            BallSocketConstraint.Parent = descendant.Part0;
            descendant:Destroy();
        end;
    end;

    p48._subject.Parent.DescendantAdded:Connect(function(p49) -- Line: 281
        if p49:IsA("Motor6D") then
            task.defer(p49.Destroy, p49);
        end;
    end);
end;

function u3._InternalThread(p50, u51, ...) -- Line: 288
    -- upvalues: IS_STUDIO (copy)
    local u52 = nil;

    if IS_STUDIO then
        u52 = u51(...);
    else
        pcall(function(...) -- Line: 294
            -- upvalues: u52 (ref), u51 (copy)
            u52 = u51(...);
        end, ...);
    end;

    table.insert(p50._threads, u52);

    return u52;
end;

function u3._Setup(p53) -- Line: 304
    -- upvalues: CONSTANTS (copy)
    if not (p53._is_humanoid and CONSTANTS.IS_SERVER) then
        return;
    end;

    for _, child in pairs(p53._subject:GetChildren()) do
        if child:IsA("NumberValue") then
            task.defer(child.Destroy, child);
        end;
    end;
end;

function u3._Init(u54) -- Line: 316
    u54._subject.Destroying:Connect(function() -- Line: 317
        -- upvalues: u54 (copy)
        u54:Destroy();
    end);
    u54:_Setup();
end;

return u3;