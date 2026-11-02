-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Finishers = game:GetService("ReplicatedStorage").Modules.Finishers;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Scene = p2;
    v3._dummy_template = v3.Scene.Model:WaitForChild("FinisherDummy");
    v3._fake_player = v3.Scene.Model:WaitForChild("FakePlayer");
    v3._playing_hash = 0;
    v3._last_rig = nil;
    v3._last_finisher = nil;
    v3:_Init();

    return v3;
end;

function u1.GetHumanoidCFrame(p4) -- Line: 30
    return p4._dummy_template:GetPivot();
end;

function u1.OnCustomizingStateChanged(p5) -- Line: 34
    task.defer(p5._StartPlaying, p5);
end;

function u1.OnStateChanged(p6) -- Line: 38
    task.defer(p6._StartPlaying, p6);
end;

function u1._StartPlaying(p7) -- Line: 46
    -- upvalues: Finishers (copy)
    p7._playing_hash = p7._playing_hash + 1;
    local _playing_hash = p7._playing_hash;

    if p7._last_rig then
        p7._last_rig:Destroy();
        p7._last_rig = nil;
    end;

    if p7._last_finisher then
        p7._last_finisher:Destroy();
        p7._last_finisher = nil;
    end;

    local SelectedCosmetic = p7.Scene.Equipment:GetSelectedCosmetic();

    if p7.Scene.Equipment:GetCustomizingType() ~= "Finisher" then
        return;
    end;

    while true do
        p7._last_rig = p7._dummy_template:Clone();
        p7._last_rig:PivotTo(p7:GetHumanoidCFrame() * CFrame.new(0, 0, 8));
        p7._last_rig.Parent = p7.Scene.Model;
        p7._last_rig.Humanoid:MoveTo((p7._last_rig:GetPivot() * CFrame.new(0, 0, -16)).Position);
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://14266666697";
        local success, result = pcall(p7._last_rig.Humanoid.LoadAnimation, p7._last_rig.Humanoid, Animation);

        if success then
            result:Play(0);
        end;

        wait(0.5);

        if p7._playing_hash ~= _playing_hash then
            return;
        end;

        if success then
            result:Stop(0);
        end;

        local _last_rig = p7._last_rig;
        local Pivot = p7._last_rig:GetPivot();
        local CFrame_Angles = CFrame.Angles;
        local v8 = math.random() - 0.5;
        _last_rig:PivotTo(Pivot * CFrame_Angles(0.17453292519943295, 0, math.sign(v8) * 0.17453292519943295));
        local HumanoidRootPart = p7._last_rig.HumanoidRootPart;
        HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity * 0;
        p7._last_rig.Humanoid.Health = 0;

        for _, child in pairs(p7._last_rig:GetChildren()) do
            if child:IsA("BasePart") then
                local v9 = child;

                for _, child2 in pairs(p7._last_rig:GetChildren()) do
                    if child2:IsA("BasePart") and child2 ~= v9 then
                        local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
                        NoCollisionConstraint.Part1 = child2;
                        NoCollisionConstraint.Part0 = v9;
                        NoCollisionConstraint.Parent = v9;
                    end;
                end;
            end;
        end;

        for _, descendant in pairs(p7._last_rig:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = true;
            end;
        end;

        local v10 = {
            Character = p7._fake_player
        };
        p7._last_finisher = require(Finishers[SelectedCosmetic == "RANDOM_COSMETIC" and "Ragdoll" or (SelectedCosmetic or "Ragdoll")]).new(p7._last_rig.Humanoid, false, v10);
        p7._last_finisher:Simulate();

        if p7._playing_hash ~= _playing_hash then
            return;
        end;

        wait(3);

        if p7._playing_hash ~= _playing_hash then
            return;
        end;

        if p7._last_rig then
            p7._last_rig:Destroy();
            p7._last_rig = nil;
        end;

        if p7._last_finisher then
            p7._last_finisher:Destroy();
            p7._last_finisher = nil;
        end;
    end;
end;

function u1._Setup(p11) -- Line: 147
    p11._dummy_template.Parent = nil;
end;

function u1._Init(p12) -- Line: 151
    p12:_Setup();
end;

return u1;